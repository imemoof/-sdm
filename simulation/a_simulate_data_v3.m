clear all
subid = [1:24];
categories = [1:5];
Items_per_cat= 86;
choice_trials = 18;
repeat = 4;
total_repeat = [1:20];
inverse_temp = 0.23/5;
plotwidth = 2;

beta = 10.02;
[~, hostname] = system('hostname'); % try to identify which computer am I using
if strcmp(hostname(1:5),'MBB31')
    addpath C:\Users\chen.hu\Dropbox\PHD\SDM_behavior
    resultdir = 'C:\Users\chen.hu\Dropbox\PHD\SDM_behavior\simulation\data';
    imgdir = 'C:\Users\chen.hu\Dropbox\PHD\SDM_behavior\simulation\plots';
else
    addpath /Users/chen/Dropbox/PHD/SDM_behavior
    resultdir = '/Users/chen/Dropbox/PHD/SDM_behavior/simulation/data';
    imgdir = '/Users/chen/Dropbox/PHD/SDM_behavior/simulation/plots';
end

%% generate ratings: ratings(subject).ind{categories} = trial number, 
rating = {};
trial_simu = {};
win_rec = {};
def_rec = {};
for subj = subid
       for cat = categories;
           rating(subj,cat).score{1} = [randi([0,100], Items_per_cat - 10,1);zeros(10,1)]'; % 10% 0s, uniformly distributed elsewhere
           win_rec(subj,cat).round{1}  = zeros(1,Items_per_cat);
           def_rec(subj,cat).round{1}  = zeros(1,Items_per_cat);
          
           for t = 1: repeat            
                    % first 18 trials ready according to the first rating
                    [per_trial(subj,(cat-1)*repeat + t), trials(subj,(cat-1)*repeat + t)]  =  group_items(rating(subj,cat).score{1});             % 4 times use the initial values to generate the choices
                    ratings_temp = NaN(Items_per_cat,1)';
                    ratings_lastround = rating(subj,cat).score{t};
                    win_temp = NaN(Items_per_cat,1)';
                    win_lastround = win_rec(subj,cat).round{t};
                    def_temp = NaN(Items_per_cat,1)';
                    def_lastround = def_rec(subj,cat).round{t};                    
                    
                    % update the values of each 
                    for i = [1: choice_trials];                     % for each trials
  %                          v_zero = per_trial(subj,categories).ratingsOrdered{i};                           % per trial rating eg. [29, 0,0]
                            itemindex = per_trial(subj,(cat-1)*repeat + t).itemsOrdered{i};                     
                            v_zero = ratings_lastround(itemindex);
                            win_record = win_lastround(itemindex);
                            defeat_record = def_lastround(itemindex);
                            
                            winning_index = 1;
                            defeat_index = 0;
 
                            k = 1;  
                            
                           while k <= length(v_zero) -1
                               if v_zero(winning_index) > v_zero(k+1)                                                                % the previous winning option is the better of the two 
                                    defeat_index = k+ 1;       
                                    winning_index = winning_index;                   
                                    v_zero(defeat_index ) = v_zero(defeat_index ) + beta*(-1);                     
                                    v_zero(winning_index) = v_zero(winning_index) + beta*1;
                                    defeat_record (defeat_index) = defeat_record(defeat_index) +1;  
                                    win_record(winning_index) = win_record(winning_index) +1;

                               elseif v_zero(winning_index) < v_zero(k+1)  % if the new option is winning
                                    defeat_index = winning_index;     
                                    winning_index = k + 1;  
                                    v_zero(defeat_index ) = v_zero(defeat_index ) + beta*(-1);                     
                                    defeat_record (defeat_index) = defeat_record(defeat_index) +1;
                                    v_zero(winning_index) = v_zero(winning_index) + beta*1;
                                    win_record(winning_index) = win_record(winning_index) +1;

                               elseif v_zero(winning_index) == v_zero(k+1)  % if the two options have the same value, flip a coin to decide which wins
                                   coin = rand(1);
                                   if        coin >= 0.5, winning_index = winning_index; defeat_index = k+1;
                                   elseif coin <0.5, defeat_index = winning_index; winnng_index = k+1; end
                                    v_zero(defeat_index ) = v_zero(defeat_index ) + beta*(-1);                     
                                    defeat_record (defeat_index) = defeat_record(defeat_index) +1; 
                                    v_zero(winning_index) = v_zero(winning_index) + beta*1;
                                    win_record(winning_index) = win_record(winning_index) +1;                
                               end
                               k = k +  1;
                           end
                                % update the values
                                V(subj,(cat-1)*repeat + t).one{i} = v_zero;  
                                win(subj,(cat-1)*repeat + t).trial{i} = win_record;        % per trial win record
                                 def(subj,(cat-1)*repeat + t).trial{i} = defeat_record;        % per trial defeat record
                               
                                % update the ratings
                                ratings_temp(itemindex) = v_zero;
                                win_temp(itemindex) = win_record;
                                def_temp(itemindex) = defeat_record;
                    end   
                    rating(subj,cat).score{t+1} = ratings_temp;
                     win_rec(subj,cat).round{t+1} = win_temp;                                   % counting history since the first round, so can start inference from Vh0
                     def_rec(subj,cat).round{t+1} = def_temp; 
           end
       
         end         
        trial_simu(subj).trialindex = [1: choice_trials * length(categories)*repeat];
        trial_simu(subj).order = [per_trial(subj,total_repeat).order];                  % the order of the the item according to rating, for example [ 40, 20, 30] would be [ 1,3,2]
        trial_simu(subj). itemNumber  = [per_trial(subj,total_repeat ).itemNumber];       % the number of items in this trial, in the above example it would be 3
        trial_simu(subj). highPosition = [per_trial(subj,total_repeat ).highPosition];      % the postion of the best item, in the above example it would be 1
        trial_simu(subj). highPositionSec = [per_trial(subj,total_repeat ).highPositionSec];  % second best item position, 3 in the above example
        trial_simu(subj). V_hzero = [per_trial(subj,total_repeat ).ratingsOrdered];    % the ratings in the above defined order, [ 40, 20, 30]
        trial_simu(subj). items_corresponding  = [per_trial(subj,total_repeat).itemsOrdered];      % not quite useful in the simulation, the item index corresponding to the ranked rating, used to trace items for presentation purpose
        trial_simu(subj).V_hone = [V(subj,total_repeat).one];         
        trial_simu(subj).winRec = [win(subj,total_repeat).trial];
        trial_simu(subj).defRec = [def(subj,total_repeat).trial];
