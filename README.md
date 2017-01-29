# Programming Assignment 3
Programming assignment for course 3 of the JHU data science specialization.

*Assumes data is saved in directory "UCI HAR Dataset" - test and train data not uploaded to Github.*

###run_analysis.R does the following:
1. Appends the test and the train data together into one dataset ("data_set").
  * done by reading in the txt files and using **rbind**.
2. Selects only the columns which are measures of means or standard deviations.
  * uses regular expression through **grepl** to identify the necessary columns.
3. Cleans up the variable names to be more legible.
  * adjusts capitalization, duplicate words, and vague use of special characters to make columns more easy to understand.
4. Names the activities in the dataset ('WALKING', 'STANDING', etc.)
  * reads in descriptive files for test and train sets, uses **rbind** to tie them together, and then **cbind** to tie to data_set.
5. Creates a separate tidy dataset which averages each variable for each activity and subject (tidy_data_set.txt)
  * uses same method as Step 4 to read in subject ids.
  * uses **dplyr** to group by Subject & Activity, then to average each. Writes to tidy_data_set.txt.
