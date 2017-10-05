function [per_trial, trials] = group_items_practice(ratingItem);

% reset random generator

rand('state',sum(100*clock));
% ratingItem;
% 86 items, 18 trials
design.trials3 = [ones(1,3).*1 ];  % 3 trials where the 3 items awaits to be chosen, favorite comes 1st, 2nd, 3rd
design.trials4 = [ones(1,4).*2]; % 4 trials of 4 items
design.trials5 = [ones(1,5).*3]; % 5 trials of 5 items
design.trials6 = [ones(1,6).*4];  % 6 trials of 6 items
design.trials_index = [design.trials3, design.trials4, design.trials5, design.trials6];
design.trials_perm = randperm(length(design.trials_index));
design.trials_sequence = design.trials_index(design.trials_perm);

order.rest3 = [1:3]; order.rest4 = [1:4]; order.rest5 = [1:5]; order.rest6 = [1:6];
order.A = [order.rest3(randperm(3))];
order.B = [order.rest4(randperm(4))];
order.C = [order.rest5(randperm(5))];
order.D = [order.rest6(randperm(6))];

per_trial = {};
for i = 1:4
    % read out the item and the rating belong to which trial
    per_trial.whichitems{i} = find(design.trials_sequence == i);    % assign each item to a trial, 1* 18 cell array
    per_trial.ratings{i} = ratingItem(per_trial.whichitems{i}); % get the ratings for the item
    
    % rank the ratings and the items per trial
    [per_trial.ratingsRanked{i},sortIndex] = sort(per_trial.ratings{i},'descend');  % sort out the rating on a descending sequence
    oi =  per_trial.whichitems{i};           
    per_trial.itemsRanked{i} = oi(sortIndex);   % sort out the item number
    
    % register pre-defined order
    if  i == 1
        per_trial.order{i} = order.A(:)';
        per_trial.itemNumber{i} = 3;
        per_trial.highPosition{i} = i;
        per_trial.highPositionSec{i} = find(per_trial.order{i}  == 2);
        
    elseif i == 2
        per_trial.order{i} = order.B(:)';        
        per_trial.itemNumber{i} = 4;
        per_trial.highPosition{i} = i;
        per_trial.highPositionSec{i} = find(per_trial.order{i}  ==2) ;

    elseif i == 3
        per_trial.order{i} = order.C(:)';
        per_trial.itemNumber{i} = 5;
        per_trial.highPosition{i} = i;
        per_trial.highPositionSec{i} = find(per_trial.order{i}  ==2)  ;

    elseif i == 4
        per_trial.order{i} = order.D(:)';        
        per_trial.itemNumber{i} = 6;
        per_trial.highPosition{i} = i;
        per_trial.highPositionSec{i} = find(per_trial.order{i}  ==2) ;

    end
    
    % reorder the sequence according to predefined order on ratings get also the item index
    r = per_trial.ratingsRanked{i};
    per_trial.ratingsOrdered{i} = r(per_trial.order{i});
    w =  per_trial.itemsRanked{i};
    per_trial.itemsOrdered{i} = w(per_trial.order{i});
    
end


    % randomize the sequence of the 18 trials
trial.sequence = [1:4];
trial.sequence = trial.sequence(randperm(4));
trials.whichitems =  per_trial.whichitems(trial.sequence);
trials.ratings = per_trial.ratings(trial.sequence);

trials.ratingsranked = per_trial.ratingsRanked(trial.sequence);
trials.itemsranked = per_trial.itemsRanked(trial.sequence);

trials.ratingsordered = per_trial.ratingsOrdered(trial.sequence);
trials.itemsordered = per_trial.itemsOrdered(trial.sequence);
trials.Order = per_trial.order(trial.sequence);
trials.itemNumber = per_trial.itemNumber(trial.sequence);
trials.highestPosition = per_trial.highPosition(trial.sequence);
trials.highestPositionSec = per_trial.highPositionSec(trial.sequence);

end



