function [symbol_set] = make_symbol_set(symbol_collection, index)
%   Make a Treisman Symbol Set
%   
%   Make a symbol set used for the treisman visual search task. The symbol
%   collection should be a struct array with multiple symbols and having
%   the fields color and letter. The index indicates which symbol you want
%   to definitevely in the set.
%
%   The output is a 4-length struct array whereby the symbol at the passed
%   index is in the first position, a symbol sharing it's color 2nd. The
%   3rd and 4th symbol share a random color distinct from the first pair,
%   however they do share the same letters as the first pair.

%   Init Symbol
symbol_set = cell(1,4);
%   Pick a symbol target and place it 
symbol_set{1} = symbol_collection(index);
%   Get the symbol targets color and letter
target_color = symbol_set{1}.color;
target_letter = symbol_set{1}.letter;

%   Pick a random color and letter that isn't the same as the target

%%  Assign the second symbol
%   Get a randon letter that isn't symbol target
letter_not_target = setdiff(unique({symbol_collection.letter}), target_letter);
letter_not_target = letter_not_target{randi(length(letter_not_target))};

%   Get the indexes of all symbols that share the target color in a logical
%   array
shared_target_color = find(contains(string({symbol_collection.color}), target_color));
%   Get the indexes of all symbols that is the letter that isn't the target
shared_not_target_letter = find(contains(string({symbol_collection.letter}), letter_not_target));
%   Find the symbol that matches the above prerequisites
second_symbol_position = intersect(shared_target_color, shared_not_target_letter);
symbol_set{2} = symbol_collection(second_symbol_position);

%%  Assign third symbol
%   Get a random color hat isn't symbol target
color_not_target = setdiff(unique({symbol_collection.color}), target_color);
color_not_target = color_not_target{randi(length(color_not_target))};

%   Get the indexes of all symbols that share the target letter in a logical
%   array
shared_target_letter = find(contains(string({symbol_collection.letter}), target_letter));
%   Get the indexes of all symbols that is the color that isn't the target
shared_not_target_color = find(contains(string({symbol_collection.color}), color_not_target));


%   Find the symbol that shares target letter but differs in color
third_symbol_position = intersect(shared_target_letter, shared_not_target_color);
symbol_set{3} = symbol_collection(third_symbol_position);

%%  Assign fourth symbol
fourth_symbol_position = intersect(shared_not_target_letter, shared_not_target_color);
symbol_set{4} = symbol_collection(fourth_symbol_position);



