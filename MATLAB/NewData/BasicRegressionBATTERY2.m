totAmp2 = [4080
    3630
    2040];

Sec2 = [770
    1170
    2490];

AvgCurr2 = (totAmp2.*3.6)./Sec2;

BCurrRegressBat2(AvgCurr2, Sec2);