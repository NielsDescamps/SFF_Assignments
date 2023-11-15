% ASSIGNMENT 1: testing a composite distribution

alpha       = [.01 .05 .1];
r           = [30 60 100];
nu          = [3 6 12];

% tLocationScale = makedist('tLocationScale','mu',0,'sigma',1,'nu',3);
% pdf(tLocationScale, x) = tpdf(x, nu=3)

rng(123);
n       = 50;
KS      = zeros(n, 1);
AD      = zeros(n, 1);
q_KS    = zeros(size(alpha, 2), size(r, 2));
q_AD    = zeros(size(alpha, 2), size(r, 2));

for j = 1:size(r, 2)
    for k = 1:size(alpha, 2)
        for sim = 1:n
        
            % realisations = random(tLocationScale, [r(j) 1]);
            realisations = trnd(3, [r(j) 1]);
            
            % MLE = fitdist(realisations, "tLocationScale");
            % est_nu      = MLE.nu;
            % est_mu      = MLE.mu;
            % est_sigma   = MLE.sigma;
            
            % custnloglf = @(realisations, mu, sigma, nu)-sum(log(pdf(makedist('tLocationScale', mu, sigma, nu), realisations)));
        
            % MLE = mle(realisations, 'distribution','tlocationscale', 'nloglf', custnloglf, 'Start', [0,1]);
            % est_mu      = MLE(1);
            % est_sigma   = MLE(2);
            % est_nu      = MLE(3);
            [est_mu, est_sigma, est_nu] = calc_MLE(realisations, nu, 'tLocationScale');
            
            i=(1:r(j))';
            ecdf1   = i./r(j);
            ecdf2   = (i - 1) / r(j);
            
            para    = cdf(makedist('tLocationScale','mu',est_mu,'sigma',est_sigma,'nu',est_nu), sort(realisations));
            % para    = tcdf(sort(realisations), nu_est);
            
            dd1     = max(ecdf1 - para);
            dd2     = max(para - ecdf2);
            KS(sim) = max([dd1, dd2]);
            AD(sim) = max(abs(ecdf2 - para) / sqrt(ecdf2' * (1 - ecdf2)));
        
        end 
        q_KS(k,j)   = quantile(KS, 1 - alpha(k));
        q_AD(k,j)   = quantile(AD, 1 - alpha(k));
    end
end

cutoffs = table( ...
    array2table(alpha', 'VariableNames', {'α\r'}), ...
    array2table(q_KS, 'VariableNames', {'30', '60', '100'}), ...
    array2table(q_AD, 'VariableNames', {'30', '60', '100'}), ...
    'VariableNames', {' ','KS','AD'} ...
    );

% writeable(cutoffs, 'cutoffs.csv') % TO ADJUST

