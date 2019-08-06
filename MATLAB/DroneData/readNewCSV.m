function readNewCSV(num, startTime, endTime, AperV, fileName, flight)

% UPDATE THE VARIABLES!!!

%{  
battery(volt, fvolt, curr, fcurr)
%}

%CHANGE ALL THESE!!!!
%CHANGE ALL THESE!!!!
%CHANGE ALL THESE!!!!
%CHANGE ALL THESE!!!!

if flight
    file = ['flightLogs/',fileName,'.csv'];
    tstart = startTime;
    tend = endTime;
else
    file = ['CSVs/',fileName,'.csv'];
    tstart = ceil(data(1,1));
    tend = floor(data(end,1));
end


currRate = AperV;
fileNum = num;
data = readmatrix(file);

    

t = [tstart:0.1:tend];


volt = pchip(data(:,1), data(:,2), t);
fvolt = pchip(data(:,3), data(:,4), t);
currTemp = pchip(data(:,5), data(:,6), t);
fcurrTemp = pchip(data(:,7), data(:,8), t);


curr = currRate * currTemp;
fcurr = currRate * fcurrTemp;

pwr = volt.*curr;
fpwr = fvolt.*fcurr;

cumPwr = cumsum(pwr)/10;
cumCurr = cumsum(curr);
FinalCurr = cumCurr(1,end);



FinalPower = cumPwr(1,end);

if flight
    save([strcat('runData/',fileNum, '.mat')], 'tstart', 'tend', 't', 'volt', 'fvolt', 'curr', 'fcurr', ...
    'pwr', 'fpwr', 'cumPwr', 'cumCurr', 'FinalPower', 'FinalCurr');
else
    save([strcat('pwrData/',fileNum, '.mat')], 'tstart', 'tend', 't', 'volt', 'fvolt', 'curr', 'fcurr', ...
    'pwr', 'fpwr', 'cumPwr', 'cumCurr', 'FinalPower', 'FinalCurr');

end

end
