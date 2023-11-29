% Q2: plot density obtained through inversion formula

%% characteristic function of student-t
dof = 2; 
x_range = 12;
N = 1000;

pdf_ievals = calc_tpdf_inversion(dof,x_range,N,'t');

%% exact distribution 
x = linspace(-x_range/2,x_range/2,N);
pdf_evals = tpdf(x,dof);

%% plots 

% plot 1: exact and inversion formula computed density function 
figure
plot(x,pdf_ievals)
hold on 
plot(x,pdf_evals)

xlabel('x')
ylabel('pdf')
legend('inv','exact','Location','best')
title(['Probability density of student-t distribution with dof=',num2str(dof),' using the exact and inversion formula'])

% plot 2: relative error between the two 
rel_error = abs(pdf_ievals-pdf_evals)./pdf_evals;
figure
plot(x,rel_error)
title(['Relative error between inversion and exact formula (dof=',num2str(dof),')'])
xlabel('x')
ylabel('relative error')
filename = ['figures/rel_error_dof',num2str(dof),'.png'];
saveas(gcf,filename)
