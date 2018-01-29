clear all
subid = [1:18,20:24];
% trial_number = 72;
plotwidth = 2;
 [~, hostname] = system('hostname')
    if strcmp(hostname(1:5),'MBB31')
        resultsdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\'];    
        plotsdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_plot\'];        
    else
        resultsdir = ['/Users/chen/Documents/GitHub/sdm/results_sdm/'];    
        plotsdir = ['/Users/chen/Documents/GitHub/sdm/results_plot/'];        
    end
    cd(resultsdir)
    
    
itemnumber_index = 6;
highpos_index = 7;
highpos2_index = 8;
rt_index = 40;
choice_index = 39;
conf_index = 41;

cate_total = [15];

for cate_number = cate_total;
    bin_simu_rt= {};
    bin_simu_choice = {};
    
    for subj = subid;
        subdir = strcat('sub',num2str(subj));
        load([resultsdir subdir filesep strcat('choice_subject_',num2str(subj),'cate_',num2str(cate_number),'.mat')]);  
        
        itnum =  choice_data(:,itemnumber_index);
        bpos =  choice_data(:,highpos_index);
        rt_order  = choice_data(:,rt_index); 
        conf_order  = choice_data(:,conf_index); 
        choice_order = choice_data(:,choice_index);
        
        C1_hzero = [];
        for q = 1:length(choice_order)
            if choice_order(q) ==  bpos(q)
                C1_hzero(q) = 1;
            else
                C1_hzero(q) = 0;
            end
        end
        
        
        
        % get 3 items trials
        for i   = 1:3
            items3 = find(itnum == 3);
            pos = bpos(items3);
            pos_bin = (find(pos ==i));
            bin_simu(subj). items3_1{i} = items3(pos_bin);
            
            bin_simu(subj). H0_rt_3{i} = rt_order(bin_simu(subj). items3_1{i});  
            bin_simu(subj). H0_choice_3{i} = C1_hzero(bin_simu(subj). items3_1{i});  
            bin_simu(subj). H0_conf_3{i} = conf_order(bin_simu(subj). items3_1{i});  

            m_h0_3_1_rt(subj,i) = nanmedian(bin_simu(subj). H0_rt_3{i});
            m_h0_3_1_choice(subj,i) = nanmean(bin_simu(subj). H0_choice_3{i});            
            m_h0_3_1_conf(subj,i) = nanmean(bin_simu(subj). H0_conf_3{i});
        end     

    
    % get 4 items trials
        for i   = 1:4
            items4 = find(itnum == 4);
            pos = bpos(items4);
            pos_bin = (find(pos ==i));
            bin_simu(subj). items4_1{i} = items4(pos_bin);
            
            bin_simu(subj). H0_rt_4{i} = rt_order(bin_simu(subj). items4_1{i});  
            bin_simu(subj). H0_choice_4{i} = C1_hzero(bin_simu(subj). items4_1{i});  
            bin_simu(subj). H0_conf_4{i} = conf_order(bin_simu(subj). items4_1{i});  

            m_h0_4_1_rt(subj,i) = nanmedian(bin_simu(subj). H0_rt_4{i});
            m_h0_4_1_choice(subj,i) = nanmean(bin_simu(subj). H0_choice_4{i});
            m_h0_4_1_conf(subj,i) = nanmean(bin_simu(subj). H0_conf_4{i});
        end

            
        % get 5 items trials
        for i   = 1:5
            items5 = find(itnum == 5);
            pos = bpos(items5);
            pos_bin = (find(pos ==i));
            bin_simu(subj). items5_1{i} = items5(pos_bin);
            
            bin_simu(subj). H0_rt_5{i} = rt_order(bin_simu(subj). items5_1{i});  
            bin_simu(subj). H0_choice_5{i} = C1_hzero(bin_simu(subj). items5_1{i});  
            bin_simu(subj). H0_conf_5{i} = conf_order(bin_simu(subj). items5_1{i});  

            m_h0_5_1_rt(subj,i) = nanmedian(bin_simu(subj). H0_rt_5{i});
            m_h0_5_1_choice(subj,i) = nanmean(bin_simu(subj). H0_choice_5{i});            
            m_h0_5_1_conf(subj,i) = nanmean(bin_simu(subj). H0_conf_5{i});
        end
 
    
     
    % get 6 items trials
        for i   = 1:6
            items6 = find(itnum == 6);
            pos = bpos(items6);
            pos_bin = (find(pos ==i));
            bin_simu(subj). items6_1{i} = items6(pos_bin);
            
            bin_simu(subj). H0_rt_6{i} = rt_order(bin_simu(subj). items6_1{i});  
            bin_simu(subj). H0_choice_6{i} = C1_hzero(bin_simu(subj). items6_1{i});  
            bin_simu(subj). H0_conf_6{i} = conf_order(bin_simu(subj). items6_1{i});  

            m_h0_6_1_rt(subj,i) = nanmedian(bin_simu(subj). H0_rt_6{i});
            m_h0_6_1_choice(subj,i) = nanmean(bin_simu(subj). H0_choice_6{i});            
            m_h0_6_1_conf(subj,i) = nanmean(bin_simu(subj). H0_conf_6{i});

        end

        
    end
    m_h0_3_1_rt = m_h0_3_1_rt(subid,:);
    m_h0_3_1_choice = m_h0_3_1_choice(subid,:);
    m_h0_3_1_conf = m_h0_3_1_conf(subid,:);

    m_h0_4_1_rt = m_h0_4_1_rt(subid,:);
    m_h0_4_1_choice = m_h0_4_1_choice(subid,:);   
    m_h0_4_1_conf = m_h0_4_1_conf(subid,:);   

    m_h0_5_1_rt = m_h0_5_1_rt(subid,:);
    m_h0_5_1_choice = m_h0_5_1_choice(subid,:);    
    m_h0_5_1_conf = m_h0_5_1_conf(subid,:);    

    m_h0_6_1_rt = m_h0_6_1_rt(subid,:);
    m_h0_6_1_choice = m_h0_6_1_choice(subid,:);    
     m_h0_6_1_conf= m_h0_6_1_conf(subid,:);    
   
    beta_rt = [];
    beta_choice = [];
    beta_conf = [];
    
    for k = 1:length(subid)
           b = glmfit([1:3], m_h0_3_1_rt(k,:), 'normal' );  beta_rt(1,k) = b(2);
           b = glmfit([1:3], m_h0_3_1_choice(k,:), 'normal');  beta_choice(1,k) = b(2);
           b = glmfit([1:3], m_h0_3_1_conf(k,:), 'normal');  beta_conf(1,k) = b(2);

           b = glmfit([1:4], m_h0_4_1_rt(k,:), 'normal'); beta_rt(2,k) = b(2);
           b = glmfit([1:4], m_h0_4_1_choice(k,:), 'normal');  beta_choice(2,k) = b(2);
           b = glmfit([1:4], m_h0_4_1_conf(k,:), 'normal');  beta_conf(2,k) = b(2);

           b = glmfit([1:5], m_h0_5_1_rt(k,:), 'normal');  beta_rt(3,k) = b(2);
           b = glmfit([1:5], m_h0_5_1_choice(k,:), 'normal');  beta_choice(3,k) = b(2);  
           b = glmfit([1:5], m_h0_5_1_conf(k,:), 'normal');  beta_conf(3,k) = b(2);

           b = glmfit([1:6], m_h0_6_1_rt(k,:), 'normal'); beta_rt(4,k) = b(2);
           b = glmfit([1:6], m_h0_6_1_choice(k,:), 'normal');   beta_choice(4,k) = b(2);         
           b = glmfit([1:6], m_h0_6_1_conf(k,:), 'normal');  beta_conf(4,k) = b(2);
    end
    
    figure
    subplot(1,3,1)
    hold on, set(gca,'fontsize',20)  
    bar(mean(mean(beta_rt)));
    errorbar(mean(mean(beta_rt)),nanstd(mean(beta_rt))/sqrt(length(subid)),'.');
    xlabel('order')
    ylabel ('beta RT')
    
    subplot(1,3,2)
    hold on, set(gca,'fontsize',20)  
    bar(mean(mean(beta_choice)));
    errorbar(mean(mean(beta_choice)),nanstd(mean(beta_choice))/sqrt(length(subid)),'.');
    xlabel('order')
    ylabel ('beta choice')    
    
    subplot(1,3,3)
    hold on, set(gca,'fontsize',20)  
    bar(mean(mean(beta_conf)));
    errorbar(mean(mean(beta_conf)),nanstd(mean(beta_conf))/sqrt(length(subid)),'.');
    xlabel('order')
    ylabel ('beta confidence')   
end
   
[h,p,ci,stats] = ttest(mean(beta_choice))  % 0.3 - 
[h,p,ci,stats] = ttest(mean(beta_rt))  % 0.4 + 
[h,p,ci,stats] = ttest(mean(beta_conf)) % 0.09 -

    
    