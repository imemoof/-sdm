%%  Plot the choice probability of each condition (3-6 items) in each bin under H0 and H1

% bin the data into corresponding bins
bin_simu = {};
for subj = subid
        itnum =  cell2mat(trial_simu(subj).itemNumber);
        P1_hzero  = cell2mat(trial_simu(subj).P1_hzero) ;
        P2_hzero  = cell2mat(trial_simu(subj).P2_hzero) ;
        P1_hone  = cell2mat(trial_simu(subj).P1_hone) ;
        P2_hone  = cell2mat(trial_simu(subj).P2_hone) ;   
        bpos =  cell2mat(trial_simu(subj).highPosition);
        bpos2 =  cell2mat(trial_simu(subj).highPositionSec);       
    % get 3 items trials
 
    
    for i   = 1:3
        items3 = find(itnum == 3);
        pos = bpos(items3);
        pos2 = bpos2(items3);
        pos_bin = (find(pos ==i));
        pos_bin2 = (find(pos2 ==i));
        bin_simu(subj). items3_1{i} = items3(pos_bin);
        bin_simu(subj). items3_2{i} = items3(pos_bin2);

        bin_simu(subj). H0_choice1_3{i} = P1_hzero(bin_simu(subj). items3_1{i});   m_h0_3_1(subj,i) = mean(bin_simu(subj). H0_choice1_3{i});
        bin_simu(subj). H1_choice1_3{i} = P1_hone(bin_simu(subj). items3_1{i} );   m_h1_3_1(subj,i) = mean(bin_simu(subj). H1_choice1_3{i});
        bin_simu(subj). H0_choice2_3{i} = P2_hzero(bin_simu(subj). items3_2{i} );  m_h0_3_2(subj,i) = mean(bin_simu(subj). H0_choice2_3{i});        
        bin_simu(subj). H1_choice2_3{i} = P2_hone(bin_simu(subj). items3_2{i} );   m_h1_3_2(subj,i) = mean(bin_simu(subj). H1_choice2_3{i});
    end     
    
    
    % get 4 items trials
    for i   = 1:4
        items4 = find(itnum == 4);
        pos = bpos(items4);
        pos2 = bpos2(items4);
        pos_bin = (find(pos ==i));
        pos_bin2 = (find(pos2 ==i));
        bin_simu(subj). items4_1{i} = items4(pos_bin);
        bin_simu(subj). items4_2{i} = items4(pos_bin2);

        bin_simu(subj). H0_choice1_4{i} = P1_hzero(bin_simu(subj). items4_1{i});  m_h0_4_1(subj,i) = mean(bin_simu(subj). H0_choice1_4{i});
        bin_simu(subj). H1_choice1_4{i} = P1_hone(bin_simu(subj). items4_1{i});   m_h1_4_1(subj,i) = mean(bin_simu(subj). H1_choice1_4{i});
        bin_simu(subj). H0_choice2_4{i} = P2_hzero(bin_simu(subj). items4_2{i});  m_h0_4_2(subj,i) = mean(bin_simu(subj). H0_choice2_4{i});        
        bin_simu(subj). H1_choice2_4{i} = P2_hone(bin_simu(subj). items4_2{i});   m_h1_4_2(subj,i) = mean(bin_simu(subj). H1_choice2_4{i});
    end     
     
    % get 5 items trials
    for i   = 1:5
        items5 = find(itnum == 5);
        pos = bpos(items5);
        pos2 = bpos2(items5);
        pos_bin = (find(pos ==i));
        pos_bin2 = (find(pos2 ==i));
        bin_simu(subj). items5_1{i} = items5(pos_bin);
        bin_simu(subj). items5_2{i} = items5(pos_bin2);

        bin_simu(subj). H0_choice1_5{i} = P1_hzero(bin_simu(subj). items5_1{i});   m_h0_5_1(subj,i) = mean(bin_simu(subj). H0_choice1_5{i});
        bin_simu(subj). H1_choice1_5{i} = P1_hone(bin_simu(subj). items5_1{i} );   m_h1_5_1(subj,i) = mean(bin_simu(subj). H1_choice1_5{i});
        bin_simu(subj). H0_choice2_5{i} = P2_hzero(bin_simu(subj). items5_2{i} );  m_h0_5_2(subj,i) = mean(bin_simu(subj). H0_choice2_5{i});       
        bin_simu(subj). H1_choice2_5{i} = P2_hone(bin_simu(subj). items5_2{i} );   m_h1_5_2(subj,i) = mean(bin_simu(subj). H1_choice2_5{i});
    end     
    
     
    % get 6 items trials
     for i   = 1:6
        items6 = find(itnum == 6);
        pos = bpos(items6);
        pos2 = bpos2(items6);
        pos_bin = (find(pos ==i));
        pos_bin2 = (find(pos2 ==i));
        bin_simu(subj). items6_1{i} = items6(pos_bin);
        bin_simu(subj). items6_2{i} = items6(pos_bin2);

        bin_simu(subj). H0_choice1_6{i} = P1_hzero(bin_simu(subj). items6_1{i});   m_h0_6_1(subj,i) = mean(bin_simu(subj). H0_choice1_6{i});
        bin_simu(subj). H1_choice1_6{i} = P1_hone(bin_simu(subj). items6_1{i});   m_h1_6_1(subj,i) = mean(bin_simu(subj). H1_choice1_6{i});
        bin_simu(subj). H0_choice2_6{i} = P2_hzero(bin_simu(subj). items6_2{i});  m_h0_6_2(subj,i) = mean(bin_simu(subj). H0_choice2_6{i});        
        bin_simu(subj). H1_choice2_6{i} = P2_hone(bin_simu(subj). items6_2{i});   m_h1_6_2(subj,i) = mean(bin_simu(subj). H1_choice2_6{i});
    end     
