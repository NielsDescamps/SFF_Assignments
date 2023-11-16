function sample = mvtrandom(sample_size,Sigma,df)

% Define the bivariate CDF function
mvtcdf_function = @(x1, x2) mvtcdf([x1; x2],Sigma, df);

% Number of points for interpolation
int_points = 100;

% Generate points in the CDF space (using a grid for simplicity)
u1 = linspace(0, 1, int_points);
u2 = linspace(0, 1, int_points);

% Evaluate the CDF at the grid points
cdf_values = zeros(int_points, int_points);
for i = 1:int_points
    for j = 1:int_points
        cdf_values(i, j) = mvtcdf_function(u1(i), u2(j));
    end
end

% Create interpolant for inverse CDF
inv_cdf_interpolant = griddedInterpolant({u1, u2}, cdf_values, 'linear', 'linear');

% Generate uniform random variables in (0,1)
u1_samples = rand(sample_size, 1);
u2_samples = rand(sample_size, 1);

% Use CDF interpolation
x_samples = inv_cdf_interpolant(u1_samples, u2_samples);

end