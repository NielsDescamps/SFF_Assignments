Sigma = [1, 0; 0, 1];
df = 4 ; 
sample_size = 1e7;
Mu = [0 ; 0];
dims = [5,5];



%% II.2 Simulate bivariate studentt distribution
% Exact profile
% num_points = 100;
% save_fig = false;
% file_name = ['MVTplot_df',num2str(df)];
% plotMVTZeroLocationExact(Mu,Sigma, df, dims, num_points,save_fig,file_name);

% Simulated profile
% bandwidth = 0.05;
% save_fig = true;
% file_name = ['MVTplot_df',num2str(df),'_Loc',num2str(Mu(1)),num2str(Mu(2)),'_Sig',num2str(Sigma(1,2)),'_'];
% plotMVTLocationScaleSimulated(sample_size,Mu,Sigma,df,dims,bandwidth,100,save_fig,file_name)

%% II.3 Simulate conditional distribution
x2=0;
epsilon = 1e-3;
plotConditionalDistribution(sample_size,x2,df,Mu,Sigma,epsilon);



