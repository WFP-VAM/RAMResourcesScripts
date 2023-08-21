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
raw_data <- cleanR::data
my_logbook <- cleanR::logbook() # this will be blank logbook that you can use to export at the end.

## Step 3: Start running your data checking 
# check survey duration
check_form_time <- survey_time(df = raw_data, time_min = 20, time_max = 40) %>% 
  filter(CHECK_interview_duration %in% c("Too long", "Too short")) %>% 
  log_sheet(question.name = "interview_duration", 
            issue = "survey filled with less/long time, please check",
            action = "check")
# merge check_form_time with your logbook using the rbind function
my_logbook <- rbind(my_logbook, check_form_time)

