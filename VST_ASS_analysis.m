
%%  Get all subject data
saves = dir('saves');
file_names = cell(1,100);
index = 1;
%   Iterate through content of saves and get every file that isn't a
%   directory and has extension .mat
for i = 1:length(saves)
    if saves(i).isdir == 0 && contains(saves(i).name, '.mat')
        file_names{index} = saves(i).name;
        index = index + 1;
    end
end


filled_entry = 1;
%   Trim file_names
while isempty(file_names{filled_entry}) == 0
    filled_entry = filled_entry + 1;
end

file_names = file_names(1: (filled_entry - 1));

%%  Compile File Data
%   Produce a table which stores the sum of all preferences grouped by
%   condition
n_datapoints = length(file_names);
%   Color Prefernce
subject_preference(n_datapoints) = struct('ppn', [], ...
    'FA_vs_NA', [], ...
    'NA_vs_Control', [], ...
    'FA_vs_Control', [], ...
    'condition', []);

%   Add ppn, preferences and condition to association_prefernces
for i = 1:length(subject_preference) 
    %   Load in data
    file_name = sprintf('saves/%s', file_names{i});
    subject = load(file_name);
    
    %   Assign variables
    subject_preference(i).ppn = subject.data.ppn;
    subject_preference(i).FA_vs_NA = subject.data.preference_table{1,2};
    subject_preference(i).NA_vs_Control = subject.data.preference_table{2,2};
    subject_preference(i).FA_vs_Control = subject.data.preference_table{3,2};
    subject_preference(i).condition = subject.data.grouping;   
end

%% Condtion Preference

%   Get sum of preferences grouped by control and experimetnal
is_experimental = ismember({subject_preference.condition}, 'experimental');
is_control = ismember({subject_preference.condition}, 'control');


%   Get SUM of all associations prefernces
pref_FA = ([subject_preference.FA_vs_NA] + [subject_preference.FA_vs_Control]);
pref_NA = ((3 -[subject_preference.FA_vs_NA]) + [subject_preference.NA_vs_Control]);
pref_CONT = ((3 - [subject_preference.FA_vs_Control]) + (3 - [subject_preference.NA_vs_Control]));

Y = [sum(pref_FA(is_experimental)) sum(pref_NA(is_experimental)) sum(pref_CONT(is_experimental)) ; ...
    sum(pref_FA(is_control)) sum(pref_NA(is_control)) sum(pref_CONT(is_control))];

X =  categorical({'Experimental', 'Control'});


figure;
hold on
xlabel('Condition');
ylabel('Amount Chosen');
grid on;
title('Comparison of Symbol Preference')
bar(X,Y)
legend('Food Associated', 'Neutral Associated', 'Control', 'location', 'NorthWest')
%   Missing: SD

%%  Evaluation Plot: Preference

Y = [sum(pref_FA(2)) sum(pref_NA(2)) sum(pref_CONT(2)) ; ...
    sum(pref_FA(3)) sum(pref_NA(3)) sum(pref_CONT(3))];

X =  categorical({'Experimental', 'Control'});

figure;
hold on
xlabel('Condition');
ylabel('Amount Chosen');
grid on;
title('Comparison of Experimental and Control Subject')
bar(X,Y)
legend('Food Associated', 'Neutral Associated', 'Control', 'location', 'NorthWest')




%% Evaluation plot reactions time bij zetten
subject_RT(n_datapoints) = struct('ppn', [], ...
    'FA', [], ...
    'NA', [], ...
    'CONT', [], ...
    'grouping', []);

%   Add ppn, preferences and condition to association_prefernces 
for i = 1:length(subject_RT) 
    %   Load in data
    file_name = sprintf('saves/%s', file_names{i});
    subject = load(file_name);
    
    %   Get the VST data of a subject
    VST_data = subject.data.VST;
    %   Get all trials that are FA;2
    FA_trials = zeros(1, length(VST_data));
    NA_trials = zeros(1, length(VST_data));
    CONT_trials = zeros(1, length(VST_data));
 
    
    %   Assign reaction to their group
    for j = 1:length(VST_data) - 1
        if strcmp(VST_data(j).symbol_set{1}.condition, 'food_associated')
            FA_trials(j) = VST_data(j).reactiontime;
        elseif strcmp(VST_data(j).symbol_set{1}.condition, 'neutral_associated')
            NA_trials(j) = VST_data(j).reactiontime;
        elseif strcmp(VST_data(j).symbol_set{1}.condition, 'control')
            CONT_trials(j) = VST_data(j).reactiontime;
        end   
        
    end
    %   Trim reaction time vetors
    FA_trials = FA_trials(FA_trials ~= 0);
    NA_trials = NA_trials(NA_trials ~= 0);
    CONT_trials = CONT_trials(CONT_trials ~= 0);
    
    %   Remove outliers
   %-----------------
    %   Get Mean and SD of RT
    mean_FA = mean(FA_trials);
    SD_FA = std(FA_trials);
    mean_NA = mean(NA_trials);
    SD_NA = std(NA_trials);
    mean_CONT = mean(CONT_trials);
    SD_CONT = std(CONT_trials);
    
    %   Assign variables
    subject_RT(i).ppn = subject.data.ppn;
    subject_RT(i).FA = [mean_FA SD_FA];
    subject_RT(i).NA = [mean_NA SD_NA];
    subject_RT(i).CONT = [mean_CONT SD_CONT];
    subject_RT(i).grouping = subject.data.grouping;
    
end

%%  Evaluation Plot: Reactiontime
pp_one = 2;
pp_two =  3;

Y = [subject_RT(pp_one).FA(1) subject_RT(pp_one).NA(1) subject_RT(pp_one).CONT(1) ; ...
     subject_RT(pp_two).FA(1) subject_RT(pp_two).NA(1) subject_RT(pp_two).CONT(1)];
 
X =  categorical({sprintf('%s (%s)',subject_RT(pp_one).ppn, subject_RT(pp_one).grouping), sprintf('%s (%s)',subject_RT(pp_two).ppn, subject_RT(pp_two).grouping)});

err = [subject_RT(pp_one).FA(2) subject_RT(pp_one).NA(2) subject_RT(pp_one).CONT(2)  ...
     subject_RT(pp_two).FA(2) subject_RT(pp_two).NA(2) subject_RT(pp_two).CONT(2)];
 
figure;
hold on
xlabel('Condition');
ylabel('Reaction Time');
grid on;
title('Reaction Time Experimental VS Control Subject')
bar(X,Y)


legend('Food Associated Targets', 'Neutral Associated Targets', 'Control Targets', 'location', 'NorthWest')

