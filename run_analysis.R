# run_analysis.R
# Author: James Shields
# Email: james.shields@gmail.com
# Purpose:  The purpose of this program is to download data on wearable computers,
#           merge the data contained in test and train files, and convert the results
#           into a tidy dataset.
#
#           This was completed for the Getting Data course conducted by Johns Hopkins University
#           and hosted by Coursera.


# libraries to import
library(reshape2)

# create directory if it does not already exist
if (!file.exists("./data/")){ dir.create("./data") }


# download data if it does not already exist
if (!file.exists("./data/HAR_Data.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                  destfile="./data/HAR_Data.zip",method="curl")
}

# unzip file if it has not been already
if (!file.exists("./data/UCI HAR Dataset/")) { unzip("./data/HAR_Data.zip", exdir="./data")}

# get labels for activities
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names=c("activity_code", "activity"), stringsAsFactors=FALSE)

# get variable names
var_names <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE, col.names=c("row_id", "varnames"))

# clean variable names to values valid in R.  Remove . and replace with empty characters
var_names$varnames <- gsub("\\.", "", make.names(var_names$varnames))

# the get_data function takes the source of data ("test" or "train") and returns a data frame
# containing the subject IDs, the activity codes, and the measurements
get_data <- function(src) {
    
    x <- read.table(gsub("XXXX", src, "./data/UCI HAR Dataset/XXXX/X_XXXX.txt"), col.names=var_names$varnames)
    y <- read.table(gsub("XXXX", src, "./data/UCI HAR Dataset/XXXX/y_XXXX.txt"), col.names="activity_code")
    subject <- read.table(gsub("XXXX", src, "./data/UCI HAR Dataset/XXXX/subject_XXXX.txt"), col.names="subject")
    data <- as.data.frame(cbind(subject, y, x))
    data$source <- src
    data
}

# get test and train datasets 
test <- get_data("test")
train <- get_data("train")

# combine the test and train datasets into one master data frame
merged <- rbind(test,train)

# identify only variables containing mean or standard deviation in the merged dataset
n <- names(merged)
vars_to_keep <- grepl("subject", n) | grepl("activity_code",n) |  (grepl("mean", n) & !grepl("meanFreq", n)) |  grepl("std", n)
merged_trimmed <- merged[,vars_to_keep]

# merge the activity labels with the trimmed datasets to obtain meaningfull names for the activity codes
merged_labeled <- merge(activity_labels, merged_trimmed, by.x="activity_code", by.y="activity_code")

# uses the melt method in the reshape2 library to convert the wide data into a narrow dataset
# with individual rows for each measurement of a subject doing an activity
molten <- melt(merged_labeled, id.vars=c("activity_code", "activity", "subject"), value.name="measurement")

# coerce character measurements to numeric type
molten$var <- as.numeric(molten$measurement)

# create a datset containing the average of each measurement for subject, activity, and variable
averages <- aggregate(formula=measurement ~ activity + subject + variable, data=molten, FUN=mean, na.action=na.omit)

# write data to a file
write.table(averages, file="./getting_data_output.txt", col.names=FALSE)
