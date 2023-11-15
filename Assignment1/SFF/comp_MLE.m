function [mu,sigma,nu] = comp_MLE(data, nu, distribution)
    
    init_params = [mean(data),sqrt((size(data) - 1) * var(data) / size(data)),nu];

    options = optimoptions('fmincon','Display', 'off');

    negloglikelihood_function = @(params) -sum(log(pdf(makedist(distribution,params(1),params(2),params(3)),data)));

    estimated_params = fmincon(negloglikelihood_function, init_params,[],[],[], [], [-Inf,0,0], [], [],options);

    mu      = estimated_params(1);
    sigma   = estimated_params(2);
    nu      = estimated_params(3);

end



