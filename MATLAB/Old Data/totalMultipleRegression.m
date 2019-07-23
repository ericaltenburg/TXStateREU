
T = [T1 T2a T2b T3a T3b T4 T5];
S = [S1 S2a S2b S3a S3b S4 S5];
E = [E1 E2a E2b E3a E3b E4 E5];

% OPEN cftool FOR BETTER VIEW!!!!!
createFit5(T, S, E);

Total = [T;S;E];

n = size(Total, 2);
p = 0.8;

ncol = round(n*p);
x = randperm(n,ncol);
TotalTrain = Total(:,x);
TotalTest = Total(:, setdiff(1:n, x));

Ttrain = TotalTrain(1,:);
Strain = TotalTrain(2,:);
Etrain = TotalTrain(3,:);

Ttest = TotalTest(1,:);
Stest = TotalTest(2,:);
Etest = TotalTest(3,:);


[x, y, z] = prepareSurfaceData( Ttrain, Strain, Etrain );
ft = fittype( 'poly23' );
[fitresult, gof] = fit( [x, y], z, ft );

Etrained = regress1(Ttrain, Strain, fitresult);
Eregress = regress1(Ttest, Stest, fitresult);

createFit4(Etrain, Etrained)
createFit4(Etest, Eregress)


