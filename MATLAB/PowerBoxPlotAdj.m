climb = ones(1, size(AllClimbAdj, 2));
descend = ones(1, size(AllDescendAdj, 2)).*2;
hover = ones(1, size(AllHoverAdj, 2)).*3;
straight = ones(1, size(AllStraightAdj, 2)).*4;

n = 9;

MoveAdj = [climb descend hover straight];

DataAdj = [CPowerAdj DPowerAdj HPowerAdj SPowerAdj];
DataAdj2 = [movmean(CPowerAdj,n) movmean(DPowerAdj,n) movmean(HPowerAdj,n) movmean(SPowerAdj, n)];

boxplot(DataAdj2, MoveAdj);