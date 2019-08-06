function averages = powerBoxPlot(Normalize)

load('AllData.mat', 'Ascend', 'Hover', 'Descend', 'Straight');

if Normalize
    AscendTemp = normalizePower(Ascend);
    DescendTemp = normalizePower(Descend);
    HoverTemp = normalizePower(Hover);
    StraightTemp = normalizePower(Straight);
else
    AscendTemp = Ascend;
    DescendTemp = Descend;
    HoverTemp = Hover;
    StraightTemp = Straight;
end

AMove = AscendTemp(1, :);
APower = AscendTemp(6, :);

DMove = DescendTemp(1, :);
DPower = DescendTemp(6, :);

HMove = HoverTemp(1, :);
HPower = HoverTemp(6, :);
Amean = mean(APower);
SMove = StraightTemp(1, :);
SPower = StraightTemp(6, :);

Move = [AMove DMove HMove SMove];

Data = [APower DPower HPower SPower];

boxplot(Data, Move);

averages = [mean(APower) mean(DPower) mean(HPower) mean(SPower)];

end