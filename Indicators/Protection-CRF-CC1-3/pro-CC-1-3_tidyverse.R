#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                    Respect and Dignity in WFP Programmes
#------------------------------------------------------------------------------#

# This script processes the indicators related to whether households feel 
# respected and dignified while engaging in WFP programmes.

library(tidyverse)
library(expss)
library(labelled)

# Add sample data.
#data <- read_csv("Static/PROP_AAP_CRF_Sample_Survey.csv")

# Assign variable and value labels.
var_label(data$HHAsstRespect) <- "Do you think WFP and/or partner staff have treated you and members of your household respectfully?"
var_label(data$HHDTPDign)     <- "Do you think the conditions of WFP programme sites are dignified?"

data <- data %>%
  mutate(across(c(HHAsstRespect, HHDTPDign), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1
  ))))

# Calculate indicator and assign variable label & name.
data <- data %>% mutate(HHAsstRespectDign = case_when(
  HHAsstRespect == 1 & HHDTPDign == 1 ~ 1,
  TRUE ~ 0
))
var_label(data$HHAsstRespectDign) <- "Treated with respect while engaging in WFP programs"
val_lab(data$HHAsstRespectDign) = num_lab("
             0 No
             1 Yes
")

# Create a table of the weighted percentage of HHAsstRespectDign.
HHAsstRespectDign_table_wide <- data %>% 
  drop_na(HHAsstRespectDign) %>%
  count(HHAsstRespectDign_lab = as.character(HHAsstRespectDign)) %>% 
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstRespectDign_lab,
              values_from = Percentage,
              values_fill =  0) 

# Print the table.
print(HHAsstRespectDign_table_wide)

# End of Scripts.