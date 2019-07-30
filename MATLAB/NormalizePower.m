X = AllStraight;
mult1 = 1.109069561;
mult2 = 1.233085222;

for col=1:size(X, 2)
    if X(2, col) < 6
        if X(2, col) == 1
            X(3, col) = X(3, col)*mult1;
        else
            X(3, col) = X(3, col)*mult2;
        end
    end
end

AllStraightAdj = X;