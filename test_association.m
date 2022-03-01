function [pref_table] = test_association(symbol_collection)
%   Test if Association establsihed
%
%   A preference test is preformed to see if the associaton established has
%   any affect on prefence of symbols. The passed symbol collection is a
%   struct array having the fields of color, letter and condition. 
%
%   The function compares each condition to another 3 times and returns a
%   table indcating which choices were made.
%   
%   Only conditions named 'food_associated', 'neutral_associated' and
%   'control' will work.
%   Get conditions
conditions = {symbol_collection(:).condition};
%   Logical vectors for FA,NA, control
v = 1:9;
FA = symbol_collection(ismember(conditions, 'food_associated'));
NA = symbol_collection(ismember(conditions, 'neutral_associated'));
CONT = symbol_collection(ismember(conditions, 'control'));

%   Indicate all the comparisons you want made
comparisons = {...
    {FA, NA},...
    {NA, CONT},...
    {FA, CONT}};

%   Table for preferences
pref_table = table('Size',[length(comparisons) 2],'VariableTypes',{'string','double'},'VariableNames',{'comparison','score'});

for row = 1:length(comparisons)
    set_one = comparisons{row}{1};
    set_two = comparisons{row}{2};
    %   Set Name of Row
    pref_table{row,1} = string(sprintf('%s vs %s', set_one(1).condition, set_two(1).condition));
    for col = 1:length(set_one)
        %   Randomly show symbol on left or right
        dir = randi(2);
        %   set_one on left
        if dir == 1
            two_symbols(set_one(col).letter ,set_one(col).color, set_two(col).letter, set_two(col).color)
        %   set_one on right
        else 
            two_symbols(set_two(col).letter, set_two(col).color, set_one(col).letter ,set_one(col).color)
        end
        %   Only continie if 'f' or 'col' is pressed
        keypress = 0;
        while strcmpi(keypress,'f') == 0 && strcmpi(keypress,'j') == 0
            pause
            keypress = get(gcf,'CurrentKey'); 
        end
        %   If first set is picked add to hit
        if dir == 1 && strcmpi(keypress,'f')
            pref_table{row, 'score'} = pref_table{row, 'score'} + 1;
        elseif dir == 2 && strcmpi(keypress,'j')
            pref_table{row, 'score'} = pref_table{row, 'score'} + 1;
        end       
        cla   
    end
end

    

