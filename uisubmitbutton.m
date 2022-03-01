function button = uisubmitbutton(lay)
% UISUBMITBUTTON Custom UI component uisubmitbutton.
% Uses a given layout as input, for example:
% lay = uigridlayout(fig, [rows, cols]);
% The output of the function is the button.
% Additional properties of this button:
%  - ValueMap - a containers.Map object in which to store textbox values on submission
%  - Textboxes - see function "pressed" for further explanation
    
% create the button
button = uibutton(lay);
button.Text = "Continue";

% two extra porperties added to the button (should be given a value after this function)
addprop(button, "ValueMap");
addprop(button, "Textboxes");

% create empty struct for textbox names and textboxes
button.Textboxes = struct();

% make sure pressing it closes the window and stores value in the map
% use the user-set ValueMap and Textboxes as arguments, as well as the toplevel ancestor of the button
% for a figure
button.ButtonPushedFcn = @(btn, event) pressed(btn.ValueMap, ancestor(btn, "figure", "toplevel"), btn.Textboxes);
end

function pressed(map, fig, textboxes)
% PRESSED Close the figure, and put the specified values in the map.
% The map input is a map from names of text boxes which correspond to the text boxes.
% The input "fig" is the figure to be closed.
% The "textboxes" input is a struct array, containing a name and textbox, whose value is to be put in the map. 
% For example:
% struct("name", {"eyesight", "sex"}, "textbox", {eyesight_textbox, sex_textbox});

%% when the button is pressed
wrong_input = false;

    % loop through the rows of textboxes: loop through each of the textbox names
    % and input pairs, and set map(name) to the corresponding value
    for row = 1:size(textboxes.name, 2)
        textbox_name = textboxes.name(row);
        textbox_value = string(textboxes.textbox(row).Value);
    
        % input checks, based on the text box
        switch textbox_name
            case {"eyesight", "adhd", "visual impairment", "colorblind", "eating disorders"}
                wrong_input = ~ismember(textbox_value, ["yes" "no"]);
            case {"sex", "gender"}
                wrong_input = ~ismember(textbox_value, ["male" "female" "other"]);
            case "age"
                wrong_input = isnan(str2double(textbox_value)) || ...
                    str2double(textbox_value) < 1 || str2double(textbox_value) > 100;
            case "ppn"
                wrong_input = isnan(str2double(textbox_value)) || ...
                    str2double(textbox_value) < 10000000 || str2double(textbox_value) > 99999999;
        end
    
        % to avoid overwriting "wrong_input", the code stops going through the
        % for loop when wrong_input = true
        if wrong_input
            break
        end
    
        % add the textbox value to the map when it passed the input checks
        map(textbox_name) = textbox_value;
    end
    
    % if all inputs are correct:  
    if ~wrong_input  
        % close the figure
        close(fig)
    else
        % creates message dialog box with the user's input
        msgbox(strcat("Wrong input: ", textbox_value))
    end
end