function [dfhat, muhat, chat, iters] = titer(x,TOL,useML)
% Estimates the df, location, mu, and scale, c, params of the t distribution
% if useML is 1 (default), then finds the MLE  by iterating between
% the three single root finders, otherwise, returns the parameters obtained
% via method from Singh(1988)

if nargin<3, useML=1; end
usetrim = 0; % set to one to use the trimmed mean for mu instead of the MLE

%% STARTING VALUES USING TRIMMED MEAN FOR MU AND RESULTS FROM SINGH(1988)
n=length(x); mu0=mytrim(x,50);  r=x-mu0; a = n*sum(r.^4) / (sum(r.^2))^2;
df0 = 2 * (2*a - 3) / (a-3); c0 = 3*sum(r.^2)/(2*a - 3)/(n+1);
df0 = max(0.2, df0); c0 = max(0.01, c0); % just in case negative or extremely small

%% JUST RETURN INITIAL VALUES
if useML ~= 1
  dfhat=df0; muhat=mu0; chat=c0; iters = 0; 
  return
end  

%% OTHERWISE, PRINT THE INITIAL VALUES OUT AND CONTINUE WITH THE MLE
df_mu_c_start = [df0 mu0 c0]; %#ok<NASGU,NOPRT> % print out the starting values

% SOMETIMES C0 IS SO BAD THAT THE SCORE FUNCTION FOR DF DOES NOT CROSS ZERO!
% FIRST TRY INCREASING C0:
samesign=1; cc=c0/2; tries=0;
while samesign && (tries<7)
  cc=cc*2; tries=tries+1; disp(['Attempt:', int2str(tries)]);
  z = (x-mu0)/cc; e1=titer_df(1,z); e2=titer_df(60,z); 
  samesign=e1*e2>=0;
end  
% IF THAT DID NOT WORK, TRY DECREASING C0:
if samesign
  cc=c0; tries=0;
  while samesign && (tries<6)
    cc=cc/2; tries=tries+1; disp(['Attempt:', int2str(tries)])
    z = (x-mu0)/cc; e1=titer_df(1,z); e2=titer_df(60,z); 
    samesign=e1*e2>=0;
  end  
end  
if samesign %% CAN'T SEEM TO FIND ACCEPTABLE STARTING VALUES. EXIT PROGRAM
  disp('Score function for df appears to have no zero.')
  dfhat=-1; muhat=-1; chat=-1; iters=-1; 
  return
end
c0=cc;

%% SO FAR SO GOOD. TRY TO GET THE MLE BY INTERATING ON THE SCORE FUNCTION
% TOL=1e-5; MAXCNT=100; conv=0; cnt=0; opts=optimset('disp','none','TolX',1e-6);
MAXCNT=100; conv=0; cnt=0; opts=optimset('disp','none','TolX',1e-6);
while (conv<1) && (cnt<MAXCNT)

  %% UPDATE DEGREES OF FREEDOM ESTIMATE. Arbitrarily restricted to lie between 1 and 60
  z = (x-mu0)/c0; %%% z is t(v,0,1)
  % still have to check if we can locate a zero:
  e1=titer_df(1,z); e2=titer_df(60,z); 
  if e1*e2>=0
    disp('During ML iteration, score function for df had no zero.')
    df0, mu0, c0, dfhat=-1; muhat=-1; chat=-1; iters=-1; return %#ok<NOPRT> 
  end
  df1 = fzero(@titer_df,[1,60],opts,z);

  %% UPDATE LOCATION ESTIMATE. Arbitrarily restricted to lie between -20 and 20
  w = x/c0; %% w is t(v,mu/c,1)
  if usetrim~=1 %% use the root solve to get mu hat
    mu1star = fzero(@titer_mu,[-20,20],opts,df1,w);
  else % use the trimmed mean with optimal percentage
    if df1<1 % No choice! Must use the root solver
      mu1star = fzero(@titer_mu,[-20,20],opts,df1,w);
    else
      alpha = getalpha(df1); mu1star = mytrim(w,alpha);
    end
  end
  mu1 = mu1star * c0;
  
  %% UPDATE SCALE ESTIMATE. Arbitrarily restricted to lie between 0.01 and 100
  c1 = fzero(@titer_c,[0.01,100],opts,df1,x-mu1); 
  
  %% UPDATE PARAMETERS AND CHECK IF CONVERGED
  disc = sqrt((mu0-mu1)^2 + (df0-df1)^2 + (c0-c1)^2); 
  conv = disc < TOL;
  cnt=cnt+1; df0=df1; mu0=mu1; c0=c1; 
