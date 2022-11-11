library(tidyverse)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/PROP_AAP_CRF_Sample_Survey.csv")

#assign variable and value labels
var_label(data$HHAsstSecurity) <- "Have you or any of your household members experienced any security challenge related to WFP assistance?"
val_lab(data$HHAsstSecurity) = num_lab("
             0 No
             1 Yes
             888 Don't know
")


#creates a table of the weighted percentage of HHAsstSecurity by
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed


HHAsstSecurity_table_wide <- data %>% 
  drop_na(HHAsstSecurity) %>%
  count(HHAsstSecurity_lab = as.character(HHAsstSecurity)) %>% # if weights are needed use instead the row below 
  #count(HHAsstSecurity_lab = as.character(HHAsstSecurity), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstSecurity_lab,
              values_from = Percentage,
              values_fill =  0) 