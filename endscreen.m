function textbox_values = endscreen()
% ENDSCREEN The title, explanation, textbox names and textbox prompts
% input for the function generate_form.
% This function makes it possible to write a title, explanation and textbox
% prompts (what is written above the textboxes). Textbox_names is how the
% different text boxes will be called, which will not show up visibly in
% the GUI.
% The input should be written in this function itself and title and
% explanation should be a string, textbox_names and textbox_prompts should
% be the amount of boxes you want, resulting in two lists of strings.
    title = "Last questions";
    explanation = "Please fill in the last questions and press 'Continue' to end the task. Thank you for participating in our experiment!";
    textbox_names = ["sex", "gender", "age", "eating disorders", "adhd"];
    textbox_prompts = ["What is your sex? (male/female/other)", ...
                       "What is your gender? (male/female/other)", ...
                       "What is your age?", ...
                       "Do you have any eating disorders? (yes/no)", ...
                       "Do you have ADHD?"];

    textbox_values = generate_form(title, explanation, textbox_names, textbox_prompts);
end