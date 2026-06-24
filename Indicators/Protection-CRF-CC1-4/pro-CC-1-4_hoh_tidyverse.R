#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                    Household Level Assistance (hoh)
#------------------------------------------------------------------------------#

# This script processes the indicators related to the receipt of different types 
# of assistance by households and the disability status of the head of the household.

library(tidyverse)
library(labelled)
library(expss)

# Add sample data.
#data <- read_csv("~/GitHub/RAMResourcesScripts/Static/PRO_WG_Sample_Survey/HoHMethod/PRO_WG_HoH_Sample_Survey.csv")

# Assign variable and value labels.
var_label(data$HHAsstWFPRecCashYN1Y)     <- "Did your household receive cash-based WFP assistance in the last 12 months?"
var_label(data$HHAsstWFPRecInKindYN1Y)   <- "Did your household receive in-kind WFP assistance in the last 12 months?"
var_label(data$HHAsstWFPRecCapBuildYN1Y) <- "Did you household receive WFP capacity building assistance in the last 12 months?"

var_label(data$HHHSex) <- "What is the sex of the head of the household?"
var_label(data$HHHAge) <- "Age of the head of the household"

var_label(data$HHHDisabSee)        <- "Does the head of household have difficulty seeing, even if wearing glasses? Would you say…"
var_label(data$HHHDisabHear)       <- "Does the head of household have difficulty hearing, even if using a hearing aid(s)? Would you say…"
var_label(data$HHHDisabWalk)       <- "Does the head of household have difficulty walking or climbing steps? Would you say…"
var_label(data$HHHDisabRemember)   <- "Does the head of household have difficulty remembering or concentrating? Would you say…"
var_label(data$HHHDisabUnderstand) <- "Using his or her usual language, does the head of household have difficulty communicating, for example understanding or being understood? Would you say…"
var_label(data$HHHDisabWash)       <- "Does the head of household have difficulty with self-care, such as washing all over or dressing? Would you say…"

data <- data %>%
  mutate(across(c(HHAsstWFPRecCashYN1Y, HHAsstWFPRecInKindYN1Y, HHAsstWFPRecCapBuildYN1Y), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1
  ))))

val_lab(data$HHHSex) = num_lab("
             0 Female
             1 Male
")

data <- data %>%
  mutate(across(c(HHHDisabSee, HHHDisabHear, HHHDisabWalk, HHHDisabRemember, HHHDisabUnderstand, HHHDisabWash), ~labelled(., labels = c(
    "No difficulty" = 1,
    "Some difficulty" = 2,
    "A lot of difficulty" = 3,
    "Cannot do at all" = 4,
    "Don't know" = 888,
    "Refuse" = 999
  ))))

# Calculate whether the respondent had "A lot of difficulty" or "Cannot do at all" for any of the 6 questions.
data <- data %>% mutate(HHHDisabCat3 = case_when(
  between(HHHDisabSee, 3, 4) | between(HHHDisabHear, 3, 4) | between(HHHDisabWalk, 3, 4) | between(HHHDisabRemember, 3, 4) | between(HHHDisabUnderstand, 3, 4) | between(HHHDisabWash, 3, 4) ~ 1,
  TRUE ~ 0
))

val_lab(data$HHHDisabCat3) = num_lab("
             0 without disability (category 3 criteria)
             1 with disability (category 3 criteria)
")

# Create tables of the weighted percentage of type of assistance received by HHHDisabCat3.

# Cash-based assistance.
HHAsstWFPRecCashYN1Y_table_wide <- data %>% 
  group_by(HHHDisabCat3_lab = as_factor(HHHDisabCat3)) %>% 
  drop_na(HHAsstWFPRecCashYN1Y) %>%
  count(HHAsstWFPRecCashYN1Y_lab = as_factor(HHAsstWFPRecCashYN1Y)) %>% 
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstWFPRecCashYN1Y_lab,
              values_from = Percentage,
              values_fill =  0) 

# In-kind assistance.
HHAsstWFPRecInKindYN1Y_table_wide <- data %>% 
  group_by(HHHDisabCat3_lab = as_factor(HHHDisabCat3)) %>% 
  drop_na(HHAsstWFPRecInKindYN1Y) %>%
  count(HHAsstWFPRecInKindYN1Y_lab = as_factor(HHAsstWFPRecInKindYN1Y)) %>% 
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstWFPRecInKindYN1Y_lab,
              values_from = Percentage,
              values_fill =  0) 

# Capacity building assistance.
HHAsstWFPRecCapBuildYN1Y_table_wide <- data %>% 
  group_by(HHHDisabCat3_lab = as_factor(HHHDisabCat3)) %>% 
  drop_na(HHAsstWFPRecCapBuildYN1Y) %>%
  count(HHAsstWFPRecCapBuildYN1Y_lab = as_factor(HHAsstWFPRecCapBuildYN1Y)) %>% 
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstWFPRecCapBuildYN1Y_lab,
              values_from = Percentage,
              values_fill =  0) 

# End of Scripts.