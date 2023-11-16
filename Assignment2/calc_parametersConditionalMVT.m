function [Muc, Sigmac, dfc] = calc_parametersConditionalMVT(x1, Mu, Sigma,df)

% Assign variables
mu1 = Mu(1); mu2 = Mu(2);
p1 = 1;
sigma11 = Sigma(1,1); sigma12 = Sigma(1,2); 
sigma21 = Sigma(2,1); sigma22 = Sigma(2,2);

% calculate intermediate factors
d1 = ((x1-mu1)^2)/(sigma11);
scale_factor = (df+d1)/(df+p1);

% Calculate parameters of condition distribution
Muc = mu2 + sigma21*sigma11^(-1)*(x1-mu1);
Sigmac = scale_factor*(sigma22-sigma21*sigma12/sigma11);
dfc = df + p1;

end
