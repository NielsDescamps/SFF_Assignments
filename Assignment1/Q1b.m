seed = 6;
rand('twister',seed);

simulations = 100;
sign_index = 2; % (1:0.01, 2:0.05, 3:0.1)
plot_KDADvals = true;
sample_sizes = [30,60,100];
dofs = [3,6,12];

all_cutoffs = load('Q1/KDAD_cutoff_values.mat');


%% 1.Gaussian sample
KD_powvals_G = zeros(length(dofs),length(sample_sizes));
AD_powvals_G = zeros(length(dofs),length(sample_sizes));

for  j=1:3
    sample_size=sample_sizes(j);
    r = sample_size;

    samples = randn(r,1);
    
    disp(["starting computations for r=",num2str(r)])

    for i=1:3
        dof = dofs(i);
        disp(["starting computations for dof=",num2str(dof)])
    
        KD_file = ['KD_cutoff_vals',num2str(dof),num2str(sample_size)];
        KD_cutoff = all_cutoffs.(KD_file)(sign_index);
        AD_file = ['AD_cutoff_vals',num2str(dof),num2str(sample_size)];
        AD_cutoff = all_cutoffs.(AD_file)(sign_index);
        
        KD_vals = zeros(simulations,1);
        AD_vals = zeros(simulations,1);
        
        for n = 1:simulations
            %make a resample of the initial sample
            indices = randi(r,1,r);
            resample = samples(indices);
        
            % calculate KD and AD of the resample
            KD_n = calc_KD(resample,dof);
            AD_n = calc_AD(resample,dof);
        
            KD_vals(n) = KD_n;
            AD_vals(n) = AD_n;
        
        end
        
        % count the number of KD/AD values exceeding the threshold
        KD_power = sum(KD_vals>KD_cutoff)/simulations;
        AD_power = sum(AD_vals>AD_cutoff)/simulations;
        
        KD_powvals_G(i,j) = KD_power;
        AD_powvals_G(i,j) = AD_power;

    end

end

disp(KD_powvals_G)
disp(AD_powvals_G)

