function [ES, VaR] = comp_ES_VaR(df, varargin)

defaultValues = {0.05 0 1};    % default values {ESlevel mu sigma};

idx = ~cellfun(@isempty,varargin);  % find which parameters have changed

defaultValues(idx) = varargin(idx); % replace the changed ones

[ESlevel, mu, sigma] = defaultValues{:};   % convert from cell to var

[ES, VaR] = comp_ES_VaR_pre(df, ESlevel, mu, sigma);

end