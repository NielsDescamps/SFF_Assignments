function y = laplacecdf(x, mu, sigma)
% CDF of LAPLACE DISTRIBUTION

y = 0.5*(1 + sign(x-mu) .* (1 - exp( -abs(x-mu) / (sigma/sqrt(2)) )));

end
