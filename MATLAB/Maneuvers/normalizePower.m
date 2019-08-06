% **
% Author:		John Graves
% Date: 		6 August 2019
% Description:	Normalizes the power data to account for different configurations
% **

function Adjusted = normalizePower(data)

X = data;

% Numbers found using a weighted average in Normalize_Power.xlsx
mult1 = 1.09710804156408; 
mult2 = 1.23091757594984;


% multiply data by respective coefficient, row 3 is flight number, row 6 is power
for col=1:size(X, 2)
    if X(3, col) < 4
        if X(3, col) == 1
            X(6, col) = X(6, col)*mult1;
        else
            X(6, col) = X(6, col)*mult2;
        end
    end
end

%returns result
Adjusted = X; 

end
