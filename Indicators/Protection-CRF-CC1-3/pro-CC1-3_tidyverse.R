library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("Static/PROP_AAP_CRF_Sample_Survey.csv")

#assign variable and value labels
var_label(data$HHAsstRespect) <- "Do you think WFPandor partner staff have treated you and members of your household respectfully?"
var_label(data$HHDTPDign) <- "Do you think the conditions of WFP programme sites are dignified?"

data <- data %>%
  mutate(across(c(HHAsstRespect, HHDTPDign), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1
    ))))

#calculate indicator and assign variable label & name
data <- data %>% mutate(HHAsstRespectDign = case_when(
  HHAsstRespect == 1 & HHDTPDign == 1 ~ 1,
  TRUE ~ 0
))
var_label(data$HHAsstRespectDign) <- "Treated with respect while engaging in WFP programs"
val_lab(data$HHAsstRespectDign) = num_lab("
             0 No
             1 Yes
")


#creates a table of the weighted percentage of HHAsstRespectDign by
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed


HHAsstRespectDign_table_wide <- data %>% 
  drop_na(HHAsstRespectDign) %>%
  count(HHAsstRespectDign_lab = as.character(HHAsstRespectDign)) %>% # if weights are needed use instead the row below 
  #count(HHAsstRespectDign_lab = as.character(HHAsstRespectDign), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstRespectDign_lab,
              values_from = Percentage,
              values_fill =  0) 

  
