#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                         Access Challenges Indicator
#------------------------------------------------------------------------------#

# This script processes the access challenges indicator by assessing 
# whether households have been unable to access WFP assistance one or more times.

library(tidyverse)
library(expss)
library(labelled)

# Add sample data.
#data <- read_csv("Static/PROP_AAP_CRF_Sample_Survey.csv")

# Assign variable and value labels.
var_label(data$HHAsstAccess) <- "Have you or any member of your household been unable to access WFP assistance one or more times?"
val_lab(data$HHAsstAccess) = num_lab("
             0 No
             1 Yes
             888 Don't know
")

# Create a table of the weighted percentage of HHAsstAccess.
HHAsstAccess_table_wide <- data %>% 
  drop_na(HHAsstAccess) %>%
  count(HHAsstAccess_lab = as.character(HHAsstAccess)) %>% 
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstAccess_lab,
              values_from = Percentage,
              values_fill =  0) 

# Print the table.
print(HHAsstAccess_table_wide)

# End of Scripts.