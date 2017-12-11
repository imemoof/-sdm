% function param = invert_data_sdm(model_n, sub)
clear all
close all
model_n = 6;
sub = [1:4, 6:12];


%% Specify how to load informations needed
[~, hostname] = system('hostname'); % try to identify which computer am I using
if strcmp(hostname(1:5),'MBB31')
    root = 'C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\';
    resultdir = 'C:\Users\chen.hu\Documents\GitHub\sdm\analysis\Model_comparison\sdm_results\';

else
    root = '/Users/chen/Documents/GitHub/sdm/results_sdm/' ;
    resultdir =  '/Users/chen/Documents/GitHub/sdm/analysis/Model_comparison/sdm_results/';

end

%% Load input data
INDX_category = 2;
INDX_itemnumber = 6;
INDX_values = 15:20;
INDX_itemid = 21:26;
INDX_choice = 39;
N_sub = length(sub);
N_items_percate = 86;
N_categories = 5;
N_items = N_items_percate * N_categories;


for s = 1:N_sub
    subj = sub(s);
    mydatafile = load([root,'sub',num2str(subj),filesep,'choice_subject_',num2str(subj),'cate_15.mat']);
    myratingfile = load([root,'sub',num2str(subj),filesep,'pleasantRating_subject_',num2str(subj),'_cate_15.mat']);
    Ntrials = length(mydatafile.choice_data);
    [choice_position, itemnum, which_category] = deal(NaN(Ntrials,1));
    [values,itemid,choice] = deal(NaN(Ntrials,6));
    
    for i = 1: Ntrials
        which_category(i) =  mydatafile.choice_data(i,INDX_category);
        itemnum(i) = mydatafile.choice_data(i,INDX_itemnumber);
        itemid(i, :)=  mydatafile.choice_data(i,INDX_itemid)* which_category(i);
        
        values(i, :)= mydatafile.choice_data(i,INDX_values);  % 6 values, sometimes le last fews can be empty
        choice_position(i) = mydatafile.choice_data(i,INDX_choice);
        temp = zeros(1, itemnum(i));
        if choice_position(i) < 7
            temp(choice_position(i)) = 1;
        end
        choice(i, 1:itemnum(i)) = temp;
    end
    
    y = choice';
     u_r = [which_category, itemnum, itemid, values]';  % 360* 8, 3- 8, itemid
    % u_r = [which_category, itemnum, itemid]';  % 360* 8, 3- 8, itemid
    % X0 = myratingfile.rating_all;
    
    
    
    %% Modeles ? tester :
    models_set = {'m_h0','m_default','m_primacy','m_recency','m_primacy_default', 'm_default_recency','m_primacy_recency','m_primacy_default_recency'};
    model_name = models_set{model_n};
    
    switch model_name
        % model 1 the null model
        case 'm_h0'   % linear model- one parameter, which is the beta
            model_obs = @obs_000;
            model_evo = [];
            prior = [0.046]; %#ok<NBRAK>
            param = length(prior);
            
            dim = struct('n',0,...  % number of hidden states
                'n_theta',0,... % number of evolution parameters
                'n_phi', param,... % number of observation parameters
                'n_t',Ntrials); % number of trials
            %        'p',1,... % total output dimension
            priors.muTheta = 0;
            priors.SigmaTheta = 1e2*eye(1);
            
            
        case 'm_default'
            model_obs = @obs_000_evo;
            model_evo = @evo_010;
            prior = [0.046];
            param = length(prior);
          dim = struct('n',N_items,...  % number of hidden states
            'n_theta',1,... % number of evolution parameters
            'n_phi', param,... % number of observation parameters
            'n_t',Ntrials); % number of trials
        %        'p',1,... % total output dimension
        
        case 'm_primacy'
            model_obs = @obs_000_evo;
            model_evo = @evo_100;
            prior = [0.046];
            param = length(prior);
          dim = struct('n',N_items,...  % number of hidden states
            'n_theta',1,... % number of evolution parameters
            'n_phi', param,... % number of observation parameters
            'n_t',Ntrials); % number of trials
        %        'p',1,... % total output dimension            
                
        case 'm_recency'
            model_obs = @obs_000_evo;
            model_evo = @evo_001;
            prior = [0.046];
            param = length(prior);
          dim = struct('n',N_items,...  % number of hidden states
            'n_theta',1,... % number of evolution parameters
            'n_phi', param,... % number of observation parameters
            'n_t',Ntrials); % number of trials
        %        'p',1,... % total output dimension  
        
        case 'm_primacy_default'
            model_obs = @obs_000_evo;
            model_evo = @evo_110;
            prior = [0.046];
            param = length(prior);
          dim = struct('n',N_items,...  % number of hidden states
            'n_theta',2,... % number of evolution parameters
            'n_phi', param,... % number of observation parameters
            'n_t',Ntrials); % number of trials
        %        'p',1,... % total output dimension
        
        case 'm_default_recency'
            model_obs = @obs_000_evo;
            model_evo = @evo_011;
            prior = [0.046];
            param = length(prior);
          dim = struct('n',N_items,...  % number of hidden states
            'n_theta',2,... % number of evolution parameters
            'n_phi', param,... % number of observation parameters
            'n_t',Ntrials); % number of trials
        %        'p',1,... % total output dimension   
        
        case 'm_primacy_recency'
            model_obs = @obs_000_evo;
            model_evo = @evo_101;
            prior = [0.046];
            param = length(prior);
          dim = struct('n',N_items,...  % number of hidden states
            'n_theta',2,... % number of evolution parameters
            'n_phi', param,... % number of observation parameters
            'n_t',Ntrials); % number of trials
        %        'p',1,... % total output dimension  
        
        case 'm_primacy_default_recency'
            model_obs = @obs_000_evo;
            model_evo = @evo_111;
            prior = [0.046];
            param = length(prior);
          dim = struct('n',N_items,...  % number of hidden states
            'n_theta',3,... % number of evolution parameters
            'n_phi', param,... % number of observation parameters
            'n_t',Ntrials); % number of trials
        %        'p',1,... % total output dimension          
    end
    
    
    %% Definition of model options
    g_name = model_obs;
    f_name = model_evo;
    
    
    options.DisplayWin = 1; % Display setting
    options.GnFigs = 0; % Plotting option
    options.verbose= 1;
    
    options.isYout = zeros(size(choice)); % vector of the size of y, 1 if trial out
    options.sources.out  = 1:6;
    options.sources.type = 2;
    %      options.binomial = 1; % 1 if binary data, 0 if continuous data
    
    %% Definition of priors
    % Observation parameters :
    priors.muPhi = prior;
    priors.SigmaPhi = 1e1*eye(dim.n_phi);
    
    if model_n ~= 1
        % Evolution parameters
        priors.muTheta = zeros(dim.n_theta,1);
        priors.SigmaTheta = 1e1*eye(dim.n_theta);
        % X0 related settings
        
        priors.muX0 = myratingfile.rating_all';
        priors.SigmaX0 = 1e1*zeros(dim.n);
        priors.a_alpha = Inf;
        priors.b_alpha = 0;
        options.skipf = zeros(1,dim.n_t);
        options.skipf(1) = 1;
    end
    
    options.priors = priors;
    
    %% Performing the inversion
    options.figName = 'choice_data';
    size_y = size(y);
    inclusion = zeros(size_y);
    for h = 1:size_y(1)
        for q = 1:size_y(2)
            if isnan(y(h,q))
                y(h,q) = 100;
                inclusion(h,q) = 1;
            end
        end
    end
    options.isYout = inclusion;
    
    [posteriorr,outr] = VBA_NLStateSpaceModel(y,u_r,f_name,g_name,dim,options);    
    
    model_evidence_r(subj,1) = outr.F; % #ok<AGROW>
    obs_param_all_r(subj,:)= posteriorr.muPhi(1:end)';
    evo_param_all_r(subj,:)= posteriorr.muTheta(1:end)';
     
    updated_x {subj} = posteriorr.muX
    posterior_all{subj} = posteriorr;
    out_fit{subj} = outr.fit;

end

cd(resultdir);
params = struct('Name',[model_name,'_VBA'],'Val_param_obs',obs_param_all_r,'Val_param_evo',evo_param_all_r,'Priors',priors,'Rating_model_evidence',model_evidence_r, 'Rating_updated', updated_x ,'Fit_quality', out_fit);
save (['sdm_model_fit_m_',num2str(model_n),'.mat'], 'params') 

% param_all = struct('Name',[model_name,'_VBA'], 'posterior',posterior_all,'out',out_fit);
% save (['sdm_model_fit_m_',num2str(model_n),'all.mat'], 'param_all') 