% **
% Author:		John Graves
% Date: 		6 August 2019
% Description:	Analyzes battery data with a variety of graphs and regressions
% **

function battery1Tests

% total Amps in battery 1 Tests
totAmp1 = [4235 %3850
    2730
    2590
    1820
    1640
    1600
    1150];

% total Time until reaching 12V in battery 1 Tests
Sec1 = [600
    705
    775
    1200
    1030
    1580
    1595];

% total Power(Energy) in battery 1 Tests
totPwr1 = [210399 %191272
    131860
    124770
    90695
    82175
    82345
    59149];

% total Amps in battery 1 Tests including tests where power wasn't recorded (Some overlap with power data)
AlltotAmp1 = [4270
    2730
    2500
    2590
    2140
    1820
    1640
    1600
    1330
    1150
    910
    440];

% total Time until reaching 12V in battery 1 Tests including tests where power wasn't recorded (Some overlap with power data)
AllSec1 = [600
    705
    740
    775
    1330
    1200
    1030
    1580
    1750
    1595
    1960
    2310];

% Calculating average current and power
% totAmp1 is in mAh, divided by 1000 puts it in Ah, multiplying by 3600 makes it As (Amp seconds), hence the 3.6
AvgCurr1 = (totAmp1.*3.6)./Sec1;
AvgPwr1 = (totPwr1)./Sec1;
AllAvgCurr1 = (AlltotAmp1.*3.6)./AllSec1;


BPwrRegress(AvgPwr1, Sec1); % Average Power vs Flight Time (fit with a rational function)
PwrToCurrRegress(AvgPwr1, AvgCurr1); % Average Power vs Average Current (fit with a linear function)
PowerLinear1(AvgPwr1, totPwr1); % Average Power vs Total Power(Energy) (fit with a linear function)
BCurrRegress(AvgCurr1, Sec1); % Average current vs Flight Time (fit with a rational function)

% Average current vs Flight Time (fit with a rational function) (Including Data where Power is unavaliable)
BCurrRegress(AllAvgCurr1, AllSec1);


%Saves the data to a MAT file
save('battery1Data.mat', 'totAmp1', 'Sec1', 'totPwr1', 'AvgCurr1', 'AvgPwr1', 'AlltotAmp1', 'AllSec1', 'AllAvgCurr1');

end




