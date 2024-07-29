#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#          Calculating Household Dietary Diversity Score (HDDS)
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#
library(tidyverse)
library(labelled)

# Load Sample Data ------------------------------------------------------------#
# df <- read_csv("path_to_your_file.csv")

# Rename variables to match the script ----------------------------------------#
df <- df %>%
  rename(HDDSStapCer  = 'HDDSStapCer',
         HDDSStapRoot = 'HDDSStapRoot',
         HDDSVeg      = 'HDDSVeg',
         HDDSFruit    = 'HDDSFruit',
         HDDSPrMeat   = 'HDDSPrMeat',
         HDDSPrEggs   = 'HDDSPrEggs',
         HDDSPrFish   = 'HDDSPrFish',
         HDDSPulse    = 'HDDSPulse',
         HDDSDairy    = 'HDDSDairy',
         HDDSFat      = 'HDDSFat',
         HDDSSugar    = 'HDDSSugar',
         HDDSCond     = 'HDDSCond')

# Compute HDDS ---------------------------------------------------------------#
df <- df %>%
  mutate(HDDS = HDDSStapCer + HDDSStapRoot + HDDSVeg + HDDSFruit +
                HDDSPrMeat + HDDSPrEggs + HDDSPrFish + HDDSPulse +
                HDDSDairy + HDDSFat + HDDSSugar + HDDSCond) %>%
  mutate(HDDSCat_IPC = case_when(
    HDDS <= 2 ~ 1,
    HDDS >= 3 & HDDS <= 4 ~ 2,
    HDDS >= 5 ~ 3
  ))

# Assign value labels
val_lab(df$HDDSCat_IPC) <- num_lab("
  1 '0-2 food groups (phase 4 to 5)'
  2 '3-4 food groups (phase 3)'
  3 '5-12 food groups (phase 1 to 2)'
")

# View the result
print(df %>% select(HDDS, HDDSCat_IPC))

# End of Scripts