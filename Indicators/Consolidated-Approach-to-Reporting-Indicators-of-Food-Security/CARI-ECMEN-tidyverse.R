#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#     Consolidated Approach for Reporting Indicators of Food Security (CARI)
#                CALCULATE CARI using FCS, rCSI, LCS and ECMEN
#------------------------------------------------------------------------------#

# Note that there are two ways to calculate CARI - using ECMEN or FES. This syntax 
# file is for calculating CARI using ECMEN (version excluding assistance). However, 
# please navigate to the script for CARI using FES as relevant. 
# Guidance on CARI can be found here: 
# https://www.wfp.org/publications/consolidated-approach-reporting-indicators-food-security-cari-guidelines.

# Note: this syntax file is based on the assumption that the scripts of the various 
# indicators that compose this version of the CARI (FCS, rCSI, LCS-FS, ECMEN) have 
# already been run. You can find these scripts here: 
# https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Indicators.
# The following variables should have been defined before running this file:
#   FCSCat21 and/or FCSCat28 
#   rCSI
#   Max_coping_behaviourFS	
#   ECMEN_exclAsst 
#   ECMEN_exclAsst_SMEB.	

library(tidyverse)
library(labelled)
library(expss)

# Load data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/CARI_FS_Sample_Survey.csv")

# Assign variable and value labels
var_label(data$FCSCat21) <- "FCS Categories (21/35 thresholds)"
var_label(data$rCSI) <- "Reduced Coping Strategies Index"
var_label(data$Max_coping_behaviourFS) <- "Max Coping Behaviour (FS)"
var_label(data$ECMEN_exclAsst) <- "Expenditure Capacity Measure Excluding Assistance"
var_label(data$ECMEN_exclAsst_SMEB) <- "Expenditure Capacity Measure Excluding Assistance (SMEB)"

# Process FCS for CARI computation
data <- data %>%
  mutate(FCS_4pt = recode(FCSCat21, `1` = 4, `2` = 3, `3` = 1),
         FCS_4pt = ifelse(rCSI >= 4 & FCS_4pt == 1, 2, FCS_4pt))

val_lab(data$FCS_4pt) <- num_lab("
             1 Acceptable
             2 Acceptable and rCSI>4
             3 Borderline
             4 Poor
")

# Process ECMEN for CARI computation
data <- data %>%
  mutate(ECMEN_MEB = case_when(
    ECMEN_exclAsst == 1 ~ 1,
    ECMEN_exclAsst == 0 & ECMEN_exclAsst_SMEB == 1 ~ 2,
    ECMEN_exclAsst == 0 & ECMEN_exclAsst_SMEB == 0 ~ 3
  ),
  ECMEN_class_4pt = recode(ECMEN_MEB, `1` = 1, `2` = 3, `3` = 4))

val_lab(data$ECMEN_class_4pt) <- num_lab("
             1 Least vulnerable
             3 Vulnerable
             4 Highly vulnerable
")

# Computation of CARI
data <- data %>%
  mutate(Mean_coping_capacity_ECMEN = rowMeans(select(., Max_coping_behaviourFS, ECMEN_class_4pt), na.rm = TRUE),
         CARI_unrounded_ECMEN = rowMeans(select(., FCS_4pt, Mean_coping_capacity_ECMEN), na.rm = TRUE),
         CARI_ECMEN = round(CARI_unrounded_ECMEN))

var_label(data$CARI_ECMEN) <- "CARI classification (using ECMEN)"
val_lab(data$CARI_ECMEN) <- num_lab("
             1 Food secure
             2 Marginally food secure
             3 Moderately food insecure
             4 Severely food insecure
")

# Frequencies of CARI_ECMEN
cari_ecmen_freq <- data %>%
  count(CARI_ECMEN) %>%
  mutate(percentage = n / sum(n) * 100)
print(cari_ecmen_freq)

# Create population distribution table
pop_distribution_table <- data %>%
  group_by(ECMEN_class_4pt, FCS_4pt, Max_coping_behaviourFS) %>%
  summarise(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)
print(pop_distribution_table)

# Drop variables that are not needed
data <- data %>%
  select(-ECMEN_MEB, -Mean_coping_capacity_ECMEN, -CARI_unrounded_ECMEN)

# End of Scripts