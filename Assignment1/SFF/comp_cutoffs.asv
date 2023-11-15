% ASSIGNMENT 1.a: computing cutoff values for KS & AD

sign_lvl    = [.01 .05 .1];
sample_size = [30 60 100];
nu          = [3 6 12];
n           = 100;
rng(123);

KS      = zeros(n, 1);
AD      = zeros(n, 1);
KS_norm = zeros(n, 1);
AD_norm = zeros(n, 1);

q_KS    = cat(3, zeros(size(sign_lvl, 2), size(sample_size, 2)));
q_AD    = cat(3, zeros(size(sign_lvl, 2), size(sample_size, 2)));

for v = 1:size(nu, 2); disp(['nu: ', num2str(nu(v))])
    for r = 1:size(sample_size, 2); disp(['r: ', num2str(sample_size(r))])

        i       = (1:sample_size(r))';
        ecdf    = (i - 3/8) / (sample_size(r) + .25);

        % true data are Student's t with nu = nu(v)
        realisations = trnd(nu(v), [sample_size(r) 1]);
        
        for sim = 1:n
            
            % non-parametric bootstrap
            ind     = randi(sample_size(r), [sample_size(r) 1]);
            bsamp   = realisations(ind);

            [est_mu, est_sigma, est_nu] = comp_MLE(bsamp, nu(v), 'tLocationScale'); % do we have to assume we know the nu?
            
            bsamp = (bsamp - est_mu) / est_sigma;
            
            para    = tcdf(sort(bsamp), est_nu);
            KS(sim) = max(abs(ecdf - para));
            AD(sim) = max(abs(ecdf - para) ./ sqrt(ecdf .* (1 - ecdf)));

        end

        for alpha = 1:size(sign_lvl, 2)

            q_KS(alpha,r,v)     = quantile(KS, 1 - sign_lvl(alpha));
            q_AD(alpha,r,v)     = quantile(AD, 1 - sign_lvl(alpha));

        end
    end
end

cutoffs_nu_3 = table( ...
    array2table(sign_lvl', 'VariableNames', {'α\r'}), ...
    array2table(round(q_KS(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    array2table(round(q_AD(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    'VariableNames', {' ','KS','AD'} ...
    );

cutoffs_nu_6 = table( ...
    array2table(sign_lvl', 'VariableNames', {'α\r'}), ...
    array2table(round(q_KS(:,:,2), 3), 'VariableNames', {'30', '60', '100'}), ...
    array2table(round(q_AD(:,:,2), 3), 'VariableNames', {'30', '60', '100'}), ...
    'VariableNames', {' ','KS','AD'} ...
    );

cutoffs_nu_12 = table( ...
    array2table(sign_lvl', 'VariableNames', {'α\r'}), ...
    array2table(round(q_KS(:,:,3), 3), 'VariableNames', {'30', '60', '100'}), ...
    array2table(round(q_AD(:,:,3), 3), 'VariableNames', {'30', '60', '100'}), ...
    'VariableNames', {' ','KS','AD'} ...
    );

save('/Users/lorenzof/Documents/MATLAB/SFF/cutoffs.mat', 'cutoffs_nu_3', 'cutoffs_nu_6', 'cutoffs_nu_12')

disp('END')
