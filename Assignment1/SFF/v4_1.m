% Assignment 4 (Point 6)

rng(6);

df      = 3;
mu      = 0;
sigma   = 1;
ESlevel = 0.05;

N = 10^6; % 10^8;

% make Location-Scale Student's t
ourDistr = makedist('tLocationScale', 'mu',mu,'sigma',sigma,'nu',df);

% sample
X = random(ourDistr, [N 1]);

% quantile
q = quantile(X, ESlevel);

% sample's observations satisfying the condition
use = X(X<q);

ES  = -pdf(ourDistr,q) / cdf(ourDistr,q) * (df+q^2)/(df-1);
VaR = q;

% empiricalES_and_trueES = [mean( use ) ES];

ES