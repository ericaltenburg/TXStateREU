# **
# Author:		Eric Altenburg
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
	# Lab Desktop
	balance_train_data = pd.read_csv('/home/user1/Documents/TXStateREU/AllSimulationTrainingDataNoTurn2.csv', sep = ',', header = None)
	# Macbook
	#balance_train_data = pd.read_csv('/Users/ealtenburg/Documents/GitHub/TXStateREU/AllSimulationTrainingDataNoTurn2.csv', sep = ',', header = None)

	return balance_train_data

# Import data being used for testing as csv
def importTestData():
	# Lab Desktop
	balance_test_data = pd.read_csv('/home/user1/Documents/TXStateREU/TestCSVNoTurn2.csv', sep = ',', header = None)
	# Macbook
	#balance_test_data = pd.read_csv('/Users/ealtenburg/Documents/GitHub/TXStateREU/TestCSVNoTurn2.csv', sep = ',', header = None)

	return balance_test_data

# Splits up the predicions from the times in the final_timeline
def splitTimelineData():
	# Import the csv containing the final timeline to isolate the predictions. Overall for testing the answers for accuracy after the smoothing

	# Lab Desktop
	X = pd.read_csv('/home/user1/Documents/TXStateREU/final_timeline.csv', sep = ',', header = None)
	# Macbook
	#X = pd.read_csv('/Users/ealtenburg/Documents/GitHub/TXStateREU/final_timeline.csv', sep = ',', header = None)

	predictions = X.values[:, 0]

	return predictions

# Splits up the data for training (supervised)
def splitTrainData(balance_train_data):

	# Split up data
	X = balance_train_data.values[:, 2:11] # Training values
	Y = balance_train_data.values[:, 0] # Answers to check with

	# TODO: look up way to specify the size
	X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size = 0.1, random_state = 6000)

	return X, Y, X_train, X_test, Y_train, Y_test

# Splits up the data we want to test it with, not training data
def extractTestData(balance_test_data):
	test_vals = balance_test_data.values[:, 2:11] 
	test_ans = balance_test_data.values[:, 0]

	return test_vals, test_ans

# Traing the CDT with gini index and combined train data
def trainModelGini(X_train, Y_train):
	# This is the decision tree itself
	classifier_gini = DecisionTreeClassifier(criterion = "gini", random_state = 6000, max_depth = 3)

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

	# Report
	print('Report:')
	print(classification_report(Y_test, Y_prediction))

# Iteravely travels through the prediction data to create a time line for each of the maneuvers
def maneuverTimelineHelper(prediction_data, maneuver, man_counter, timeline):
	# Initial maneuver set
	maneuver = prediction_data[0]

	# Traverse through prediction_data adding up each subsequent instance and placing in 2D array
	for i in range(prediction_data.size):

		# If the element is different or it is the last element
		if ((prediction_data[i] != maneuver) or (i == prediction_data.size-1)):

			# If it is the last element, then +1 to man_counter to count itself. Else not the last element
			if (i == prediction_data.size-1):
				timeline = np.append(timeline, [[maneuver, man_counter+1]], axis = 0)
			else:
				timeline = np.append(timeline, [[maneuver, man_counter]], axis = 0)
				maneuver = prediction_data[i]
				man_counter = 1
		elif (prediction_data[i] == maneuver):
			man_counter += 1

	return timeline

# Calls helper method
def maneuverTimeline(prediction_data):
	# Creation of Rx2 matrix to hold the maneuver and the amount of time held
	timeline = np.empty(shape=[0, 2])

	return maneuverTimelineHelper(prediction_data, 0, 0, timeline)

# Gets rid of multiple of the same maneuvers
def removeRepeats(timeline):
	# Rarely ever going to be called
	if (timeline.shape[0] == 1):
		return timeline

	# Holds the new reduced timeline
	new_timeline = np.empty(shape=[0,2])
	maneuver = 0
	weight = 0

	# Traverse through the entire array
	for i in range (timeline.shape[0]):
		curr_man = timeline[i][0]
		curr_weight = timeline[i][1]
		if (i == 0):
			maneuver = curr_man
			weight = curr_weight
			continue

		# Same maneuver, add up and move on
		if (curr_man == maneuver):
			weight += curr_weight

			# Print the last added up maneuver and weight to the new
			if (i == timeline.shape[0]-1):
				new_timeline = np.append(new_timeline, [[maneuver, weight]], axis = 0)
		else:
			new_timeline = np.append(new_timeline, [[maneuver, weight]], axis = 0)
			maneuver = curr_man
			weight = curr_weight

			# The last element gets appended regardless
			if (i == timeline.shape[0]-1):
				new_timeline = np.append(new_timeline, [[timeline[i][0], timeline[i][1]]], axis = 0)

	return new_timeline


