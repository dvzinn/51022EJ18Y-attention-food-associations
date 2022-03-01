function two_symbols(s1, c1, s2, c2)
%   Plot two symbols
%
%   Input is two colors and two letters in char array form
%   Plots two symbols on a fullscreen figure

%%  Input check
if ischar(s1) == 0 || length(s1) > 1
    error("Both symbols need to be a string of 1")
end
if ischar(s2) == 0 || length(s2) > 1
    error("Both symbols need to be a string of 1")
end

%% Borderless Fullscreen figure with a margin of [100 100]
hold on
set(gcf,'WindowState', 'fullscreen','menubar', 'none')
set(gca,'xlim',[0 100],'ylim',[0 100],'visible','off');

%%  Plot figures
text(10, 50, s1,'FontSize', 300, 'Color', c1);
text(70, 50, s2,'FontSize', 300, 'Color', c2);
end