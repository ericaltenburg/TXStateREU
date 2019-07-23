
% UPDATE THE VARIABLES!!!

%{ 
veh_air_data(alt), battery(volt, fvolt, curr, fcurr), 
actuator_controls_0(roll[0], pitch[1], yaw[2], ti[3]),
veh_local_pos(ax, ay, az, vx, vy, vz)
%}

%CHANGE ALL THESE!!!!
%CHANGE ALL THESE!!!!
%CHANGE ALL THESE!!!!
%CHANGE ALL THESE!!!!
file = 'SlowDischargeTest.csv';
tstart = 89;
tend = 1696;
currRate = 37/15.39;z
fileNum = 'SD';

data = readmatrix(file);
t = [tstart:0.1:tend];


alt = pchip(data(:,1), data(:,2), t);
volt = pchip(data(:,3), data(:,4), t);
fvolt = pchip(data(:,5), data(:,6), t);
currTemp = pchip(data(:,7), data(:,8), t);
fcurrTemp = pchip(data(:,9), data(:,10), t);
roll = pchip(data(:,11), data(:,12), t);
pitch = pchip(data(:,13), data(:,14), t);
yaw = pchip(data(:,15), data(:,16), t);
ti = pchip(data(:,17), data(:,18), t);
ax = pchip(data(:,19), data(:,20), t);
ay = pchip(data(:,21), data(:,22), t);
az = pchip(data(:,23), data(:,24), t);
vx = pchip(data(:,25), data(:,26), t);
vy = pchip(data(:,27), data(:,28), t);
vz = pchip(data(:,29), data(:,30), t);

curr = currRate * currTemp;
fcurr = currRate * fcurrTemp;

pwr = volt.*curr;
fpwr = fvolt.*fcurr;
spd = sqrt((vx.*vx) + (vy.*vy));

total = [t', ax', ay', az', roll', pitch', yaw', ti', spd', vz']; 
writematrix(total, strcat('train', fileNum, '.csv'))

assignin('base', strcat('t', fileNum), t);
assignin('base', strcat('volt', fileNum), volt);
assignin('base', strcat('fvolt', fileNum), fvolt);
assignin('base', strcat('curr', fileNum), curr);
assignin('base', strcat('fcurr', fileNum), fcurr);
assignin('base', strcat('pwr', fileNum), pwr);
assignin('base', strcat('fpwr', fileNum), fpwr);
assignin('base', strcat('pwrCum', fileNum), cumsum(pwr)/10);
assignin('base', strcat('fpwrCum', fileNum), cumsum(fpwr)/10);
assignin('base', strcat('total', fileNum), total);

save([strcat(fileNum, '.mat')], 'tstart', 'tend', strcat('t', fileNum), strcat('volt', fileNum), ...
    strcat('fvolt', fileNum), strcat('curr', fileNum), strcat('fcurr', fileNum), ...
    strcat('pwr', fileNum), strcat('fpwr', fileNum), strcat('pwrCum', fileNum), ...
    strcat('fpwrCum', fileNum), strcat('total', fileNum));



