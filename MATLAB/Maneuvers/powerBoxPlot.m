% **
% Author:		John Graves
% Date: 		6 August 2019
% Description:	create a box plot of varience and find average values of power for each maneuver
% **

function powerBoxPlot(Normalize)
% Normalize: Boolean - whether or not to normalize the data for the box plot and average

% Use the respective date (normalized or plain)
if Normalize
    load('AllDataNormalized.mat', 'AscendNorm', 'HoverNorm', 'DescendNorm', 'StraightNorm');
    AscendTemp = AscendNorm;
    DescendTemp = DescendNorm;
    HoverTemp = HoverNorm;
    StraightTemp = StraightNorm;
else
    load('AllData.mat', 'Ascend', 'Hover', 'Descend', 'Straight');
    AscendTemp = Ascend;
    DescendTemp = Descend;
    HoverTemp = Hover;
    StraightTemp = Straight;
end

% pull out the maneuver and power data
AMove = AscendTemp(1, :);
APower = AscendTemp(6, :);

DMove = DescendTemp(1, :);
DPower = DescendTemp(6, :);

HMove = HoverTemp(1, :);
HPower = HoverTemp(6, :);

SMove = StraightTemp(1, :);
SPower = StraightTemp(6, :);

Move = [AMove DMove HMove SMove];

Data = [APower DPower HPower SPower];

% plot the data in a box plot grouped by Move
boxplot(Data, Move);


% Save the average power for each maneuver
if Normalize
    averagesNorm = [mean(APower) mean(DPower) mean(HPower) mean(SPower)];
    save('avgPowersNormalized.mat', 'averagesNorm');
else
    averages = [mean(APower) mean(DPower) mean(HPower) mean(SPower)];
    save('avgPowers.mat', 'averages');
end

end