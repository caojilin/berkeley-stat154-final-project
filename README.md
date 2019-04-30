# Cloud Detection
The goal of cloud detection is to develop a classification model that effectively distinguishes the presence of cloud over the presence of ice/snow surfaces. 

## Usage
#### Clone the repositories
All works are done in cloudDetection.Rmd and CVgeneric.R
Every R chunk has a brief introduction
```bash
$ git clone https://github.com/caojilin/cloud-detection
$ cd cloud-detection/cloudDetection.Rmd
```
#### Load Required Libraries / Packages
```R
library(caret)
library(ggplot2)
library(scales)
library(e1071)
library(class)
library(randomForest)
library(ggfortify)
library(MASS)
library(corrplot)
library(rpart)
library(PRROC)
library(rpart.plot)
```

#### 1 Data Visualization
 * Load datasets and add column names
 * Add a column identifying which image they are from (for later convenience when splitting and merging data)
 * Remove unlabeled values (zeros) and convert -1 to 0
 * Combine data frames for all three images into one
 * Plot well-labeled map of the images based on x and y coordinates
```R
# E.g. Image 1
ggplot(data = image1) + geom_point(aes(x = x_coordinate, y = y_coordinate, color = as.factor(expert_label))) + scale_y_reverse() + scale_color_manual("Expert Labels", labels = c("Not Cloud", "No Label", "Cloud"), values = c("grey", "black", "white")) + ggtitle('Image 1: MISR Orbit 13257')
```
* Observe pair-wise relationships between variables by creating correlation plots on all features
```R
# E.g. 
corrplot(cor(images_all[,c(7, 8, 9, 10, 11)]), 
         method = 'number', 
         type = 'lower',
         tl.srt = 45,
         title = "Correlation For Radiance Angles")
```
* Observe relationships between different features and expert labels by creating histograms of individual variables color-coded with expert labels
```R
# Distribution of CORR In Relation to Expert Label
ggplot(data = image1_nozero) + geom_histogram(aes(x = image1_nozero$CORR, fill = expert_label))
```

#### 2. Data Preprocessing
a)
Split the entire dataset using two non-trivial methods
Method 1: split each image into 16 squares, extract 80% training, and 20% testing from each square
Method 2: split each image into many smaller squares and randomly select some squares to be testing and others to be training
b) 
a baseline classifier and its accuracy
c) 
generating PCA features
d)
generic CV function, see CVgeneric.R
**Input**: `classifier` is a string such as `'svm'`, `'logistic'`
training features, training labels, number of folds K and a loss function(optional)
**Output**: a dataframe containing accuracy and loss (if given a loss function) in each fold

#### 3. Modeling
In this section, 
* Logistic Regression, LDA, QDA, knn, svm, decision tree
* ROC curves for each model
* Precision Recall curves for each model

#### 4. Diagnostics
* A for loop for finding the optimal the number of trees in randomforest model. For each `i` in given `ntree`, train the randomforest model and evaluate the accuracy on validation dataset. 
* A function for generating maps where the misclassification pixels are plotted in different color for further investigation ![](https://ibb.co/th4T3L8)


