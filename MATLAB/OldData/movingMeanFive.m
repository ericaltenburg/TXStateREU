t = [tstart:0.1:tend]*1e6;
t2 = [tstart:5:tend]*1e6;
t3 = [tstart+2.5:5:tend-2.5];

volt = pchip(dcurr(:,1), dcurr(:,2), t);
pwr = pchip(dcurr(:,1), dcurr(:,4), t);

M = movmean(volt, 51);

adjM = pchip(t, M, t2);

slope = [];

for col=2:size(adjM, 2)
    slope(1, col - 1) = adjM(1, col) - adjM(1, col - 1);
end

plot(t3,slope,'o')

Sfive5 = [];
Efive5 = [];


for col=1:size(adjM, 2)
    if col + 1 <= size(adjM, 2)
            Sfive5 = [Sfive5 adjM(1, col)];
            Efive5 = [Efive5 adjM(1, col + 1)];
    end
end

%save(['Moving Mean Data/logfive5','.mat'], 'Sfive5', 'Efive5');