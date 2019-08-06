function movingMeanNew(num)

binLog = num; %As String

load(['runData/',binLog,'.mat'], 'tstart', 'tend', 't', 'volt', 'pwr')

t2 = [tstart:tend];


M = movmean(volt, 11);
M2 = movmean(pwr, 11);

adjM = pchip(t, M, t2);

adjM2 = pchip(t, M2, t2);


S = [];
E = [];
P = [];



for col=1:size(adjM, 2)
    cur = adjM(1, col);
    if col + 1 <= size(adjM, 2)
        S = [S cur];
        E = [E adjM(1, col + 1)];
        P = [P adjM2(1, col + 1)];
    end
end


assignin('caller', strcat('S', binLog), S);
assignin('caller', strcat('E', binLog), E);
assignin('caller', strcat('P', binLog), P);


save(['smoothedData/',binLog,'sm.mat'], 'S', 'E', 'P');
end