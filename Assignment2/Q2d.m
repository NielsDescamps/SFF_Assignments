clear variables
Mu = [0,0];
Sigma = [1,0;0,1];
df = 3;
condition = "X1onX2";
x2 = 4; 
save_fig=false;


%% Calculate conditional parameters through analytic formula
[mu_ana, sigma_ana, df_ana] = calc_parametersConditionalMVT_analytic(x2, Mu, Sigma, df,condition);

%% Calculate conditional parameters through simulation
sample_size = 1e7;
epsilon = 1e-3;
sample = mvtLocationScale_random(sample_size, Mu, Sigma, df);
[mu_sim, sigma_sim, df_sim,~] = calc_parametersConditionalMVT_simulate(sample,df,x2,epsilon,condition);
    

%% Plot both distributions
x = linspace(-10,10,1000);
values_ana = tpdf((x-mu_ana)./sigma_ana,df_ana); 
values_sim = tpdf((x-mu_sim)./sigma_sim,df_sim);

figure 
plot(x,values_ana); hold on
plot(x,values_sim);
title(['Conditional distribution X1|X2 for x2=',num2str(x2)])
xlabel('x1')
ylabel('density')
legend('analytic','simulation')
if save_fig == true
    file_name = ['figures/Q2/Analytic_vs_Simulated/AnaSim_df',num2str(df),'_x2',num2str(x2),'.png'];
    saveas(gcf,file_name);
end