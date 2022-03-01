function [inputvalues] = hungerscreen()
% HUNGERSCREEN draws a figure and has a slider in it.
% Output value = the value of the hungerslider 

%% create a figure
fig = uifigure;
fig.WindowState = "maximized";

% give it a title
fig.Name = "How hungry or full are you?";

% give it a layout
lay = uigridlayout(fig, [5, 1]);
lay.RowHeight = {60, 32, 60, "1x", 60};

% add a heading to the figure
title = uilabel(lay);
title.Layout.Row = 1;
title.Layout.Column = 1;
title.HorizontalAlignment = "center";
title.FontSize = 44;
title.Text = fig.Name;

% add the explanation text to the figure
explanation = uilabel(lay);
explanation.Layout.Row = 2;
explanation.Layout.Column = 1;
explanation.VerticalAlignment = "top";
explanation.WordWrap = "on";
explanation.Text = "Now, slide de slider to indicate your hunger or " + ...
    "fullness and press the button to continue to the final few questions.";
explanation.HorizontalAlignment = "center";

%% add the slider
hungerlabels = {'Greatest imaginable hunger',
                'Extremely hungry',
                'Very hungry',
                'Moderately hungry',
                'Slightly hungry',
                'Neither hungry nor full',
                'Slightly full',
                'Moderately full',
                'Very full',
                'Extremely full',
                'Greatest imaginable fullness'};

sli = uislider(lay);
sli.Layout.Row = 3;
sli.Layout.Column = 1;
sli.MajorTicks = [1:length(hungerlabels)];
sli.Limits = [1, length(hungerlabels)];
sli.MajorTickLabels = hungerlabels;
sli.FontSize = 10;

% map for the value of the slider, the key hungerslider, the map is the 
% value of the hungerslider
inputvalues = containers.Map;

% add a submit button
button = uisubmitbutton(lay);
button.Layout.Row = 5;
button.Layout.Column = 1;
button.ValueMap = inputvalues;
button.Textboxes.name = ["hungerslider"];
button.Textboxes.textbox = [sli];

uiwait(fig);
end