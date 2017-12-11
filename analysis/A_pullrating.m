% Pull ratings of 5 categories together, category 1+2+3+4+5 = 15
clear
total_subject = [1:4,6:12];
N_item_percate = 86;
cate_total = 1:5;

[~, hostname] = system('hostname');
if strcmp(hostname(1:5),'MBB31')
    resultsdir = 'C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\';
else 
    resultsdir = '/Users/chen/Documents/GitHub/sdm/results_sdm/';
end
cd(resultsdir)

N_cate = length(cate_total);
for subid = total_subject
    rating_all = NaN(1,N_item_percate * N_cate);
    for cate_number = cate_total;
        subdir = strcat('sub',num2str(subid));
        load([resultsdir subdir filesep strcat('pleasantRating_subject_',num2str(subid),'_cate_',num2str(cate_number),'.mat')]);
        rating_all((cate_number - 1)*N_item_percate + 1: cate_number*N_item_percate) = ratingItem;
    end
    cd([resultsdir subdir])
    save(['pleasentRating_subject_',num2str(subid),'_cate_15.mat'],'rating_all')
    
end