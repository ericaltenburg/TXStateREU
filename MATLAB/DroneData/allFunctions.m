
readOldCSV('1', 628, 1230, 37/15.4);
readOldCSV('2', 335, 473, 1);
readOldCSV('3', 249, 385, 1);

readNewCSV('4', 71, 177, 37/15.4, '4', true);
readNewCSV('5', 31, 126, 37/15.4, '5', true);

movingMeanOld('1');
movingMeanOld('2');
movingMeanOld('3');

movingMeanNew('4');
movingMeanNew('5');

labelAllData(9);

avg = powerBoxPlot(true);

avg;