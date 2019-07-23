
binlog = 'FILLIN';
load(['logs/',binlog,'.log.mat'])

total = [];

t = [tstart:0.1:tend]*1e6;

ax = pchip(dimu(:,1), dimu(:,2), t)';
ay = pchip(dimu(:,1), dimu(:,3), t)';
az = pchip(dimu(:,1), dimu(:,4), t)';
droll = pchip(datt(:,1), datt(:,2), t)';
dpitch = pchip(datt(:,1), datt(:,4), t)';
dyaw = pchip(datt(:,1), datt(:,6), t)';
ti = pchip(dctun(:,1), dctun(:,2), t)';
speed = pchip(dgps(:,1), dgps(:,2), t)';
vertv = pchip(dgps(:,1), dgps(:,3), t)';
time = t';

total = [total; [time, ax, ay, az, droll, dpitch, dyaw, ti, speed, vertv]]; 

%RISING
RS1 = tstart*1e6;
RE1 = 0*1e6;
RS2 = 0*1e6;
RE2 = 0*1e6;
RS3 = 0*1e6;
RE3 = 0*1e6;

%HOVERING
HS1 = 0*1e6;
HE1 = 0*1e6;
HS2 = 0*1e6;
HE2 = 0*1e6;
HS3 = 0*1e6;
HE3 = 0*1e6;
HS4 = 0*1e6;
HE4 = 0*1e6;
HS5 = 0*1e6;
HE5 = 0*1e6;

%STRAIGHT
SS1 = 0*1e6;
SE1 = 0*1e6;
SS2 = 0*1e6;
SE2 = 0*1e6;
SS3 = 0*1e6;
SE3 = 0*1e6;
SS4 = 0*1e6;
SE4 = 0*1e6;
SS5 = 0*1e6;
SE5 = 0*1e6;
SS6 = 0*1e6;
SE6 = 0*1e6;
SS7 = 0*1e6;
SE7 = 0*1e6;

%TURN
TS1 = 0*1e6;
TE1 = 0*1e6;
TS2 = 0*1e6;
TE2 = 0*1e6;
TS3 = 0*1e6;
TE3 = 0*1e6;
TS4 = 0*1e6;
TE4 = 0*1e6;

%FALL
FS1 = 0*1e6;
FE1 = 0*1e6;
FS2 = 0*1e6;
FE2 = 0*1e6;
FS3 = 0*1e6;
FE3 = tend*1e6;

M = [];


for row=1:size(total,1)
    if (total(row, 1) < RE1) | (total(row, 1) >= RS2 & total(row, 1) < RE2) | (total(row, 1) >= RS3 & total(row, 1) < RE3)
        M(row, 1) = 1;
    elseif (total(row, 1) >= HS1 & total(row, 1) < HE1) | (total(row, 1) >= HS2 & total(row, 1) < HE2) | ...
            (total(row, 1) >= HS3 & total(row, 1) < HE3) | (total(row, 1) >= HS4 & total(row, 1) < HE4) | ...
            (total(row, 1) >= HS5 & total(row, 1) < HE5)
        M(row, 1) = 2;
        elseif (total(row, 1) >= SS1 & total(row, 1) < SE1) | (total(row, 1) >= SS2 & total(row, 1) < SE2) | ...
            (total(row, 1) >= SS3 & total(row, 1) < SE3) | (total(row, 1) >= SS4 & total(row, 1) < SE4) | ...
            (total(row, 1) >= SS5 & total(row, 1) < SE5) | (total(row, 1) >= SS6 & total(row, 1) < SE6) | ...
            (total(row, 1) >= SS7 & total(row, 1) < SE7)
        M(row, 1) = 4;
        elseif (total(row, 1) >= TS1 & total(row, 1) < TE1) | (total(row, 1) >= TS2 & total(row, 1) < TE2) | ...
            (total(row, 1) >= TS3 & total(row, 1) < TE3) | (total(row, 1) >= TS4 & total(row, 1) < TE4)
        M(row, 1) = 5;
    elseif (total(row, 1) >= FS1 & total(row, 1) < FE1) | (total(row, 1) >= FS2 & total(row, 1) < FE2) | (total(row, 1) >= FS3)
        M(row, 1) = 3;
    end
end
  
final = [M total];

writematrix(final, ['CSVs/',binlog,'.csv'])