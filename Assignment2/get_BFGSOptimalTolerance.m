function opt_tol = get_BFGSOptimalTolerance(sample,dof)

%% Get a high accuracy solution using tolerance = 1e-14
% Calculate high accuracy estimates 
[muhat_opt, chat_opt, dfhat_opt] = calc_BFGS(sample,dof,1e-14);
dfhat_optSD = significant4Digits(dfhat_opt);
muhat_optSD = significant4Digits(muhat_opt);
chat_optSD = significant4Digits(chat_opt);

% Store the 4 significant digits of each parameter in opt_paramsSD
opt_paramsSD = [dfhat_optSD(1), muhat_optSD(1), chat_optSD(1)];


%% Generate a list of possible tolerance levels
expLow = -11;
expHigh = -1;
toleranceList = generateToleranceLevels(expLow,expHigh);

%% Find the optimal tolerance value from the list (4 significant digits)
% for all tolerance levels do
for i=1:length(toleranceList)
   tol = toleranceList(i);
    
   % calculate parameter estimates
   [muhati, chati, dfhati] = calc_BFGS(sample,dof,tol);
   dfhatiSD = significant4Digits(dfhati);
   muhatiSD = significant4Digits(muhati);
   chatiSD = significant4Digits(chati);

   last_paramsSD = [dfhatiSD, muhatiSD, chatiSD];
    
   % compare the 4 significant digits with the high accuracy estimates
   diff = sum(abs(last_paramsSD - opt_paramsSD));
   if ~diff==0
       opt_tol = last_tol;
       break
   end
   last_tol = tol;
end


end