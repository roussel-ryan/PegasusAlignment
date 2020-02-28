clear all
%testing script
t1 = linspace(-1,1,3);
t2 = linspace(-1,1,3);

[tt1,tt2] = meshgrid(t1,t2);

cen = 1 + 2*tt1(:) + 3*tt2(:) + 0.5 * rand(size(tt1(:)));

plot3(tt1(:),tt2(:),cen,'.')

one_col = ones(1,length(cen)).';
test_data = [tt1(:) one_col tt2(:) one_col cen one_col];

[fit,MSE] = phase1_fit(test_data,'x')
