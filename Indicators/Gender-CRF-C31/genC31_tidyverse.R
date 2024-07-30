#------------------------------------------------------------------------------#
#	                          WFP Standardized Scripts
#                  Calculating Gender-Related Indicator (genC31)
#------------------------------------------------------------------------------#

# This script calculates the gender-related indicator (genC31) based on 
# household decision-making regarding WFP assistance received.

# Load Packages
library(tidyverse)
library(labelled)
library(expss)

# Import dataset
#data <- read_csv("~/GitHub/RAMResourcesScripts/Static/Gender_CRF_C31_Sample_Survey.csv")

# Assign variable and value labels 
var_label(data$HHAsstWFPRecCashYN1Y)    <- "Did your household receive cash-based WFP assistance in the last 12 months?"
var_label(data$HHAsstWFPRecInKindYN1Y)  <- "Did your household receive in-kind WFP assistance in the last 12 months?"
var_label(data$HHAsstCashDescWho)       <- "Who in your household decides what to do with the cash/voucher given by WFP, such as when, where and what to buy, is it women, men or both?"
var_label(data$HHAsstInKindDescWho)     <- "Who in your household decides what to do with the food given by WFP, such as when, where and what to buy, is it women, men or both?"

data <- data %>%
  mutate(across(c(HHAsstWFPRecCashYN1Y, HHAsstWFPRecInKindYN1Y), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1
  ))))

data <- data %>%
  mutate(across(c(HHAsstCashDescWho, HHAsstInKindDescWho), ~labelled(., labels = c(
    "Men" = 10,
    "Women" = 20,
    "Both together" = 30,
    "Not Applicable" = "n/a"
  ))))

# Decision making - cash
HHAsstCashDescWho_table_wide <- data %>% 
  filter(HHAsstCashDescWho != "n/a") %>%
  count(HHAsstCashDescWho_lab = as_factor(HHAsstCashDescWho)) %>%
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% 
  select(-n) %>%
  pivot_wider(names_from = HHAsstCashDescWho_lab,
              values_from = Percentage,
              values_fill =  0)

# Decision making - in-kind
HHAsstInKindDescWho_table_wide <- data %>% 
  filter(HHAsstInKindDescWho != "n/a") %>%
  count(HHAsstInKindDescWho_lab = as_factor(HHAsstInKindDescWho)) %>%
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% 
  select(-n) %>%
  pivot_wider(names_from = HHAsstInKindDescWho_lab,
              values_from = Percentage,
              values_fill =  0)

# End of Scripts