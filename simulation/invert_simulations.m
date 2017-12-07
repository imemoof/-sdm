function param = invert_simulations(beta, dataset, model_n, dispo, sub)


%% Specify how to load informations needed
[~, hostname]      = system('hostname'); % try to identify which computer am I using
if strcmp(hostname(1:5),'MBB31')
    load(['C:\Users\chen.hu\Dropbox\PHD\SDM_behavior\simulation\data\beta',num2str(beta*100),'_simudata.mat']);
else
    load(['/Users/chen/Dropbox/PHD/SDM_behavior/simulation/data/beta',num2str(beta*100),'_simudata.mat']);
end
   
%% Mod?les ? tester :
    verb = 0;
    models={'m_hzero','m_hone'};
    model_name=models{model_n};
    disp(model_n)

switch model_name
    case 'm_hzero'   % linear model- one parameter, which is the beta
        model_fun = @m_hzero;
        prior = [0.046];
        var_prior= [1];
    case 'm_hone'
        model_fun = @m_hone;
        prior = [0.046,0];
        var_prior = eye(2);
end

modeles={model_fun};
param = length(prior);
row = 0;


k = length(sub);

for s = 1:k
    subj = sub(s)               % subject number
    row = row+1;          % how many subject?

 
        for i = 1:180
          if length( trial_simu(subj).V_hzero{i}) == 3
              trial_simu(subj).V_hzero{i} = [trial_simu(subj).V_hzero{i} NaN NaN NaN];
          elseif length( trial_simu(subj).V_hzero{i}) == 4
              trial_simu(subj).V_hzero{i} = [trial_simu(subj).V_hzero{i} NaN NaN];
            elseif length( trial_simu(subj).V_hzero{i}) == 5
              trial_simu(subj).V_hzero{i} = [trial_simu(subj).V_hzero{i} NaN];
          end

          if dataset == 0
              choice(i) = trial_simu(subj).C1_hzero{i};
          elseif dataset == 1
              choice(i) = trial_simu(subj).C1_hone{i};
          end
           
          itemnum(i) = trial_simu(subj).itemNumber{i};
          values (i, :)= trial_simu(subj).V_hzero{i};
          highpos(i) = trial_simu(subj).highPosition{i};
          val =  values (i, :);
          highest_value(i) = val( highpos(i));
        end        
               
     Ntrials = length(choice);

    for mod=1:length(modeles)        
        %% Definition of model options
        nb_param= param(mod);       
        g_name= modeles{mod};
        f_name = [];
        
        u_r = [choice', itemnum',values,highpos',highest_value']';  % 180*10 matrix, values  (3-8)
        
        
        dim = struct('n',0,...  % number of hidden states
            'p',1,... % total output dimension
            'n_theta',0,... % number of evolution parameters
            'n_phi', nb_param,... % number of observation parameters
            'n_t',Ntrials); % number of trials
        
        options.DisplayWin = dispo; % Display setting
        options.GnFigs = 0; % Plotting option
        options.isYout = zeros(1,Ntrials); % vector of the size of y, 1 if trial out
        options.verbose= verb;
        options.binomial = 1; % 1 if binary data, 0 if continuous data
        
        %% Definition of priors
        
        % Observation parameters :
        priors.muPhi = prior;
        priors.SigmaPhi = var_prior;
        
        % Evolution parameters
        priors.muTheta =0;
        priors.SigmaTheta =1e2*eye(1);
        options.priors = priors;
        
        y = choice;
        
        %% Performing the inversion
        options.figName='choice_simudata';
        [posteriorr,outr] = VBA_NLStateSpaceModel(y,u_r,f_name,g_name,dim,options);
        model_evidence_r(row,mod)= outr.F;
        param_all_r(row,:)=[posteriorr.muPhi(1:end)'];
        
        posterior_all{subj}=posteriorr;
        out_all{subj}=outr;
        
        
    end
    
end

param = struct('Name',[func2str(modeles{1}),'_VBA'],'Val_param',param_all_r,'Priors',prior,'Var_priors',var_prior,'Rating_model_evidence',model_evidence_r,...
    'posterior',posterior_all,'out',out_all);

