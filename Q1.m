% Q1

dof = 1;
r = 20;
samples = trnd(dof,[r,1]);
sorted_samples = sort(samples);

% KD = calc_KD(samples);
% AD = calc_AD(samples)
dof = 1;
sign_levels = [0.01,0.05,0.1];
sample_size = 20;
simulations = 1000;
seed = 6;
plot = true;

[KD_cutoff_vals,AD_cutoff_vals] = KDAD_cutoff_studentt(dof,sample_size,sign_levels,simulations,seed,plot);

