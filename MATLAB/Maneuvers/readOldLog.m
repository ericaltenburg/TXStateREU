% **
% Author:		John Graves (Adaped from a previous students work)
% Date: 		6 August 2019
% Description:	Parses data from old log flights
% **

function readOldLog(num, startTime, endTime, AperV)
% num: String - flight number
% startTime: Double - Take off time of flight
% endTime: Double - landing time of flight
% AperV: Double - 37 divided by flight Amps per Volt to get all flights on same scale

logNum = num; % As String
binlog = ['flightLogs/',logNum,'.log'];
tstart = startTime; % start time
tend = endTime;  % end time
AmpVmult = AperV;

fp = fopen(binlog,'r');

dcurr = [];

%Iterates through all data, pulling out the relevant info
count  = 0;
while true
    l = fgetl(fp);
    if ~ischar(l)
        break;
    end;
    d = split(l,',');
   if strcmp(d{1},'CURR')
% FMT,164,45,CURR,QfffcHHHHHHHHHH,TimeUS,Volt,Curr,CurrTot,Temp,V1,V2,V3,V4,V5,V6,V7,V8,V9,V10
% CURR: Volt,Curr
        tcurr = str2num(d{2});
        volt = str2num(d{3});
        currTemp = str2num(d{4});
        curr = currTemp*AmpVmult;
        pwr = volt.*curr;
        dcurr = [dcurr; [tcurr, volt, curr, pwr]];
   end
   count = count + 1;
   if mod(count,10000) == 0
        count
   end

end

fclose(fp);


%saves the variables to MAT file
save(['runData/',logNum,'.mat'], 'tstart', 'tend', 'dcurr');

'end'
