function x = evenToOdd(x)
% evenToOdd
% Turns eventually odd numbers into even numbers

if mod(x,2) == 0
    x = x+1;
end