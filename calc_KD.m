function KD = calc_KD(samples)
%calc_KD calculates the KD statistic from a given set of student-t
%distributed simulated samples

   
% empirical cdf
r=length(samples);
v=1:r;
ecdf1 = (v-0.5)./r;
ecdf1 = reshape(ecdf1,[],1);
ecdf2 = (v-3/8)./(r+1/4);
ecdf2 = reshape(ecdf2,[],1);


% fitted cdf
sorted_samples = sort(samples);
samples_column_vector = reshape(samples,[],1);

pd = fitdist(samples_column_vector, 'tLocationScale');
dofhat = pd.nu;  % Degrees of freedom
muhat = pd.mu;   % Location parameter (mean)
sigmahat = pd.sigma;  % Scale parameter (standard deviation)

% %check properness of cdf 
% i=-10:0.01:10;
% pdf = tpdf(i,dofhat);
% plot(i,pdf)
% 
% cdf = tcdf(i,dofhat);
% plot(i,cdf)

% determine fcdfit values
yi = sort(samples);
xi = (yi-muhat)./sigmahat; %correct for location and scale
para = tcdf(xi,dofhat);

%calculate the KD statistic
KD = max(abs(ecdf1-para));


end