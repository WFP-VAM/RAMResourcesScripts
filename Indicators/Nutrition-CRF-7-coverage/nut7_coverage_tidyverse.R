library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/Nut_CRF_7_coverage_Sample_Survey/Nutrition_module_NutProg_submodule_RepeatNutProg.csv")

#can only download repeat csv data as zip file from moda with group names - will update this code to remove group names
#rename to remove group names
data <- data %>% rename(PNutProgPartic_yn = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgPartic_yn')


#assign variable and value labels
var_label(data$PNutProgPartic_yn) <- "Is participant enrolled in the ((insert name/description  of program, to be adapted locally)) programme?"
val_lab(data$PNutProgPartic_yn) = num_lab("
             0 No
             1 Yes
")


#creates a table of the weighted percentage of NutProgPartic_yn by
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed


NutProgPartic_yn_table_wide <- data %>% 
  drop_na(PNutProgPartic_yn) %>%
  count(PNutProgPartic_yn_lab = as.character(PNutProgPartic_yn)) %>% # if weights are needed use instead the row below 
  #count(PNutProgPartic_yn_lab = as.character(PNutProgPartic_yn), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = PNutProgPartic_yn_lab,
              values_from = Percentage,
              values_fill =  0) 