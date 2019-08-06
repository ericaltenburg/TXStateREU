
%Runs through all the functions sequentially to analyze the battery capabilities

readBatCSV('115', 37/15.4);
readBatCSV('160', 37/15.4);
readBatCSV('164', 37/15.4);
readBatCSV('165', 37/15.4);
readBatCSV('182', 37/15.4);
readBatCSV('231', 37/15.4);
readBatCSV('259', 37/15.4);
readBatCSV('273', 1);


readBatCSV('204_3Cell', 1);
readBatCSV('363_3Cell', 1);
readBatCSV('408_3Cell', 1);

battery1Tests();
battery2Tests();