clear
for i = 1:length(beta_all)
%% For dataset of H0,test the fit of H0 and H1
    beta = beta_all(i);
    sub = [1:24];
    model_evidence_choiceH0 = [];
    dataset = 0;
    dispo = 1;
    [~, hostname] = system('hostname'); % try to identify which computer am I using
    if strcmp(hostname(1:5),'MBB31')
        resultdir = 'C:\Users\chen.hu\Dropbox\PHD\SDM_behavior\simulation\ModelSelection';
    else
        resultdir = '/Users/chen/Dropbox/PHD/SDM_behavior/simulation/ModelSelection';
    end

    PARAM_dataH0 = struct;
    for model_n= [1:2]
        param = invert_simulations_v3(beta, dataset, model_n, dispo, sub);
       % invert_simulations;
        ll = param.Rating_model_evidence;       
        model_evidence_choiceH0= [model_evidence_choiceH0; ll'];
        if model_n == 1;
            PARAM_dataH0 = param;
        else 
            PARAM_dataH0(model_n,:) = param;
        end

    end
    cd(resultdir);
    save (['beta',num2str(beta*100),'_choice_H0.mat'],'model_evidence_choiceH0','PARAM_dataH0') % ,'beta_allsessions','a_reward_allsessions','a_effort_allsessions');

    %% For dataset of H1,test the fit of H0 and H1
    model_evidence_choiceH1 = [];
    dataset = 1;
    
    PARAM_dataH1 = struct;
    for model_n= [1:2]
        param = invert_simulations_v3(beta, dataset, model_n, dispo, sub);
       % invert_simulations;
        ll = param.Rating_model_evidence;       
        model_evidence_choiceH1= [model_evidence_choiceH1; ll'];
        if model_n == 1;
            PARAM_dataH1 = param;
        else 
            PARAM_dataH1(model_n,:) = param;
        end

    end
    cd(resultdir);
    save (['beta',num2str(beta*100),'_choice_H1.mat'],'model_evidence_choiceH1','PARAM_dataH1') % ,'beta_allsessions','a_reward_allsessions','a_effort_allsessions');
    clearvars -except beta_all
end

