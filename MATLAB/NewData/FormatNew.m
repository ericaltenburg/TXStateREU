pwr = HoverH(2, :);
t = HoverH(1, :);
num = 7;


time = t(1):t(end-9);
pwrAdj = movmean(pwr, 11);
pwrSimple = pchip(t, pwrAdj, time);

final7H = [time; ones(1, size(time, 2)).*6; pwrSimple];