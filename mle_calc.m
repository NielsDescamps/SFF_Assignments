function [mu_mle, sigma_mle, df_mle] = mle_calc(samples, df_guess, Distribution)
    % Calculate MLE for location (mu)
 
    initial_params = [mean(samples), std(samples), df_guess];
    options = optimoptions('fmincon', 'Display', 'off');
    % Calculate MLE for scale (sigma)
    neg_log_likelihood = @(params) -sum(log(pdf(makedist(Distribution, params(1), params(2), params(3)), samples)));
    
    %Do not allow for showing the Status of each optimization 
    options = optimoptions('fmincon', 'Display', 'off');
    % Optimize the negative log-likelihood function
    optimized_params = fmincon(neg_log_likelihood, initial_params,[0,-1,0;0,0,-1],[0;0],[], [], [], [], [],options);
    
    % Extract the estimated parameters
    mu_mle = optimized_params(1);
    sigma_mle = optimized_params(2);
    df_mle = optimized_params(3);
    
end