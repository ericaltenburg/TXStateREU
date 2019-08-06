
%Runs through all the functions sequentially to analyze the power of different maneuvers

readOldLog('1', 628, 1230, 37/15.4);
readOldLog('2', 335, 473, 1);
readOldLog('3', 249, 385, 1);

readNewCSV('4', 71, 177, 37/15.4);
readNewCSV('5', 31, 126, 37/15.4);

movingMeanOld('1');
movingMeanOld('2');
movingMeanOld('3');

movingMeanNew('4');
movingMeanNew('5');

labelAllData(9);

powerBoxPlot(true);

