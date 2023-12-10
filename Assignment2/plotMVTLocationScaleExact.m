function out = plotMVTLocationScaleExact(Location, Sigma, df, dims, num_points, save_fig, file_name)
    
    if nargin < 6 || isempty(save_fig)
        save_fig = false;
        file_name = '';
    end
    
    locx1 = Location(1);
    locx2 = Location(2);

    dim1 = dims(1);
    dim2 = dims(2);

    x1 = linspace(-dim1,dim1, num_points);
    x2 = linspace(-dim2,dim2, num_points);

    x1plot = linspace(locx1 - dim1, locx1 + dim1, num_points);
    x2plot = linspace(locx2 - dim2, locx2 + dim2, num_points);

    [X1, X2] = meshgrid(x1, x2);
    F = mvtpdf([X1(:) X2(:)], Sigma, df);
    F = reshape(F, length(x2), length(x1));
 
    figure 
    surf(x1plot, x2plot, F);
    axis([locx1 - dim1, locx1 + dim1, locx2 - dim2, locx2 + dim2, 0, 0.4])
    xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
    
    
    if save_fig == true
        figure 
        surf(x1plot, x2plot, F);
        axis([locx1 - dim1, locx1 + dim1, locx2 - dim2, locx2 + dim2, 0, 0.3])
        xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
        view(0, 90);
        filename = ['figures/Q2/AdditionalPlots/',file_name,'topview.png'];
        saveas(gcf,filename);
        
        figure 
        surf(x1plot, x2plot, F);
        axis([locx1 - dim1, locx1 + dim1, locx2 - dim2, locx2 + dim2, 0, 0.3])
        xlabel('x1'); ylabel('x2'); zlabel('Probability Density');
        filename = ['figures/Q2/additionalPlots/',file_name,'sideview.png'];
        saveas(gcf,filename);
    end
        

    out = true;

end