import pandas as pd
import numpy as np
import sklearn
import matplotlib.pyplot as plt

print("Loading in train data")
train = pd.read_csv('src/data/train.csv')
print("Train data loaded")

train['Age'] = train.groupby(['Pclass', 'Sex'])['Age'].transform(lambda x: x.fillna(x.median()))
print("Group the age column by class and sex and fill in the NaN values with the median of each group")

feature_cols = ['Pclass','Sex','Age','SibSp','Parch','Fare']
print(f"Select feature columns as {feature_cols}")
gender_mapping = {'male': 1, 'female': 0}
train['Sex'] = train['Sex'].map(gender_mapping)
print("Map male to 1 and female to 0 to avoid NaN error in the model for train data")
X = train[feature_cols]
print("Set up training input set X as a subset of total data by just selecting the feature columns")
y = train['Survived']
print("Set up training target variable y as the 'Survived' column from the training data")

print('Importing sklearn LogisticRegression')
from sklearn.linear_model import LogisticRegression

print('Set up model with l2 penalty for ridge regularization, C = 1 for strong regularization, and liblinear solver for binary classification')
model = LogisticRegression(penalty='l2', C=1, solver='liblinear')
print('Fitting the model with X and y')
model.fit(X,y)

print('Importing metrics from sklearn to assess accuracy')
from sklearn.metrics import accuracy_score, classification_report
print('Making predictions for survival based on training data')
y_pred = model.predict(X)
print('Calculating accuracy using accuracy score metric based on comparison between predictions and target variable data y')
accuracy = accuracy_score(y, y_pred)
print(f"Training accuracy: {accuracy:.4f}")

print('Calculate the classification report using the classification report metric')
report = classification_report(y, y_pred, target_names = ['Did not survive','Survived'])
print(report)

print('Loading in test csv file')
test = pd.read_csv('src/data/test.csv')
print('Test csv file loaded')

print("Group the age column by class and sex and fill in the NaN values with the median of each group")
test['Age'] = test.groupby(['Pclass', 'Sex'])['Age'].transform(lambda x: x.fillna(x.median()))
print("Map male to 1 and female to 0 to avoid NaN error in the model for test data")
test['Sex'] = test['Sex'].map(gender_mapping)
print("Fill the 1 NaN fare with the mean of the fares to avoid NaN error in the model for test data")
test['Fare'] = test['Fare'].fillna(np.mean(test['Fare']))

X_test = test[feature_cols]
print('Create new column in the test data for the model predictions "Survived" based on the test data')
test['Survived'] = model.predict(X_test)
print('Save the passenger ID and "Survived" column to a csv called prediction_file.csv')
test[['PassengerId', 'Survived']].to_csv('prediction_file.csv', index=False)