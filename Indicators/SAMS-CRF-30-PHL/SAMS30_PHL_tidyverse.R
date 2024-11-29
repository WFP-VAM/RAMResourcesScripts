#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#                Post-Harvest Loss Calculation (SAMS Indicator 30)
#------------------------------------------------------------------------------

# This script calculates the Post-Harvest Loss (PHL) based on SAMS Indicator 30 guidelines.
# Detailed guidelines can be found in the SAMS documentation.

# This syntax is based on SPSS download version from MoDA.
# More details can be found in the background document at: 
# https://wfp.sharepoint.com/sites/CRF2022-2025/CRF%20Outcome%20indicators/Forms/AllItems.aspx

library(tidyverse)
library(labelled)
library(expss)

# add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/SAMS_CRF_30_PHL_Sample_Survey/SAMS_module_Indicator30_submodule_RepeatSAMSPHL.csv")

# rename to remove group names
data <- data %>% rename(PSAMSPHLCommName         = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommName',
                        PSAMSPHLCommName_oth     = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommName_oth',
                        PSAMSPHLCommClass        = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommClass',
                        PSAMSPHLCommQntHand      = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntHand',
                        PSAMSPHLCommQntHandUnit  = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntHandUnit',
                        PSAMSPHLCommQntHandUnit_oth = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntHandUnit_oth',
                        PSAMSPHLCommQntLost      = 'SAMS_module/Indicator30_submodule/RepeatSAMSPHL/PSAMSPHLCommQntLost',
                        PSAMSPHLFarmerNum        = '_parent_index')

# assign variable and value labels
var_label(data$PSAMSPHLCommName)        <- "What is the name of commodity?"
var_label(data$PSAMSPHLCommClass)       <- "Which of the following groups does this commodity belong to?"
var_label(data$PSAMSPHLCommQntHand)     <- "What is the amount of this commodity initially stored?"
var_label(data$PSAMSPHLCommQntHandUnit) <- "Enter unit of measure."
var_label(data$PSAMSPHLCommQntLost)     <- "Of the total quantity you stored how much was lost?"

# Calculate % loss per row
data <- data %>% mutate(perc_loss = round((PSAMSPHLCommQntLost / PSAMSPHLCommQntHand) * 100, 1))

# Average loss per farmer
avglossperfarmer_table <- data %>% group_by(PSAMSPHLFarmerNum) %>% summarise(avglossperfarmer = mean(perc_loss))

# Average across farmers
average_phl_loss_table <- avglossperfarmer_table %>% summarise(average_phl_loss = mean(avglossperfarmer))

#creates a table of the weighted percentage of nutprogpartic_yn by
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed

nutprogpartic_yn_table_wide <- data %>% 
  drop_na(pnutprogpartic_yn) %>%
  count(pnutprogpartic_yn_lab = as.character(pnutprogpartic_yn)) %>% # if weights are needed use instead the row below 
  #count(pnutprogpartic_yn_lab = as.character(pnutprogpartic_yn), wt = nameofweightvariable)
  mutate(percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = pnutprogpartic_yn_lab,
              values_from = percentage,
              values_fill =  0) 

# End of Scripts