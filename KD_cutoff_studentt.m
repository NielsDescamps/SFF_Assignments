function cutoff_val = KD_cutoff_studentt(dof,SampleSize,alpha,simulations,seed,plot)
%Determines the cutoff value for a given

rand('twister',seed);

r=SampleSize;

KD_vals = zeros(simulations,1);

for n= 1:simulations
    samples_n = trnd(dof,[r,1]);
    KD_n = calc_KD(samples_n);
    
    KD_vals(n) = KD_n;
end
display(KD_vals)

sorted_KD_values = sort(KD_vals)
percentile = [(1-alpha)*100];

cutoff_val = prctile(sorted_KD_values,percentile);

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