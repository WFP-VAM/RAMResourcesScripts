library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/SAMS_CRF_30_PHL_Sample_Survey/SAMS_module_Indicator30_submodule_RepeatSAMSPHL.csv")

#can only download repeat csv data as zip file from moda with group names - will update this code to remove group names
#rename to remove group names
data <- data %>% rename(PSAMSPHLCommName = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommName')
data <- data %>% rename(PSAMSPHLCommName_oth = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommName_oth')
data <- data %>% rename(PSAMSPHLCommClass = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommClass')
data <- data %>% rename(PSAMSPHLCommQntHand = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntHand')
data <- data %>% rename(PSAMSPHLCommQntHandUnit = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntHandUnit')
data <- data %>% rename(PSAMSPHLCommQntHandUnit_oth = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntHandUnit_oth')
data <- data %>% rename(PSAMSPHLCommQntLost = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntLost')
#also rename the _parent_index variable to farmer number 
data <- data %>% rename(PSAMSPHLFarmerNum = '_parent_index')

#assign variable and value labels
var_label(data$PSAMSPHLCommName) <- "What is the name of commodity?"
var_label(data$PSAMSPHLCommClass) <- "Which of the following groups does this commodity belong to?"
var_label(data$PSAMSPHLCommQntHand) <- "What is the amount of this commodity initially stored?"
var_label(data$PSAMSPHLCommQntHandUnit) <- "Enter unit of measure."
var_label(data$PSAMSPHLCommQntLost) <- "Of the total quantity you stored how much was lost?"

#Calculate % loss per row
data <- data %>% mutate(perc_loss = round((PSAMSPHLCommQntLost /(PSAMSPHLCommQntHand) * 100),1))
#Average loss per farmer 
avglossperfarmer_table <- data %>% group_by(PSAMSPHLFarmerNum) %>% summarise(avglossperfarmer = mean(perc_loss))
#Average across farmers
average_phl_loss_table <- avglossperfarmer_table %>% summarise(average_phl_loss = mean(avglossperfarmer))









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