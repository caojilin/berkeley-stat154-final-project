# Cloud Detection
The goal of cloud detection is to develop a classification model that effectively distinguishes the presence of cloud over the presence of ice/snow surfaces. 

## Usage
#### Clone the repositories
```bash
$ git clone https://github.com/caojilin/cloud-detection
$ cd cloud-detection/proj2_codes.Rmd
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
* Split the entire dataset using two non-trivial methods
    * Method 1: split each image into 16 squares, extract 80% training, and 20% testing from each square
    * Method 2: split each image into many smaller squares and randomly select some squares to be testing and others to be training
b) 
*baseline accuracy
c) 
*PCA features
d)
*generic CV function, see CVgeneric.R

#### 2. Data Preprocessing

