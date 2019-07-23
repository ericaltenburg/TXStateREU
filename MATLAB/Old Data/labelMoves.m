

mov = [];

for col=1:size(All, 2)
    if col <= 77 | (col >= 617 & col <= 619) | (col >= 698 & col <= 708) | ...
        (col >= 765 & col <= 778) | (col >= 835 & col <= 841) | ...
        (col >= 876 & col <= 880) | (col >= 885 & col <= 887) | ...
        (col >= 906 & col <= 918) | (col >= 1044 & col <= 1054) | (col >= 1151 & col <= 1161)
        mov(1, col) = 1;
    elseif (col >= 614 & col <= 616) | (col >= 735 & col <= 764) | ...
        (col >= 779 & col <= 792) | (col >= 847 & col <= 875) | (col >= 895 & col <= 905) | ...
        (col >= 1026 & col <= 1043) | (col >= 1131 & col <= 1150) | col >= 1259
        mov(1, col) = 2;
    else 
        mov(1, col) = 3;
    end
end


New = [mov(1, 1:614) mov(1,617:end) 2 2; All];


Rise = New(:,New(1,:)==1);

Fall = New(:,New(1,:)==2);

Air = New(:,New(1,:)==3);

save(['Power Data/Data','.mat'], 'New', 'Rise', 'Fall', 'Air');