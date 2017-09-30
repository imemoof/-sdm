clear all
subid = [1:24];
categories = [1:10];
IndItems_cat= [1:86];
choice_trials = 18;
inverse_temp = 0.23;
plotwidth = 2;

beta = 1.01;


addpath /Users/chen/Dropbox/PHD/SDM_behavior
resultdir = '/Users/chen/Dropbox/PHD/SDM_behavior/simulation/data';
imgdir = '/Users/chen/Dropbox/PHD/SDM_behavior/simulation/plots';
%% generate ratings: ratings(subject).ind{categories} = trial number, 
rating = {};
for subj = subid
       for cat = categories;
           rating(subj).ind{cat} = IndItems_cat;  % or IndItems_cat + cat*100; so every item will have anunique ID
           rating(subj).score{cat} = [randi([0,100], length(IndItems_cat) - 10,1);zeros(10,1)]'; % 10% 0s, uniformly distributed elsewhere
       end
end


%%  after the ratings has been generated, group them into trials of a certain pre-defined sequence 
for subj = subid
       for cat = categories
           [per_trial(subj,cat), trials] = group_items(rating(subj).score{cat}); % 10% 0s, uniformly distributed elsewhere
       end
end


%%  Put the 10 categories together, get180 trials of simulated trials for each subject,
trial_simu = {};
for subj = subid
     trial_simu(subj).trialindex = [1: choice_trials * length(categories)];
     trial_simu(subj).order = [per_trial(subj,categories).order];                  % the order of the the item according to rating, for example [ 40, 20, 30] would be [ 1,3,2]
     trial_simu(subj). itemNumber  = [per_trial(subj,categories).itemNumber];       % the number of items in this trial, in the above example it would be 3
     trial_simu(subj). highPosition = [per_trial(subj,categories).highPosition];      % the postion of the best item, in the above example it would be 1
     trial_simu(subj). highPositionSec = [per_trial(subj,categories).highPositionSec];  % second best item position, 3 in the above example
     trial_simu(subj). V_hzero = [per_trial(subj,categories).ratingsOrdered];    % the ratings in the above defined order, [ 40, 20, 30]
     trial_simu(subj). items_corresponding  = [per_trial(subj,categories).itemsOrdered];      % not quite useful in the simulation, the item index corresponding to the ranked rating, used to trace items for presentation purpose
end


%% Next step: to calculate V_hone (meanwhile mark the winning time and losing time of each item, to be used to run BMS),
for subj = subid
       for i = [1: choice_trials * length(categories)];                     % for each trials
           v_zero = trial_simu(subj). V_hzero{i};                               % per trial rating eg. [29, 0,0]
           
           winning_index = 1;
           defeat_index = 0;
           win_record = zeros (1, length(v_zero));
           defeat_record = zeros(1, length(v_zero));
            k = 1;  
           while k <= length(v_zero) -1
               if v_zero(winning_index) > v_zero(k+1)                                                                % the previous winning option is the better of the two 
                    defeat_index = k+ 1;       
                    winning_index = winning_index;                   
                    v_zero(defeat_index ) = v_zero(defeat_index ) + beta*(-1);                     
                    defeat_record (defeat_index) = defeat_record(defeat_index) +1;           
                    v_zero(winning_index) = v_zero(winning_index) + beta*1;
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
           % after the comparison of the trial, update the Values of H1 for
           % each trial of each subject
            trial_simu(subj).V_hone{i} = v_zero;
            trial_simu(subj).win_record{i} = win_record;
            trial_simu(subj).defeat_record{i} = defeat_record;

       end
end

%% P_hzero, P_hone,  C1_hzero, C1_hone, C2_hzero,C2_hone
for subj = subid
    
       for i = [1: choice_trials * length(categories)];                     % for each trials
           v_zero = trial_simu(subj). V_hzero{i};                               % per trial rating eg. [29, 0,0]
           v_one = trial_simu(subj).V_hone{i};
           p_zero = []; p_one = [];
           for w = 1:length(v_zero)
               p_zero(w) = exp(v_zero(w).* inverse_temp)./sum(exp(v_zero.*inverse_temp));
               p_one (w) = exp(v_one(w).* inverse_temp)./sum(exp(v_one.*inverse_temp));
           end
           
               cointoss_1 = rand(1);                           % to decide what the decision is
               if cointoss_1< max(p_zero)
                   C1_hzero = 1; C2_hzero = 0;
               elseif cointoss_1 >=max(p_zero) && cointoss_1<= (max(p_zero) + max(p_zero(p_zero<max(p_zero))))
                   C1_hzero = 0; C2_hzero = 1;
               else
                   C1_hzero = 0; C2_hzero = 0;
               end

                  % for two models, whether should I toss twice the coins or use
                  % the same cointoss for both of the models
               cointoss_2 = rand(1);                           % to decide what the decision is
               if cointoss_2< max(p_one)
                   C1_hone = 1; C2_hone = 0;
               elseif cointoss_2 >=max(p_one) && cointoss_1<= (max(p_one) + max(p_one(p_one<max(p_one))))
                   C1_hone = 0; C2_hone = 1;
               else 
                   C1_hone = 0; C2_hone = 0;
               end   
       
            trial_simu(subj).p_zero{i} = p_zero;            
            trial_simu(subj).p_one{i} = p_one;
            
            trial_simu(subj).C1_hzero{i} = C1_hzero;
            trial_simu(subj).C1_hone{i} = C1_hone;
            trial_simu(subj).C2_hzero{i} = C2_hzero;
            trial_simu(subj).C2_hone{i} = C2_hone;
            
            trial_simu(subj).P1_hzero{i} = max(p_zero);
            trial_simu(subj).P1_hone{i} = max(p_one);
            trial_simu(subj).P2_hzero{i} = max(p_zero(p_zero<max(p_zero)));
            trial_simu(subj).P2_hone{i} = max(p_one(p_one<max(p_one)));
 
       end
end

cd (resultdir)
save(['beta',num2str(beta*100),'_simudata.mat'], 'trial_simu','rating','per_trial',   'subid','beta','inverse_temp','plotwidth','choice_trials','IndItems_cat','categories','resultdir','imgdir')