function textbox_values = startscreen()
% STARTSCREEN The title, explanation, textbox names and textbox prompts
% input for the function generate_form.
% This function makes it possible to write a title, explanation and textbox
% prompts (what is written above the textboxes). Textbox_names is how the
% different text boxes will be called, which will not show up visibly in
% the GUI.
% The input should be written in this function itself and title and
% explanation should be a string, textbox_names and textbox_prompts should
% be the amount of boxes you want, resulting in two lists of strings.
title = "Welcome to our task";
explanation = "Hello! Thank you for participating in this experiment.                                                                                                                                                        " + ...
    "This experiment contains multiple parts, which will be explained in the next information screens. " + ...
    "Please fill in the textboxes and press 'Continue' to proceed. Goodluck!";
textbox_names = ["ppn", "visual impairment"];
textbox_prompts = ["Subject Number", ...
                   "Do you have visual impairments that cannot be corrected with lenses or glasses? (yes/no)"];

textbox_values = generate_form(title, explanation, textbox_names, textbox_prompts);
end