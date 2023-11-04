function AD = comp_AD(data_stand, ecdf, est_nu)
% comp_AD
% Computation of KS distance

para    = tcdf(sort(data_stand), est_nu);
AD(sim)     = max(abs(ecdf3 - para) ./ sqrt(ecdf3 .* (1 - ecdf3)));

end