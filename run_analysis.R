run_analysis <- function(){
        
        #1) append datasets together into one dataset.
        
        #setting up directory location
        data_dir <- "UCI HAR Dataset"
        
        file_path <- function(...) { paste(data_dir,...,sep="/") }
        
        #load data & append datasets together.
        training_set <- read.table(file_path("train/X_train.txt"))
        test_set <- read.table(file_path("test/X_test.txt"))
        data_set <- rbind(training_set,test_set)
        data_set[1:4,1:5] #just checking the data
        
        # removing unused data
        rm(test_set,training_set)
        
        
        #2) select only columns which are means or standard deviations
        features_name <- read.table(file_path("features.txt"))[,2]
        colnames(data_set) <- features_name
        selected_measures <- grepl('-(mean|std)\\(',features_name)
        data_set <- subset(data_set,select=selected_measures)
        data_set[1:4,1:5] #again, checking the data
        
        #3) cleaning up variable names. 
        colnames(data_set) <- gsub("mean", "Mean", colnames(data_set))
        colnames(data_set) <- gsub("std", "Std", colnames(data_set))
        colnames(data_set) <- gsub("^t", "Time", colnames(data_set))
        colnames(data_set) <- gsub("^f", "Freq", colnames(data_set))
        colnames(data_set) <- gsub("\\(\\)", "", colnames(data_set))
        colnames(data_set) <- gsub("-", "", colnames(data_set))
        colnames(data_set) <- gsub("BodyBody", "Body", colnames(data_set))
        colnames(data_set) <- gsub("^", "MeanOf", colnames(data_set))
        colnames(data_set) #check all column names
        data_set[1:4,1:5] #checking data
        
        
        #4) name activities in dataset
        act_train <- read.table(file_path("train/y_train.txt"))
        act_test <- read.table(file_path("test/y_test.txt"))
        activities <- rbind(act_train,act_test)[,1]
        labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
                    "SITTING", "STANDING", "LAYING")
        activities <- labels[activities]
        data_set <- cbind(Activity = activities,data_set)
        data_set[1:4,1:5] #checking data
        
        
        #5) creates tidy data set with average of each variable for each activity and each subject.
        subj_train <- read.table(file_path("train/subject_train.txt"))
        subj_test <- read.table(file_path("test/subject_test.txt"))
        subjects <- rbind(subj_train,subj_test)[,1]
        data_set <- cbind(Subject = subjects,data_set)
        data_set[1:4,1:5]
        
        library('dplyr')
        average_data_set <- data_set %>%
                group_by(Subject,Activity) %>%
                summarise_each(funs(mean))
        
        write.table(average_data_set,row.name = FALSE,file = "tidy_data_set.txt")    
        
}