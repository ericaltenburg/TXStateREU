climb = ones(1, size(AllClimb, 2));
descend = ones(1, size(AllDescend, 2)).*2;
hover = ones(1, size(AllHover, 2)).*3;
straight = ones(1, size(AllStraight, 2)).*4;

n = 9;

Move = [climb descend hover straight];

Data = [CPower DPower HPower SPower];
Data2 = [movmean(CPower,n) movmean(DPower,n) movmean(HPower,n) movmean(SPower, n)];

boxplot(Data2, Move);