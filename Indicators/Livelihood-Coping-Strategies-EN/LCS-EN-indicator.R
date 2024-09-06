#------------------------------------------------------------------------------#
#	                          WFP Standardized Scripts
#              Calculating Livelihood Coping Strategy for Food Security (LCS-EN)
#------------------------------------------------------------------------------#

# This script calculates the Livelihood Coping Strategy for Food Security (LCS-EN) 
# indicator based on household responses to various coping strategies. The indicator 
# considers stress, crisis, and emergency strategies and summarizes coping behavior.

# Important note: this script is only an example. When calculating the indicator, 
# you will need to include the 10 strategies (4 stress, 3 crisis, 3 emergency) that 
# were selected for your specific case.

# Please find more guidance on the indicator at the LCS-EN VAM Resource Center page: 
# https://resources.vam.wfp.org/data-analysis/quantitative/essential-needs/livelihood-coping-strategies-essential-needs

library(tidyverse)
library(labelled)
library(expss)

# Load data
#data <- read_csv("~/GitHub/RAMResourcesScripts/Static/LCS_EN_Sample_Survey.csv")

# Assign variable and value labels
var_label(data$LcsEN_stress_DomAsset)    <- "Sold household assets/goods (radio, furniture, refrigerator, television, jewellery, etc.)"
var_label(data$LcsEN_stress_Utilities)   <- "Reduced or ceased payments on essential utilities and bills"
var_label(data$LcsEN_stress_Saving)      <- "Spent savings"
var_label(data$LcsEN_stress_BorrowCash)  <- "Borrowed cash"
var_label(data$LcsEN_crisis_ProdAssets)  <- "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)"
var_label(data$LcsEN_crisis_Health)      <- "Reduced expenses on health (including drugs)"
var_label(data$LcsEN_crisis_OutSchool)   <- "Withdrew children from school"
var_label(data$LcsEN_em_ResAsset)        <- "Mortgaged/Sold house or land"
var_label(data$LcsEN_em_Begged)          <- "Begged and/or scavenged (asked strangers for money/food/other goods)"
var_label(data$LcsEN_em_IllegalAct)      <- "Had to engage in illegal income activities (theft, prostitution)"

data <- data %>%
  mutate(across(c(LcsEN_stress_DomAsset, LcsEN_stress_Utilities, LcsEN_stress_Saving, LcsEN_stress_BorrowCash, 
                  LcsEN_crisis_ProdAssets, LcsEN_crisis_Health, LcsEN_crisis_OutSchool, 
                  LcsEN_em_ResAsset, LcsEN_em_Begged, LcsEN_em_IllegalAct), 
                ~labelled(., labels = c(
                  "No, because we did not need to" = 10,
                  "No, because we already sold those assets or have engaged in this activity within the last 12 months and cannot continue to do it" = 20,
                  "Yes" = 30,
                  "Not applicable (don’t have access to this strategy)" = 9999
                ))))

# Treatment of missing values
frequencies <- data %>% summarise(across(starts_with("LcsEN"), ~ sum(is.na(.))))
print(frequencies)

# Custom handling for missing values can be added here if required

# Stress strategies
data <- data %>% 
  mutate(stress_coping_EN = case_when(
    LcsEN_stress_DomAsset %in% c(20, 30) | LcsEN_stress_Utilities %in% c(20, 30) | 
    LcsEN_stress_Saving %in% c(20, 30) | LcsEN_stress_BorrowCash %in% c(20, 30) ~ 1, 
    TRUE ~ 0))

var_label(data$stress_coping_EN) <- "Did the HH engage in stress coping strategies?"

# Crisis strategies
data <- data %>% 
  mutate(crisis_coping_EN = case_when(
    LcsEN_crisis_ProdAssets %in% c(20, 30) | LcsEN_crisis_Health %in% c(20, 30) | 
    LcsEN_crisis_OutSchool %in% c(20, 30) ~ 1, 
    TRUE ~ 0))

var_label(data$crisis_coping_EN) <- "Did the HH engage in crisis coping strategies?"

# Emergency strategies
data <- data %>% 
  mutate(emergency_coping_EN = case_when(
    LcsEN_em_ResAsset %in% c(20, 30) | LcsEN_em_Begged %in% c(20, 30) | 
    LcsEN_em_IllegalAct %in% c(20, 30) ~ 1, 
    TRUE ~ 0))

var_label(data$emergency_coping_EN) <- "Did the HH engage in emergency coping strategies?"

# Coping behavior
data <- data %>% 
  mutate(temp_nonmiss_number = rowSums(!is.na(select(., starts_with("LcsEN")))), 
         max_coping_behaviourEN = case_when(
           temp_nonmiss_number > 0 ~ 1, 
           stress_coping_EN == 1 ~ 2, 
           crisis_coping_EN == 1 ~ 3, 
           emergency_coping_EN == 1 ~ 4, 
           TRUE ~ NA_real_))

var_label(data$max_coping_behaviourEN) <- "Summary of asset depletion"
val_lab(data$max_coping_behaviourEN) <- c("HH not adopting coping strategies" = 1, 
                                          "Stress coping strategies" = 2, 
                                          "Crisis coping strategies" = 3, 
                                          "Emergency coping strategies" = 4)

# Remove temporary variables
data <- data %>% select(-temp_nonmiss_number)

# Analyze reasons for adopting strategies
data <- data %>% 
  rename(LhCSIEnAccess1 = LhCSIEnAccess.1, LhCSIEnAccess2 = LhCSIEnAccess.2, LhCSIEnAccess3 = LhCSIEnAccess.3, 
         LhCSIEnAccess4 = LhCSIEnAccess.4, LhCSIEnAccess5 = LhCSIEnAccess.5, LhCSIEnAccess6 = LhCSIEnAccess.6, 
         LhCSIEnAccess7 = LhCSIEnAccess.7, LhCSIEnAccess8 = LhCSIEnAccess.8, LhCSIEnAccess999 = LhCSIEnAccess.999)

var_label(data$LhCSIEnAccess1) <- "Adopted strategies to buy food"
var_label(data$LhCSIEnAccess2) <- "Adopted strategies to pay for rent"
var_label(data$LhCSIEnAccess3) <- "Adopted strategies to pay school, education costs"
var_label(data$LhCSIEnAccess4) <- "Adopted strategies to cover health expenses"
var_label(data$LhCSIEnAccess5) <- "Adopted strategies to buy essential non-food items (clothes, small furniture)"
var_label(data$LhCSIEnAccess6) <- "Adopted strategies to access water or sanitation facilities"
var_label(data$LhCSIEnAccess7) <- "Adopted strategies to access essential dwelling services (electricity, energy, waste disposal...)"
var_label(data$LhCSIEnAccess8) <- "Adopted strategies to pay for existing debts"
var_label(data$LhCSIEnAccess999) <- "Adopted strategies for other reasons"

desc_stats <- data %>% summarise(across(starts_with("LhCSIEnAccess"), mean, na.rm = TRUE))

# Calculating LCS-FS using the LCS-EN module
data <- data %>% 
  mutate(max_coping_behaviourFS = if_else(!is.na(max_coping_behaviourEN), max_coping_behaviourEN, NA_real_),
         max_coping_behaviourFS = if_else(LhCSIEnAccess1 == 0 & !is.na(max_coping_behaviourFS), 1, max_coping_behaviourFS))

var_label(data$max_coping_behaviourFS) <- "Summary of asset depletion (converted from EN to FS)"

# End of Scripts