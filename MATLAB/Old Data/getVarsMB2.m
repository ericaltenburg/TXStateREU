New2 = New(:, 615:end);
Rise2 = New2(:,New2(1,:)==1);
Fall2 = New2(:,New2(1,:)==2);
Air2 = New2(:,New2(1,:)==3);

TA2 = Air2(2, :);
SA2 = Air2(4, :);
EA2 = Air2(5, :);
PA2 = Air2(6, :);

TF2 = Fall2(2, :);
SF2 = Fall2(4, :);
EF2 = Fall2(5, :);
PF2 = Fall2(6, :);

TR2 = Rise2(2, :);
SR2 = Rise2(4, :);
ER2 = Rise2(5, :);
PR2 = Rise2(6, :);

TN2 = New2(2, :);
SN2 = New2(4, :);
EN2 = New2(5, :);
PN2 = New2(6, :);

%%
% Not Ready Yet!!!
%{
SAmb2 = AirMB2(4, :);
EAmb2 = AirMB2(5, :);

SFmb2 = FallMB2(4, :);
EFmb2 = FallMB2(5, :);

SRmb2 = RiseMB2(4, :);
ERmb2 = RiseMB2(5, :);

SNmb2 = NewMB2(4, :);
ENmb2 = NewMB2(5, :);

%}

