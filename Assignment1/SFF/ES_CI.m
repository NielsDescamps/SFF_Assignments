function [ES_true, lb_para, ub_para, lb_nonpara, ub_nonpara, ES_emp_para, ES_emp_nonpara] = ES_CI(df, ESlevel, N, B)
    
    % rng(123)
    
    % ESlevel = 0.05;
    
    % df = 3; % use 4 - CHECK THAT df > 1
    % B = 500; % default 500
    % N = 500; % default 500
    
    % the program generates a random dataset of IID Student's realisations
    X = trnd(df, [N 1]);
    
    % A. Compute the true ES
    ES_true = comp_ES_VaR(df, ESlevel);
    
    ES_emp_para = zeros([B 1]);
    
    % estimate parameters
    [mu,sigma,nu] = comp_MLE(X, df, 'tLocationScale');
    ourDistr = makedist('tLocationScale','mu',mu,'sigma',sigma,'nu',nu);
    
    % Parametric Bootstrap
    
    for i = 1:B
        % sample
        % REVIEW: is our assumption that the distribution is Student's t or
        % Location-Scale Student's t? IMO the new samples should follow the
        % distribution we assume as true.
        bsamp = random(ourDistr, [N 1]);
        % bsamp = trnd(nu, [N 1]);
    
        % compute empirical ES

        % quantile (vs. inverted cdf) given our ASSUMPTION that we are not sure about the underlying density
        q = quantile(bsamp, ESlevel);
        % q = tinv(ESlevel, nu);
        % q = icdf(ourDistr, ESlevel, mu, sigma, nu);

        % REVIEW - REVIEW - REVIEW - REVIEW - REVIEW - REVIEW - REVIEW - REVIEW
        % Z = (bsamp - mu) / sigma;
        % Z = randn(1e6,1);
    
        I = (bsamp < q);
        
        ES_emp_para(i) = mean(bsamp .* I) / mean(I);
    end
    
    % take quantiles of ES vector (alpha/2%) to get its confidence interval
    lb_para = quantile(ES_emp_para, 0.05);
    ub_para = quantile(ES_emp_para, 0.95);
    
    
    % Non-Parametric Bootstrap
    
    ES_emp_nonpara = zeros([B 1]);
    
    for i = 1:B
        % resample
        indx    = randi(N, [N 1]);
        bsamp   = X(indx);
    
        % compute empirical ES

        % quantile (vs. inverted cdf) given our ASSUMPTION that we are not sure about the underlying density
        q = quantile(bsamp, ESlevel);
        % q = icdf(ourDistr, ESlevel, mu, sigma, nu);
    
        I = (bsamp < q);
        
        ES_emp_nonpara (i) = mean(bsamp .* I) / mean(I);
    end
    
    % take quantiles of ES vector (alpha/2%) to get its confidence interval
    lb_nonpara = quantile(ES_emp_nonpara, 0.05);
    ub_nonpara = quantile(ES_emp_nonpara, 0.95);

end
