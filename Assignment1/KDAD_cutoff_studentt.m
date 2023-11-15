function [KD_cutoff_vals,AD_cutoff_vals] = KDAD_cutoff_studentt(dof,SampleSize,alpha,simulations,seed,plot_KDvals)
%Determines the cutoff value for a given

rand('twister',seed);

r=SampleSize;
tsample = trnd(dof,[r,1]);

KD_vals = zeros(simulations,1);
AD_vals = zeros(simulations,1);


for n= 1:simulations
    indices = randi(r,1,r);
    resample = tsample(indices);

    KD_n = calc_KD(resample,dof);
    AD_n = calc_AD(resample,dof);
    KD_vals(n) = KD_n;
    AD_vals(n) = AD_n;
end

sorted_KD_values = sort(KD_vals);
sorted_AD_values = sort(AD_vals);
percentiles = [(1-alpha)*100];

KD_cutoff_vals = prctile(sorted_KD_values,percentiles);
AD_cutoff_vals = prctile(sorted_AD_values,percentiles);

if plot_KDvals==true
    [f, x] = ksdensity(KD_vals,'Function','pdf','Bandwidth', 0.01, 'Kernel', 'epanechnikov', 'NumPoints', 1000);
    figure
    plot(x,f);
    title(['estimated pdf for KD values for r=',num2str(r),' and dof=',num2str(dof)])
    xlabel('KD Values');
    ylabel('Probability Density');
    file_name = ['figures/KDr',num2str(r),'dof',num2str(dof),'.png'];
    saveas(gcf,file_name)

    [f, x] = ksdensity(AD_vals,'Function','pdf','Bandwidth', 0.01, 'Kernel', 'epanechnikov', 'NumPoints', 1000);
    figure
    plot(x,f);
    title(['estimated pdf for AD values for r=',num2str(r),' and dof=',num2str(dof)])
    xlabel('AD Values');
    ylabel('Probability Density');
    file_name = ['figures/ADr',num2str(r),'dof',num2str(dof),'.png'];
    saveas(gcf,file_name)

end

end