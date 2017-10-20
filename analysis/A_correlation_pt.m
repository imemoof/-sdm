clear all
subid = [1:4,6:12];
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
pt_index = [33:38];
value_index = [15:20];

cate_total = [15];

for cate_number = cate_total;
    bin_simu_rt= {};
    bin_simu_choice = {};
    
    dv_subject = [];
    pt_subject = [];
    
    for subj = subid;
        subdir = strcat('sub',num2str(subj));
        load([resultsdir subdir filesep strcat('choice_subject_',num2str(subj),'cate_',num2str(cate_number),'.mat')]);  
        
        itnum =  choice_data(:,itemnumber_index);
        pt_order  = choice_data(:,pt_index); 
        values_order = choice_data(:,value_index);
        dv = [];
        pt = [];
        
        for k = 1:length(itnum)
            v = values_order(k,:);
            pptt = pt_order(k,:);
            itemnumm = itnum(k);
           dvdv = [];     
           dvdv(1) = v(1);
           dvdv(2) = abs(v(2) - v(1));
           dvdv(3) = abs(v(3) - max(v(1:2)));
           if itemnumm == 4            
               dvdv(4) = abs(v(4) - max(v(1:3)));         
           elseif itemnumm == 5
               dvdv(4) = abs(v(4) - max(v(1:3)));         
                dvdv(5) = abs(v(5) - max(v(1:4)));         
           elseif itemnumm == 6
                 dvdv(4) = abs(v(4) - max(v(1:3)));         
                dvdv(5) = abs(v(5) - max(v(1:4)));        
                dvdv(6) = abs(v(6) - max(v(1:5)));      
           end  
           dv = [dv,dvdv];
           pt = [pt,(pptt(~isnan(pptt)));];     
        end
        dv_subject = [dv_subject;dv];
        pt_subject = [pt_subject;pt];
        
    end

end

for k = 1:length(subid)
           b = glmfit(dv_subject(k,:), pt_subject(k,:), 'normal' );  
           beta_pt(k) = b(2);
           constant_pt(k) = b(1);
end
    
    % mean = -0.4808, p  = 0.64
    