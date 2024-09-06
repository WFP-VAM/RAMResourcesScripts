#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#     Consolidated Approach for Reporting Indicators of Food Security (CARI)
#                CALCULATE CARI using FCS, rCSI, LCS and FES
#------------------------------------------------------------------------------#

# Note that there are two ways to calculate CARI - using ECMEN or FES. This script 
# is for calculating CARI using FES. However, please navigate to the script 
# for CARI using ECMEN as relevant. 
# Guidance on CARI can be found here: 
# https://www.wfp.org/publications/consolidated-approach-reporting-indicators-food-security-cari-guidelines.

# Note: this script is based on the assumption that the scripts of the various 
# indicators that compose this version of the CARI (FCS, rCSI, LCS-FS, FES) have 
# already been run. You can find these scripts here: 
# https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Indicators.
# The following variables should have been defined before running this file:
#   FCSCat21 and/or FCSCat28 
#   rCSI
#   Max_coping_behaviourFS	
#   FES
#   Foodexp_4pt.		

library(dplyr)
library(tidyr)
library(labelled)

# Create FCS_4pt for CARI calculation
data <- data %>% 
  mutate(FCS_4pt = case_when(
    FCSCat21 == 1 ~ 4,
    FCSCat21 == 2 ~ 3,
    FCSCat21 == 3 ~ 1
  ))

var_label(data$FCS_4pt) <- "4pt FCG"
val_labels(data$FCS_4pt) <- c(Acceptable = 1, Borderline = 3, Poor = 4)

# Combine rCSI with FCS_4pt for CARI calculation (current consumption)
data <- data %>% 
  mutate(FCS_4pt = if_else(rCSI >= 4 & FCS_4pt == 1, 2, FCS_4pt))

val_labels(data$FCS_4pt) <- c(Acceptable = 1, `Acceptable and rCSI>4` = 2, Borderline = 3, Poor = 4)

# Computation of CARI
data <- data %>% 
  mutate(
    Mean_coping_capacity_FES = rowMeans(select(., Max_coping_behaviourFS, Foodexp_4pt), na.rm = TRUE),
    CARI_unrounded_FES = rowMeans(select(., FCS_4pt, Mean_coping_capacity_FES), na.rm = TRUE),
    CARI_FES = round(CARI_unrounded_FES)
  )

var_label(data$CARI_FES) <- "CARI classification (using FES)"
val_labels(data$CARI_FES) <- c(`Food secure` = 1, `Marginally food secure` = 2, `Moderately food insecure` = 3, `Severely food insecure` = 4)

# Frequency table of CARI_FES
table(data$CARI_FES)

# Create population distribution table to explore how the domains interact within the different food security categories
table_all <- data %>% 
  select(Foodexp_4pt, FCS_4pt, Max_coping_behaviourFS) %>% 
  gather(key = "Variable", value = "Value") %>% 
  group_by(Variable, Value) %>% 
  summarise(Count = n()) %>% 
  spread(key = "Variable", value = "Count")

# Drop variables that are not needed
data <- data %>% 
  select(-Mean_coping_capacity_FES, -CARI_unrounded_FES)

# End of Scripts