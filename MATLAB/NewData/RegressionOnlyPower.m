totAmp = [4270%3850
    2730
    2590
    1820
    1640
    1600
    1150];

Sec = [600
    705
    775
    1200
    1030
    1580
    1595];

totPwr = [212121%191272
    131860
    124770
    90695
    82175
    82345
    59149];

AvgCurr = (totAmp.*3.6)./Sec;
AvgPwr = (totPwr)./Sec;

BPwrRegress(AvgPwr, Sec);
PwrToCurrRegress(AvgPwr, AvgCurr);
PowerLinear1(AvgPwr, totPwr);




