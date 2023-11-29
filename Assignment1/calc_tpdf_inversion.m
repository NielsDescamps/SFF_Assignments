function pdf = calc_tpdf_inversion(v, Xrange, NumPoints, distribution)
N = NumPoints;
t_range = 100;
x_range = Xrange;


t_min = -t_range/2; t_max = t_range/2;
dt = (t_max-t_min)/(N-1);
t = t_min:dt:t_max;

if distribution =='t'

    % get values for cf
    cf_evals = characteristic_function_studentt(t,v);

    % get values for pdf
    x_min = -x_range/2; x_max = x_range/2;
    dx = (x_max-x_min)/(N-1);
    x = x_min:dx:x_max;
    
    pdf_evals = zeros(1,N);
    for i=1:length(x)
        x_i = x(i);
        
        pdf_eval_i = trapz(t,real(cf_evals.*exp(-1i*t*x_i))/(2*pi));
        pdf_evals(i) = pdf_eval_i;
    end
    
    pdf = pdf_evals;
    
end

end