function [ES, VaR] = comp_ES_VaR_pre(df, ESlevel, mu, sigma)
% COMP_ES_VAR
% Compute the true value of ES and VaR for the given inputs of a
% Location-Scale Student's t

arguments
    df (1,:) {mustBeNumeric, mustBePositive, mustBeFinite}
    ESlevel (1,:) {mustBeNumeric, mustBeFinite}
    mu (1,:) {mustBeNumeric, mustBeFinite}
    sigma (1,:) {mustBeNumeric, mustBeFinite}
end

if ~(0 < ESlevel && ESlevel < 1)
   error('Error. ESlevel must be in (0,1).')
end

rng(6);

N = 10^6; % 10^8;

% make Location-Scale Student's t
ourDistr = makedist('tLocationScale', 'mu',mu,'sigma',sigma,'nu',df);

% sample
X = random(ourDistr, [N 1]);

% quantile
q = quantile(X, ESlevel);

% sample's observations satisfying the condition
% use = X(X<q);

ES  = -pdf(ourDistr,q) / cdf(ourDistr,q) * (df+q^2)/(df-1);
VaR = q;

% empiricalES_and_trueES = [mean( use ) ES];

end

