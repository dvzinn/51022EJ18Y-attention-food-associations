function [symbol] = zet_symbool_infiguur(loc, s, k)
%Place Symbol in Figure
%   Place a figure randomly in a figure
%   Inputs are location, string and color
%   loc = [x y], number between 0 and 1
%   s = string
%   k = color

%   Turn loc into x and y
x = loc(1);
y = loc(2);
%   Make text
symbol = text(x, y, s, 'color', k);
set(symbol,'FontSize', 20);