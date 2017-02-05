# Getting and Cleaning Data Course Project

This project's goal was to read in the [Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones), perform some fitering and anaysis and then produce a tidy dataset of the results

The original dataset can be obtained in zip format [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Steps to Reproduce

1. Download the zipfile
2. Unzip the data
3. The R script ([run_analysis.R](https://github.com/BenGatewood/GettingandCleaningData/blob/master/run_analysis.R)) assumes that these files are in the same directory as itself:
  * X_test.txt
  * X_train.txt
  * features.txt
  * subject_test.txt
  * subject_train.txt
  * y_test.txt
  * y_train.txt
4. The files in the "Inertial Signals" sub-directories are not used and can be discarded
  
The script requires the [reshape2](https://cran.r-project.org/web/packages/reshape2/index.html) package
