function [KD_cutoff_vals,AD_cutoff_vals] = KDAD_cutoff_studentt(dof,SampleSize,alpha,simulations,seed,plot)
%Determines the cutoff value for a given

rand('twister',seed);

r=SampleSize;

KD_vals = zeros(simulations,1);
AD_vals = zeros(simulations,1);

for n= 1:simulations
    samples_n = trnd(dof,[r,1]);
    KD_n = calc_KD(samples_n);
    AD_n = calc_AD(samples_n);
    
    KD_vals(n) = KD_n;
    AD_vals(n) = AD_n;
end

sorted_KD_values = sort(KD_vals);
sorted_AD_values = sort(AD_vals);
percentiles = [(1-alpha)*100];

KD_cutoff_vals = prctile(sorted_KD_values,percentiles);
AD_cutoff_vals = prctile(sorted_AD_values,percentiles);


% if plot==true
%     % pdf = (1:simulations)/simulations;
%     % sorted_KD_vals = sort(KD_vals);
% 
%     [f, x] = ksdensity(KD_vals);
% 
%     plot(x,f);
%     title('estimated pdf for KD values')
%     xlabel('KD Values');
%     ylabel('Probability Density');
% 
% end

end