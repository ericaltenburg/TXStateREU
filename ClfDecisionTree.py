# **
# Author:		Eric Altenburg and John
# Date: 		25 June 2019
# Description:	Machine learning classification decision tree for supervised learning
# **

import numpy as np 
import pandas as pd
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
from sklearn.metrics import classification_report
from sklearn.tree import export_graphviz
from IPython.display import Image
import matplotlib.pyplot as plt 
from subprocess import call

# Imports data being used for training as csv 
def importTrainData():
	# Change this for different systems	
	balance_train_data = pd.read_csv('/home/user1/Usable Logs/combinedTrainTable.csv', sep = ',', header = None)
	# Macbook, change these for the new file paths
	#balance_train_data = pd.read_csv('
	
	# Statistics about data (optional print)
	#print('Dataset Length: ', len(balance_train_data))
	#print('Dataset Shape: ', balance_train_data.shape)
	#print('Dataset: ')
	#print(balance_train_data.head())

	return balance_train_data

# Import data being used for testing as csv
def importTestData():
	balance_test_data = pd.read_csv('/home/user1/Usable Logs/trainTable5.csv', sep = ',', header = None)

	# Statistics about data (optional print)
	#print('Dataset Length: ', len(balance_test_data))
	#print('Dataset Shape: ', balance_test_data.shape)
	#print('Dataset: ')
	#print(balance_data.head())

	return balance_test_data

# Import data from the prediction that will be used for determining timeline
def importPredictionData():
	balance_pred_data = pd.read_csv('/home/user1/Documents/ManeuverPredictionML/predictions.csv', sep = ',', header = None)

	# Statistics about data (optional print)
	#print('Dataset Length: ', len(balance_pred_data))
	#print('Dataset Shape: ', balance_pred_data.shape)
	#print('Dataset: ')
	#print(balance_pred_data.head())

	# Isolates the answers and puts them into a numpy array
	pred_data = balance_pred_data.values[:, 0]

	return pred_data

# Splits up the predicions from the times in the final_timeline
def splitTimelineData():
	# Import the csv containing the final timeline to isolate the predictions. Overall for testing the answers for accuracy after the smoothing
	X = pd.read_csv('/home/user1/Documents/ManeuverPredictionML/final_timeline', sep = ',', header = None)

	predictions = X.values[:, 0]

	return predictions

# Splits up the data for training (supervised)
def splitTrainData(balance_train_data):

	# Split up data
	X = balance_train_data.values[:, 3:11] # Training values
	Y = balance_train_data.values[:, 0] # Answers to check with

	# TODO: look up way to specify the size
	X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.1, random_state = 6000)

	return X, Y, X_train, X_test, Y_train, Y_test

# Splits up the data we want to test it with, not training data
def extractTestData(balance_test_data):
	test_vals = balance_test_data.values[:, 3:11] 
	test_ans = balance_test_data.values[:, 0]

	return test_vals, test_ans

# Traing the CDT with gini index and combined train data
def trainModelGini(X_train, X_test, Y_train):
	# This is the decision tree itself
	classifier_gini = DecisionTreeClassifier(criterion = "gini", random_state = None, max_depth = 4)

	print("Size of X",X_train.size)
	print("Size of Y",Y_train.size)

	# Training
	classifier_gini.fit(X_train, Y_train)

	return classifier_gini

# Makes prediction of values from the test data and prints them
def prediction(X_test, classifier_object):
	Y_prediction = classifier_object.predict(X_test)

	print('Predicted values:')
	print(Y_prediction)

	return Y_prediction

# Calcualtes the accuracy of the prediction. ONLY FOR TESTING PURPOSES	
def accuracy(Y_test, Y_prediction):
	# Print out the confusion matrix
	# 			Predicted X 	Predicted Y
	# Actual X 		num 			num
	# Actual Y 		num 			num
	print('Confusion matrix:')
	print(confusion_matrix(Y_test, Y_prediction))

	# Accuracy score/percentage
	print('Accuracy: ', accuracy_score(Y_test, Y_prediction)*100)

	# Report?
	print('Report:')
	print(classification_report(Y_test, Y_prediction))

# Recurrsively travels through the prediction data to create a time line for each of the maneuvers
def maneuverTimelineHelper(prediction_data, maneuver, man_counter, data_counter, timeline):

	# There are still values left to be evaluated
	while data_counter <= prediction_data.size:

		# Initial maneuver
		if (maneuver == 0):
			maneuver = prediction_data[0]
			man_counter += 1
			data_counter += 1
			continue

		# The maneuver has changed
		if ((prediction_data[data_counter-1] != maneuver) or (data_counter == prediction_data.size)):

			if (data_counter==prediction_data.size):
				timeline = np.append(timeline, [[maneuver, man_counter+1]], axis = 0)
			else:
				timeline = np.append(timeline, [[maneuver, man_counter]], axis = 0)

			# Only reset if the value is not at the end of array or out of bounds exception
			if (data_counter < prediction_data.size):
				maneuver = prediction_data[data_counter]
				man_counter = 1
			data_counter += 1
			continue

		# The maneuver has not changed, do not change anything
		if (maneuver != 0):
			man_counter += 1

		data_counter +=1

	return timeline

