totAmp2 = [4080
    3630
    2040];

Sec2 = [770
    1170
    2490];

totPwr2 = [148480
    138600
    80640];

AvgCurr2 = (totAmp2.*3.6)./Sec2;
AvgPwr2 = (totPwr2)./Sec2;

BPwrRegress(AvgPwr2, totPwr2);