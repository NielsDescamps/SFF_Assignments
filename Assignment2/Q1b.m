clear variables 

%% Set the tolerance levels for BFGS and titer to optimal values
tol_titer = 1e-3;
tol_BFGS = 1e-2;
df = 3;

seed=6;
rng(seed,'twister')

%% Generate k samples of size T with trnd()
k = 10000; % number of samples
T = 250; % sample size

samples = trnd(df,k,T);


%% Measure runtime for function calls specifically
% titer time measurement
elapsedTime_titer = 0;
runtimes_titer = zeros(k,1);
for i=1:k
    sample_i = samples(i,:);
    ftiter = @() titer(sample_i,tol_titer); % define function call to be timed
    time_run_i = timeit(ftiter); % measures exactly one function call 
    runtimes_titer(i) = time_run_i;
    elapsedTime_titer = elapsedTime_titer+time_run_i; % sum up over k samples
end

%BFGS time measurement
runtimes_BFGS = zeros(k,1);
elapsedTime_BFGS=0;
for i=1:k
    sample_i = samples(i,:);
    fBFGS = @() calc_BFGS(sample_i,df,tol_BFGS);
    time_run_i = timeit(fBFGS);
    runtimes_BFGS(i) = time_run_i;
    elapsedTime_BFGS = elapsedTime_BFGS +time_run_i;
end

[f, x] = ksdensity(runtimes_titer,'Function','pdf','Bandwidth', 0.00009, 'Kernel', 'epanechnikov', 'NumPoints', 1000);
figure
plot(x,f./sum(f));
title('density of titer run times')
xlabel('run time')
ylabel('pdf')
file_name = ['figures/Q1/runtimes_titer.png'];
saveas(gcf,file_name)

figure
[f, x] = ksdensity(runtimes_BFGS,'Function','pdf','Bandwidth', 0.0007, 'Kernel', 'epanechnikov', 'NumPoints', 1000);
plot(x,f./sum(f));
title('density of BFGS run times')
xlabel('run times')
ylabel('pdf')
file_name = ['figures/Q1/runtimes_BFGS.png'];
saveas(gcf,file_name)
