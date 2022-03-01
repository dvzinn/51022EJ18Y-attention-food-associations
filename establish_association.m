function    establish_association(letter, color, img, condition)
%   Establish Association
%  
%   This function takes in a letter, color, condition and image all being
%   char arrays. The image has to refer to a image in the working
%   directory.
%
%   There are two possible outputs based on the condition passed. For the
%   learning conditions only one image is passed. Hereby only a symbol and
%   a single image are displayed.
%  
%   The retrieval condition displays a single symbol in combination with
%   two images, both labeled with numbers.

%%  Input Check
%   check if passed letter is a char of 1
if ischar(letter) == 0 || length(letter) > 1
    error("Usage: plot_association('x', 'image.jpg', condition). Passed letter should be a single char")
end
%   INPUT CHECK: Check if img is a file in directory
%   INPUT CHECK: COlor
%   Check if condition is "learning" or "testing"
if condition == "testing"
    %   If testing, check if image is a cell array of 2
    if isa(img, 'cell') == 0 || length(img) ~= 2
        error("When using condition 'testing', for images pass a 3-cell array")
    end
elseif  condition == "learning"
    %   If learning, check if image is a string
    if isa(img, 'char') == 0
        error("When using condition 'learning', for images pass a single string")
    end
else
    error("Usage: plot_association('x', 'image.jpg', condition). Condition should be 'learning' or 'testing'");
end
 

%% Testing or Learning Trial
if condition == "testing"
    y_axis_image = [68 100];
    %   Plot letter
     instruct = text(10, 50, letter,'FontSize', 300,'color', color);
    %   Plot 3 images horizontally
    for i = 1:2
        %   Translate Image to be Usable in matlab
        RGB_map = imread(img{i});
        %   Plot Image
        image(flipud(RGB_map), 'XData', [70 95], 'YData', y_axis_image);
        %   Plot Image Numbers
        text(65, y_axis_image(2) - 15,{i},'FontSize', 80 )
        %   Modify y-axis to place images lower
        y_axis_image = y_axis_image - 63;
    end
else
    %   Translate Image to be Usable in matlab
    RGB_map = imread(img);
    %   Plot Image
    image(flipud(RGB_map), 'XData', [55 90], 'YData', [20 70]);
    %   Plot Plus
    text(40,50,'+','FontSize',120);
    %   Plot letter
    text(10, 50, letter,'FontSize', 300, 'color', color);
end
end

%Documentation
%   Image was hard to get workin
%   Image didn't remove
