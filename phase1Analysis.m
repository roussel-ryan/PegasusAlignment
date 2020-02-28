clear all
clf
%script to do analysis of phase1
data = load('-mat', 'alignmet_master');

data_off = data.data_off;
data_on = data.data_on;

%clean data (remove negative centroid data points
data_off = data_off(find(data_off(:,5) > 0),:); 
data_on = data_on(find(data_on(:,5) > 0),:); 

[fit_off, MSE_off] = phase1_fit(data_off,'x');
[fit_on, MSE_on] = phase1_fit(data_on,'x');

hold on
% plot raw data
plot3(data_off(:,1),data_off(:,3),data_off(:,5),'ro','MarkerFaceColor','r')
plot3(data_on(:,1),data_on(:,3),data_on(:,5),'go','MarkerFaceColor','g')

% plot fits
x = linspace(min([data_off(:,1);data_on(:,1)]),max([data_off(:,1);data_on(:,1)]));
y = linspace(min([data_off(:,3);data_on(:,3)]),max([data_off(:,3);data_on(:,3)]));

[xx,yy] = meshgrid(x,y);
off_fit = fit_off(1) + fit_off(2)*xx + fit_off(3)*yy;
on_fit = fit_on(1) + fit_on(2)*xx + fit_on(3)*yy;
s_off = surf(xx,yy,off_fit);
s_on = surf(xx,yy,on_fit);

A = fit_on(1) - fit_off(1);
B = fit_on(2) - fit_off(2);
C = fit_on(3) - fit_off(3);

intersect_fit = [-A/B -C/B];
temp = [y*0+1; y];
t_1_intersect = intersect_fit*temp;
plot3(t_1_intersect,y,fit_off(1) + fit_off(2)*t_1_intersect + fit_off(3)*y,'black')

set(s_off,'FaceColor',[1 0 0],'FaceAlpha',0.5,'EdgeColor','none')
set(s_on,'FaceColor',[0 1 0],'FaceAlpha',0.5,'EdgeColor','none')

MSE_off
MSE_on

xlabel('Trim 1 Strength (arb. u.)')
ylabel('Trim 2 Strength (arb. u.)')
zlabel('<x> (px)')

view(24,12)

print('phase1Analysis_plot', '-dpdf')
hold off