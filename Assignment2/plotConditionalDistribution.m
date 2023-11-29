function plotConditionalDistribution(sample_size, x2, df, Mu, Sigma, epsilon)

    sample = mvtLocationScale_random(sample_size, Mu, Sigma, df);
    [mu_est,sigma_est, df_est, X1CondX2_sim] = conditionOnX2(sample,df,x2,epsilon);
       
    
    % % Plot the kernel density estimate of X1midX2
    % [f, xi] = ksdensity(X1CondX2_sim);
    % figure;
    % plot(xi, f);
    % title(['Kernel Density Estimation of X1 conditioned on X2=',num2str(x2)]);
    % xlabel('X1');
    % ylabel('Density');
    % xlim([-5, 5]);

    % Plot parametric estimate of X1midX2
    x=-5:0.01:5;
    X1CondX2_param = sigma_est.*tpdf(x,df_est) + mu_est;
    figure
    plot(x,X1CondX2_param)
    title(['Parametric density estimation of X1 conditioned on X2=',num2str(x2)])
    xlabel('X1');
    ylabel('Density');

end