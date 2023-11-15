function pdfINV = comp_tINV(nu,x)
% COMP_TINV
% Computes the Student's t density given its inversion formula

syms t
pdfINV = int(exp(-1i*t*x) * comp_tCF(nu,t));

end

