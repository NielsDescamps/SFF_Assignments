% ASSIGNMENT 1: testing a composite distribution

sign_lvl        = [.01 .05 .1];
sample_size     = [30 60 100];
nu              = [3 6 12]; % [1 3 6 12 20];
n               = 100;
rng(6);

KS      = zeros(n, 1);
AD      = zeros(n, 1);
KS_norm = zeros(n, 1);
AD_norm = zeros(n, 1);

% q_KS      = zeros(size(sign_lvl, 2), size(sample_size, 2));
% q_AD      = zeros(size(sign_lvl, 2), size(sample_size, 2));
% power_KS  = zeros(size(sign_lvl, 2), size(sample_size, 2));
% power_AD  = zeros(size(sign_lvl, 2), size(sample_size, 2));

q_KS        = cat(3, zeros(3), zeros(3), zeros(3));
q_AD        = cat(3, zeros(3), zeros(3), zeros(3));
power_KS    = cat(3, zeros(3), zeros(3), zeros(3));
power_AD    = cat(3, zeros(3), zeros(3), zeros(3));

for v = 1:size(nu, 2)
    for r = 1:size(sample_size, 2)
        for sim = 1:n

            realisations = trnd(3, [sample_size(r) 1]);

            [est_mu, est_sigma, est_nu] = comp_MLE(realisations, nu(v), 'tLocationScale');
            
            i       = (1:sample_size(r))';
            ecdf1   = i ./ sample_size(r);
            ecdf2   = (i - 1) / sample_size(r);
            ecdf3   = (i - 3/8) / (sample_size(r) + .25);
            
            para        = cdf(makedist('tLocationScale','mu',est_mu,'sigma',est_sigma,'nu',est_nu), sort(realisations));
            para_norm   = normcdf(sort(realisations), est_mu, est_sigma);

            dd1         = max(ecdf1 - para);
            dd2         = max(para - ecdf2);
            KS(sim)     = max([dd1, dd2]);
            AD(sim)     = max(abs(ecdf3 - para) ./ sqrt(ecdf3 .* (1 - ecdf3)));

            dd1         = max(ecdf1 - para_norm);
            dd2         = max(para_norm - ecdf2);
            KS_norm(sim)= max([dd1, dd2]);
            AD_norm(sim)= max(abs(ecdf3 - para_norm) ./ sqrt(ecdf3 .* (1 - ecdf3)));

        end

        for alpha = 1:size(sign_lvl, 2)

            q_KS(alpha,r,v)     = quantile(KS, 1 - sign_lvl(alpha));
            q_AD(alpha,r,v)     = quantile(AD, 1 - sign_lvl(alpha));
    
            power_KS(alpha,r,v) = sum(KS_norm >= q_KS(alpha,r,v)) / n;
            power_AD(alpha,r,v) = sum(AD_norm >= q_AD(alpha,r,v)) / n;

        end
    end
end

x  = nu;
y1 = power_KS(2, 1, :);
y1 = y1(:);
y2 = power_KS(2, 2, :);
y2 = y2(:);
y3 = power_KS(2, 3, :);
y3 = y3(:);
plot(x,y1,x,y2,x,y3);
title('Power of size 0.05 KD Test for tLocationScale');
xlabel('Degrees of Freedom for Student`s t');
ylabel('Power');
legend(string(sample_size));

x  = nu;
y1 = power_AD(2, 1, :);
y1 = y1(:);
y2 = power_AD(2, 2, :);
y2 = y2(:);
y3 = power_AD(2, 3, :);
y3 = y3(:);
plot(x,y1,x,y2,x,y3);
title('Power of size 0.05 AD Test for tLocationScale');
xlabel('Degrees of Freedom for Student`s t');
ylabel('Power');
legend(string(sample_size));

format shortg;

cutoffs = table( ...
    array2table(sign_lvl', 'VariableNames', {'α\r'}), ...
    array2table(round(q_KS(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    array2table(round(q_AD(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    'VariableNames', {' ','KS','AD'} ...
    );

power = table( ...
    array2table(sign_lvl', 'VariableNames', {'α\r'}), ...
    array2table(round(power_KS(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    array2table(round(power_AD(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    'VariableNames', {' ','KS','AD'} ...
    );

% writeable(cutoffs, 'cutoffs.csv') % TO ADJUST




