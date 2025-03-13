#!/usr/bin/env python3

#
# Try the following commands to add missing Python modules:
#    pip install numpy
#    pip install pandas
#    pip install scikit-learn
#    pip install graphviz
#    pip install pydotplus
#

import html
import numpy
import os
import pandas as pd
import pydotplus
import sys

from io import StringIO

from sklearn import metrics
from sklearn import tree
from sklearn.tree import DecisionTreeClassifier
from sklearn.tree import export_graphviz
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import confusion_matrix


# load dataset
column_names = ['age', 'workclass', 'fnlwgt', 'education', 'education-num', 'marital-status', 'occupation', 'relationship', 'race', 'sex', 'capital-gain', 'capital-loss', 'hours-per-week', 'native-country', 'income']

data_train = pd.read_csv("./Lab4/adult.data", header=None, sep=', ', names=column_names, engine='python')
data_test  = pd.read_csv("./Lab4/adult.test", header=None, sep=', ', names=column_names, engine='python', skiprows=1)


print()
print("Training data:")
print(data_train)
print()
print("Testing data:")
print(data_test)

class_names = ['income']
for col in class_names:
    count = {}
    for item in data_train[col]:
        if item in count:
            count[item] = count[item] + 1
        else:
            count[item] = 1
    print(f"Column {col}:")
    for item in count:
        print(f"{item} : count: {count[item]}, proportion: {count[item] / len(data_train)}")
    print()
    count = {}
    for item in data_test[col]:
        if item in count:
            count[item] = count[item] + 1
        else:
            count[item] = 1
    print(f"Column {col}:")
    for item in count:
        print(f"{item} : count: {count[item]}, proportion: {count[item] / len(data_test)}")
    print()


# select features
feature_columns = ['age', 'workclass', 'education-num', 'marital-status', 'occupation', 'relationship', 'race', 'sex', 'capital-gain', 'capital-loss', 'hours-per-week', 'native-country']
features_train = data_train[feature_columns]
label_train = data_train.income

features_test = data_test[feature_columns]
label_test = data_test.income


# convert categorical features to numerical
le_label = LabelEncoder()
label_train = le_label.fit_transform(label_train)
label_test_raw = label_test
label_test = le_label.fit_transform(label_test)

raw_labels = le_label.classes_
html_labels = list(map(lambda label: html.escape(label), raw_labels))

print()
pd.options.mode.copy_on_write = True   # gets rid of SettingWithCopyWarning
for i, col in enumerate(feature_columns):
    # only encode features that are not already numerical
    if not col in ['age', 'fnlwgt', 'education-num', 'capital-gain', 'capital-loss', 'hours-per-week']:
        le_feature = LabelEncoder()
        print("Encoding " + col + " (feature " + str(i) + ") to numerical")
        features_train[col] = le_feature.fit_transform(features_train[col])
        features_test[col] = le_feature.fit_transform(features_test[col])
        for i, cls in enumerate(le_feature.classes_):
            print(f"    {i} = {cls}")
        print()

       
# create decision tree model
classifier = DecisionTreeClassifier()
model = classifier.fit(X=features_train, y=label_train)


# evaluate model
label_pred_train = model.predict(features_train)
label_pred_test = model.predict(features_test)

print()
print("Evaluating model")
print("   accuracy on training data: %.2f" % metrics.accuracy_score(label_train, label_pred_train))
print("   accuracy on testing data: %.2f" % metrics.accuracy_score(label_test, label_pred_test))
print("   F1 score on training data: %.2f" % metrics.f1_score(label_train, label_pred_train))
print("   F1 score on testing data: %.2f" % metrics.f1_score(label_test, label_pred_test))

print()
print("Confusion matrix")
matrix = confusion_matrix(label_test, label_pred_test)

x = numpy.array(matrix)
print("                 ", end="")
for l in raw_labels:
    print("%015s" % l, end="")
print("   (predicted label)")
for label, row in zip(list(raw_labels), x):
    print( '%015s [%s]' % (label, ' '.join('%014s' % i for i in row)))
print("(correct label)")

print()


# feature importance

# <add some code here to quantify the relative importance of different features>


# visualization
fname = 'census_large.svg'
print()
print('Saving visualization to ' + fname + ", this may take a few seconds ...")

dot_data = StringIO()
export_graphviz(model, out_file=dot_data,
                filled=True, rounded=True,
                special_characters=True,
                feature_names = feature_columns,
                class_names=html_labels)

graph = pydotplus.graph_from_dot_data(dot_data.getvalue())
graph.write_svg(fname)
print()
