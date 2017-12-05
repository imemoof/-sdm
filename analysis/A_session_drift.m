clear all
subid = [2:4,6,8,9,11];
% trial_number = 72;
plotwidth = 2;
 [~, hostname] = system('hostname')
 [~, hostname] = system('hostname')
    if strcmp(hostname(1:5),'MBB31')
        resultsdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\'];    
        plotsdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_plot\'];        
    else
        resultsdir = ['/Users/chen/Documents/GitHub/sdm/results_sdm/'];    
        plotsdir = ['/Users/chen/Documents/GitHub/sdm/results_plot/'];        
    end
    cd(resultsdir)

session_order_index = 4;       
itemnumber_index = 6;% how many items in this trial

highpos_index = 7;      % the position of the higest valued item
choice_index = 39;

rt_index = 40;          % response time index
confidence_index = 41;

cate_total = [15];
mean_rt_3 = [];mean_rt_4 = []; mean_rt_5 = []; mean_rt_6 = [];
mean_confidence_3 = [];mean_confidence_4 = []; mean_confidence_5 = []; mean_confidence_6 = [];

for cate_number = cate_total;
    bin_simu = {};
    for i = 1:length(subid);
        subj = subid(i);
        subdir = strcat('sub',num2str(subj));
        load([resultsdir subdir filesep strcat('choice_subject_',num2str(subj),'cate_',num2str(cate_number),'.mat')]);  
        for g = 1:5
            rt_3items = megafind(choice_data,[session_order_index, itemnumber_index],{g,3},rt_index);
            rt_4items = megafind(choice_data,[session_order_index, itemnumber_index],{g,4},rt_index);
            rt_5items = megafind(choice_data,[session_order_index, itemnumber_index],{g,5},rt_index);
            rt_6items = megafind(choice_data,[session_order_index, itemnumber_index],{g,6},rt_index);
            mean_rt_3(i,g) = nanmean(rt_3items);
            mean_rt_4(i,g) = nanmean(rt_4items);
            mean_rt_5(i,g) = nanmean(rt_5items);
            mean_rt_6(i,g) = nanmean(rt_6items);    
        end
        
        for g = 1:5
            confidence_3items = megafind(choice_data,[session_order_index, itemnumber_index],{g,3},confidence_index);
            confidence_4items = megafind(choice_data,[session_order_index, itemnumber_index],{g,4},confidence_index);
            confidence_5items = megafind(choice_data,[session_order_index, itemnumber_index],{g,5},confidence_index);
            confidence_6items = megafind(choice_data,[session_order_index, itemnumber_index],{g,6},confidence_index);
            mean_confidence_3(i,g) = nanmean(confidence_3items);
            mean_confidence_4(i,g) = nanmean(confidence_4items);
            mean_confidence_5(i,g) = nanmean(confidence_5items);
            mean_confidence_6(i,g) = nanmean(confidence_6items); 
        end
    end

% plot the probability of chosing the best option
    figure
    % subplot(1,2,1), 
    hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
    errorbar(nanmean(mean_rt_3), nanstd(mean_rt_3)/sqrt(length(subid)),'Color','b', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_rt_4), nanstd(mean_rt_4)/sqrt(length(subid)),'Color','m', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_rt_5), nanstd(mean_rt_5)/sqrt(length(subid)),'Color','g', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_rt_6), nanstd(mean_rt_6)/sqrt(length(subid)),'Color','r', 'LineWidth',plotwidth)
    legend('3 items','4 items','5 items', '6 items');
    ylabel ('mean responset time')
    xlabel('session order')
    cd(plotsdir);saveas(gcf,['RT_session_order.tif']);
    
    figure
    % subplot(1,2,1), 
    hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
    errorbar(nanmean(mean_confidence_3),nanstd(mean_confidence_3)/sqrt(length(subid)),'Color','b', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_confidence_4),nanstd(mean_confidence_4)/sqrt(length(subid)),'Color','m', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_confidence_5),nanstd(mean_confidence_5)/sqrt(length(subid)),'Color','g', 'LineWidth',plotwidth)
    errorbar(nanmean(mean_confidence_6),nanstd(mean_confidence_6)/sqrt(length(subid)),'Color','r', 'LineWidth',plotwidth)
    legend('3 items','4 items','5 items', '6 items');
    ylabel ('mean confidence level')
    xlabel('session order')
    cd(plotsdir);saveas(gcf,['conf_session_order.tif']);    
    
end

