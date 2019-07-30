function [fitresult, gof] = BPwrRegress(AvgPwr, Sec)
%CREATEFIT(AVGPWR,SEC)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : AvgPwr
%      Y Output: Sec
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 29-Jul-2019 03:47:08


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( AvgPwr, Sec );

% Set up fittype and options.
ft = fittype( 'rat11' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.0539501186666071 0.530797553008973 0.7792];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'Flight Time vs. Average Power', ['f(x) = (p1*x + p2) / (x + q1)',newline,'       p1 =       324.3',newline,'       p2 =        98250',newline,'       q1 =       29.03',newline,'R-Square; 0.9525'], 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'Avgerage Power (W)', 'Interpreter', 'none' );
ylabel( 'Flight Time (Sec)', 'Interpreter', 'none' );
grid on

