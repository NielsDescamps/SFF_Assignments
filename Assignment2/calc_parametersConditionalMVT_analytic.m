function [Muc, Sigmac, dfc] = calc_parametersConditionalMVT_analytic(x, Mu, Sigma,df,condition)

% Assign variables
mu1 = Mu(1); mu2 = Mu(2);
p = 1; % 1D parts
sigma11 = Sigma(1,1); sigma12 = Sigma(1,2); 
sigma21 = Sigma(2,1); sigma22 = Sigma(2,2);

if condition == "X2onX1" % x2|x1
    % calculate intermediate factors
    d1 = ((x-mu1)^2)/(sigma11);
    scale_factor = (df+d1)/(df+p);
    
    % Calculate parameters of condition distribution
    Muc = mu2 + sigma21*sigma11^(-1)*(x-mu1);
    Sigmac = sqrt(scale_factor*(sigma22-sigma21*sigma12/sigma11));
    dfc = df + p;

elseif condition == "X1onX2" % x1|x2
    % calculate intermediate factors
    d2 = ((x-mu2)^2)/(sigma22);
    scale_factor = (df+d2)/(df+p);
    
    % Calculate parameters of condition distribution
    Muc = mu1 + sigma12*sigma22^(-1)*(x-mu2);
    Sigmac = sqrt(scale_factor*(sigma11-sigma21*sigma12/sigma22));
    dfc = df + p;
end

end
