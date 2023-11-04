function [mu, sigma, df, ESlevel] = test4(name1, arg1, name2, arg2, name3, arg3, name4, arg4)


if nargin == 1
    df = name1;
end



innames = {name1 name2 name3 name4};
invars  = {arg1 arg2 arg3 arg4};
default = [0, 1, 0.05];


% if a variable has the name X
if any(strcmp(innames,'mu'))
    
    % check which variable has name X and assign it to var Y
    if strcmp(innames{i}, 'mu')
        mu = invars{i};
    end

% if no variable has the name X
% assign to variable Y the default value
else
    mu = default_mu;
end

sigma = 0;
df = 0;
ESlevel = 0;