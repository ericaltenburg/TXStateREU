% **
% Author:		John Graves
% Date: 		6 August 2019
% Description:	Parses data from new CSV flights
% **

function readNewCSV(num, startTime, endTime, AperV)
% num: String - flight number
% startTime: Double - Take off time of flight
% endTime: Double - landing time of flight
% AperV: Double - 37 divided by flight Amps per Volt to get all flights on same scale
 
%Format for CSVs ("analysis" software from pixhwak can create csv's from ulg files):
%
%>>> battery(volt, fvolt, curr, fcurr)
%


file = ['flightLogs/',num,'.csv'];
tstart = startTime;
tend = endTime;



fileNum = num;
data = readmatrix(file); % reads the csv

    

t = [tstart:0.1:tend];

% normalizes data on tenth of a second intervals
volt = pchip(data(:,1), data(:,2), t);
fvolt = pchip(data(:,3), data(:,4), t);
currTemp = pchip(data(:,5), data(:,6), t);
fcurrTemp = pchip(data(:,7), data(:,8), t);

% Creates current data using AperV input
curr = AperV * currTemp;
fcurr = AperV * fcurrTemp;

% calculating power data
pwr = volt.*curr;
fpwr = fvolt.*fcurr;

% Finding Total Power (Energy) and Current data
cumPwr = cumsum(pwr)/10;
cumCurr = cumsum(curr);
FinalCurr = cumCurr(1,end);
FinalPower = cumPwr(1,end);

%Saving variables to MAT file
save([strcat('runData/',fileNum, '.mat')], 'tstart', 'tend', 't', 'volt', 'fvolt', 'curr', 'fcurr', ...
    'pwr', 'fpwr', 'cumPwr', 'cumCurr', 'FinalPower', 'FinalCurr');


end
