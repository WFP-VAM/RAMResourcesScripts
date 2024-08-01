#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#    Engagement in Income Generation Activities (EIG) Calculation
#------------------------------------------------------------------------------

# This script calculates the Engagement in Income Generation Activities (EIG)
# using standard variable names and sample data.
# Detailed guidelines can be found in the WFP documentation.

library(tidyverse)
library(labelled)
library(expss)

# Add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/EIG_Sample_Survey.csv")

# Rearrange variable names to ensure consistency in the dataset
data <- data %>%
  rename_with(~ gsub("/", "", .), starts_with("v"))

# Loop to account for up to 9 training types
for (i in 1:9) {
  training_col <- paste0("PTrainingTypes", i)
  data[[training_col]] <- ifelse(is.na(data[[training_col]]), 0, data[[training_col]])
}

# Calculate engagement in income generation activities
data <- data %>%
  mutate(across(starts_with("PPostTrainingEmpl"), as.numeric),
         across(starts_with("PPostTrainingIncome"), as.numeric),
         PostTrainingEngagement = pmax(PPostTrainingEmpl, PPostTrainingIncome, na.rm = TRUE),
         PTrainingPart = rowSums(select(., starts_with("PTrainingTypes"))))

# Calculate household level variables
household_data <- data %>%
  group_by(household_id) %>%
  summarise(PostTrainingEngagement = sum(PostTrainingEngagement, na.rm = TRUE),
            PTrainingPartNb = sum(PTrainingPart, na.rm = TRUE))

household_data <- household_data %>%
  mutate(EIG = PostTrainingEngagement / PTrainingPartNb)

# Summary statistics for full sample
summary(household_data$EIG)

# End of Scripts