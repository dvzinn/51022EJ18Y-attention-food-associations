function association_task(symbol_collection, FA_images, NA_images)
%   Perform Associotion Task
%   Pass a symbol collection, and two image sets
%   The symbol collection needs to be a struct with the fields:
%   'color', 'letter' and 'condition', having at least two unique variables
%   for each
%   The images sets are a cell arrays are images referring to files in the
%   working directory. 
%   
%   The purpose of the task is to establish an association between a symbol
%   and image. It repeatedly runs an encoding trial, symbol + 1 picture,
%   and a retrieval trial, symbol + 3 pictures. The program ends when all
%   symbols have been retrieved perfectly two time in a row

%%   Run whole associaton task until participants gets 2 perfec retrievals
n_perfect_retrieval = 0;
while n_perfect_retrieval < 2
    %%  Run learning trials
            %   Randomize symbol sequence
    rand_v = randomize(1:9);
    
    rand_color = {symbol_collection(rand_v).color};
    rand_letter = {symbol_collection(rand_v).letter};
    rand_condition = {symbol_collection(rand_v).condition};
    rand_image = {symbol_collection(rand_v).image};
        
    for i = 1:length(symbol_collection)
        symbol_collection(i).color = rand_color{i};
        symbol_collection(i).letter = rand_letter{i};
        symbol_collection(i).condition = rand_condition{i};
        symbol_collection(i).image = rand_image{i};
    end
        
    %   Encoding
    for i = 1:length(symbol_collection)
        establish_association(symbol_collection(i).letter, symbol_collection(i).color,  symbol_collection(i).image, 'learning');
        keypress = 0;
        while strcmpi(keypress,'f') == 0 && strcmpi(keypress,'j') == 0
            pause
            keypress = get(gcf,'CurrentKey');
        end
        cla
    end

    
    %%  Run Retrieval Trials
    
        %   Randomize symbol sequence
    rand_v = randomize(1:9);
    
    rand_color = {symbol_collection(rand_v).color};
    rand_letter = {symbol_collection(rand_v).letter};
    rand_condition = {symbol_collection(rand_v).condition};
    rand_image = {symbol_collection(rand_v).image};
        
    for i = 1:length(symbol_collection)
        symbol_collection(i).color = rand_color{i};
        symbol_collection(i).letter = rand_letter{i};
        symbol_collection(i).condition = rand_condition{i};
        symbol_collection(i).image = rand_image{i};
    end
    
    perfect_retrieval = true;
    for i = 1:length(symbol_collection)
        %   3-Cell array consisting of the retrieval image and two distractors

        %   Retrieval of FA
        if strcmp(symbol_collection(i).condition, 'food_associated')
            retrieval_image_set = {NA_images{randi(length(NA_images))}, symbol_collection(i).image};
            %   Retrieval of NA
        elseif strcmp(symbol_collection(i).condition, 'neutral_associated')
            retrieval_image_set = {FA_images{randi(length(FA_images))}, symbol_collection(i).image};
            %   Retrieval of Control
        else
            continue
        end
        %   Put Images of Retrieval Set in Random Order
        retrieval_image_set = randomize(retrieval_image_set);

        %   Show Association
        establish_association(symbol_collection(i).letter, symbol_collection(i).color, retrieval_image_set, 'testing');

        %   Parse keypress
        keypress = 0;
        while (strcmpi(keypress,'1') == 0 && strcmpi(keypress,'2') == 0 && strcmpi(keypress,'3') == 0)
            pause
            keypress = get(gcf,'CurrentKey');
        end
        cla

        %   Check if answer was correct by comparing position to index
        index = find(contains(retrieval_image_set,symbol_collection(i).image));
        %   If correct
        if any(strcmp(string(index),string(keypress)))
            %   Correct Message
            text(40,50, 'Correct','FontSize', 40);
        %   If Incorrect
        else
            %   Error Message
            perfect_retrieval = false;
            text(40,50, 'Incorrect', 'FontSize', 40);
        end
        pause(1)
        cla
    end
    
    %   Log pefrect retrievals
    if  perfect_retrieval == true
        n_perfect_retrieval = n_perfect_retrieval + 1;
    else 
        n_perfect_retrieval = 0;
    end
    
end
