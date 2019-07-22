# TXStateREU

Code for the Classifier Decision Tree machine learning model. Used to predict the maneuvers a given UAV was performing during a simulated flight based on data values passed through as .csv files. 

## Compiling

Compile the ClfDecisionTree.py in the terminal by typing '''python3 ./ClfDecisionTree.py.'''

## Issues

If you're having issues compiling, check to see if you have Python 3 installed. You can do so by opening the terminal and typing '''pip3''' and hitting enter. If you encounter errors, follow the Python 3 with this [link](https://realpython.com/installing-python/).

If Python 3 is installed and you are compiling with it, then another common error is:
> ModuleNotFoundError: No module named 'XXXXX'

To fix this, type:
'''
pip3 install *Module Name*
'''

## Github Commands

###### After modifying the files

This tells you information about midified files and the repository in general:
'''
git status
'''

Adds files to be pushed:
'''
git add *file_name*
'''
or to add multiple
'''
git add *file_name1* *file_name2* *...*
'''
or to add all of the changed files
'''
git add --all
'''

To commit:
'''
git commit -m "Your message here"
'''

Push changes to the repo:
'''
git push
'''

###### Getting the updated repo

Grabs changes:
'''
git pull origin master
'''


```
git status
git add
git commit
```
