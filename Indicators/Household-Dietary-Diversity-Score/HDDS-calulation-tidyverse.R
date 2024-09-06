#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#          Calculating Household Dietary Diversity Score (HDDS)
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#
library(tidyverse)
library(dplyr)
library(labelled)
library(expss)
library(haven)

# Load Sample Data ------------------------------------------------------------#

# data <- read_csv("path_to_your_file.csv")

# Assign variable labels -------------------------------------------------------#
var_label(data$HDDSStapCer)  <- "Cereals consumption in the previous 24 hours"
var_label(data$HDDSStapRoot) <- "Roots and tubers consumption in the previous 24 hours"
var_label(data$HDDSVeg)      <- "Vegetable consumption in the previous 24 hours"
var_label(data$HDDSFruit)    <- "Fruit consumption in the previous 24 hours"
var_label(data$HDDSPrMeat)   <- "Meat/poultry consumption in the previous 24 hours"
var_label(data$HDDSPrEggs)   <- "Eggs consumption in the previous 24 hours"
var_label(data$HDDSPrFish)   <- "Fish consumption in the previous 24 hours"
var_label(data$HDDSPulse)    <- "Pulses/legumes consumption in the previous 24 hours"
var_label(data$HDDSDairy)    <- "Milk and dairy product consumption in the previous 24 hours"
var_label(data$HDDSFat)      <- "Oil/fats consumption in the previous 24 hours"
var_label(data$HDDSSugar)    <- "Sugar/honey consumption in the previous 24 hours"
var_label(data$HDDSCond)     <- "Miscellaneous/condiments consumption in the previous 24 hours"

# Compute HDDS ---------------------------------------------------------------#
data <- data %>%
  mutate(HDDS = HDDSStapCer + HDDSStapRoot + HDDSVeg + HDDSFruit +
                HDDSPrMeat + HDDSPrEggs + HDDSPrFish + HDDSPulse +
                HDDSDairy + HDDSFat + HDDSSugar + HDDSCond) %>%
  mutate(HDDSCat_IPC = case_when(
    HDDS <= 2 ~ 1,
    HDDS >= 3 & HDDS <= 4 ~ 2,
    HDDS >= 5 ~ 3
  ))

# Assign value labels
val_lab(data$HDDSCat_IPC) <- num_lab("
  1 '0-2 food groups (phase 4 to 5)'
  2 '3-4 food groups (phase 3)'
  3 '5-12 food groups (phase 1 to 2)'
")

# View the result
print(data %>% select(HDDS, HDDSCat_IPC))

# End of Scripts