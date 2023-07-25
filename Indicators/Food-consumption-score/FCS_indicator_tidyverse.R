#------------------------------------------------------------------------------#

#	                        WFP RAM Standardized Scripts
#                         Calculating and Analyzing FCS

#------------------------------------------------------------------------------#

## Load Packages --------------------------------------------------------------#

library(tidyverse)
library(dplyr)
library(labelled)
library(expss)
library(haven)

# Load Sample Data ------------------------------------------------------------#

data <- read_csv("~/GitHub/RAMResourcesScripts/Static/FCS_Sample_Survey.csv")

# Label relevant FCS variables ------------------------------------------------# 

var_label(data$FCSStap)   <- "Cereals, grains, roots and tubers, such as:"
var_label(data$FCSPulse)  <- "Pulses/ legumes / nuts, such as:"
var_label(data$FCSDairy)  <- "Milk and other dairy products, such as:"
var_label(data$FCSPr)     <- "Meat, fish and eggs, such as:"
var_label(data$FCSVeg)    <- "Vegetables and leaves, such as:"
var_label(data$FCSFruit)  <- "Fruits, such as:"
var_label(data$FCSFat)    <- "Oil/fat/butter, such as:"
var_label(data$FCSSugar)  <- "Sugar, or sweet, such as:"
var_label(data$FCSCond)   <- "Condiments/Spices, such as:"

# Calculate FCS ---------------------------------------------------------------# 
data <- data %>% mutate(FCS = (FCSStap  * 2) + 
                              (FCSPulse * 3) +
                              (FCSPr    * 4) +
                              (FCSDairy * 4) + 
                               FCSVeg +
                               FCSFruit +
                              (FCSFat   * 0.5) +
                              (FCSSugar * 0.5))
var_label(data$FCS) <- "Food Consumption Score"

# Create FCG groups based on 21/55 or 28/42 thresholds ------------------------# 

# Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35
data <- data %>% mutate(FCSCat21 = case_when(
                             FCS <= 21 ~ 1,
                             between(FCS, 21.5, 35) ~ 2, 
                             FCS > 35 ~ 3),
                        FCSCat28 = case_when(
                             FCS <= 28 ~ 1, 
                             between(FCS, 28.5, 42) ~ 2, 
                             FCS > 42 ~ 3))

val_lab(data$FCSCat21) = num_lab("
             1 Poor
             2 Borderline
             3 Acceptable
                                 ")
var_label(data$FCSCat21) <- "FCS Categories: 21/35 thresholds"

val_lab(data$FCSCat28) = num_lab("
             1 Poor
             2 Borderline
             3 Acceptable
                                 ")
var_label(data$FCSCat28) <- "FCS Categories: 28/42 thresholds"

# End of Scripts
