Sigma = [1, -0.6; 1, -0.6];
df = 3; 
sample_size = 1000;
Mu = [1 ; 1];
x1 = 1;

% pdf_samples = mvtrandom(sample_size,Sigma,df);
dims = [5,5];
num_points = 100;
plotMVTZeroLocation(Sigma, df, dims, num_points)

% x1 = -3:.2:3; x2 = -3:.2:3;
% [X1,X2] = meshgrid(x1,x2);
% F = mvtpdf([X1(:) X2(:)],Sigma,df);
% F = reshape(F,length(x2),length(x1));
% surf(x1,x2,F);
% axis([-3 3 -3 3 0 .2])
% xlabel('x1'); ylabel('x2'); zlabel('Probability Density');