# Smoothes the data to get rid of any extraneous values. If found, will default to the biggest next to it. If surrounding are equal, for loop to the next until it finds one that isn't equal to each other
def smoothData(timeline):
	# Rarely ever going to be called
	if (timeline.shape[0] == 1):
		return timeline

	# Get rid of all repeats to have non repeating timelne. Makes smoothing easier and reduces space consumption.
	timeline = removeRepeats(timeline)
	# Determines whether or not to travel through the array again. May result in an n^2 time complexity. Will cut back on space consumption (1 less array)
	re_smooth = True 

	# Travel thorugh the array after the repeats were removed.
	while (re_smooth == True):
		# Traverse through the array to see if there is a value below 10 (1 sec)
		for i in range(timeline.shape[0]):
			# Value is low, change it
			if (timeline[i][1] < 10.0):
				# This is the first value or last value
				if (i == 0 and (timeline[i+1][1] > timeline[i][1])):
					timeline[i][0] = timeline[i+1][0]
					continue
				elif (i == timeline.shape[0]-1 and (timeline[i][1] < timeline[i-1][1])):
					timeline[i][0] = timeline[i-1][0]
					continue

				above = timeline[i-1][1]
				below = timeline[i+1][1]

				if (above > below):
					timeline[i][0] = timeline[i-1][0]
				elif (below > above):
					timeline[i][0] = timeline[i+1][0]
				elif (above == below):
					count_up = i+1
					count_down = i-1
					searching = True

					# So long as you are at least doing one of the following, then search in a direction
					while (searching == True):
						if (timeline[count_up][1] == timeline[count_down][1]):
							if (count_up+1 in range(0, timeline.shape[0])):
								count_up += 1

							if (count_down-1 in range(0, timeline.shape[0])):
								count_down -= 1
						else:
							searching = False

					if (timeline[count_down][1] > timeline[count_up][1]):
						timeline[i][0] = timeline[count_down][0]
					else:
						timeline[i][0] = timeline[count_up][0]

		timeline = removeRepeats(timeline)

		# Go through array one last time to see if there is another instance of a value less than 10
		for i in range(timeline.shape[0]):
			if (timeline[i][1] < 10.0):
				re_smooth = True
				break
			else:
				re_smooth = False

	return timeline

# Breaks down the timeline to be able to expand it into the same format the predictions were in order to test the accuracy
def redoAccuracy(timeline):
	timeline = removeRepeats(timeline)
	timeline = timeline.astype(int)

	final_pred = []

	for i in range(timeline.shape[0]):
		size = timeline[i][1]
		for k in range(size):
			final_pred.append(timeline[i][0])

	return final_pred


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
	classifier_gini = trainModelGini(X_train, Y_train)

	# Prints out the predictions from the CDT
	prediction_gini = prediction(test_vals, classifier_gini)

	# Save predictions to csv file (optional)
	np.savetxt("predictions.csv", prediction_gini, delimiter = ",")

	# Calculate and print accuracy along with confusion matrix
	accuracy(test_ans, prediction_gini)

	# Visualize tree in png
	export_graphviz(classifier_gini, out_file = 'tree.dot', feature_names = None, class_names = None, rounded = True,
	proportion = False, precision = 2, filled = True)
	all(['dot', '-Tpng', 'tree.dot', '-o', 'tree.png', '-Gdpi=6k00'])
	plt.figure(figsize = (14, 18))
	#plt.imshow(plt.imread('tree.png'))
	plt.axis('off')

	# Holds the initial timeline before the smoothing occurs
	timeline = maneuverTimeline(prediction_gini)
	np.savetxt("timeline.csv", timeline, delimiter = ",")

	print(timeline)

	# Holds the final timeline with the smoothed data, ready to be passed into matlab models
	final_timeline = smoothData(timeline)
	np.savetxt("final_timeline.csv", final_timeline, delimiter = ",")

	print(final_timeline)

	# Holds the expanded version of the timeline
	final_pred = redoAccuracy(final_timeline)
	np.savetxt("final_pred.csv", final_pred, delimiter = ",")

	# Calculate and print accuracy of the final predictions along with confusion matrix
	accuracy(test_ans, final_pred)

	# For converting the tree.dot to the proper tree.png
	import os
	os.system("dot -Tpng tree.dot -o tree.png")

# Calling main method
if __name__ == "__main__":
	main()
