library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/Nut_CRF_7_Sample_Survey/Nutrition_module_NutProg_submodule_RepeatNutProg.csv")

#can only download repeat data as zip file from moda with group names - will update this code to remove group names
data <- data %>% rename(NutProgPartic_yn = 'Nutrition_module/NutProg_submodule/RepeatNutProg/NutProgPartic_yn')


#assign variable and value labels
var_label(data$NutProgPartic_yn) <- "Is ${NutProgParticName} enrolled in the ((insert name/description  of program, to be adapted locally)) programme?"
val_lab(data$NutProgPartic_yn) = num_lab("
             0 No
             1 Yes
")


#creates a table of the weighted percentage of NutProgPartic_yn by
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed


NutProgPartic_yn_table_wide <- data %>% 
  drop_na(NutProgPartic_yn) %>%
  count(NutProgPartic_yn_lab = as.character(NutProgPartic_yn)) %>% # if weights are needed use instead the row below 
  #count(NutProgPartic_yn_lab = as.character(NutProgPartic_yn), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = NutProgPartic_yn_lab,
              values_from = Percentage,
              values_fill =  0) 