end

% plot the probability of chosing the best option
figure
subplot(1,2,1), hold on, set(gca,'fontsize',20)%,ylim([0.75, 1])
errorbar(mean(m_h0_3_1),std(m_h0_3_1)/sqrt(length(subid)),'Color','b', 'LineWidth',plotwidth)
errorbar(mean(m_h0_4_1),std(m_h0_4_1)/sqrt(length(subid)),'Color','m', 'LineWidth',plotwidth)
errorbar(mean(m_h0_5_1),std(m_h0_5_1)/sqrt(length(subid)),'Color','g', 'LineWidth',plotwidth)
errorbar(mean(m_h0_6_1),std(m_h0_6_1)/sqrt(length(subid)),'Color','r', 'LineWidth',plotwidth)
legend('3 items','4 items','5 items', '6 items');
ylabel (' best option choice proba')
title (' Simulation of H0')

subplot(1,2,2), hold on,set(gca,'fontsize',20)%,ylim([0.75, 1])
errorbar(mean(m_h1_3_1),std(m_h1_3_1)/sqrt(length(subid)),'Color','b', 'LineWidth',plotwidth)
errorbar(mean(m_h1_4_1),std(m_h1_4_1)/sqrt(length(subid)),'Color','m', 'LineWidth',plotwidth)
errorbar(mean(m_h1_5_1),std(m_h1_5_1)/sqrt(length(subid)),'Color','g', 'LineWidth',plotwidth)
errorbar(mean(m_h1_6_1),std(m_h1_6_1)/sqrt(length(subid)),'Color','r', 'LineWidth',plotwidth)
legend('3 items','4 items','5 items', '6 items');
ylabel (' best option choice proba')
title (['Simulation of H1 (betaC = ',num2str(beta),')'])
set(gcf, 'Position', [0, 0, 1600, 600])
cd(imgdir);saveas(gcf,['beta',num2str(beta*100),'_P1.tif']);



% plot the probability of chosing the second best option
figure 
subplot(1,2,1), hold on, set(gca,'fontsize',20) %,ylim([0.75, 1])
errorbar(nanmean(m_h0_3_2),nanstd(m_h0_3_2)/sqrt(length(subid)),'Color','b', 'LineWidth',plotwidth)
errorbar(nanmean(m_h0_4_2),nanstd(m_h0_4_2)/sqrt(length(subid)),'Color','m', 'LineWidth',plotwidth)
errorbar(nanmean(m_h0_5_2),nanstd(m_h0_5_2)/sqrt(length(subid)),'Color','g', 'LineWidth',plotwidth)
errorbar(nanmean(m_h0_6_2),nanstd(m_h0_6_2)/sqrt(length(subid)),'Color','r', 'LineWidth',plotwidth)
legend('3 items','4 items','5 items', '6 items');
ylabel (' 2nd best option choice proba')
title (' Simulation of H0')

subplot(1,2,2), hold on,set(gca,'fontsize',20) %,ylim([0.75, 1])
errorbar(nanmean(m_h1_3_2),nanstd(m_h1_3_2)/sqrt(length(subid)),'Color','b', 'LineWidth',plotwidth)
errorbar(nanmean(m_h1_4_2),nanstd(m_h1_4_2)/sqrt(length(subid)),'Color','m', 'LineWidth',plotwidth)
errorbar(nanmean(m_h1_5_2),nanstd(m_h1_5_2)/sqrt(length(subid)),'Color','g', 'LineWidth',plotwidth)
errorbar(nanmean(m_h1_6_2),nanstd(m_h1_6_2)/sqrt(length(subid)),'Color','r', 'LineWidth',plotwidth)
legend('3 items','4 items','5 items', '6 items');
ylabel (' 2nd best option choice proba')
title (['Simulation of H1 (betaC = ',num2str(beta),')'])
set(gcf, 'Position', [0, 0, 1600, 600])
cd(imgdir); saveas(gcf,['beta',num2str(beta*100),'_P2.tif']);