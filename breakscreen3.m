function breakscreen3()
% BREAKSCREEN3 The title and explanation input for the function
% generate_form.
% This function makes it possible to write a title and explanation on the
% GUI screen. The input should be written in this function itself and both
% should be a string.
title = "Time for the last part!";
explanation = "You will be shown 2 symbols at a time, press 'f' if you " + ...
    "prefer the left symbol, press 'j' if you prefer the symbol on the right.";

generate_form(title, explanation, [], []);
end
