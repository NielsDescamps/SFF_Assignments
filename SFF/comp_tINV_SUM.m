function pdf = comp_tINV_SUM(v, Xrange, NumPoints, distribution)

N = NumPoints;
x_range = Xrange;

% t in [-50, 50]
t_min = -x_range; t_max = x_range;

% NumPoints -> Inf equals the real integration
dt = (t_max - t_min) / evenToOdd(N);
t = t_min:dt:t_max;

if distribution =='t'

    % get values for cf
    cf_evals = zeros(1,N);
    for i = 1:length(t)
        cf_eval_i = comp_tCF(v,t(i));
        cf_evals(i) = cf_eval_i;
    end

    % get values for pdf
    x_min = -x_range; x_max = x_range;
    dx = (x_max-x_min) / (N-1);
    x = x_min:dx:x_max;
    
    pdf_evals = zeros(1,N);

    size(t)
    size(x)

    pdf_eval_i = @(x) trapz(t,real(cf_evals.*exp(-1i*t*x))/(2*pi));

    for i=1:length(x)
        x_i = x(i);

        f = @(s) trapz(x, pdf_eval_i(x));

        pdf_evals(i) = f(x_i);
    end
    
    pdf = pdf_evals;
    
end

end