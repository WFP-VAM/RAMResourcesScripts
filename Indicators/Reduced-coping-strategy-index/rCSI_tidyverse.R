#------------------------------------------------------------------------------#

#	                        WFP RAM Standardized Scripts
#                      Calculating and Summarising rCSI

#------------------------------------------------------------------------------#

rm(list = ls())

## Load Packages --------------------------------------------------------------#

library(tidyverse)
library(dplyr)
library(labelled)

# Load Sample Data ------------------------------------------------------------#

data <- read_csv("~/GitHub/RAMResourcesScripts/Static/rCSI_Sample_Survey.csv")

# Label rCSI relevant variables -----------------------------------------------#

var_label(data$rCSILessQlty)  <- "Relied on less preferred and less expensive food"
var_label(data$rCSIBorrow)    <- "Borrowed food or relied on help from a relative or friend"
var_label(data$rCSIMealNb)    <- "Reduce number of meals eaten in a day"
var_label(data$rCSIMealSize)  <- "Limit portion size of meals at meal times"
var_label(data$rCSIMealAdult) <- "Restricted consumption by adults for small children to eat"

# Calculate rCSI --------------------------------------------------------------# 

data <- data %>% mutate(rCSI = rCSILessQlty + 
                              (rCSIBorrow * 2) + 
                               rCSIMealNb + 
                               rCSIMealSize + 
                              (rCSIMealAdult * 3))

var_label(data$rCSI)          <- "Reduced coping strategies index (rCSI)"

# Creating weighted and unweighted summary of rCSI ----------------------------# 

#unweighted
rCSI_table_mean <- data %>% 
  drop_na(rCSI) %>% 
  summarise(meanrCSI = mean(rCSI))
  
#with weights 
rCSI_table_mean <- data %>% 
  drop_na(rCSI) %>% 
  summarise(meanrCSI = weighted.mean(rCSI,nameofweightvariable))
#insert name of weight variable 

