# Getting and Cleaning Data Project

My script requires that the dplyr and tidyr packages are installed

The steps that the script carries out to combine the data are:

- Column Bind Test Data files
- Column Bind Training Data files
- Row Bind Test and Training Data Sets
- Read in features data information
- Create column_names vector with Subject, Activity as first two names, then all of the feature names as the remaining 561 items
- Applies the column_names vector to the data set

The above steps combine all of the required data ready for tidying. 

I decided to tidy the data into a long format. Part of the reasoning was to make writing the CodeBook simpler. 

The steps carried out to tidy the data are:
- Select only the columns named "Activity", "Subject", or containing "mean" or "std" in name
- Remove columns containing "meanFreq" in name
- Replace activity IDs with meaningful activity labels
- Create data set with the average of each variable for each activity and each subject
- Transform data from wide to long format
- Order Data
- Write output to file

To read the output of the file back into R to view it the following commands can be used:

	data <- read.table(file_path, header = TRUE) 
    View(data)