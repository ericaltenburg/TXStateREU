% **
% Author:		John Graves
% Date: 		6 August 2019
% Description:	Parses data from CSV's for battery tests
% **

function readBatCSV(name, AperV)
% name: String - test name
% AperV: Double - 37 divided by flight Amps per Volt to get all flights on same scale
 
%Format for CSVs ("analysis" software from pixhwak can create csv's from ulg files):
%
%>>> battery(volt, fvolt, curr, fcurr)
%




file = ['CSVs/',name,'.csv'];

data = readmatrix(file);

% calculates start and end times from the on and of times of the drone
tstart = ceil(data(1,1));
tend = floor(data(end,1));


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
save([strcat('pwrData/',name, '.mat')], 'tstart', 'tend', 't', 'volt', 'fvolt', 'curr', 'fcurr', ...
    'pwr', 'fpwr', 'cumPwr', 'cumCurr', 'FinalPower', 'FinalCurr');

end
