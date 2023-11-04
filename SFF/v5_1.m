%% Task 5.


df      = 3;
ESlevel = 0.05;
N       = 500;
B       = 500;

[ES_true, lb_para, ub_para, lb_nonpara, ub_nonpara, ES_emp_para, ES_emp_nonpara] = ES_CI(df, ESlevel, N, B);

%% Plotting

figure(1)
boxplot(ES_emp_para)
title('Empirical ES Boxplot under Parametric Bootstrap');
xlabel('Empirical ES');

figure(2)
boxplot(ES_emp_nonpara)
title('Empirical ES Boxplot under Non-Parametric Bootstrap');
xlabel('Empirical ES');

%% Boxplots compared
ES_emp  = vertcat(ES_emp_para, ES_emp_nonpara);
temp1 = repelem("Parametric", size(ES_emp_para, 1));
temp2 = repelem("Non-Parametric", size(ES_emp_para, 1));
boot = vertcat(temp1', temp2');

figure(3)
boxplot(ES_emp, boot)
title('Empirical ES Boxplot under Parametric & Non-Parametric Bootstrap')
hold on
plot([0.001 5], [ES_true ES_true], '--', 'Color', 'green', 'LineWidth', 2)
legend('true ES')
