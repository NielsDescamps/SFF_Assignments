function plotMVTLocationScaleSimulated(sample_size, mu, Sigma, df, dims,bandwidth,num_pts,save_fig,file_name)
    
    if nargin < 8 || isempty(save_fig)
        save_fig = false;
        file_name = '';
    end
    
    % Generate location-scale bivariate student t samples
    sample = mvtLocationScale_random(sample_size, mu, Sigma, df);

    % Create meshgrid
    dim1 = dims(1) ; dim2 = dims(2);
    x1 = linspace(-dim1,dim1,num_pts);
    x2 = linspace(-dim2,dim2,num_pts);

    [X, Y] = meshgrid(x1, x2);

    % Evaluate the kernel density on the grid
    Z = mvksdensity(sample, [X(:), Y(:)], 'Bandwidth', bandwidth);

    % Reshape Z to match the dimensions of X and Y
    Z = reshape(Z, size(X));

    % Create mesh/surface plot
    figure;
    mesh(X, Y, Z);
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Density');
    title('Kernel Density Estimation of Location-Scale Bivariate Student t Samples');
    view(0, 90)

    if save_fig == true
        figure 
        mesh(X, Y, Z);
        xlabel('X-axis');
        ylabel('Y-axis');
        zlabel('Density');
        title('Kernel Density Estimation of Location-Scale Bivariate Student t Samples');
        view(0, 90);
        filename = ['figures/Q2/AdditionalPlots/',file_name,'Simulated_Topview.png'];
        saveas(gcf,filename);
        
        figure 
        mesh(X, Y, Z);
        xlabel('X-axis');
        ylabel('Y-axis');
        zlabel('Density');
        title('Kernel Density Estimation of Location-Scale Bivariate Student t Samples');
        view(45, 30);
        filename = ['figures/Q2/AdditionalPlots/',file_name,'Simulated_sideview.png'];
        saveas(gcf,filename);
    end
end