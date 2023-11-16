clear variables 

%% Set the tolerance levels for BFGS and titer
tol_titer = 1e-3;
tol_BFGS = 1e-2;
df = 3;

seed=6;
rng(seed,'twister')

%% Generate k samples of size T with trnd()
k = 1000; % number of samples
T = 250; % sample size

samples = trnd(df,k,T);


%% Measure runtime for function calls specifically
% titer time measurement
elapsedTime_titer = 0;
for i=1:k
    sample_i = samples(i,:);
    ftiter = @() titer(sample_i,tol_titer);
    time_run_i = timeit(ftiter); % measures exactly one function call 
    elapsedTime_titer = elapsedTime_titer+time_run_i; % sum up over k samples
end

%BFGS time measurement
elapsedTime_BFGS=0;
for i=1:k
    sample_i = samples(i,:);
    fBFGS = @() calc_BFGS(sample_i,df,tol_BFGS);
    time_run_i = timeit(fBFGS);
    elapsedTime_BFGS = elapsedTime_BFGS +time_run_i;
end
