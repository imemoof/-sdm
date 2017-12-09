clear
sub = [1];
[~, hostname] = system('hostname'); % try to identify which computer am I using
if strcmp(hostname(1:5),'MBB31')
    resultdir = 'C:\Users\chen.hu\Documents\GitHub\sdm\analysis\Model_comparison\';
else
    resultdir = '/Users/chen/Dropbox/PHD/SDM_behavior/simulation/ModelSelection/';
end

PARAM_data = struct;
model_evidence_data = [];

for model_n = [1:2]
    param = invert_data_sdm(model_n, sub);
    ll = param.Rating_model_evidence;
    model_evidence_data = [model_evidence_data; ll'];
    if model_n == 1
        PARAM_data = param;
    else
        PARAM_data(model_n,1) = param;
    end
    
            
end
cd(resultdir);
save (['sdm_model_fit_m12.mat'],'model_evidence_data','PARAM_data') % ,'beta_allsessions','a_reward_allsessions','a_effort_allsessions');
