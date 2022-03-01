function [data_VST] = VST(symbol_collection, required_correct, pause_trials,  n_treisman)
 %  Visual Search Task Conjunctive
 %
 %  Performs the Treisman Visual Search Task in conjunctive mode. Whereby a
 %  person starts with 15 learning trials
 %
 %  Symbol_collection is the struct array indicating which symbols will be
 %  uses, fields being color and letter. required_correct indicates how
 %  many times each condition needs to be guessed correctly, pause_trials
 %  indicates how many trials have to pause before a pause ensues. And
 %  n_treisman indcates the amount of symbols showcased per trial
 % 
 %  The ouput is a struct with the trial number, the symbol set used
 %  whereby the first member of the set was the target, target which
 %  indicates target presen (1 or 0). User input such as keypress, reaction
 %  time and correctness is also logged
 
 
data_VST(400) = struct('ppn', [], 'trial', [], 'symbol_set',[],'reactiontime', [], 'target', [], 'keypress', [], 'correct', []);
N_color = length(unique({symbol_collection.color}));
N_letter = length(unique({symbol_collection.letter}));

%   Make a matrix recording all hits
hit_matrix = zeros(N_color, N_letter);
%   Make index vector
index_vector = 1:(N_color * N_letter);

%%  Start Pop up Message


%% Run Learning Trials Until 15 trails are correct
%   Amount of Correct Trials during learning phase
learning_correct = 0;
while learning_correct < 15
    %   Get Target and Randoize a Symbol Set
    symbol_set = make_symbol_set(symbol_collection, randi(length(symbol_collection)));
    target = floor(randi([4 9])/5);
    %   Run a trial and return whether answer is correct
    correct = doe_experiment(symbol_set, target, n_treisman).correct;
    %   Add to count
    learning_correct = learning_correct + correct;
    cla
end

%% Middle Message
set(gcf,'menubar', 'none','Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gca,'visible','off');
learn_text = text(0.5, 0.5, "Good job. You have completed the learning trials. The real experiment will now begin.");
set(learn_text,'visible','on','HorizontalAlignment','center','VerticalAlignment','middle','FontSize', 20);
pause
pause
clf

%%  Run Real Trials
% Trial Count
n_trials = 1;
while sum(hit_matrix(:)) < (required_correct * length(hit_matrix) * width(hit_matrix))
    %   Take random index that isn't NaN
    target_index = index_vector(randi(length(index_vector)));
    %   Determine Corresponding X-value
    row = ceil(target_index/3);
    column =  mod(target_index-1,3) + 1;
    %   Assign presence of target, Produce a 1 or 0 80% 1's
    target = floor(randi([4 9])/5);
    
    %   Pick 4 random symbols
     symbol_set = make_symbol_set(symbol_collection, target_index);

    %   Run a trial and log target, keypress, correct status and RT
    trial = doe_experiment(symbol_set, target, n_treisman);
    
    %%   If participants guessed correctly when target is present increment
    if trial.correct == 1 && strncmpi(trial.keypress, 'j', 1) == 1
       hit_matrix(row, column) = hit_matrix(row, column) + 1;
        %   If a combination of trial and setsize hit 20, remove the
        %   correspodning target_index
        if hit_matrix(row, column)== required_correct
            index_vector(index_vector == target_index) = [];
        end
    end
    
    %%   Store sn and trial and place in struture
    data_VST(n_trials).trial = n_trials;
    data_VST(n_trials).symbol_set = symbol_set;
    data_VST(n_trials).target = trial.target; 
    data_VST(n_trials).keypress = trial.keypress;
    data_VST(n_trials).reactiontime = trial.reactiontime;
    data_VST(n_trials).correct = trial.correct;
    
    %   Increment n_trial and clear figure
    n_trials = n_trials + 1;
    clf
    
    %%  Take a pause every 100 trials
    if mod(n_trials,pause_trials) == 0
        %   Display Pause Text
        set(gcf,'menubar', 'none','Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
        set(gca,'visible','off');
        pausetext = text(0.5, 0.5, "This is a planned pause. The experiment will continue when you touch they keyboard again");
        set(pausetext,'visible','on','HorizontalAlignment','center','VerticalAlignment','middle','FontSize', 20);
        pause
        pause
        clf
    end
end
