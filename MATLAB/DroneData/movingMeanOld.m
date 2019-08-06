function movingMeanOld(num)

binLog = num; %As String
load(['runData/',binLog,'.mat'], 'tstart', 'tend', 'dcurr')

t = [tstart:0.1:tend]*1e6;
t2 = [tstart:tend]*1e6;

volt = pchip(dcurr(:,1), dcurr(:,2), t);
pwr = pchip(dcurr(:,1), dcurr(:,4), t);

M = movmean(volt, 11);
%L = movmean(volt, 9);
M2 = movmean(pwr, 11);
%L2 = movmean(pwr, 9);

adjM = pchip(t, M, t2);
%adjM(1,end + 1) = L(1, end);

adjM2 = pchip(t, M2, t2);
%adjM2(1,end + 1) = L2(1, end);

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



save(['smoothedData/',binLog,'sm.mat'], 'S', 'E', 'P');

end
