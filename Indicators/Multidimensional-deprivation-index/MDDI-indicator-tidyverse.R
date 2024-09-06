#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#          Multidimensional Deprivation Index (MDDI) Calculation
#------------------------------------------------------------------------------

# Construction of the Multidimensional Deprivation Index (MDDI) is based on the 
# codebook questions prepared for the MDDI module available at:
# https://docs.wfp.org/api/documents/WFP-0000134356/download/

library(tidyverse)
library(labelled)

# Load the data
data <- read_csv("path/to/your/data.csv")

#------------------------------------------------------------------------------
# 1. Creation of variables of deprivations for each dimension
#------------------------------------------------------------------------------

# FOOD DIMENSION

# Define labels
var_label(data$FCSStap)  <- "Consumption over the past 7 days (cereals and tubers)"
var_label(data$FCSVeg)   <- "Consumption over the past 7 days (vegetables)"
var_label(data$FCSFruit) <- "Consumption over the past 7 days (fruit)"
var_label(data$FCSPr)    <- "Consumption over the past 7 days (protein-rich foods)"
var_label(data$FCSPulse) <- "Consumption over the past 7 days (pulses)"
var_label(data$FCSDairy) <- "Consumption over the past 7 days (dairy products)"
var_label(data$FCSFat)   <- "Consumption over the past 7 days (oil)"
var_label(data$FCSSugar) <- "Consumption over the past 7 days (sugar)"

# Calculate FCS
data <- data %>%
  mutate(FCS = (FCSStap * 2) + FCSVeg + FCSFruit + (FCSPr * 4) + 
               (FCSPulse * 3) + (FCSDairy * 4) + (FCSFat * 0.5) + (FCSSugar * 0.5))

# Categorize FCS
data <- data %>%
  mutate(FCSCat28 = case_when(
    FCS <= 28 ~ 1,
    FCS <= 42 ~ 2,
    TRUE ~ 3
  ))

data <- data %>%
  mutate(FCSCat21 = case_when(
    FCS <= 21 ~ 1,
    FCS <= 35 ~ 2,
    TRUE ~ 3
  ))

val_labels(data$FCSCat28) <- c("poor" = 1, "borderline" = 2, "acceptable" = 3)
val_labels(data$FCSCat21) <- c("poor" = 1, "borderline" = 2, "acceptable" = 3)

# Turn into MDDI variable
data <- data %>%
  mutate(MDDI_food1 = FCSCat28 %in% c(1, 2))

# rCSI (Reduced Consumption Strategies Index)
data <- data %>%
  mutate(rCSI = (rCSILessQlty * 1) + (rCSIBorrow * 2) + (rCSIMealNb * 1) + 
                  (rCSIMealSize * 1) + (rCSIMealAdult * 3))

data <- data %>%
  mutate(MDDI_food2 = rCSI > 18)

# EDUCATION DIMENSION
data <- data %>%
  mutate(MDDI_edu1 = HHNoSchool == 1)

# HEALTH DIMENSION
data <- data %>%
  mutate(MDDI_health1 = HHENHealthMed %in% c(0, 1))

data <- data %>%
  mutate(HHSickNb = rowSums(select(data, HHDisabledNb, HHChronIllNb), na.rm = TRUE)) %>%
  mutate(HHSickShare = HHSickNb / HHSizeCalc) %>%
  mutate(MDDI_health2 = (HHSickNb > 1 | HHSickShare > 0.5))

# SHELTER DIMENSION
data <- data %>%
  mutate(MDDI_shelter1 = HEnerCookSRC %in% c(0, 100, 102, 200, 500, 600, 900, 999))

data <- data %>%
  mutate(MDDI_shelter2 = !HEnerLightSRC %in% c(401, 402))

data <- data %>%
  mutate(crowding = HHSizeCalc / HHRoomUsed) %>%
  mutate(MDDI_shelter3 = crowding > 3)

# WASH DIMENSION
data <- data %>%
  mutate(MDDI_wash1 = HToiletType %in% c(20100, 20200, 20300, 20400, 20500))

data <- data %>%
  mutate(MDDI_wash2 = HWaterSRC %in% c(500, 600, 700, 800))

# SAFETY DIMENSION
data <- data %>%
  mutate(MDDI_safety1 = HHPercSafe == 0 | HHShInsec1Y == 1)

data <- data %>%
  mutate(interview_date = as.Date("2021-11-25"),
         Arrival_time = as.numeric(difftime(interview_date, as.Date(HHHDisplArrive, origin = "1970-01-01"), units = "days")) / 30,
         MDDI_safety2 = ifelse(HHDispl == 0, 0, Arrival_time < 13 & HHDisplChoice == 0))

#------------------------------------------------------------------------------
# 2. Calculate deprivation score of each dimension
#------------------------------------------------------------------------------

data <- data %>%
  mutate(MDDI_food    = (MDDI_food1 * 1 / 2) + (MDDI_food2 * 1 / 2),
         MDDI_edu     = MDDI_edu1 * 1,
         MDDI_health  = (MDDI_health1 * 1 / 2) + (MDDI_health2 * 1 / 2),
         MDDI_shelter = (MDDI_shelter1 * 1 / 3) + (MDDI_shelter2 * 1 / 3) + (MDDI_shelter3 * 1 / 3),
         MDDI_wash    = (MDDI_wash1 * 1 / 2) + (MDDI_wash2 * 1 / 2),
         MDDI_safety  = (MDDI_safety1 * 1 / 2) + (MDDI_safety2 * 1 / 2))

# Label variables
var_label(data$MDDI_food)    <- "Deprivation score for food dimension"
var_label(data$MDDI_edu)     <- "Deprivation score for education dimension"
var_label(data$MDDI_health)  <- "Deprivation score for health dimension"
var_label(data$MDDI_shelter) <- "Deprivation score for shelter dimension"
var_label(data$MDDI_wash)    <- "Deprivation score for WASH dimension"
var_label(data$MDDI_safety)  <- "Deprivation score for safety and displacement dimension"

data %>%
  summarise(across(starts_with("MDDI_"), list(mean = mean, sd = sd, min = min, max = max), na.rm = TRUE))

#------------------------------------------------------------------------------
# 3. Calculate MDDI-related measures
#------------------------------------------------------------------------------

# Calculate the overall MDDI Score
data <- data %>%
  mutate(MDDI = (MDDI_food + MDDI_edu + MDDI_health + MDDI_shelter + MDDI_wash + MDDI_safety) / 6)

var_label(data$MDDI) <- "MDDI score"

# Calculate MDDI Incidence (H)
data <- data %>%
  mutate(MDDI_poor_severe = MDDI >= 0.50,
         MDDI_poor = MDDI >= 0.33)

val_labels(data$MDDI_poor)        <- c("HH is not deprived" = 0, "HH is deprived" = 1)
val_labels(data$MDDI_poor_severe) <- c("HH is not deprived" = 0, "HH is deprived" = 1)

# Calculate the Average MDDI Intensity (A)
data <- data %>%
  mutate(MDDI_intensity = ifelse(MDDI_poor == 1, MDDI, NA))

var_label(data$MDDI_intensity) <- "Average MDDI Intensity (A)"

# Calculate Combined MDDI (M = H x A)
data <- data %>%
  mutate(MDDI_combined = ifelse(MDDI_poor == 1, MDDI_poor * MDDI_intensity, 0))

var_label(data$MDDI_combined) <- "Combined MDDI (M)"

# Show results
data %>%
  summarise(across(c(MDDI_poor, MDDI_poor_severe, MDDI_intensity, MDDI_combined), mean, na.rm = TRUE))

# End of Scripts