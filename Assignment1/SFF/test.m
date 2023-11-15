function [output1, output2] = test(input1, input2)
% TEST Summary of this function goes here
%   Detailed explanation goes here

arguments
    input1 (1,:) {mustBePositive, mustBeFinite}
    input2 (1,:) {mustBeNumeric, mustBeFinite}
end

if ~exist('input1', 'var'), input1=1; end
if ~exist('input2', 'var'), input2=100; end

output1 = input1;
output2 = input2;

end