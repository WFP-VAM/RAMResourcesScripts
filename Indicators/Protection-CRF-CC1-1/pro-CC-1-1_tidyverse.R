#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                          Security Challenges Indicator
#------------------------------------------------------------------------------#

# This script processes the security challenges indicator by assessing 
# whether households have experienced any security challenge related to WFP assistance.

library(tidyverse)
library(expss)
library(labelled)

# Add sample data.
#data <- read_csv("~/GitHub/RAMResourcesScripts/Static/PROP_AAP_CRF_Sample_Survey.csv")

# Assign variable and value labels.
var_label(data$HHAsstSecurity) <- "Have you or any of your household members experienced any security challenge related to WFP assistance?"
val_lab(data$HHAsstSecurity) = num_lab("
             0 No
             1 Yes
             888 Don't know
")

# Create a table of the weighted percentage of HHAsstSecurity.
HHAsstSecurity_table_wide <- data %>% 
  drop_na(HHAsstSecurity) %>%
  count(HHAsstSecurity_lab = as.character(HHAsstSecurity)) %>% 
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstSecurity_lab,
              values_from = Percentage,
              values_fill =  0) 

# Print the table.
print(HHAsstSecurity_table_wide)

# End of Scripts.