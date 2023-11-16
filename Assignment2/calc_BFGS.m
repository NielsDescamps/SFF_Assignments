function [mu,sigma,nu] = calc_BFGS(sample, dof, tolerance)
    
    init_params = [mean(sample),std(sample),dof];
    options = optimoptions('fmincon','Display', 'off','OptimalityTolerance',tolerance);

    negloglikelihood_function = @(params) -sum(log(pdf(makedist('tLocationScale',params(1),params(2),params(3)),sample)));

    estimated_params = fmincon(negloglikelihood_function, init_params,[],[],[], [], [-Inf,0,0], [], [],options);

    mu = estimated_params(1);
    sigma = estimated_params(2);
    nu = estimated_params(3);

end



