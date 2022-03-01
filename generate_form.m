function textbox_values = generate_form(title_text, explanation_text, textbox_names, textbox_prompts)
% GENERATE_FORM Generates the lay-out and appearance of a GUI.
% Inputarguments for title_text and explanation_text should be strings,
% inputs for textbox_names and textbox_prompts can be lists of strings.
% title_text generates the title, explanation_text is the text that you want 
% to be shown on the GUI, textbox_names are unique identifiers of textboxes, 
% textbox_prompts are the headings of the textboxes. These are used to draw 
% the GUI, output is a map of textbox-names (keys) with the values from the 
% text-boxes.

% create a figure
fig = uifigure;

% apply settings to the frame
fig.Name = title_text;

% give it a layout
% make sure there are enough rows and columns for the textboxes and labels
rows = 2 * size(textbox_names, 2) + 3; % 2*textbox_names, since you need a space for the title and input box
cols = 2;
lay = uigridlayout(fig, [rows, cols]);
lay.RowHeight = {60, "1x", "1x", 50};
% repeat height 1x for each textbox label and textbox
lay.RowHeight = repelem(lay.RowHeight, [1, 2 * size(textbox_names, 2), 1, 1]);

disp(lay.RowHeight)

% add a heading to the figure
title = uilabel(lay);
title.Layout.Row = 1;
title.Layout.Column = [1 2];
title.HorizontalAlignment = "center";
title.FontSize = 44;
title.Text = fig.Name;

% add the explanation text to the figure
explanation = uilabel(lay);
% when there are no text-boxes there are three rows (2*0+3, see rows), 
% the rows would span from 2-2, which causes an error, so just specify 
% one number 2
if rows-1 == 2
    explanation.Layout.Row = 2;
else
    explanation.Layout.Row = [2 rows-1];
end
explanation.Layout.Column = 1;
explanation.VerticalAlignment = "top";
explanation.WordWrap = "on";
explanation.Text = explanation_text;

% add the input boxes to the figure
textboxes = [];
for box_number = 1:size(textbox_prompts, 2)
    % add the label
    label = uilabel(lay);
    label.Layout.Row = box_number * 2;
    label.Layout.Column = 2;
    label.Text = textbox_prompts(box_number);
    label.WordWrap = "on";

    % add the textbox
    textbox = uieditfield(lay);
    textbox.Layout.Row = box_number * 2 + 1;
    textbox.Layout.Column = 2;
    textbox.Tooltip = label.Text;

    % add the textbox to the list of textboxes
    textboxes = [textboxes textbox];
end

% create a map to store return values in
textbox_values = containers.Map;

% add confirmation button
button = uisubmitbutton(lay);
button.Layout.Row = rows;
button.Layout.Column = [1 2]; 
% the empty map in which the button safes the values of the text boxes
button.ValueMap = textbox_values;
% which names it should use to be placed in the map.
button.Textboxes.name = textbox_names;
% the textboxes from which the button should get the information from
button.Textboxes.textbox = textboxes;

uiwait(fig)
end