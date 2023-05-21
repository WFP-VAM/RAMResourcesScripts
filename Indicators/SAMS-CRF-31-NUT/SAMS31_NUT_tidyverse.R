library(tidyverse)
library(labelled)
library(expss)
library(janitor)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/SAMS_CRF_31_NUT_Sample_Survey/SAMS_module_Indicator31_submodule_RepeatNutCrop.csv")
data2 <- read_csv("~/GitHub/RAMResourcesScripts/Static/SAMS_CRF_31_NUT_Sample_Survey/data.csv")

#can only download repeat csv data as zip file from moda with group names - will update this code to remove group names
#rename to remove group names
data <- data %>% rename(PSAMSNutCropName = 'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropName')
data <- data %>% rename(PSAMSNutCropName_oth = 'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropName_oth')
data <- data %>% rename(PSAMSNutCropQuant = 'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropQuant')
data <- data %>% rename(PSAMSNutCropQuantUnit = 'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropQuantUnit')
data <- data %>% rename(PSAMSNutCropIncr = 'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropIncr')
data <- data %>% rename(index = '_parent_index')

data2 <- data2 %>% rename(RespSex = 'Demographic_module/DemographicBasic_submodule/RespSex')
data2 <- data2 %>% rename(index = '_index')

#assign variable and value labels
var_label(data2$RespSex) <- "Sex of the Respondent"
var_label(data$PSAMSNutCropName) <- "What is the name of crop?"
var_label(data$PSAMSNutCropQuant) <- "How much of this commodity did you produce in the last 12 months?"
var_label(data$PSAMSNutCropQuantUnit) <- "Enter unit of quantity produced"
var_label(data$PSAMSNutCropIncr) <- "Did you produce more, less or the same amount of this nutritious crop in the last 12 months compared to the 12 months before that?"


val_lab(data2$RespSex) = num_lab("
             0 Female
             1 Male
")
val_lab(data$PSAMSNutCropName) = num_lab("
             1 Crop 1 
             2 Crop 2
             3 Crop 3
             4 Crop 4
             5 Crop 5
             999 Other
")
val_lab(data$PSAMSNutCropIncr) = num_lab("
             1 More
             2 Less
             3 The same
             9999 Not applicable
")

#join dataset "data" & "data2"
data <- data %>% left_join(data2, by = "index")

#selecting farmers that grew "Crop 1" show proportion reporting an increase, decrease or the same amount of production as the year before
SAMS31_table_total_wide <- data %>% filter(PSAMSNutCropName == 1) %>% filter(PSAMSNutCropIncr != 9999) %>%
  drop_na(PSAMSNutCropIncr) %>%
  count(PSAMSNutCropIncr_lab = as.character(PSAMSNutCropIncr)) %>% # if weights are needed use instead the row below 
   mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = PSAMSNutCropIncr_lab,
              values_from = Percentage,
              values_fill =  0) 

#selecting farmers that grew "Crop 1" show proportion reporting an increase, decrease or the same amount of production as the year before
SAMS31_table_bysex_wide <- data %>% filter(PSAMSNutCropName == 1) %>% filter(PSAMSNutCropIncr != 9999) %>% group_by(RespSex_lab = as.character(RespSex)) %>%
  drop_na(PSAMSNutCropIncr) %>%
  count(PSAMSNutCropIncr_lab = as.character(PSAMSNutCropIncr)) %>% # if weights are needed use instead the row below 
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = PSAMSNutCropIncr_lab,
              values_from = Percentage,
              values_fill =  0) 



