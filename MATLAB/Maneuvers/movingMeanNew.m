% **
% Author:		John Graves 
% Date: 		6 August 2019
% Description:	Smooths and parses new data on one second intervals
% **

function movingMeanNew(name)
% name: String - represents flight name/number

binLog = name; %As String

load(['runData/',binLog,'.mat'], 'tstart', 'tend', 't', 'volt', 'pwr')

t2 = [tstart:tend];


%smoothing over 1.1 seconds
Vtemp = movmean(volt, 11);
Ptemp = movmean(pwr, 11);

%simplifying data to 1 second intervals
Volt1 = pchip(t, Vtemp, t2);
Pwr1 = pchip(t, Ptemp, t2);


S = [];
E = [];
P = [];

% creating starting and ending voltage numbers and power matricies
for col=1:size(Vtemp, 2)
    cur = Vtemp(1, col);
    if col + 1 <= size(Volt1, 2)
        S = [S cur];
        E = [E Volt1(1, col + 1)];
        P = [P Pwr1(1, col + 1)];
    end
end


%saving data as MAT file
save(['smoothedData/',binLog,'sm.mat'], 'S', 'E', 'P');
end