end
dfhat=df1; muhat=mu1; chat=c1; iters = cnt; 

function m=mytrim(x,pvec)
% m=mytrim(xx,p)
% calculates the trimmed means of vector x at percent values pvec
% appears to return same values as does matlab's TRIMMEAN, but is much faster for multiple p

x=sort(x); n=length(x); pl=length(pvec); m=zeros(1,pl);
for i=1:pl
  p=pvec(i)/2; lo=round(n*p/100); lo=max(1,lo) + 1; hi=round(n*(100-p)/100);
  y = x(lo:hi); m(i) = sum(y) / length(y);
  % [lo hi]
end  

function alpha = getalpha(df)
  if df<=3, alpha = round(76.2022 - 26.9827 * log(df));
  elseif df<=33, alpha = round(77.7679 - 33.1411 * log(df) + 3.2809 * (log(df))^2);
  elseif df<50, alpha=3;
  else, alpha=1; 
  end

function out=titer_c(c,df,q)
% called by titer.m when estimating the scale parameter.
% variable q is t(df,0,c)
n=length(q); z = q/c; y = df+z.^2;
out = n-(df+1)*sum(z.^2 ./ y);

function out=titer_mu(mu,df,w)
% called by titer.m when estimating the location parameter.
% variable w is t(df,mu/c,1)
z=w-mu; y=df+z.^2; out = sum(z./y);

function out=titer_df(df,z)
% called by titer.m when estimating the df parameter.
% variable z is already location-scale transformed
v=df; n=length(z); y = v+z.^2; k = (v+1)/2;
if 1==2
  % mfun was for sympbolic toolbox, and is now removed from Matlab 2021
  term1 = n*(mfun('Psi',0,k) + 1+log(v)- mfun('Psi',0,v/2) )/2;
else
  term1 = n*(digamma(k) + 1+log(v)-digamma(v/2))/2;
end
term2 = k*sum(1./y) + (1/2)*sum(log(y)); out = term1-term2;

function d=digamma(xvec,p)
% p=0: (default) digamma, the 1st derivative of ln(Gamma(x))
% p=1:           trigamma,  2nd derivative of ln(Gamma(x))
% etc.

if nargin<2, p=0; end
d=[];
uplim=[400,20,50,20,20,20]; gamma=0.5772156649;

for xloop=1:length(xvec)
  x=xvec(xloop);
  if p==0
    if x<=0,    val=NaN;
    elseif x>2, val=digamma(x-1,p)+1/(x-1);
    elseif x<1, val=digamma(x+1,p)-1/x;
    else
      k=1:uplim(p+1); val=(x-1)*sum( 1./(k.*(k+x-1)) );
      val=val-gamma+log(abs( (1000+x-0.5)/(1000+0.5)   ));
      val=val-err(x,p);
    end  
  else
    if x<=0,    val=NaN;
    elseif x>2, val=digamma(x-1,p) + (-1)^p * (x-1)^(-p-1) * locfact(p);
    elseif x<1, val=digamma(x+1,p) - (-1)^p * locfact(p) * x^(-p-1);
    else
      k=0:uplim(p+1); val=(-1)^(p+1) * locfact(p) * sum( (x+k).^(-p-1) );
      val = val + (uplim(p+1) + x + 0.5)^(-p) / p;
      val=val-err(x,p);
    end  
  end, d=[d val]; %#ok<AGROW> 
end

function f=locfact(p) % speed things up a bit
switch p
  case {0,1}, f=1; case 2, f=2; case 3, f=6; case 4, f=24;
  otherwise, f=gamma(p+1);
end
  
function y=err(x,p)
X=[1 x x.^(2) x.^(-1) x.^(-2)];
switch p
  case 0, beta =        [ 0.00149985469951  -0.00150252512644   0.00000259680697   0.00000010171105  -0.00000002809066]';
  case 1, beta = 1e-5 * [ 0.94537256884013  -0.12567679965822   0.00771953803399   0.01432653031347  -0.00387560345071]';
  case 2, beta = 1e-3 * [ 0.58767214976005  -0.02295679880111   0.00057163015709   0.00032389365787  -0.00008887677215]';
  case 3, beta = 1e-3 * [-0.18896723075195   0.02511308728742  -0.00154210997332  -0.00286025343675   0.00077376338023]';
  case 4, beta = 1e-4 * [ 0.33894910875572  -0.05815106605933   0.00416791889087   0.00962153748377  -0.00259254174103]';
  case 5, beta = 1e-5 * [-0.61247750211043   0.12714298618324  -0.01026281680048  -0.02879106364680   0.00773173473570]';
end    
y=X*beta;