end


% P_hzero, P_hone,  C1_hzero, C1_hone, C2_hzero,C2_hone
for subj = subid
    
       for i = [1: choice_trials * length(categories)*repeat];                     % for each trials
           v_zero = trial_simu(subj). V_hzero{i};                               % per trial rating eg. [29, 0,0]
           v_one = trial_simu(subj).V_hone{i};
           p_zero = []; p_one = [];
           for w = 1:length(v_zero)
               p_zero(w) = exp(v_zero(w).* inverse_temp)./sum(exp(v_zero.*inverse_temp));
               p_one (w) = exp(v_one(w).* inverse_temp)./sum(exp(v_one.*inverse_temp));
           end
           
               p_zeroRange = cumsum(p_zero);            
               cointoss_1 = rand(1);                           % to decide what the decision is
               if cointoss_1< max(p_zero)
                   C1_hzero = 1; C2_hzero = 0;
               elseif cointoss_1 >=max(p_zero) || cointoss_1<= (max(p_zero) + max(p_zero(p_zero<max(p_zero))))
                   C1_hzero = 0; C2_hzero = 1;
               else
                   C1_hzero = 0; C2_hzero = 0;
               end
               which_choice_0 = min(find(p_zeroRange > cointoss_1)); % accumulator
               
               

                  % for two models, whether should I toss twice the coins or use
                  % the same cointoss for both of the models
               p_oneRange = cumsum(p_one);
               cointoss_2 = rand(1);                           % to decide what the decision is
               if cointoss_2< max(p_one)
                   C1_hone = 1; C2_hone = 0;
               elseif cointoss_2 >=max(p_one) || cointoss_1<= (max(p_one) + max(p_one(p_one<max(p_one))))
                   C1_hone = 0; C2_hone = 1;
               else 
                   C1_hone = 0; C2_hone = 0;
               end   
               which_choice_1 = min(find(p_oneRange > cointoss_2));
               
       
            trial_simu(subj).p_zero{i} = p_zero;            
            trial_simu(subj).p_one{i} = p_one;
            
            trial_simu(subj).C1_hzero{i} = C1_hzero;
            trial_simu(subj).C1_hone{i} = C1_hone;
            trial_simu(subj).C2_hzero{i} = C2_hzero;
            trial_simu(subj).C2_hone{i} = C2_hone;
            trial_simu(subj).choice_zero{i} = which_choice_0;
            trial_simu(subj).choice_one{i}= which_choice_1;
            
            trial_simu(subj).P1_hzero{i} = max(p_zero);
            trial_simu(subj).P1_hone{i} = max(p_one);
            trial_simu(subj).P2_hzero{i} = max(p_zero(p_zero<max(p_zero)));
            trial_simu(subj).P2_hone{i} = max(p_one(p_one<max(p_one)));
            
            
            % try to generate a choice
            
 
       end
end

cd (resultdir)
save(['v3_beta',num2str(beta*100),'_simudata.mat'], 'trial_simu','rating','per_trial', 'beta','inverse_temp','plotwidth','categories','resultdir','imgdir', 'win_rec', 'def_rec')