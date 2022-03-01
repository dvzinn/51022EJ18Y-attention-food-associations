function breakscreen1()
% BREAKSCREEN1 The title and explanation input for the function
% generate_form.
% This function makes it possible to write a title and explanation on the
% GUI screen. The input should be written in this function itself and both
% should be a string.
title = "Learning trials";
explanation = "The first part of this experiment " + ...
    "will consist of learning trials. Symbols and images will be shown. " + ...
    "Take your time to remember them, because after the learning trials " + ...
    "you will have to retrieve 6 combinations. If you paired a combination two times correctly, " + ...
    "the next task will begin. Press 1 or 2 to choose an option and press 'j' or 'f' to go to the next associoation" + ...
    "Explanation about the next tasks will be given later. Press 'Continue' to continue.";

generate_form(title, explanation, [], []);
end