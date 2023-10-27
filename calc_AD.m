function AD = calc_AD(samples,dof)
%calc_AD calculates the AD statistic from a given set of student-t
%distributed simulated samples

   
% empirical cdf
r=length(samples);
v=1:r;
ecdf1 = (v-0.5)./r;
ecdf1 = reshape(ecdf1,[],1);

% fited cdf
[muhat, sigmahat,dofhat] = calc_MLE(samples, dof, 'tLocation');
yi = sort(samples);
xi = (yi-muhat)./sigmahat; %correct for location and scale
para = tcdf(xi,dofhat);

%calculate the AD statistic
coeff = sqrt(para.*(1-para));
AD = max(abs(ecdf1-para)./coeff);

end