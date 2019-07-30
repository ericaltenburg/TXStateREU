


t = (tstart:0.1:tend)*1e6;

volts = pchip(dcurr(1,:), dcurr(2,:), t);
currTemp = pchip(dcurr(:,1), dcurr(:,3), t);

curr = currTemp.*(37/15.39);

pwr = volts.*curr;

cumPwr = cumsum(pwr)/10;

