#------------------------------------------------------------------------------#
#	                          WFP Standardized Scripts
#                   Calculating Food Consumption Sources (FCS Source)
#------------------------------------------------------------------------------#

## Load Packages --------------------------------------------------------------#

library(tidyverse)
library(dplyr)
library(labelled)
library(expss)
library(haven)

# Load Sample Data ------------------------------------------------------------#

# data <- read_csv("~/GitHub/RAMResourcesScripts/Static/FCS_Source_Sample_Survey.csv")

# Label relevant FCS variables ------------------------------------------------# 

var_label(data$FCSStap)    <- "Consumption over the past 7 days: cereals, grains and tubers"
var_label(data$FCSPulse)   <- "Consumption over the past 7 days: pulses"
var_label(data$FCSDairy)   <- "Consumption over the past 7 days: dairy products"
var_label(data$FCSPr)      <- "Consumption over the past 7 days: protein-rich foods"
var_label(data$FCSVeg)     <- "Consumption over the past 7 days: vegetables"
var_label(data$FCSFruit)   <- "Consumption over the past 7 days: fruit"
var_label(data$FCSFat)     <- "Consumption over the past 7 days: oil"
var_label(data$FCSSugar)   <- "Consumption over the past 7 days: sugar"
var_label(data$FCSCond)    <- "Consumption over the past 7 days: condiments"

var_label(data$FCSStap_SRf)    <- "Main source: cereals, grains and tubers"
var_label(data$FCSPulse_SRf)   <- "Main source: pulses"
var_label(data$FCSDairy_SRf)   <- "Main source: dairy products"
var_label(data$FCSPr_SRf)      <- "Main source: protein-rich foods"
var_label(data$FCSVeg_SRf)     <- "Main source: vegetables"
var_label(data$FCSFruit_SRf)   <- "Main source: fruit"
var_label(data$FCSFat_SRf)     <- "Main source: oil"
var_label(data$FCSSugar_SRf)   <- "Main source: sugar"
var_label(data$FCSCond_SRf)    <- "Main source: condiments"

# Define source types --------------------------------------------------------#

sources   <- c("Ownprod", "HuntFish", "Gather", "Borrow", "Cash", "Credit", "Beg", "Exchange", "Gift", "Assistance")
food_vars <- c("Stap", "Pulse", "Dairy", "Pr", "Veg", "Fruit", "Fat", "Sugar", "Cond")

# Create source variables -----------------------------------------------------#

for (food in food_vars) {
  for (source in sources) {
    data <- data %>% mutate(!!paste0(source, "_", food) := ifelse(get(paste0("FCS", food, "_SRf")) == match(source, sources) * 100, 
    get(paste0("FCS", food)), 0))
  }
}

# Aggregate by source --------------------------------------------------------#

data <- data %>% mutate(
  Ownprod    = rowSums(select(data, starts_with("Ownprod_")), na.rm = TRUE),
  HuntFish   = rowSums(select(data, starts_with("HuntFish_")), na.rm = TRUE),
  Gather     = rowSums(select(data, starts_with("Gather_")), na.rm = TRUE),
  Borrow     = rowSums(select(data, starts_with("Borrow_")), na.rm = TRUE),
  Cash       = rowSums(select(data, starts_with("Cash_")), na.rm = TRUE),
  Credit     = rowSums(select(data, starts_with("Credit_")), na.rm = TRUE),
  Beg        = rowSums(select(data, starts_with("Beg_")), na.rm = TRUE),
  Exchange   = rowSums(select(data, starts_with("Exchange_")), na.rm = TRUE),
  Gift       = rowSums(select(data, starts_with("Gift_")), na.rm = TRUE),
  Assistance = rowSums(select(data, starts_with("Assistance_")), na.rm = TRUE)
)

# Compute total sources of food -----------------------------------------------#

data <- data %>% mutate(
  Total_source = rowSums(select(data, Ownprod, HuntFish, Gather, Borrow, Cash, Credit, Beg, Exchange, Gift, Assistance), 
                         na.rm = TRUE)
)

# Calculate percentage of each food source ------------------------------------#

data <- data %>% mutate(
  Percent_Ownprod    = (Ownprod / Total_source) * 100,
  Percent_HuntFish   = (HuntFish / Total_source) * 100,
  Percent_Gather     = (Gather / Total_source) * 100,
  Percent_Borrow     = (Borrow / Total_source) * 100,
  Percent_Cash       = (Cash / Total_source) * 100,
  Percent_Credit     = (Credit / Total_source) * 100,
  Percent_Beg        = (Beg / Total_source) * 100,
  Percent_Exchange   = (Exchange / Total_source) * 100,
  Percent_Gift       = (Gift / Total_source) * 100,
  Percent_Assistance = (Assistance / Total_source) * 100
)

# Label new percentage variables ------------------------------------------------#

var_label(data$Percent_Ownprod)      <- "Percent of main source: Own production"
var_label(data$Percent_HuntFish)     <- "Percent of main source: Hunted or fished"
var_label(data$Percent_Gather)       <- "Percent of main source: Gathered"
var_label(data$Percent_Borrow)       <- "Percent of main source: Borrowed from family or friends"
var_label(data$Percent_Cash)         <- "Percent of main source: Purchased with cash"
var_label(data$Percent_Credit)       <- "Percent of main source: Purchased with credit"
var_label(data$Percent_Beg)          <- "Percent of main source: Begging"
var_label(data$Percent_Exchange)     <- "Percent of main source: Barter or exchange"
var_label(data$Percent_Gift)         <- "Percent of main source: Gifts from family or friends"
var_label(data$Percent_Assistance)   <- "Percent of main source: Assistance"

# Drop intermediate variables --------------------------------------------------#

data <- data %>% select(-starts_with("Ownprod_"),
                        -starts_with("HuntFish_"),
                        -starts_with("Gather_"),
                        -starts_with("Borrow_"),
                        -starts_with("Cash_"),
                        -starts_with("Credit_"),
                        -starts_with("Beg_"),
                        -starts_with("Exchange_"),
                        -starts_with("Gift_"),
                        -starts_with("Assistance_"))

# End of Scripts