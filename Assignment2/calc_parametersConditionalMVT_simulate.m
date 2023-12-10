function [mu_est,sigma_est,nu_est,conditional_sample] = calc_parametersConditionalMVT_simulate(sample, df, x, eps,condition)
    
    % Extract X1 and X2 columns from the sample
    X1 = sample(:, 1);
    X2 = sample(:, 2);

    if condition == "X1onX2"
        % Find indices where X2 is in the specified interval
        indices = X2 >= (x - eps) & X2 <= (x + eps);
    
        % Extract corresponding values of X1
        conditional_sample = X1(indices);

    elseif condition == "X2onX1"
        % Find indices where X1 is in the specified interval
        indices = X1 >= (x - eps) & X1 <= (x + eps);
    
        % Extract corresponding values of X2
        conditional_sample = X2(indices);

    end

    % Get MLE estimate
    tolerance = 1e-3;
    [mu_est,sigma_est,nu_est] = calc_BFGS(conditional_sample, df, tolerance);
end