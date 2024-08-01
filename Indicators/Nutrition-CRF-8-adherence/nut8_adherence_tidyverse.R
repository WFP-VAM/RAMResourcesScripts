#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                         NUT8 Adherence Indicator
#------------------------------------------------------------------------------#

# Note: This script processes the NUT8 adherence indicator by assessing 
# whether participants received an adequate number of distributions as per 
# program requirements.

library(tidyverse)
library(labelled)
library(expss)

# Add sample data.
#data <- read_csv("~/GitHub/RAMResourcesScripts/Static/Nut_CRF_8_adherence_Sample_Survey/Nutrition_module_NutProg_submodule_RepeatNutProg.csv")

# Can only download repeat CSV data as a zip file from MODA with group names.
# Rename to remove group names.
data <- data %>% rename(PNutProgCard = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgCard',
                        PNutProgShouldNbrCard = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgShouldNbrCard',
                        PNutProgDidNbrCard = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgDidNbrCard',
                        PNutProgShouldNbrNoCard = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgShouldNbrNoCard',
                        PNutProgDidNbrNoCard = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgDidNbrNoCard'
                        )

# Assign variable and value labels.
var_label(data$PNutProgCard)            <- "May I see participant's program participation card?"
var_label(data$PNutProgShouldNbrCard)   <- "Number of distributions entitled to - measured with participation card"
var_label(data$PNutProgDidNbrCard)      <- "Number of distributions received - measured with participation card"
var_label(data$PNutProgShouldNbrNoCard) <- "Number of distributions entitled to - measured without participation card"
var_label(data$PNutProgDidNbrNoCard)    <- "Number of distributions received - measured without participation card"

val_lab(data$PNutProgCard) = num_lab("
             0 No
             1 Yes
")

# Create variable which classifies if participant received 66% or more of planned distributions.
data <- data %>% mutate(NutProgRecAdequate = case_when(
  PNutProgCard == 1 & ((PNutProgDidNbrCard / PNutProgShouldNbrCard) >= .66) ~ 1,
  PNutProgCard == 0 & ((PNutProgDidNbrNoCard / PNutProgShouldNbrNoCard) >= .66) ~ 1,
  TRUE ~ 0
))
var_label(data$NutProgRecAdequate) <- "Participant received adequate number of distributions?"
val_lab(data$NutProgRecAdequate) = num_lab("
             0 No
             1 Yes
")

# Create a table of the weighted percentage of NutProgRecAdequate.
NutProgRecAdequate_table_wide <- data %>%
  drop_na(NutProgRecAdequate) %>%
  count(NutProgRecAdequate_lab = as.character(NutProgRecAdequate)) %>%
  # Use the line below if weights are needed.
  # count(NutProgRecAdequate_lab = as.character(NutProgRecAdequate), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>%
  select(-n) %>%
  pivot_wider(names_from = NutProgRecAdequate_lab, values_from = Percentage, values_fill = 0)

# End of Scripts.