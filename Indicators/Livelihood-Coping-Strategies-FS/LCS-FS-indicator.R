#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#          Calculating Livelihood Coping Strategy for Food Security (LCS-FS)
#------------------------------------------------------------------------------#

# This script calculates the Livelihood Coping Strategy for Food Security (LCS-FS) 
# indicator based on household responses to various coping strategies. The indicator 
# considers stress, crisis, and emergency strategies and summarizes coping behavior.

# Important note: this script is only an example. When calculating the indicator, 
# you will need to include the 10 strategies (4 stress, 3 crisis, 3 emergency) that 
# were selected for your specific case.

# Please find more guidance on the indicator at the LCS-FS VAM Resource Center page: 
# https://resources.vam.wfp.org/data-analysis/quantitative/food-security/livelihood-coping-strategies-food-security

library(tidyverse)
library(labelled)
library(expss)

# Load data
#data <- read_csv("~/GitHub/RAMResourcesScripts/Static/LCS_FS_Sample_Survey.csv")

# Assign variable labels
var_label(data$Lcs_stress_DomAsset)     <- "Sold household assets/goods (radio, furniture, refrigerator, television, jewellery, etc.)"
var_label(data$Lcs_stress_Utilities)    <- "Reduced or ceased payments on essential utilities and bills"
var_label(data$Lcs_stress_Saving)       <- "Spent savings"
var_label(data$Lcs_stress_BorrowCash)   <- "Borrowed cash"
var_label(data$Lcs_crisis_ProdAssets)   <- "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)"
var_label(data$Lcs_crisis_Health)       <- "Reduced expenses on health (including drugs)"
var_label(data$Lcs_crisis_OutSchool)    <- "Withdrew children from school"
var_label(data$Lcs_em_ResAsset)         <- "Mortgaged/Sold house or land"
var_label(data$Lcs_em_Begged)           <- "Begged and/or scavenged (asked strangers for money/food/other goods)"
var_label(data$Lcs_em_IllegalAct)       <- "Had to engage in illegal income activities (theft, prostitution)"

# Assign value labels
data <- data %>%
  mutate(across(c(Lcs_stress_DomAsset, Lcs_stress_Utilities, Lcs_stress_Saving, 
                  Lcs_stress_BorrowCash, Lcs_crisis_ProdAssets, Lcs_crisis_Health, 
                  Lcs_crisis_OutSchool, Lcs_em_ResAsset, Lcs_em_Begged, Lcs_em_IllegalAct), 
                ~ labelled(., labels = c(
                  "No, because we did not need to" = 10,
                  "No, because we already sold those assets or have engaged in this activity within the last 12 months and cannot continue to do it" = 20,
                  "Yes" = 30,
                  "Not applicable (don’t have access to this strategy)" = 9999
                ))))

# Check for missing values
missing_values <- sapply(data, function(x) sum(is.na(x)))
print(missing_values)

# Stress strategies
data <- data %>% mutate(stress_coping_FS = case_when(
  Lcs_stress_DomAsset   %in% c(20, 30) | 
  Lcs_stress_Utilities  %in% c(20, 30) | 
  Lcs_stress_Saving     %in% c(20, 30) | 
  Lcs_stress_BorrowCash %in% c(20, 30) ~ 1,
  TRUE ~ 0))
var_label(data$stress_coping_FS) <- "Did the HH engage in stress coping strategies?"

# Crisis strategies
data <- data %>% mutate(crisis_coping_FS = case_when(
  Lcs_crisis_ProdAssets %in% c(20, 30) | 
  Lcs_crisis_Health     %in% c(20, 30) | 
  Lcs_crisis_OutSchool  %in% c(20, 30) ~ 1,
  TRUE ~ 0))
var_label(data$crisis_coping_FS) <- "Did the HH engage in crisis coping strategies?"

# Emergency strategies
data <- data %>% mutate(emergency_coping_FS = case_when(
  Lcs_em_ResAsset   %in% c(20, 30) | 
  Lcs_em_Begged     %in% c(20, 30) | 
  Lcs_em_IllegalAct %in% c(20, 30) ~ 1,
  TRUE ~ 0))
var_label(data$emergency_coping_FS) <- "Did the HH engage in emergency coping strategies?"

# Coping behavior
data <- data %>% mutate(temp_nonmiss_number = rowSums(!is.na(select(., 
  Lcs_stress_DomAsset, Lcs_stress_Utilities, Lcs_stress_Saving, Lcs_stress_BorrowCash, 
  Lcs_crisis_ProdAssets, Lcs_crisis_Health, Lcs_crisis_OutSchool, Lcs_em_ResAsset, 
  Lcs_em_Begged, Lcs_em_IllegalAct))))

data <- data %>% mutate(Max_coping_behaviourFS = case_when(
  temp_nonmiss_number > 0 ~ 1,
  stress_coping_FS == 1   ~ 2,
  crisis_coping_FS == 1   ~ 3,
  emergency_coping_FS == 1~ 4,
  TRUE ~ NA_real_))
var_label(data$Max_coping_behaviourFS) <- "Summary of asset depletion"
val_lab(data$Max_coping_behaviourFS) <- num_lab("
             1 'HH not adopting coping strategies'
             2 'Stress coping strategies'
             3 'Crisis coping strategies'
             4 'Emergency coping strategies'
")

# Remove temporary variable
data <- data %>% select(-temp_nonmiss_number)

# Tabulate results
Max_coping_behaviourFS_table <- data %>% count(Max_coping_behaviourFS, sort = TRUE)
print(Max_coping_behaviourFS_table)

# End of Scripts