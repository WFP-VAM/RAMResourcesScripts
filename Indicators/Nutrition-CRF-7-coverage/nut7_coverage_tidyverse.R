#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#                         NUT7 Coverage Indicator
#------------------------------------------------------------------------------#

# Note: This script processes the NUT7 coverage indicator by assessing participant 
# enrollment in a specified nutrition program.

library(tidyverse)
library(labelled)
library(expss)

# Add sample data.
#data <- read_csv("~/GitHub/RAMResourcesScripts/Static/Nut_CRF_7_coverage_Sample_Survey/Nutrition_module_NutProg_submodule_RepeatNutProg.csv")

# Can only download repeat CSV data as a zip file from MODA with group names.
# Rename to remove group names.
data <- data %>% rename(PNutProgPartic_yn = 'Nutrition_module/NutProg_submodule/RepeatNutProg/PNutProgPartic_yn')

# Assign variable and value labels.
var_label(data$PNutProgPartic_yn) <- "Is participant enrolled in the ((insert name/description of program, to be adapted locally)) programme?"
val_lab(data$PNutProgPartic_yn) = num_lab("
             0 No
             1 Yes
")

# Create a table of the weighted percentage of NutProgPartic_yn.
NutProgPartic_yn_table_wide <- data %>%
  drop_na(PNutProgPartic_yn) %>%
  count(PNutProgPartic_yn_lab = as.character(PNutProgPartic_yn)) %>%
  # Use the line below if weights are needed.
  # count(PNutProgPartic_yn_lab = as.character(PNutProgPartic_yn), wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>%
  select(-n) %>%
  pivot_wider(names_from = PNutProgPartic_yn_lab, values_from = Percentage, values_fill = 0)

# End of Scripts.