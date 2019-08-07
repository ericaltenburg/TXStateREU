function [fitresult, gof] = CurrToPwrRegress(AvgCurr, AvgPwr)
%CREATEFIT(AVGPWR,AVGCURR)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : AvgCurr
%      Y Output: AvgPwr
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 29-Jul-2019 03:57:00


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( AvgCurr, AvgPwr );

% Set up fittype and options.
ft = fittype( 'poly1' );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'Average Power vs. Average Current', ['f(x) = p1*x + p2',newline,'       p1 =     13.65',newline,'       p2 =    0.5223',newline,'R-Squared: 0.9994'], 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'Average Current (A)', 'Interpreter', 'none' );
ylabel( 'Average Power (W)', 'Interpreter', 'none' );
% Create title
title('Predicting Average Power from Flights Average Current',...
    'FontSize',15);
grid on

