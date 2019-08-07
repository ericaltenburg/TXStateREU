% **
% Author:		John Graves
% Date: 		6 August 2019
% Description:	Analyzes battery data with a variety of graphs and regressions
% **

function battery1Tests

% total Amps in battery 1 Tests
totAmp1 = [ 
    %3850 is the original number, but adjusted as shown with normalizing in the maneuver analysis. 
    %This first data point is actually flight 1 from the other data
    4235
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
totPwr1 = [ 
    %191272 is the original number, but adjusted as shown with normalizing in the maneuver analysis. 
    %This first data point is actually flight 1 from the other data
    210399
    131860
    124770
    90695
    82175
    82345
    59149];


% total Amps in battery 1 Tests including tests where power wasn't recorded (Some overlap with power data)
noSensorTotAmp1 = [2500
    2140
    1330
    910
    440];

% total Time until reaching 12V in battery 1 Tests including tests where power wasn't recorded (Some overlap with power data)
noSensorSec1 = [740
    1330
    1750
    1960
    2310];

% Calculating average current and power
% totAmp1 is in mAh, divided by 1000 puts it in Ah, multiplying by 3600 makes it As (Amp seconds), hence the 3.6
AvgCurr1 = (totAmp1.*3.6)./Sec1;
AvgPwr1 = (totPwr1)./Sec1;
noSensorAvgCurr1 = (noSensorTotAmp1.*3.6)./noSensorSec1;


BPwrRegress(AvgPwr1, Sec1); % Average Power vs Flight Time (fit with a rational function)
PowerLinear1(AvgPwr1, totPwr1); % Average Power vs Total Power(Energy) (fit with a linear function)

CurrToPwrRegress(AvgCurr1, AvgPwr1); % Average Power vs Average Current (fit with a linear function)

slope = 13.65;
yInter = 0.5223;

PredNoSensorAvgPwr1 = (noSensorAvgCurr1*slope) + yInter;

testingFlightTimeFit(PredNoSensorAvgPwr1, noSensorSec1);



%Saves the data to a MAT file
save('battery1Data.mat', 'totAmp1', 'Sec1', 'totPwr1', 'AvgCurr1', 'AvgPwr1', 'noSensorTotAmp1', 'noSensorSec1', 'noSensorAvgCurr1', 'PredNoSensorAvgPwr1');

end




