function labelAllData(n)

%Power Smoothing number is n

load('smoothedData/1sm.mat', 'S', 'E', 'P');
tot1 = [ones(1, size(S, 2)); S; E; movmean(P, n)];

load('smoothedData/2sm.mat', 'S', 'E', 'P');
tot2 = [ones(1, size(S, 2))*2; S; E; movmean(P, n)];

load('smoothedData/3sm.mat', 'S', 'E', 'P');
tot3 = [ones(1, size(S, 2))*3; S; E; movmean(P, n)];

load('smoothedData/4sm.mat', 'S', 'E', 'P');
tot4 = [ones(1, size(S, 2))*4; S; E; movmean(P, n)];

load('smoothedData/5sm.mat', 'S', 'E', 'P');
tot5 = [ones(1, size(S, 2))*5; S; E; movmean(P, n)];




pre = [tot1 tot2 tot3 tot4 tot5];
all = [1:size(pre,2); pre];

mov = [];

for col=1:size(all, 2)
    if col <= 8 || (col >= 54 && col <= 68) || (col >= 603 && col <= 615) || (col >= 741 && col <= 751) ...
            || (col >= 877 && col <= 891) || (col >= 983 && col <= 989) || (col >= 1024 && col <= 1034)
        mov(1, col) = 1;
    elseif (col >= 9 && col <= 53) || (col >= 69 && col <= 602) || (col >= 616 && col <= 722) ...
            || (col >= 892 && col <= 954) || (col >= 1035 && col <= 1039) 
        mov(1, col) = 2;
    elseif (col >= 723 && col <= 740) || (col >= 849 && col <= 876) ...
            || (col >= 955 && col <= 982) || (col >= 1040 && col <= 1077)  
        mov(1, col) = 3;
    else 
        mov(1, col) = 4;
    end
end


New = [mov; all];

Ascend = New(:,New(1,:)==1);

Hover = New(:,New(1,:)==2);

Descend = New(:,New(1,:)==3);

Straight = New(:,New(1,:)==4);

save('AllData.mat', 'New', 'Ascend', 'Hover', 'Descend', 'Straight');

end

