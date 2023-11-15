function KD = calc_KD(samples,dof)
%calc_KD calculates the KD statistic from a given set of student-t
%distributed simulated samples

   
% empirical cdf
r=length(samples);
v=1:r;
ecdf1 = (v-0.5)./r;
ecdf1 = reshape(ecdf1,[],1);

% fitted cdf
[muhat, sigmahat,dofhat]= calc_MLE(samples, dof, 'tLocationScale');
yi = sort(samples);
xi = (yi-muhat)./sigmahat; %correct for location and scale
para = tcdf(xi,dofhat);

%calculate the KD statistic
KD = max(abs(ecdf1-para));


end