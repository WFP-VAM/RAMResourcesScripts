library(tidyverse)
library(expss)
library(labelled)

#add sample data
data <- read_csv("Static/PROP_AAP_CRF_Sample_Survey.csv")

#assign variable and value labels
var_label(data$HHAsstAccess) <- "Have you or any member of your household been unable to access WFP assistance one or more times?"
val_lab(data$HHAsstAccess) = num_lab("
             0 No
             1 Yes
             888 Don't know
")


#creates a table of the weighted percentage of HHAsstAccess by
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed


HHAsstAccess_table_wide <- data %>% 
  drop_na(HHAsstAccess) %>%
  count(HHAsstAccess_lab = as.character(HHAsstAccess)) %>% # if weights are needed use instead the row below 
  #count(HHAsstAccess_lab = as.character(HHAsstAccess), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = HHAsstAccess_lab,
              values_from = Percentage,
              values_fill =  0) 

  
