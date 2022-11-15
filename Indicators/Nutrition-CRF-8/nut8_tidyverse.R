library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/Nut_CRF_8_Sample_Survey/Nutrition_module_NutProg_submodule_RepeatNutProg.csv")

#can only download repeat csv data as zip file from moda with group names - will update this code to remove group names
#rename to remove group names
data <- data %>% rename(PNutProgCard = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgCard',
                        PNutProgShouldNbrCard = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgShouldNbrCard',
                        PNutProgDidNbrCard = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgDidNbrCard',
                        PNutProgShouldNbrNoCard = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgShouldNbrNoCard',
                        PNutProgDidNbrNoCard = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgDidNbrNoCard'
                        )

#assign variable labels 
var_label(data$PNutProgCard) <- "May I see participant's program participation card?"
var_label(data$PNutProgShouldNbrCard) <- "number of distributions entitled to - measured with participation card"
var_label(data$PNutProgDidNbrCard) <- "number of distributions received - measured with participation card"
var_label(data$PNutProgShouldNbrNoCard) <- "number of distributions entitled to - measured without participation card"
var_label(data$PNutProgDidNbrNoCard) <- "number of distributions received - measured without participation card"

val_lab(data$PNutProgCard) = num_lab("
             0 No
             1 Yes
")

#create variable which classifies if participant received 66% or more of planned distributions 
data <- data %>% mutate(NutProgRecAdequate = case_when(
  PNutProgCard == 1 & ((PNutProgDidNbrCard / PNutProgShouldNbrCard) >= .66) ~ 1,
  PNutProgCard == 0 & ((PNutProgDidNbrNoCard / PNutProgShouldNbrNoCard) >= .66) ~ 1,
  TRUE ~ 0
))
var_label(data$NutProgRecAdequate) <- "Participant recieved adequate number of distributions?"
val_lab(data$NutProgRecAdequate) = num_lab("
             0 No
             1 Yes
")

#creates a table of the weighted percentage of NutProgRecAdequate by
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed

NutProgRecAdequate_table_wide <- data %>% 
  drop_na(NutProgRecAdequate) %>%
  count(NutProgRecAdequate_lab = as.character(NutProgRecAdequate)) %>% # if weights are needed use instead the row below 
  #count(NutProgRecAdequate_lab = as.character(NutProgRecAdequate), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = NutProgRecAdequate_lab,
              values_from = Percentage,
              values_fill =  0) 