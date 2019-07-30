
% UPDATE THE VARIABLES!!!

%{  
battery(volt, fvolt, curr, fcurr)
%}

%CHANGE ALL THESE!!!!
%CHANGE ALL THESE!!!!
%CHANGE ALL THESE!!!!
%CHANGE ALL THESE!!!!
file = '204-3Cell.csv';
currRate = 1;
fileNum = '204';

data = readmatrix(file);
tstart = ceil(data(1,1));
tend = floor(data(end,1));
t = [tstart:0.1:tend];

volt = [];
fvolt = [];
currTemp = [];
fcurrTemp = [];


volt = pchip(data(:,1), data(:,2), t);
fvolt = pchip(data(:,3), data(:,4), t);
currTemp = pchip(data(:,5), data(:,6), t);
fcurrTemp = pchip(data(:,7), data(:,8), t);


curr = currRate * currTemp;
fcurr = currRate * fcurrTemp;

pwr = volt.*curr;
fpwr = fvolt.*fcurr;

cumPwr = [];
cumPwr = cumsum(pwr)/10;
cumCurr = cumsum(curr);
CurrFinal = cumCurr(1,end);

assignin('base', strcat('t', fileNum), t);
assignin('base', strcat('volt', fileNum), volt);
assignin('base', strcat('fvolt', fileNum), fvolt);
assignin('base', strcat('curr', fileNum), curr);
assignin('base', strcat('fcurr', fileNum), fcurr);
assignin('base', strcat('pwr', fileNum), pwr);
assignin('base', strcat('fpwr', fileNum), fpwr);
assignin('base', strcat('pwrCum', fileNum), cumPwr);
assignin('base', strcat('fpwrCum', fileNum), cumsum(fpwr)/10);

FinalPower = cumPwr(1,end);

save([strcat(fileNum, '.mat')], 'tstart', 'tend', strcat('t', fileNum), strcat('volt', fileNum), ...
    strcat('fvolt', fileNum), strcat('curr', fileNum), strcat('fcurr', fileNum), ...
    strcat('pwr', fileNum), strcat('fpwr', fileNum), strcat('pwrCum', fileNum), ...
    strcat('fpwrCum', fileNum));