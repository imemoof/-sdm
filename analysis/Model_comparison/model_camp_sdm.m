clear
close all
 sub = [1];

[~, hostname] = system('hostname'); % try to identify which computer am I using
if strcmp(hostname(1:5),'MBB31')
    resultdir = 'C:\Users\chen.hu\Documents\GitHub\sdm\analysis\Model_comparison\sdm_results\';
else
    resultdir =  '/Users/chen/Documents/GitHub/sdm/analysis/Model_comparison/sdm_results/';
    addpath '/Users/chen/Documents/GitHub/sdm/analysis/Model_comparison';
end

model_evidence_data = [];
for model_n = [2]
    param = invert_data_sdm(model_n, sub);
    ll = param.Rating_model_evidence;
    model_evidence_data = [model_evidence_data; ll'];
    cd(resultdir);
    save (['sdm_model_fit_m_',num2str(model_n),'.mat']) % ,'beta_allsessions','a_reward_allsessions','a_effort_allsessions');    
end


%% 
clear all
close all
 sub = [1];

[~, hostname] = system('hostname'); % try to identify which computer am I using
if strcmp(hostname(1:5),'MBB31')
    resultdir = 'C:\Users\chen.hu\Documents\GitHub\sdm\analysis\Model_comparison\sdm_results\';
else
    resultdir =  '/Users/chen/Documents/GitHub/sdm/analysis/Model_comparison/sdm_results/';
    addpath '/Users/chen/Documents/GitHub/sdm/analysis/Model_comparison';
end

model_evidence_data = [];
for model_n = [3]
    param = invert_data_sdm(model_n, sub);
    ll = param.Rating_model_evidence;
    model_evidence_data = [model_evidence_data; ll'];
    cd(resultdir);
    save (['sdm_model_fit_m_',num2str(model_n),'.mat']) % ,'beta_allsessions','a_reward_allsessions','a_effort_allsessions');    
end