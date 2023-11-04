function KS = comp_KS(data_stand, ecdf, est_nu)
% comp_KS
% Computation of KS distance

para    = tcdf(sort(data_stand), est_nu);
KS      = max(abs(ecdf - para))

end