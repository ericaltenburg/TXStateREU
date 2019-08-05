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

<<<<<<< HEAD
BPwrRegress(AvgPwr2, totPwr2);
=======
BPwrRegressBat2(AvgPwr2, Sec2);
PowerLinear2(AvgPwr2, totPwr2);
>>>>>>> b7a016e0ffe3d243cf07af98ff4c809a5e285b2c
