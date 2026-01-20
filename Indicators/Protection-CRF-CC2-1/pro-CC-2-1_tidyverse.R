#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                Access to Information in WFP Programmes (pro-CC-2-1)
#------------------------------------------------------------------------------#

# This script processes the indicators related to households' access to information 
# about their entitlements, selection criteria, information comprehension, and 
# reporting misconduct in WFP programmes.

library(tidyverse)
library(labelled)
library(expss)

# Add sample data.
#data <- read_csv("Static/PROP_AAP_CRF_Sample_Survey.csv")

# Assign variable and value labels.
var_label(data$HHAsstKnowEnt)    <- "Have you been told exactly what you are entitled to receive in terms of commodities/quantities or cash? Please describe your entitlements"
var_label(data$HHAsstKnowPeople) <- "Do you know how people were chosen to receive assistance? Please describe how they were chosen"
var_label(data$HHAsstRecInfo)    <- "Did you receive the information in a way that you could easily understand?"
var_label(data$HHAsstReportMisc) <- "Do you know how to report misconduct from WFP or partners, including asking for (sexual) favours or money in exchange of assistance?"

data <- data %>%
  mutate(across(c(HHAsstKnowEnt, HHAsstKnowPeople, HHAsstReportMisc), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1
  )))) %>%
  mutate(across(c(HHAsstRecInfo), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1,
    "I never received information" = 2
  ))))

# Calculate indicator and assign variable label & name.
data <- data %>% mutate(HHAcessInfo = case_when(
  HHAsstKnowEnt == 1 & HHAsstKnowPeople == 1 & HHAsstRecInfo == 1 & HHAsstReportMisc == 1 ~ 1,
  TRUE ~ 0
))
var_label(data$HHAcessInfo) <- "Provided with accessible information about the programme"
val_lab(data$HHAcessInfo) = num_lab("
             0 No
             1 Yes
")

# Create a table of the weighted percentage of HHAcessInfo.
HHAcessInfo_table_wide <- data %>% 
  drop_na(HHAcessInfo) %>%
  cou