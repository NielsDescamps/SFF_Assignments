function char_f = characteristic_function_studentt(t_val,v_val)

    char_function = @(t,v) (besselk(v/2,sqrt(v).*abs(t)).*(sqrt(v).*abs(t)).^(v/2))./(gamma(v/2)*2^(v/2 - 1));

    char_f = char_function(t_val,v_val);

end

