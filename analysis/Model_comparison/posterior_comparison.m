%% choice analysis
clear
cd C:\Users\chen.hu\Documents\GitHub\sdm\analysis\Model_comparison\sdm_results
subject = [1:4,6:12];
hist_bins = 50;

% get dataset
m1_choice = load('sdm_model_fit_m_1.mat')
m2_choice = load('sdm_model_fit_m_2.mat')
m3_choice = load('sdm_model_fit_m_9.mat')

% get the observation parameter posterior
obs_m1 = safepos(m1_choice.params(1).Val_param_obs(subject));
obs_m2 = safepos(m2_choice.params(1).Val_param_obs(subject));
obs_m3 = safepos(m3_choice.params(1).Val_param_obs(subject));

% get the evolution parameter posterior
evo_m2 = m2_choice.params(1).Val_param_evo(subject);

% ge the model evidence
m1_evidence = m1_choice.params(1).Rating_model_evidence(subject);
m2_evidence = m2_choice.params(1).Rating_model_evidence(subject);
m3_evidence = m3_choice.params(1).Rating_model_evidence(subject);

% do a model comparison of the second and third model, model 1 is outside
% of the picture because hidden states dimension is not aligned.
[posterior,out] = VBA_groupBMC([m1_evidence, m2_evidence,m3_evidence]')
[posterior,out] = VBA_groupBMC([m2_evidence,m3_evidence]')

% plot the posterior of observation parameter
figure
hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
bar([mean(obs_m1),mean(obs_m2),mean(obs_m3)])
errorbar([mean(obs_m1),mean(obs_m2),mean(obs_m3)],[nanstd(obs_m1)/sqrt(length(subject)), nanstd(obs_m2)/sqrt(length(subject)),nanstd(obs_m3)/sqrt(length(subject))],'.');
title('model fit to choice')
xlabel ('model index')
ylabel('inverse temp of obs function (safepos)')
xlim( [0.1,3.9])

figure
boxplot([obs_m1,obs_m2,obs_m3])
title('model fit to choice','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('inverse temp of obs function (safepos)','FontSize',20)

% plot the posterior of the evolution parameter
figure
boxplot([evo_m2])
title('model fit to choice','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('bonus for winning in pairwise comparison','FontSize',20)

% plot the end distribution of hidden states compare to srart distribution
figure
for i = 1:length(subject)
    x_m2 = m2_choice.params(subject(i)).Rating_updated;
    subplot(3,4,i)
    histogram(x_m2(:,1),hist_bins)
    hold on
    histogram(x_m2(:,360),hist_bins)    
    title(['subject ',num2str(i)])
    xlabel('value range')
    ylabel('frequency')

end


%% rt analysis

clearvars -except subject hist_bins
m1_rt = load('sdm_rt_model_fit_m_1.mat')
m2_rt = load('sdm_rt_model_fit_m_2.mat')
m3_rt = load('sdm_rt_model_fit_m_3.mat')

obs_m1_beta = safepos(m1_rt.params(1).Val_param_obs(subject,1));
obs_m2_beta = safepos(m2_rt.params(1).Val_param_obs(subject,1));
obs_m3_beta = safepos(m3_rt.params(1).Val_param_obs(subject,1));

obs_m1_ke = m1_rt.params(1).Val_param_obs(subject,2);
obs_m2_ke = m2_rt.params(1).Val_param_obs(subject,2);
obs_m3_ke = m3_rt.params(1).Val_param_obs(subject,2);

obs_m1_kc = m1_rt.params(1).Val_param_obs(subject,3);
obs_m2_kc = m2_rt.params(1).Val_param_obs(subject,3);
obs_m3_kc = m3_rt.params(1).Val_param_obs(subject,3);

evo_m2 = m2_rt.params(1).Val_param_evo(subject);

% get the model evidence
m1_evidence = m1_rt.params(1).Rating_model_evidence(subject);
m2_evidence = m2_rt.params(1).Rating_model_evidence(subject);
m3_evidence = m3_rt.params(1).Rating_model_evidence(subject);

% do a model comparison of the second and third model, model 1 is outside
% of the picture because hidden states dimension is not aligned.
[posterior,out] = VBA_groupBMC([m1_evidence, m2_evidence,m3_evidence]')
[posterior,out] = VBA_groupBMC([m2_evidence,m3_evidence]')

% plot the posterior of observation parameter
figure
hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
bar([mean(obs_m1_beta),mean(obs_m2_beta),mean(obs_m3_beta)])
errorbar([mean(obs_m1_beta),mean(obs_m2_beta),mean(obs_m3_beta)],[nanstd(obs_m1_beta)/sqrt(length(subject)), nanstd(obs_m2_beta)/sqrt(length(subject)),nanstd(obs_m3_beta)/sqrt(length(subject))],'.');
title('model fit to RT','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('inverse temp of obs function (safepos)','FontSize',20)
xlim( [0.1,3.9])

figure
boxplot([obs_m1_beta,obs_m2_beta,obs_m3_beta])
title('model fit to RT','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('inverse temp of obs function (safepos)','FontSize',20)

% weight of the entropy
figure
hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
bar([mean(obs_m1_ke),mean(obs_m2_ke),mean(obs_m3_ke)])
errorbar([mean(obs_m1_ke),mean(obs_m2_ke),mean(obs_m3_ke)],[nanstd(obs_m1_ke)/sqrt(length(subject)), nanstd(obs_m2_ke)/sqrt(length(subject)),nanstd(obs_m3_ke)/sqrt(length(subject))],'.');
title('model fit to RT','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('weight of the entropy','FontSize',20)
xlim( [0.1,3.9])

figure
boxplot([obs_m1_ke,obs_m2_ke,obs_m3_ke])
title('model fit to RT','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('weight of the entropy','FontSize',20)



% the constant
figure
hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
bar([mean(obs_m1_kc),mean(obs_m2_kc),mean(obs_m3_kc)])
errorbar([mean(obs_m1_kc),mean(obs_m2_kc),mean(obs_m3_kc)],[nanstd(obs_m1_kc)/sqrt(length(subject)), nanstd(obs_m2_kc)/sqrt(length(subject)),nanstd(obs_m3_kc)/sqrt(length(subject))],'.');
title('model fit to RT','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('constant','FontSize',20)
xlim( [0.1,3.9])

figure
boxplot([obs_m1_kc,obs_m2_kc,obs_m3_kc])
title('model fit to RT','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('constant','FontSize',20)

% plot the posterior of the evolution parameter
figure
boxplot([evo_m2])
title('model fit to choice','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('bonus for winning in pairwise comparison','FontSize',20)


% plot the posterior distribution of X0
figure
for i = 1:length(subject)
    x_m2 = m2_rt.params(subject(i)).Rating_updated;
    subplot(3,4,i)
    histogram(x_m2(:,1),hist_bins)
    hold on
    histogram(x_m2(:,360),hist_bins)   
    title(['subject ',num2str(i)])
    xlabel('value range')
    ylabel('frequency')

end
%% confidence analysis

clearvars -except subject hist_bins
m1_conf = load('sdm_conf_model_fit_m_1.mat')
m2_conf = load('sdm_conf_model_fit_m_2.mat')
m3_conf = load('sdm_conf_model_fit_m_3.mat')

obs_m1_beta = safepos(m1_conf.params(1).Val_param_obs(subject,1));
obs_m2_beta = safepos(m2_conf.params(1).Val_param_obs(subject,1));
obs_m3_beta = safepos(m3_conf.params(1).Val_param_obs(subject,1));

obs_m1_ke = m1_conf.params(1).Val_param_obs(subject,2);
obs_m2_ke = m2_conf.params(1).Val_param_obs(subject,2);
obs_m3_ke = m3_conf.params(1).Val_param_obs(subject,2);

evo_m2 = m2_conf.params(1).Val_param_evo(subject);

% get the model evidence
m1_evidence = m1_conf.params(1).Rating_model_evidence(subject);
m2_evidence = m2_conf.params(1).Rating_model_evidence(subject);
m3_evidence = m3_conf.params(1).Rating_model_evidence(subject);

% do a model comparison of the second and third model, model 1 is outside
% of the picture because hidden states dimension is not aligned.
[posterior,out] = VBA_groupBMC([m1_evidence, m2_evidence,m3_evidence]')
[posterior,out] = VBA_groupBMC([m2_evidence,m3_evidence]')


% plot the posterior of observation parameter
figure
hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
bar([mean(obs_m1_beta),mean(obs_m2_beta),mean(obs_m3_beta)])
errorbar([mean(obs_m1_beta),mean(obs_m2_beta),mean(obs_m3_beta)],[nanstd(obs_m1_beta)/sqrt(length(subject)), nanstd(obs_m2_beta)/sqrt(length(subject)),nanstd(obs_m3_beta)/sqrt(length(subject))],'.');
title('model fit to confidence','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('inverse temp of obs function (safepos)','FontSize',20)
xlim( [0.1,3.9])

figure
boxplot([obs_m1_beta,obs_m2_beta,obs_m3_beta])
title('model fit to confidence','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('inverse temp of obs function (safepos)','FontSize',20)

% weight of the entropy
figure
hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
bar([mean(obs_m1_ke),mean(obs_m2_ke),mean(obs_m3_ke)])
errorbar([mean(obs_m1_ke),mean(obs_m2_ke),mean(obs_m3_ke)],[nanstd(obs_m1_ke)/sqrt(length(subject)), nanstd(obs_m2_ke)/sqrt(length(subject)),nanstd(obs_m3_ke)/sqrt(length(subject))],'.');
title('model fit to confidence','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('weight of the entropy','FontSize',20)
xlim( [0.1,3.9])

figure
boxplot([obs_m1_ke,obs_m2_ke,obs_m3_ke])
title('model fit to confidence','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('weight of the entropy','FontSize',20)

% plot the posterior of the evolution parameter
figure
boxplot([evo_m2])
title('model fit to confidence','FontSize',20)
xlabel ('model index','FontSize',20)
ylabel('bonus for winning in pairwise comparison','FontSize',20)




% plot the posterior of x0 when fitted to the confidence data
figure
for i = 1:length(subject)
    x_m2 = m2_conf.params(subject(i)).Rating_updated;
    subplot(3,4,i)
    histogram(x_m2(:,1),hist_bins)
    hold on
    histogram(x_m2(:,360),hist_bins) 
    title(['subject ',num2str(i)])
    xlabel('value range')
    ylabel('frequency')
end