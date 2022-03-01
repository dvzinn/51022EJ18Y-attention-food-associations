%   Food Associated Visual Search Task
%
%   This entire task performs association between a selected set of images
%   and symbols, followed by a visual search task and a symbol preference
%   test. Main starts by randomly assigning whether a participants is part
%   of the experimental condition or control condition. Afterwards all
%   color-letter combinations are initilaized based on the parameters colors, letters,
%   images and condition. 
%
%   Although not completely generazible, the symbol set produced by main can
%   take a variable amount of color, conditons and letters. Images can also
%   vary aslong as the sum of images is equal or more then the sum of all
%   possible symbols.
%
%   Other functionaliteis for main are the storage and saving of data. This
%   includes the results of the subfunctions and the results of the
%   questionnares ran.

%%  Randomly assign experimental or grouping
if randi(2) == 1
    grouping = 'experimental';
else
    grouping = 'control';
end

grouping = 'experimental';

%%   Init all images
images = struct('FA', [], 'NA', []);
images.FA = {'bread.jpg','chocolate.jpg','pizza.jpg'};
images.NA = {'landscape1.jpg', 'landscape2.jpg', 'landscape3.jpg'};

%   Randomize Order and Make sure Bread is always in set
images.FA = randomize(images.FA);
images.NA = randomize(images.NA);

%%  Produce Datastructre Containing All Symbols with Random Conditions
%   Input Variables
colors = {'blue', 'red', 'green'};
letters = {'X', 'O', '△'};

%   Structure containing all possible symbols
all_symbols(length(colors)*length(letters)) = struct("color", [], "letter", [], "condition", [],'image',[]);

%   N for food association, neutral association and control
n_FA = 3;
n_NA = 3;
n_CON = 3;

%   Input Check for Condition Assignment
if (n_FA+n_NA+n_CON) ~= length(all_symbols)
    error("Too litte or too many assigned conditions")
end
if n_FA ~= length(images.FA) || n_NA ~= length(images.NA)
    error("Make sure the N specified for associations is equal to the amount of images specified")
end

%   Assign all the conditions to vectors
conditions = struct('condition', [], 'image', []);
%   Food Associated
for i = 1:n_FA
    conditions.condition{i} = 'food_associated';
    conditions.image{i} = images.FA{i};
end
%   Neutral Associated
for i = (n_FA+1):(n_FA+n_NA)
    conditions.condition{i} = 'neutral_associated';
    conditions.image{i} = images.NA{i-n_FA};
end

%   Control
for i = (n_FA+n_NA+1):(n_FA+n_NA+n_CON)
    conditions.condition{i} = 'control';
    conditions.image{i} = 'control.jpg';
end
%   Randomize Condition Vector
rand_v = randperm(length(conditions.condition));
conditions.condition = {conditions.condition{rand_v}};
conditions.image = {conditions.image{rand_v}};
%   Assign all symbols, condiition to structure
for i  = 1:length(all_symbols)
    all_symbols(i).color = colors{ceil(i/length(colors))};
    all_symbols(i).letter =  letters{mod(i-1,length(letters)) + 1};
    all_symbols(i).condition = conditions.condition{i};
    all_symbols(i).image = conditions.image{i};
end

%% Questionnaire input on questions from different information screens 
% initialize the data struct
data = struct("ppn", [], ...
    'VST', [], ...
    'preference_table', [], ...
    'symbols', [], ...
    'questions', [], ...
    'grouping', []);
    

startscreen_values = startscreen();

if startscreen_values("visual impairment") == "yes"
    msgbox("Sadly, you cannot participate in our task, but your interest is appreciated.")
    return
end

%% Borderless Fullscreen figure with a margin of [100 100]
figure('WindowState', 'fullscreen','menubar', 'none')
hold on
set(gca,'xlim',[0 100],'ylim',[0 100],'visible','off');

%%  Association Tasks
if strcmpi(grouping, 'experimental')
    breakscreen1()
     association_task(all_symbols, images.FA, images.NA);
end

%%  Visual Search Task
close
breakscreen2()

required_hits = 20;
pause_trial = 50;
n_treisman = 24;

data_VST = VST(all_symbols, required_hits, pause_trial, n_treisman);

%   Trim The VST data and add student number
n_entries = 1;
while isempty(data_VST(n_entries).trial) == 0
    n_entries = n_entries + 1;
    data_VST(n_entries).ppn = startscreen_values("ppn");
end

data_VST = data_VST(1:n_entries);

%% Measure Association
breakscreen3()
preference_table = test_association(all_symbols);

%%  Store Data

% End Questionnare and store question data from information screens in the struct
slider_values = hungerscreen();
endscreen_values = endscreen();


questions = struct("ppn", [], ... 
    "visual_impairment", [], ...
    "eyesight", [], ... 
    "age", [], ...
    "gender", [], ...
    "sex", [], ...
    "hungerslider", [], ...
    "adhd", [], ...
    "eatingdisorders", []);

% insert the start- and end screen data into the data struct
questions.ppn = startscreen_values("ppn");
questions.sex = endscreen_values("sex");
questions.gender = endscreen_values("gender");
questions.age = endscreen_values("age");
questions.eatingdisorders = endscreen_values("eating disorders");
questions.visual_impairment = startscreen_values("visual impairment");
questions.adhd = endscreen_values("adhd");
questions.hungerslider = slider_values("hungerslider");


data.ppn = startscreen_values("ppn");
data.VST = data_VST;
data.preference_table = preference_table;
data.symbols = all_symbols;
data.questions = questions;
data.grouping = grouping;




%%  Save Data to File
%   Make File Name
base_name = sprintf("saves/%i", str2double(data.ppn));
file_name = sprintf("%s.mat", base_name);

%  Check if file exist
file_count = 1;
while exist(file_name) == 2;
    file_name = sprintf("%s(%i).mat", base_name, file_count);
    file_count = file_count + 1;
end

%   Save File and Clear Data
save(file_name, 'data');

close all