% ASSIGNMENT 1.b: computing power curves

load('cutoffs', 'cutoffs_nu_3');
load('cutoffs', 'cutoffs_nu_6');
load('cutoffs', 'cutoffs_nu_12');
cutoffs = {cutoffs_nu_3,cutoffs_nu_6,cutoffs_nu_12};

% we will use alpha = 0.05 only
alpha       = .05;
sample_size = [30 60 100];
nu          = [3 6 12];
n           = 100;
rng(6);

KS_norm = zeros(n, 1);
AD_norm = zeros(n, 1);

power_KS    = zeros(size(nu, 2), size(sample_size, 2));
power_AD    = zeros(size(nu, 2), size(sample_size, 2));         

for v = 1:size(nu, 2); disp(['nu: ', num2str(nu(v))])

    cutoffs_nu      = cutoffs{v};
    cutoffs_KS_nu   = table2array(table2array(cutoffs_nu(2,2)));
    cutoffs_AD_nu   = table2array(table2array(cutoffs_nu(2,3)));

    for r = 1:size(sample_size, 2); disp(['r: ', num2str(sample_size(r))])

        i       = (1:sample_size(r))';
        ecdf    = (i - 3/8) / (sample_size(r) + .25);

        % true data are Standard Normal
        % "An r-length random sample of Standard Normal is simulated." (p.66)
        realisations = randn(sample_size(r), 1);
        
        for sim = 1:n
            
            % non-parametric bootstrap
            ind     = randi(sample_size(r), [sample_size(r) 1]);
            bsamp   = realisations(ind);

            [est_mu, est_sigma, est_nu] = comp_MLE(bsamp, nu(v), 'tLocationScale');

            bsamp = (bsamp - est_mu) / est_sigma;

            % "The KD & AD stats are computed using a fitted Student's t c.d.f"
            para_norm    = tcdf(sort(bsamp), est_nu);
            % para_norm       = normcdf(sort(bsamp), est_mu, est_sigma);
            KS_norm(sim)    = max(abs(ecdf - para_norm));
            AD_norm(sim)    = max(abs(ecdf - para_norm) ./ sqrt(ecdf .* (1 - ecdf)));

        end

        power_KS(v, r)  = sum(KS_norm >= cutoffs_KS_nu(r)) / n;
        power_AD(v, r)  = sum(AD_norm >= cutoffs_AD_nu(r)) / n;

    end
end

disp('END')




