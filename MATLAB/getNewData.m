
file = 'OldPowerData.csv';
fileName = 'OldPowerData';

read = readmatrix(file);
data = read';

Climb = data([2 3 6], data(1, :)==1);
Descend = data([2 3 6], data(1, :)==3);
Hover = data([2 3 6], data(1, :)==2);
Horizontal = data([2 3 6], data(1, :)==4);

save([fileName, '.mat'], 'Climb', 'Descend', 'Hover', 'Horizontal');



