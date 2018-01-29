% Pull the 5 categories together, category 1+2+3+4+5 = 15
clear all
total_subject = [1:18,20:24];

 [~, hostname] = system('hostname')
    if strcmp(hostname(1:5),'MBB31')
        resultsdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\'];           
    end
    cd(resultsdir)
    
    cate_total = [1:5];
    for subid = total_subject
            
        choice_results = [];
        for cate_number = cate_total;
            subdir = strcat('sub',num2str(subid));
            load([resultsdir subdir filesep strcat('choice_subject_',num2str(subid),'cate_',num2str(cate_number),'.mat')]); 
%             % Get rid of data where choice trials are not correct or too
%             slow
            for q = 1:length(choice_data)
                if choice_data(q,39) > 10
                    choice_data(q,39) = NaN;
                    choice_data(q,40) = NaN;
                    choice_data(q,41) = NaN;
                end
            end
            
                
            choice_results  = [choice_results;choice_data];
        end
        choice_data = choice_results;
        cd([resultsdir subdir])
        save(['choice_subject_',num2str(subid),'cate_15.mat'],'choice_data')
        
    end