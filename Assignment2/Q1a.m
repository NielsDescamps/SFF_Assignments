clear variables

rng(6,'twister');
nu = 3;
sampleSize = 250;

sample = trnd(nu,sampleSize,1); 

% opt_tol_titer = get_titerOptimalTolerance(sample);
opt_tol_BFGS = get_BFGSOptimalTolerance(sample,nu);

[muhat_opt, chat_opt, dfhat_opt] = calc_BFGS(sample,nu,9e-3);

sims = 100;
opt_tols_titer = zeros(sims,1);
opt_tols_BFGS = zeros(sims,1);

for seed = 1:sims
    rng(seed,'twister');
    sample = trnd(nu,sampleSize,1);

    toli_titer = get_titerOptimalTolerance(sample);
    toli_BFGS = get_BFGSOptimalTolerance(sample,nu);
    opt_tols_titer(seed) = toli_titer;
    opt_tols_BFGS(seed) = toli_BFGS;
end

[f, x] = ksdensity(opt_tols_titer,'Function','pdf','Bandwidth', 0.00001, 'Kernel', 'epanechnikov', 'NumPoints', 1000);
figure
plot(x,f./sum(f));
title('density of "optimal" tolerance for titer')
xlabel('tolerance level')
ylabel('pdf')
file_name = ['figures/pdfOptToleranceValues_tist.png'];
saveas(gcf,file_name)

figure
[f, x] = ksdensity(opt_tols_BFGS,'Function','pdf','Bandwidth', 0.0001, 'Kernel', 'epanechnikov', 'NumPoints', 1000);
plot(x,f./sum(f));
title('density of "optimal" tolerance for BFGS')
xlabel('tolerance level')
ylabel('pdf')
file_name = ['figures/pdfOptTolerance_BFGS.png'];
saveas(gcf,file_name)


