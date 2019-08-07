% **
% Author:		John Graves
% Date: 		6 August 2019
% Description:	Analyzes battery data with a variety of graphs and regressions
% **

function battery2Tests

% total Amps in battery 2 Tests
totAmp2 = [4080
    3630
    2040];

% total Time until reaching 9V in battery 2 Tests
Sec2 = [770
    1170
    2490];

% total Power(Energy) in battery 2 Tests
totPwr2 = [148480
    138600
    80640];

% Calculating average current and power
% totAmp1 is in mAh, divided by 1000 puts it in Ah, multiplying by 3600 makes it As (Amp seconds), hence the 3.6
AvgCurr2 = (totAmp2.*3.6)./Sec2;
AvgPwr2 = (totPwr2)./Sec2;

PowerLinear2(AvgPwr2, totPwr2); % Average Power vs Total Power(Energy) (fit with a linear function)

%Saves the data to a MAT file
save('battery2Data.mat', 'totAmp2', 'Sec2', 'totPwr2', 'AvgCurr2', 'AvgPwr2');

end

