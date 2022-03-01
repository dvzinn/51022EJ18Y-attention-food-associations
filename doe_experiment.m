function [trial_result] = doe_experiment(symbol_set, target, n)
% This function shows a visual search task figure based on a passed symbol
% set inddicated presenece of a target and n (amount of symbols)
%  
%   Symbol_set should be a 4-length struct array where the struct have the
%   fields color and letter. n should be a positive integer and target
%   should be 1 or 0
%
%   doe_experiment outputs a structure which contains the symbol_set used
%   in the trial and whether a target was present, user keypress, reaction
%   time and correctness

%% Maak figuur
%   Make symbol set usable for treisman
treisman_set{4} = '';
for i = 1:4
    treisman_set{i} = {symbol_set{i}.color, symbol_set{i}.letter};
end
treisman_conj(treisman_set, n, target)
%% Meet reactietijd gebruik hiervoor tic-toc en pause.
%   Storeage vector for trial_result
trial_result = struct('symbol_set', [], 'target', [], 'keypress', [], 'correct', [], 'reactiontime', []);
%   Start timer
tic;
%   Check for button input
pause
%   Log reaction time
reactietijd = toc;
%   Log keypress
keypress = get(gcf, 'CurrentCharacter');
%   Check if correct 
if target == 1 && strncmpi(keypress, 'j', 1) == 1
    correct = 1;
elseif target == 0 && strncmpi(keypress, 'f', 1) == 1
    correct = 1;
else
    correct = 0;
end

%   Store keypress, reaction time, correct status and target
trial_result.symbol_set = symbol_set;
trial_result.keypress = keypress;
trial_result.reactiontime = reactietijd;
trial_result.correct = correct;
trial_result.target = target;
end