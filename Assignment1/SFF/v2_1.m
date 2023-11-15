% % ASSIGNMENT 2: plotting density and density by inversion formula of
% Student's s

% v, Xrange, NumPoints, distribution
% x_min = -x_range/2; x_max = x_range/2;
% dx = (x_max-x_min)/(N-1);
% x = x_min:dx:x_max;

% STEPS TO TAKE:
% 1. Make a function out of this
% 2. Make sure that nu is not negative. Throw error if it is.

nu      = 3;
bounds  = 6 / nu^(1/4);
xPoints = 1000;

x_u = bounds;
x_d = -bounds; 
dx = (x_u - x_d) / (xPoints - 1);

x   = x_d:dx:x_u;
y1  = tpdf(x, nu);
y2  = comp_tINV(nu, bounds, xPoints, 't');

% y2 = comp_tINV(nu, bounds, xPoints, 't') .* comp_tINV(nu, bounds, xPoints, 't');

rel_error = abs(y2 - y1) ./ y1;

% Plot 1: density and density computed using the inversion formula

figure
plot(x,y1,'blue',x,y2,'red','LineWidth',2.0);
title('Density of Student`t s');
xlabel('X');
ylabel('f(x)');
legend('Density','Inversion');
xlim([x_d,x_u]);

% plot 2: relative percentage error between the two
figure
plot(x,rel_error, 'red', 'Linewidth', 3.0)
title('Relative percentage error between exact and inversion-computed density')
xlabel('X')
ylabel('Relative Error (%)')

