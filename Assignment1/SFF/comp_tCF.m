function output = comp_tCF(nu,t)
% COMP_TCF
% Compute Student's t characteristic function's density given X input

% Formula follows (C.6) and (C.9) of "Linear Models and Time-Series Analysis"
cf = @(nu,t) (( besselk(nu/2, sqrt(nu) * abs(t)) * ( sqrt(nu) * abs(t) )^(nu/2) )) / ( gamma(nu/2) * 2^(nu/2 - 1) );

output = cf(nu,t);

end