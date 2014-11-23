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

The script loads the variable names from the **features.txt** file and applies them to each of the x_ files
from the *test* and *train* data sets.  

### Merging data sets and selecting variables ###

The x, y, and subject files for both the *test* and *train* data sets are merged into a a single
dataset by means of R's *cbind()* method.  These datasets are then concatenated using the *rbind()* method.

The activity labels from the *activity_labels.txt* file are then merged with the combined dataset to
assign meaningful activity codes to the activities.

As only variables containing the mean and standard deviatio are of interest, the variable naems from the
on the data set are then searched to identify only the variables that contain the subject, activity code,
mean and standard deviation by means of R's *grepl()* method.  The variables containing values of the
meanFreq are not included in this dataset, as they are not the values that are being measured, but rather
the weighted average of the frequency components.

### Converting to a narrow data set ###

The data set thus far is in a wide format.  The *melt()* method from R's *reshape2* library is used to
convert this wide data set into a tall, narrow format.  Each row in this dataset contains the subject ID,
the activity label, a textual description of the measurement that was taken, and measurement value as a
character.  The textual value for the measurement is then coerced into a numeric value using the
*as.numeric()* method.

### Summarizing the data ###

Next, a summary dataset is created from the combined dataset produced in the section above.  The summary
data set averages each of the measurments for each subject while performing one of the activities.  This
is accomplished by using the *aggregate()* method.

### Output ###

Finally, a text file is created in the working directory.  This file contains the summarized data set
produced in the previous section.  The file is created using the *write.table()* method and suppressing
variable names, by setting the *col.names* option to *FALSE*.  This file is titled "*getting\_data\_output.txt*".

## Code Book ##

The "*getting\_data\_output.txt*" file is a space-delimited file containing the tidy data set produced by
the run_analysis.R script.  Text values are indicated by quotation marks ("").  The variables contained
in the data set are described below.

* **row ID**

  Row ID is a unique identifier for each row in the tidy data set.  It is a character-type value, enclosed
  in quotation marks ("").
* **activity code**  
  Activity code is a meaningful, textual description of each activity that a subject was performing.  The
  valid values are
  
  * LAYING
  * SITTING
  * STANDING
  * WALKING
  * WALKING\_DOWNSTAIRS
  * WALKING\_UPSTAIRS

  Each value is enclosed in quotation marks (""), as this variable is of the character type.
* **subject ID**  

  Subject ID is a numeric code for each of the 30 subjects in the study.  The identifiers that are used are
  simply the numbers 1 -- 30.
* **measurement**  

  Measurement is the meaningful, textual name for each measurement taken of the subject.  It is a character
  type value and each value is enclosed in quotation marks ("").
* **average value**  

  The average value contains the mean value for each of the measurements for each subject performing each
  activity.  This is a numeric type value. The measurements are time values, with units in seconds.

-------------------------------------------------------------------------------  
[^1]: Per Jeffrey Leek's lecture "The components of tidy data" [Here](https://d396qusza40orc.cloudfront.net/getdata/lecture_slides/01_03_componentsOfTidyData.pdf).

