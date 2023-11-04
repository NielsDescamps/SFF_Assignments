% ASSIGNMENT 3.

% Make a computer program that inputs 2 degrees of freedom values
% and plots, on the same plot, 3 lines:

% a. the result of using the integral convolution formula for sums of two independent Student t random variables
% Let each distribution have zero location and unit scale term.

nu     = 3;
bounds  = 6 / nu^(1/4);
xPoints = 1000;

x_u = bounds;
x_d = -bounds; 
dx = (x_u - x_d) / (xPoints - 1);

x   = x_d:dx:x_u;
y1  = tpdf(x, nu);
y2 = comp_tINV_SUM(nu1, bounds, xPoints, 't');

rel_error = abs(y2 - y1) ./ y1;

% Plot 1: density of sums of two independent Student t r.v.s computed using the inversion formula

figure
plot(x,y1,'blue',x,y2,'red','LineWidth',2.0);
title('Density of Student`t s');
xlabel('X');
ylabel('f(x)');
legend('Density','Inversion');
xlim([x_d,x_u]);



