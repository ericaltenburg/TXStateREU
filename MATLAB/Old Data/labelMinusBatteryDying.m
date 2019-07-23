RiseMB = NewMB(:,NewMB(1,:)==1);

FallMB = NewMB(:,NewMB(1,:)==2);

AirMB = NewMB(:,NewMB(1,:)==3);

save(['Data(MinusDying)','.mat'], 'NewMB', 'RiseMB', 'FallMB', 'AirMB');