library(tidyverse)
library(labelled)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/PROP_AAP_CRF_Sample_Survey.csv")

#assign variable and value labels
var_label(data$HHAsstKnowEnt) <- "Have you been told exactly what you are entitled to receive in terms of commodities/quantities or cash? Please describe your entitlements"
var_label(data$HHAsstKnowPeople) <- "Do you know how people were chosen to receive assistance? Please describe how they were chosen"
var_label(data$HHAsstRecInfo) <- "Did you receive the information in a way that you could easily understand?"
var_label(data$HHAsstReportMisc) <- "Do you know how to report misconduct from WFP or partners, including asking for (sexual) favours or money in exchange of assistance?"

data <- data %>%
  mutate(across(c(HHAsstKnowEnt, HHAsstKnowPeople, HHAsstReportMisc), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1
  ))))
data <- data %>%
  mutate(across(c(HHAsstRecInfo), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1,
    "I never received information" = 2
  ))))


#calculate indicator and assign variable label & name
data <- data %>% mutate(HHAcessInfo = case_when(
  HHAsstKnowEnt == 1 & HHAsstKnowPeople == 1 & HHAsstRecInfo == 1 & HHAsstReportMisc == 1 ~ 1,
  TRUE ~ 0
))
var_label(data$HHAcessInfo) <- "Provided with accessible information about the programme"
val_lab(data$HHAcessInfo) = num_lab("
             0 No
             1 Yes
")


#creates a table of the weighted percentage of HHAcessInfo by
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed


HHAcessInfo_table_wide <- data %>% 
  drop_na(HHAcessInfo) %>%
  count(HHAcessInfo_lab = as.character(HHAcessInfo)) %>% # if weights are needed use instead the row below 
  #count(HHAcessInfo_lab = as.character(HHAcessInfo), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAcessInfo_lab,
              values_from = Percentage,
              values_fill =  0) 

  