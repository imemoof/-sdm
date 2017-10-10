clear all
total_subject = [1:4,6:12];
trial_number = 72;

 [~, hostname] = system('hostname')
    if strcmp(hostname(1:5),'MBB31')
        resultsdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\'];    
        plotsdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_plot\'];        
%     elseif strcmp(hostname(1:6),'PRISME')
%         resultdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\'];        
    end
    confidence_index = 41;
    
    cd(resultsdir)
    cate_total = [1:5];
    DATA_confidence = {};
for cate_number = cate_total;
    rating = [];
    for subid = total_subject
        subdir = strcat('sub',num2str(subid));
        load([resultsdir subdir filesep strcat('choice_subject_',num2str(subid),'cate_',num2str(cate_number),'.mat')]);   
        rating = [rating;choice_data(:,confidence_index)];
    end
    DATA_confidence{cate_number} = [rating];
end
save('DATA_allsubjects_confidence','DATA_confidence') ;

figure
hold on
set(gca,'fontsize',16)
%set(gca,'LineWidth',2)
for cate_number = cate_total;
    a = DATA_confidence{cate_number};
    b = reshape(a,[trial_number*length(total_subject),1]);
    [f,xi,bw] = ksdensity(b);
    plot(xi,f,'LineWidth',2)
end
legend('Fruits & Veg', 'Snacks', 'Music','Magazines','Movies');

xlabel('subject rating (n = 11)')
ylabel('cpnfidence rating distribution')
h1 = plot([0,0],[0,0.05],'m--');
h2 = plot([100,100],[0,0.05],'m--')  
set(get(get(h1,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(h2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
cd(plotsdir);saveas(gcf,['confidence_distribution.tif']);
