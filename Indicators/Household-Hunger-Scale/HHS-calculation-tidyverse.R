#------------------------------------------------------------------------------#
#                      WFP Standardized Scripts
#                Calculating the Household Hunger Scale (HHS)
#------------------------------------------------------------------------------#

# Load necessary packages -----------------------------------------------------#
library(tidyverse)  # For data manipulation
library(labelled)   # For handling value labels

# Load data --------------------------------------------------------------------#
# Replace with your data file path
#df <- read_csv("path_to_your_file.csv")

# Define variable labels -------------------------------------------------------#
var_label(data$HHSNoFood)     <- "In the past [4 weeks/30 days], was there ever no food to eat of any kind in your house because of lack of resources to get food?"
var_label(data$HHSNoFood_FR)  <- "How often did this happen in the past [4 weeks/30 days]?"
var_label(data$HHSBedHung)    <- "In the past [4 weeks/30 days], did you or any household member go to sleep at night hungry because there was not enough food?"
var_label(data$HHSBedHung_FR) <- "How often did this happen in the past [4 weeks/30 days]?"
var_label(data$HHSNotEat)     <- "In the past [4 weeks/30 days], did you or any household member go a whole day and night without eating anything because there was not enough food?"
var_label(data$HHSNotEat_FR)  <- "How often did this happen in the past [4 weeks/30 days]?"

# Define value labels ----------------------------------------------------------#
val_lab(data$HHSNoFood) <- num_lab("
  0 No
  1 Yes
")

val_lab(data$HHSNoFood_FR) <- num_lab("
  1 Rarely (1–2 times)
  2 Sometimes (3–10 times)
  3 Often (more than 10 times)
")

val_lab(data$HHSBedHung) <- num_lab("
  0 No
  1 Yes
")

val_lab(data$HHSBedHung_FR) <- num_lab("
  1 Rarely (1–2 times)
  2 Sometimes (3–10 times)
  3 Often (more than 10 times)
")

val_lab(data$HHSNotEat) <- num_lab("
  0 No
  1 Yes
")

val_lab(data$HHSNotEat_FR) <- num_lab("
  1 Rarely (1–2 times)
  2 Sometimes (3–10 times)
  3 Often (more than 10 times)
")

# Cleaning of HHS variables: consistency between filter and frequency questions ----#
# HHSNoFood and HHSNoFood_FR
data <- data %>%
  mutate(HHSNoFood = ifelse(HHSNoFood_FR > 0, 1, HHSNoFood))

# HHSBedHung and HHSBedHung_FR
data <- data %>%
  mutate(HHSBedHung = ifelse(HHSBedHung_FR > 0, 1, HHSBedHung))

# HHSNotEat and HHSNotEat_FR
data <- data %>%
  mutate(HHSNotEat = ifelse(HHSNotEat_FR > 0, 1, HHSNotEat))

# Create new variables for frequency-of-occurrence questions --------------------#
data <- data %>%
  mutate(
    HHSQ1 = case_when(HHSNoFood_FR %in% c(1, 2) ~ 1, 
                      HHSNoFood_FR == 3 ~ 2, 
                      TRUE ~ 0),
    HHSQ2 = case_when(HHSBedHung_FR %in% c(1, 2) ~ 1, 
                      HHSBedHung_FR == 3 ~ 2, 
                      TRUE ~ 0),
    HHSQ3 = case_when(HHSNotEat_FR %in% c(1, 2) ~ 1, 
                      HHSNotEat_FR == 3 ~ 2, 
                      TRUE ~ 0)
  )

# Compute the Household Hunger Score (HHS) -------------------------------------#
data <- data %>%
  mutate(HHS = HHSQ1 + HHSQ2 + HHSQ3)

# Define variable labels for HHS and HHS categories -----------------------------#
var_label(data$HHS) <- "Household Hunger Score"

# Categorize HHS scores --------------------------------------------------------#
data <- data %>%
  mutate(
    HHSCat = case_when(
      HHS <= 1 ~ 1,
      HHS >= 2 & HHS <= 3 ~ 2,
      HHS >= 4 ~ 3
    ),
    HHSCatr = case_when(
      HHS == 0 ~ 0,
      HHS == 1 ~ 1,
      HHS >= 2 & HHS <= 3 ~ 2,
      HHS == 4 ~ 3,
      HHS >= 5 ~ 4
    )
  )

# Define value labels for HHS categories ---------------------------------------#
data <- data %>%
  mutate(
    HHSCat = val_lab(data$HHSCat, num_lab("
      1 No or little hunger in the household
      2 Moderate hunger in the household
      3 Severe hunger in the household
    ")),
    HHSCatr = val_lab(data$HHSCatr, num_lab("
      0 No hunger in the household
      1 Little hunger in the household (stress)
      2 Moderate hunger in the household (crisis)
      3 Severe hunger in the household (emergency)
      4 Very severe hunger in the household (catastrophe)
    "))
  )

# View results -----------------------------------------------------------------#
print(data %>% select(HHS, HHSCat, HHSCatr))

# End of Scripts