% Q1
seed = 6;
simulations = 1000;
sign_levels = [0.01,0.05,0.1];
plot_KDvals = true;

%% DOF = 3 %%
% Calculate cutoff values for DOF = 3, sample size = 30
dof = 3;
sample_size = 30;
[KD_cutoff_vals330,AD_cutoff_vals330] = KDAD_cutoff_studentt(dof,sample_size,sign_levels,simulations,seed,plot_KDvals);
disp('finished dof=3, r=30')

% Calculate cutoff values for DOF = 3, sample size = 30
dof = 3;
sample_size=60;
[KD_cutoff_vals360,AD_cutoff_vals360] = KDAD_cutoff_studentt(dof,sample_size,sign_levels,simulations,seed,plot_KDvals);
disp('finished dof=3, r=60')

% Calculate cutoff values for DOF = 3, sample size = 100
dof = 3;
sample_size=100;
[KD_cutoff_vals3100,AD_cutoff_vals3100] = KDAD_cutoff_studentt(dof,sample_size,sign_levels,simulations,seed,plot_KDvals);
disp('finished dof=3, r=100')

disp('finished dof=3')
%% DOF = 6 %%
% Calculate cutoff values for DOF = 6, sample size = 30
dof = 6;
sample_size = 30;
[KD_cutoff_vals630,AD_cutoff_vals630] = KDAD_cutoff_studentt(dof,sample_size,sign_levels,simulations,seed,plot_KDvals);

% Calculate cutoff values for DOF = 6, sample size = 30
dof = 6;
sample_size=60;
[KD_cutoff_vals660,AD_cutoff_vals660] = KDAD_cutoff_studentt(dof,sample_size,sign_levels,simulations,seed,plot_KDvals);

% Calculate cutoff values for DOF = 6, sample size = 100
dof = 6;
sample_size=100;
[KD_cutoff_vals6100,AD_cutoff_vals6100] = KDAD_cutoff_studentt(dof,sample_size,sign_levels,simulations,seed,plot_KDvals);

disp('finished dof=6')
%% DOF = 9 %%
% Calculate cutoff values for DOF = 12, sample size = 30
dof = 12;
sample_size = 30;
[KD_cutoff_vals1230,AD_cutoff_vals1230] = KDAD_cutoff_studentt(dof,sample_size,sign_levels,simulations,seed,plot_KDvals);

% Calculate cutoff values for DOF = 12, sample size = 30
dof = 12;
sample_size=60;
[KD_cutoff_vals1260,AD_cutoff_vals1260] = KDAD_cutoff_studentt(dof,sample_size,sign_levels,simulations,seed,plot_KDvals);

% Calculate cutoff values for DOF = 12, sample size = 100
dof = 12;
sample_size=100;
[KD_cutoff_vals12100,AD_cutoff_vals12100] = KDAD_cutoff_studentt(dof,sample_size,sign_levels,simulations,seed,plot_KDvals);
% 
% disp('finished dof=12')
