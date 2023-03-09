library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/FCS_Sample_Survey.csv")

#assign variable and value labels
#variable labels
var_label(data$FCSStap) <- "Cereals, grains, roots and tubers, such as:"
var_label(data$FCSPulse) <- "Pulses/ legumes / nuts, such as:"
var_label(data$FCSDairy) <- "Milk and other dairy products, such as:"
var_label(data$FCSPr) <- "Meat, fish and eggs, such as:"
var_label(data$FCSVeg) <- "Vegetables and leaves, such as:"
var_label(data$FCSFruit) <- "Fruits, such as:"
var_label(data$FCSFat) <- "Oil/fat/butter, such as:"
var_label(data$FCSSugar) <- "Sugar, or sweet, such as:"
var_label(data$FCSCond) <- "Condiments/Spices, such as:"



#calculate FCS
data <- data %>% mutate(FCS = (2 * FCSStap) + (3 * FCSPulse)+ (4*FCSPr) +FCSVeg  +FCSFruit +(4*FCSDairy) + (0.5*FCSFat) + (0.5*FCSSugar))

#create FCG groups based on 21/25 or 28/42 thresholds

#Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35
data <- data %>% mutate(FCSCat21 = case_when(
    FCS <= 21 ~ 1, between(FCS, 21.5, 35) ~ 2, FCS > 35 ~ 3))

val_lab(data$FCSCat21) = num_lab("
             1 Poor
             2 Borderline
             3 Acceptable
")
var_label(data$FCSCat21) <- "FCS Categories"

# Important note: pay attention to the threshold used by your CO when selecting the syntax (21 cat. vs 28 cat.)
# Use this when analyzing a country with high consumption of sugar and oil – thresholds 28-42

data <- data %>% mutate(FCSCat28 = case_when(
  FCS <= 28 ~ 1, between(FCS, 28.5, 42) ~ 2, FCS > 42 ~ 3))

val_lab(data$FCSCat28) = num_lab("
             1 Poor
             2 Borderline
             3 Acceptable
")
var_label(data$FCSCat28) <- "FCS Categories"




