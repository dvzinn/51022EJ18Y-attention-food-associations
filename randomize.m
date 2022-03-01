function [output] = randomize(input)
%   Randomize the contents of a one dimensional cell or vector
%
%   Input is a one dimensionsal vector or cell array
%   Output is that same vector or array in a random order
%   Only works for 1-dimensional data

output = input(randperm(length(input)));
