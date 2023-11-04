function [param,stderr ,iters ,loglik ,Varcov] = tlikmax(x,initvec)

%%%%%%%% df mu c
bound. lo= [1 1 0.01];
bound. hi= [100 1 100 ]; 
bound.which=[1 0 1 ];
% In this case, as bound.which for mu is zero, mu will not be
% restricted . As such , the values for . lo and . hi are irrelevant

maxiter =100;
tol =1e-3;
% change these as you see fit
opts=optimset ( ' Display ' , ' notify −detailed ' , ' Maxiter ' , maxiter , ...
    'TolFun',tol,'TolX',tol,'LargeScale','Off');

[pout,fval,exitflag,theoutput,grad,hess]= ...
    fminunc(@(param) tloglik(param,x,bound), einschrk(initvec ,bound), opts);

V=inv(hess); %Don't negate: we work with the neg of the loglik

[param,V]=einschrk(pout,bound,V); % Transform back, apply delta method
param=param'; Varcov=V;
stderr=sqrt(diag(V)) ; % Approx std err of the params
loglik=-fval ; % The value of the loglik at its maximum. 
iters=theoutput.iterations ; % Number of loglik function evals