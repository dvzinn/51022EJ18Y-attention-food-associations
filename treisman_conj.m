function treisman_conj(symbol_set, n, target)
% Make a figure of n objects, with or without a figure
% Peform a conjunctive treisman plot 
% symbols: a array of cells, each containing color and symbol {
% n = amount of letters 
% target: whether or not a target will be present (0 or 1)
% target is the first member of the cell array
%Example Array = {{'blue','X'}, {'red','O'}, {'red','X'}, {'blue','O'}}

%Input check 
%   check valid n
if isnumeric(n) == 0
    error("n should be a positive integer")
elseif mod(n,1) > 0
    error("n should be a whole integer. No floats allowed")
elseif n < 8 || n > 60
    error("n should be a integer between 8-60")
end
%   IMPLEMENT: Input check symbols
        %Check if order is right 
%   target
if target ~= 1 && target ~= 0
    error("Target should be a 1 or 0.")
end


%% Set the distribution for distractors and target
%   The 1 is allocated to the target, the n/2-1 to the distractor with same
%   color as target, n/4 is assigned to other distractors
distribution = [target n/2-1 n/4 n/4];

%   Put the distractor that shares target color in second position
for i = 3:length(symbol_set)
    %   If color shared distractor is found swap it to the 2nd positiion
    if strcmp(symbol_set{i}{1}, symbol_set{1}{1})
        temp = symbol_set{2}{1};
        symbol_set{2}{1} = symbol_set{i}{1};
        symbol_set{i}{1} = temp;
        break
    end
end



%%  Make a fulscreen figure with no axis and menubar
set(gcf,'menubar', 'none')
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'visible','off')

%%
%   Loop for each symbol
for i = 1:length(distribution);
    %   Assign letter and color
    letter = symbol_set{i}{2};
    color = symbol_set{i}{1};
    %   attirubte s ymbol amount
    n_symbol = distribution(i);
    %   Loop the symbol according to distribution
    for  j = 1:n_symbol
        %   Generate 
        zet_symbool_infiguur([rand(1) rand(1)], letter, color);       
    end
end

%%  Documentation
%   Changed Treisman to take input from passed symbols
%   Distribution works based on conjuncyion ad 1st position
%
%