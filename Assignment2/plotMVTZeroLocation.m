function out = plotMVTZeroLocation(Sigma, df, dims, num_points)

dim1 = dims(1);
dim2 = dims(2); 
x1 = linspace(-dim1,dim1,num_points);
x2 = linspace(-dim2,dim2,num_points);

[X1,X2] = meshgrid(x1,x2);
F = mvtpdf([X1(:) X2(:)],Sigma,df);
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
axis([-dim1 dim1 -dim2 dim2 0 0.25])
xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
campos([0,0,2.290063509461096])
out = true;
end