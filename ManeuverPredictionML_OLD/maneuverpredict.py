# **
# Author: 		Eric Altenburg
# Date: 		June 20, 2019
# Description: 	Machine Learning Decision Tree model for supervised leaning
# **

# Importing the packages needed for project
import numpy as np
import pandas as pd
from sklearn.metrics import confusion_matrix
from sklearn.model_selection import train_test_split 
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score
from sklearn.metrics import classification_report

# Creating a visualization for the tree

from sklearn.tree import export_graphviz

from IPython.display import Image

# Reads a csv file which holds all data
def importData():

	# Takes in a file from a location in storage, can also do with website
	balance_data=pd.read_csv('/home/user1/Usable Logs/combinedTrainTable.csv', sep=',', header = None);

	# Prints the length and shape of data
	print ("Dataset Length: ", len(balance_data))
	print ("dataset Shape:", balance_data.shape)

	# Prints a little bit of the data passed through
	print ("Dataset: ")
	print (balance_data.head())
	return balance_data

def importTestData():
	balance_data_test = pd.read_csv('/home/user1/Usable Logs/trainTable5.csv', sep=',', header = None)

	return balance_data_test

def extractAnswers(balance_data_test):
	W = np.zeros(shape=(891, 11))

	for i in range (891):
		W[i] = balance_data_test.loc[i]

	W_actual = np.zeros(shape=891)

	for i in range(891):
		W_actual[i] = W[i][0]

	return W_actual


def extractTestData(balance_data_test):
	Z = np.zeros(shape=(891, 11))

	for i in range(891):
		Z[i] = balance_data_test.loc[i]

	Z_actual = np.zeros(shape=(891, 9))
	for i in range(891):
		for k in range (2, 11):
			Z_actual[i][k-2] = Z[i][k] 

	return Z_actual

# Split up the data set by training and testing
def splitDataSet(balance_data):
	
	#X is target for training and Y is answer for testing
	X = balance_data.values[:, 2:11]
	Y = balance_data.values[:, 0]

	#Splitting everything up to its own training and testing sets, test_size is proportion to answers to data, random_state is const if testing, in practice put None

	X_train, X_test, Y_train, Y_test = train_test_split(X, Y, 
		test_size = 0.1, random_state = 6000)

	return X, Y, X_train, X_test, Y_train, Y_test

# Function that uses a certain way of leaning - GiniIndex. Includes training the model
def train_using_gini(X_train, X_test, Y_train): 
	
	# Make object, keep random state const for testing, put None for practice
	classifier_gini = DecisionTreeClassifier(criterion = "gini", 
		random_state = None, max_depth = 19, min_samples_leaf = 5)

	# Commence training
	classifier_gini.fit(X_train, Y_train)
	
	return classifier_gini

# Function to make the predictions with the model
def prediction(X_test, classifier_object):

	print('These are the values passed in:')
	print(X_test)
	
	# Make predictions with classifier tree
	Y_prediction = classifier_object.predict(X_test)

	# Print out predictions
	print("Predicted values:")
	print(Y_prediction)
	return Y_prediction

def cal_accuracy(Y_test, Y_prediction):

	# Print out the confusion matrix
	# 		 	Predicted No 	Predicted Yes
	# Actual No      *				*
	# Actual Yes     *				*
	print("Confusion Matrix: ")
	print(confusion_matrix(Y_test, Y_prediction))

	# Accuracy Score
	print("Accuracy: ", accuracy_score(Y_test,Y_prediction)*100)

	# Report print
	print("Report: ")
	print(classification_report(Y_test, Y_prediction))

# Driver
def main():
	# Take the data from doc/website
	data = importData()
	test_data = importTestData()

	# Split it up into training and testing
	X, Y, X_train, X_test, Y_train, Y_test = splitDataSet(data)
	Z = extractTestData(test_data)

	W = extractAnswers(test_data)

	# Create GiniIndex object
	classifier_gini = train_using_gini(X_train, X_test, Y_train)

	# Using the obj
	print("Results from Using Gini Index:")

	y_prediction_gini = prediction(Z, classifier_gini)
	np.savetxt("predictions.csv", y_prediction_gini, delimiter=",")
	cal_accuracy(W, y_prediction_gini)

	export_graphviz(classifier_gini, out_file='tree.dot', feature_names = None,
		class_names = None, rounded = True, proportion = False, precision = 2, filled = True)

	from subprocess import call 
	call(['dot', '-Tpng', 'tree.dot', '-o', 'tree.png', '-Gdpi=600'])

	import matplotlib.pyplot as plt 
	plt.figure(figsize = (14, 18))
	plt.imshow(plt.imread('tree.png'))
	plt.axis('off');
	plt.show();

# Calling main function
if __name__=="__main__":
	main()