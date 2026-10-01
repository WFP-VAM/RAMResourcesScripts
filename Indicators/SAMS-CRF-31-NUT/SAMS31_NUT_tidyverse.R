#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#         Nutritious Crop Production Increase Calculation (SAMS Indicator 31)
#------------------------------------------------------------------------------

# This script calculates the proportion of farmers reporting an increase in 
# nutritious crop production based on SAMS Indicator 31 guidelines.
# Detailed guidelines can be found in the SAMS documentation.

# This syntax is based on SPSS download version from MoDA.
# More details can be found in the background document at: 
# https://wfp.sharepoint.com/sites/CRF2022-2025/CRF%20Outcome%20indicators/Forms/AllItems.aspx

library(tidyverse)
library(labelled)
library(expss)
library(janitor)

# Add sample data
data  <- read_csv("~/GitHub/RAMResourcesScripts/Static/SAMS_CRF_31_NUT_Sample_Survey/SAMS_module_Indicator31_submodule_RepeatNutCrop.csv")
data2 <- read_csv("~/GitHub/RAMResourcesScripts/Static/SAMS_CRF_31_NUT_Sample_Survey/data.csv")

# Rename to remove group names
data <- data %>%
  rename(
    PSAMSNutCropName       = 'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropName',
    PSAMSNutCropName_oth   = 'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropName_oth',
    PSAMSNutCropQuant      = 'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropQuant',
    PSAMSNutCropQuantUnit  = 'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropQuantUnit',
    PSAMSNutCropIncr       = 'SAMS_module/Indicator31_submodule/RepeatNutCrop/PSAMSNutCropIncr',
    index                  = '_parent_index'
  )

data2 <- data2 %>%
  rename(
    RespSex = 'Demographic_module/DemographicBasic_submodule/RespSex',
    index   = '_index'
  )

# Assign variable and value labels
var_label(data2$RespSex)          <- "Sex of the Respondent"
var_label(data$PSAMSNutCropName)  <- "What is the name of crop?"
var_label(data$PSAMSNutCropQuant) <- "How much of this commodity did you produce in the last 12 months?"
var_label(data$PSAMSNutCropQuantUnit) <- "Enter unit of quantity produced"
var_label(data$PSAMSNutCropIncr)  <- "Did you produce more, less or the same amount of this nutritious crop in the last 12 months compared to the 12 months before that?"

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

# Join dataset "data" & "data2"
data <- data %>% left_join(data2, by = "index")

# Selecting farmers that grew "Crop 1" show proportion reporting an increase, decrease or the same amount of production as the year before
SAMS31_table_total_wide <- data %>%
  filter(PSAMSNutCropName == 1) %>%
  filter(PSAMSNutCropIncr != 9999) %>%
  drop_na(PSAMSNutCropIncr) %>%
  count(PSAMSNutCropIncr_lab = as.character(PSAMSNutCropIncr)) %>%
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>%
  select(-n) %>%
  pivot_wider(names_from = PSAMSNutCropIncr_lab,
              values_from = Percentage,
              values_fill = 0)

SAMS31_table_bysex_wide <- data %>%
  filter(PSAMSNutCropName == 1) %>%
  filter(PSAMSNutCropIncr != 9999) %>%
  group_by(RespSex_lab = as.character(RespSex)) %>%
  drop_na(PSAMSNutCropIncr) %>%
  count(PSAMSNutCropIncr_lab = as.character(PSAMSNutCropIncr)) %>%
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>%
  select(-n) %>%
  pivot_wider(names_from = PSAMSNutCropIncr_lab,
              values_from = Percentage,
              values_fill = 0)

# Print results
print(SAMS31_table_total_wide)
print(SAMS31_table_bysex_wide)

# End of Scripts