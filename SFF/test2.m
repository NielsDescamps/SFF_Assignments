function output1 = test2(input1)
% TEST Summary of this function goes here
%   Detailed explanation goes here

arguments
    input1 (1,:) {mustBePositive, mustBeFinite}
end

if ~exist('input1', 'var'), input1=1; end

output1 = input1;

end