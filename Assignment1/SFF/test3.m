function output = test3(arg1, arg2, arg3)

  if nargin < 3
    arg3 = 100;
  end

  output = arg1 + arg2 + arg3;

end