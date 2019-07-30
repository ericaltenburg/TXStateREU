function [fitresult, gof] = PwrToCurrRegress(AvgPwr, AvgCurr)
%CREATEFIT(AVGPWR,AVGCURR)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : AvgPwr
%      Y Output: AvgCurr
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 29-Jul-2019 03:57:00


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( AvgPwr, AvgCurr );

% Set up fittype and options.
ft = fittype( 'poly1' );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'Average Current vs. Average Power', ['f(x) = p1*x + p2',newline,'       p1 =     0.07318',newline,'       p2 =    -0.03096',newline,'R-Squared: 0.9994'], 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'Average Power (W)', 'Interpreter', 'none' );
ylabel( 'Average Current (A)', 'Interpreter', 'none' );
% Create title
title('Predicting Average Current from Flight''s Average Power',...
    'FontSize',15);
grid on


