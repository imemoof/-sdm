clear all
col = hsv(100); % generate 10 colors
col = col(randperm(100),:);

beta = [0.01, 0.025, 0.04, 0.05, 0.1,0.2,0.5,1];
legendstr = {};

figure, 
subplot(1,2,1), hold on,set(gca,'fontsize',20)
dv = [-99:1:99];
for i = 1: length(beta)
    b = beta(i);
    proba = 1./(1 + exp(dv*(-1)*b));
    plot(dv,proba,'LineWidth',2,'Color',col(i,:))
    legendstr{i} = ['beta = ', num2str(b)];
end
 legend(legendstr);
 xlabel('value difference')
 title('range 100')
 
subplot(1,2,2), hold on,set(gca,'fontsize',20)
dv = [-19:1:19];
for i = 1: length(beta)
    b = beta(i);
    proba = 1./(1 + exp(dv*(-1)*b));
    plot(dv,proba,'LineWidth',2,'Color',col(i,:))
    legendstr{i} = ['beta = ', num2str(b)];
end
 legend(legendstr);
 xlabel('value difference')
 title ('range 20')