# Calls helper method
def maneuverTimeline(prediction_data):
	# Creation of Rx2 matrix to hold the maneuver and the amount of time held
	timeline = np.empty(shape=[0, 2])

	return maneuverTimelineHelper(prediction_data, 0, 0, 0, timeline)

# Smoothes the data to get rid of any extraneous values. If found, will default to the biggest next to it.
def smoothData(timeline):
	# Matrix to hold the values and the total amount of weight of each value, used for deciding which value to switch current val (if low enough) to. Time complex of maybe n^2? Same shape as the timeline
	val_weight = np.empty(shape = [timeline.shape[0], 2])
	# Going to hold the amount to back track for entering weight per maneuver
	counter = 0
	# Going to hold the total weight for multiple maneuvers
	weight = 0

	decider = 0		

	# Holds the current maneuver, might not be necessary though, just use i -1

	# Iterate through the entire array counting up the weight per maneuver and add it to the matrix with same size
	while (decider == 0):
		for i in range(timeline.shape[0]):
			# First item
			if (i == 0):
		 		counter = 1
				weight += timeline[i][1]
				val_weight[i][0] = timeline[i][0]
				val_weight[i][1] = weight
				continue

			# Same item
			if (timeline[i][0] == timeline[i-1][0]):
				counter +=1
				val_weight[i][1] = weight
				weight += timeline[i][1]
				val_weight[i][0] = timeline[i][0]
			else:
				for k in range(counter):
					val_weight[i-(counter - k)][1] = weight

				counter = 1
				weight = timeline[i][1]
				val_weight[i][0] = timeline[i][0]
				val_weight[i][1] = weight

		for i in range(timeline.shape[0]):

			if (timeline[i][1] > 10.0):
				decider = 1
			else:
				decider = 0

				# The item is the first, and the one after it is bigger
				if (i == 0 and (val_weight[i][1] < val_weight[i+1][1])):
					timeline[i][0] = timeline[i+1][0]
					continue
                
				if (i == (timeline.shape[0]-1) and (val_weight[i][1] < val_weight[i+1][1])):
					timeline[i][0] = timeline[i-1][0]
				else:
					above = val_weight[i-1][1]
					below = val_weight[i+1][1]
					
					if (above < below):
						timeline[i][0] = val_weight[i+1][0]
					else:
						timeline[i][0] = val_weight[i-1][0]
	return timeline

	#for i in range(timeline.shape[0]):
#
#		# If the value is too small, look at top and bottom
#		if (timeline[i, 1] < 20.0):
#
#			# Also have to make sure if it is surrounded by similar maneuvers, it can change/leave it alone
#
#			# This is the first one, so only look below
#			if (timeline[i, 1] == timeline[0, 1]):
#				timeline[0, 0] = timeline[1, 0]
#
#			# This is the last one, so only look above
			#if (timeline[i, 1] == timeline[-1, 1]):
#				timeline[-1, 0] = timeline[-2, 0]
#
#			x = timeline[i-1, 1]
#			y = timeline[i+1, 1]
#
#			if (x > y):
#				timeline[i, 0] = timeline[i-1, 0]
#			else:
#				timeline[i, 0] = timeline[i+1, 0]
#
#	return timeline

# Driver
def main():
	# Import data
	train_data = importTrainData()
	test_data = importTestData()

	# From the training data, split up the values/answers for training in random order
	X, Y, X_train, X_test, Y_train, Y_test = splitTrainData(train_data)

	# From the data we want to test, it separates the values to test and the values that have answers
	test_vals, test_ans = extractTestData(test_data)

	# Creating the Decision Tree
	classifier_gini = trainModelGini(X_train, X_test, Y_train)

	# Prints out the predictions from the CDT
	prediction_gini = prediction(test_vals, classifier_gini)

	# Save predictions to csv file
	np.savetxt("predictions.csv", prediction_gini, delimiter = ",")

	# Calculate and print accuracy along with confusion matrix
	accuracy(test_ans, prediction_gini)

	# print(log_loss(test_ans, prediction_gini))

	# Visualize tree in png
	#xport_graphviz(classifier_gini, out_file = 'tree.dot', feature_names = None, class_names = None, rounded = True,
	#proportion = False, precision = 2, filled = True)
	#all(['dot', '-Tpng', 'tree.dot', '-o', 'tree.png', '-Gdpi=600'])
	#lt.figure(figsize = (14, 18))
	#lt.imshow(plt.imread('tree.png'))
	#lt.axis('off')
	#lt.show()

	# For determining how long each maneuver was done in the predition
	prediction_data = importPredictionData()

	# Holds the initial timeline before the smoothing occurs
	timeline = maneuverTimeline(prediction_data)
	np.savetxt("timeline.csv", timeline, delimiter = ",")

	# TESTING #
	print(timeline)

	# Holds the final timeline with the smoothed data, ready to be passed into matlab models
	final_timeline = smoothData(timeline)
	np.savetxt("final_timeline.csv", final_timeline, delimiter = ",")

	# TESTING #
	print()
	print(final_timeline)

	#predictions = splitTimelineData()

	#accuracy(test_ans, predictions)

# Calling main method
if __name__ == "__main__":
	main()
