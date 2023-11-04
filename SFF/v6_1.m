%% Task 6 (Point 8)

rng(123)

df      = 3;
ESlevel = 0.05;
N       = 500;
B       = 500;

nom_covg= 0.10;
sims    = 1000;

covered_para    = zeros([sims, 1]);
covered_nonpara = zeros([sims, 1]);
length_para     = zeros([sims, 1]);
length_nonpara  = zeros([sims, 1]);

for i = 1:sims
    
    [ES_true, lb_para, ub_para, lb_nonpara, ub_nonpara, ES_emp_para, ES_emp_nonpara] = ES_CI(df, ESlevel, N, B);
    
    lb = quantile(ES_emp_para, 0.05);
    ub = quantile(ES_emp_para, 0.95);

    length_para(i)  = ub - lb;
    covered_para(i) = (lb < ES_true) && (ES_true < ub);

    lb = quantile(ES_emp_nonpara, nom_covg/2);
    ub = quantile(ES_emp_nonpara, 1-nom_covg/2);

    length_nonpara(i)  = ub - lb;
    covered_nonpara(i) = (lb < ES_true) && (ES_true < ub);

end

%% Results

actual_coverage_para    = mean(covered_para);
actual_coverage_nonpara = mean(covered_nonpara);

mean_length_para    = mean(length_para);
mean_length_nonpara = mean(length_nonpara);
