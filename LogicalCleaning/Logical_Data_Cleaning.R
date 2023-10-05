### Logical Data Cleaning with cleanR package
rm(list = ls())
today <- Sys.Date()

## Step 1: load required packages
library(tidyverse)
library(openxlsx)
# install.packages("devtools")
# remotes::install_github("axmedmaxamuud/cleanR")
library(cleanR)

## Step 2: load data & create blank cleaning log book file
raw_data <- cleanR::survey_data # this is dumpy data generated from SD platform
my_logbook <- cleanR::logbook() # this will be blank logbook that you can use to export at the end.

## Step 3: Start running your data checking exercise
# check survey duration
check_form_time <- survey_time(df = raw_data, time_min = 20, time_max = 40) %>% 
  log_sheet(question.name = "interview_duration", 
            issue = "survey filled with less/long time, please check",
            action = "check")
# merge check_form_time with your logbook using the rbind function
my_logbook <- rbind(my_logbook, check_form_time)

# check other responses 
# first make a list of all other columns included in your data
other_columns <- c("HHAsstSecurityRisk_oth",
                   "HHAsstAccessWhat_oth")

check_others <- check_other_responses(data = raw_data, other_columns = other_columns)

# include other checks dataframe into your logbook
my_logbook <- rbind(my_logbook, check_others)

## You can run project specefic checks by using dplyr functions and than use the log_sheet function to reshape your data into clog format
# check the age of respondents
check_ki_age <- raw_data %>% 
  filter(RESPAge < 18) %>% 
  log_sheet(question.name = "RESPAge",
            issue = "the respondent is under age, please check if there was guardian",
            action = "check")
my_logbook <- rbind(my_logbook, check_ki_age)

# check if there are any duplicated uuids in your data
check_dup_surveys <- check_duplicate_uuid(data = raw_data) # this function will return the list of duplicated uuids in the console

# check the non-response rate of survey variables
check_missing_data <- get_na_response_rates(data = raw_data)

## Step 4: Export your cleaning log book and share it with field staff for making actions and filling the new.value column


