Getting Data Course Assignment
==============================

Human Activity Recognition Assignment
-------------------------------------

**Author:** James Shields  
**Email:** james.shields@gmail.com  
**Date:** 11/23/2014  

## Contents ##

* **Introduction**  
    Purpose and overview of work
* **Data Source**  
    Where data was obtained
* **Method**  
    Description of processing steps undertaken
* **Code Book**  
    Description of varialbes contained in the output data set.
		
## Introduction ##

This Code Book was created as part of the Getting Data class hosted on
Coursera and sponsored by Johns Hopkins University.  This Code Book describes
the operation and outputs of the R-script run_analysis.R contained in this
repository.  This program processes raw data and converts it into a "tidy" data
set, obeying the following principles[^1].

* Each variable measured is in one column
* Each observation is in a different row
* One table for each kind of variable
* If there are multiple tables, there are identifiers in each table allowing them to
be linked. [Not necessary in this assignment.]

## Data ##

Data for this study was obtained via the University of California, Irvine.

The data measures 30 subjects and captures linear acceleration and angular
velocities as the subjects performed a defined set of common activities
(details in **Code Book**).

Further details of the study can be found here: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The data set used for this assignment is linked here: [Data set](
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Method ##

The script run_analysis.R contains all the relevant code.

### Obtaining data from the Internet ###

The script checks for the existence of a subdirectory called *data* in the present working direcotry.
If the directory does not exist, it is created.  The program then checks to see if the *data* subdirectory
contains the Human Activity Recognition data set archive.  If the archive is not present, it is
downloaded via R's *download.file()* method and saved as "*HAR_Data.zip*".  Finally, the script checks
to see if the archive has been decompressed.  If it has not, then the archive is uncompressed with
R's *unzip* method.

### Loading data into R ###

Data is read into R via the *read.table()* method.  The following data files are loaded into R by the
run_analysis script.

* **activity\_labels.txt** -- This file contains a mapping between numeric activity codes and the textual
descriptions of the relevant activities.
* **features.txt** -- This file contains a list of measurements that were taken for each subject while
performing an activity.
* **X\_test.txt** / **X\_train.txt** -- These files contain the measurement data for the *test* and *train*
data sets.
* **y\_test.txt** / **y\_train.txt** -- These files contain the numeric activity codes for each activity
performed by a subject during the experiment.
* **subject\_test.txt** / **subject\_train.txt** --These files contain the identifiers for the individual
subjects in each of the *test* and *train* groups.


[^1]: Per Jeffrey Leek's lecture "The components of tidy data" [Here](https://d396qusza40orc.cloudfront.net/getdata/lecture_slides/01_03_componentsOfTidyData.pdf).

