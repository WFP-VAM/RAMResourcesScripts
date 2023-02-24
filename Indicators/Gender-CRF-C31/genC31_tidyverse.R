library(tidyverse)
library(labelled)
library(expss)

#import dataset
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/Gender_CRF_C31_Sample_Survey.csv")


#assign variable and value labels 
var_label(data$HHAsstWFPRecCashYN1Y) <- "Did your household receive cash-based WFP assistance in the last 12 months?"
var_label(data$HHAsstWFPRecInKindYN1Y) <- "Did your household receive in-kind WFP assistance in the last 12 months?"
var_label(data$HHAsstCashDescWho) <- "Who in your household decides what to do with the cash/voucher given by WFP, such as when, where and what to buy, is it women, men or both?"
var_label(data$HHAsstInKindDescWho) <- "Who in your household decides what to do with the food given by WFP, such as when, where and what to buy, is it women, men or both?"


data <- data %>%
  mutate(across(c(HHAsstWFPRecCashYN1Y, HHAsstWFPRecInKindYN1Y), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1
  ))))

data <- data %>%
  mutate(across(c(HHAsstCashDescWho, HHAsstInKindDescWho), ~labelled(., labels = c(
    "Men" = "10",
    "Women" = "20",
    "Both together" = "30",
    "Not Applicable" = "n/a"
  ))))

#decision making - cash
HHAsstCashDescWho_table_wide <- data %>% 
  filter(HHAsstCashDescWho != "n/a") %>%
  count(HHAsstCashDescWho_lab = as_factor(HHAsstCashDescWho)) %>% # if weights are needed use instead the row below 
  #count(HHAsstCashDescWho_lab = as.character(HHAsstCashDescWho), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstCashDescWho_lab,
              values_from = Percentage,
              values_fill =  0) 

#decision making - inkind
HHAsstInKindDescWho_table_wide <- data %>% 
  filter(HHAsstInKindDescWho != "n/a") %>%
  count(HHAsstInKindDescWho_lab = as_factor(HHAsstInKindDescWho)) %>% # if weights are needed use instead the row below 
  #count(HHAsstInKindDescWho_lab = as.character(HHAsstInKindDescWho), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstInKindDescWho_lab,
              values_from = Percentage,
              values_fill =  0)
