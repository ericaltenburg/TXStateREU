function readbinlog2a

% binlog = 'logs/2.log';
% tstart = 200; % start time
% tend = 1250;  % end time
binlog = 'logs/2.log';
tstart = 26.4; % start time
tend = 174.4;  % end time

fp = fopen(binlog,'r');

dimu = [];
dbaro = [];
datt = [];
dcurr = [];
dmode = [];
dctun = [];
dntun = [];
dgps = [];

count  = 0;
while true
    l = fgetl(fp);
    if ~ischar(l)
        break;
    end;
    d = split(l,',');
    if strcmp(d{1},'IMU')
% FMT,133,53,IMU,QffffffIIfBBHH,TimeUS,GyrX,GyrY,GyrZ,AccX,AccY,AccZ,EG,EA,T,GH,AH,GHz,AHz
% IMU: AccX,AccY,AccZ
        timu = str2num(d{2});
        accx = str2num(d{6});
        accy = str2num(d{7});
        accz = str2num(d{8});
        dimu = [dimu; [timu, accx, accy, accz]];
    elseif strcmp(d{1},'BARO')
% FMT,139,37,BARO,QffcfIff,TimeUS,Alt,Press,Temp,CRt,SMS,Offset,GndTemp
% BARO: Press
        tbaro = str2num(d{2});
        press = str2num(d{4});
        dbaro = [dbaro; [tbaro, press]];
    elseif strcmp(d{1},'ATT')
% FMT,163,27,ATT,QccccCCCC,TimeUS,DesRoll,Roll,DesPitch,Pitch,DesYaw,Yaw,ErrRP,ErrYaw
% ATT: DesRoll,Roll,DesPitch,Pitch,DesYaw,Yaw
        tatt = str2num(d{2});
        desroll = str2num(d{3});
        roll = str2num(d{4});
        despitch = str2num(d{5});
        pitch = str2num(d{6});
        desyaw = str2num(d{7});
        yaw = str2num(d{8});
        datt = [datt; [tatt, desroll, roll, despitch, pitch, desyaw, yaw]];
    elseif strcmp(d{1},'CURR')
% FMT,164,45,CURR,QfffcHHHHHHHHHH,TimeUS,Volt,Curr,CurrTot,Temp,V1,V2,V3,V4,V5,V6,V7,V8,V9,V10
% CURR: Volt,Curr
        tcurr = str2num(d{2});
        volt = str2num(d{3});
        curr = str2num(d{4});
        pwr = volt.*curr;
        dcurr = [dcurr; [tcurr, volt, curr, pwr]];
    elseif strcmp(d{1},'MODE')
% FMT,169,14,MODE,QMBB,TimeUS,Mode,ModeNum,Rsn
% MODE: ModeNum
        tmode = str2num(d{2});
        modenum = str2num(d{4});
        dmode = [dmode; [tmode, modenum]];
    elseif strcmp(d{1},'CTUN')
% FMT,4,51,CTUN,Qffffffeccfhh,TimeUS,ThI,ABst,ThO,ThH,DAlt,Alt,BAlt,DSAlt,SAlt,TAlt,DCRt,CRt
% CTUN: ThI,ThO,Alt
        tctun = str2num(d{2});
        thi = str2num(d{3});
        tho = str2num(d{5});
        alt = str2num(d{8});
        dctun = [dctun; [tctun, thi, tho, alt]];
    elseif strcmp(d{1},'NTUN')
% FMT,5,51,NTUN,Qffffffffff,TimeUS,DPosX,DPosY,PosX,PosY,DVelX,DVelY,VelX,VelY,DAccX,DAccY
% NTUN: VelX,VelY
        tntun = str2num(d{2});
        velx = str2num(d{9});
        vely = str2num(d{10});
        dntun = [dntun; [tntun, velx, vely]];
    elseif strcmp(d{1},'GPS')
% FMT,130,46,GPS,QBIHBcLLefffB,TimeUS,Status,GMS,GWk,NSats,HDop,Lat,Lng,Alt,Spd,GCrs,VZ,U
        tgps = str2num(d{2});
        spd = str2num(d{11});
        vz = str2num(d{13});
        dgps = [dgps; [tgps, spd, vz]];
    end;
    
    count = count + 1;
    if mod(count,10000) == 0
        count
    end;
end;

fclose(fp);

[length(dmode), length(dimu), length(dbaro), length(datt), length(dcurr), length(dctun), length(dntun), length(dgps)]
stimu = dimu(2:end,1) - dimu(1:end-1,1);
stbaro = dbaro(2:end,1) - dbaro(1:end-1,1);
stcurr = dcurr(2:end,1) - dcurr(1:end-1,1);
stctun = dctun(2:end,1) - dctun(1:end-1,1);
[median(stimu), median(stbaro), median(stcurr), median(stctun)]

save(['logs/2a.log','.mat'], 'tstart', 'tend', 'dmode', 'dimu', 'dbaro', 'datt', 'dcurr', 'dctun', 'dntun', 'dgps');

'end'
