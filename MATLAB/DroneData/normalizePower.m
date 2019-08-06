function Adjusted = normalizePower(data)

X = data;
mult1 = 1.09710804156408;
mult2 = 1.23091757594984;

for col=1:size(X, 2)
    if X(3, col) < 4
        if X(3, col) == 1
            X(6, col) = X(6, col)*mult1;
        else
            X(6, col) = X(6, col)*mult2;
        end
    end
end

Adjusted = X; 

end
