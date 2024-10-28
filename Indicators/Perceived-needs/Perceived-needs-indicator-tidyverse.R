# ------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#                     Perceived Needs Indicators Calculation
# ------------------------------------------------------------------------------

# NOTE: This syntax file assumes the use of all the questions included in the standard module.
# If any question is dropped, the corresponding variable names should be deleted from the syntax file.

# Import sample dataset
# The sample data on which this syntax file is based can be found here: 
# https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Static

# For more information on the Perceived Needs Indicators (including module), 
# see the VAM Resource Center: https://resources.vam.wfp.org/data-analysis/quantitative/essential-needs/perceived-needs-indicators

# ------------------------------------------------------------------------------#
# Open dataset
# ------------------------------------------------------------------------------#

library(tidyverse)
library(labelled)
library(janitor)

# Import dataset
data <- read_csv("path/to/Perceived_Needs.csv")

# ------------------------------------------------------------------------------#
# Labels
# ------------------------------------------------------------------------------#

# Assign variable and value labels
var_label(data$HHPercNeedWater)      <- "Not enough water that is safe for drinking or cooking"
var_label(data$HHPercNeedFood)       <- "Not enough food, or good enough food, or not able to cook food"
var_label(data$HHPercNeedHousing)    <- "No suitable place to live in"
var_label(data$HHPercNeedToilet)     <- "No easy and safe access to a clean toilet"
var_label(data$HHPercNeedHygiene)    <- "Not enough soap, sanitary materials, water or a suitable place to wash"
var_label(data$HHPercNeedClothTex)   <- "Not enough or good enough, clothes, shoes, bedding or blankets"
var_label(data$HHPercNeedLivelihood) <- "Not enough income, money or resources to live"
var_label(data$HHPercNeedDisabIll)   <- "Serious problem with physical health"
var_label(data$HHPercNeedHealth)     <- "Not able to get adequate health care (including during pregnancy or childbirth - for women)"
var_label(data$HHPercNeedSafety)     <- "Not safe or protected where you live now"
var_label(data$HHPercNeedEducation)  <- "Children not in school, or not getting a good enough education"
var_label(data$HHPercNeedCaregive)   <- "Difficult to care for family members who live with you"
var_label(data$HHPercNeedInfo)       <- "Not have enough information (including on situation at home - for displaced)"
var_label(data$HHPercNeedAsstInfo)   <- "Inadequate aid"
var_label(data$CMPercNeedJustice)    <- "Inadequate system for law and justice in community"
var_label(data$CMPercNeedGBViolence) <- "Physical or sexual violence towards women in community"
var_label(data$CMPercNeedSubstAbuse) <- "People drink a lot of alcohol or use harmful drugs in community"
var_label(data$CMPercNeedMentalCare) <- "Mental illness in community"
var_label(data$CMPercNeedCaregiving) <- "Not enough care for people who are on their own in community"

val_labels_list <- c(
  "No serious problem" = 0,
  "Serious problem" = 1,
  "Don't know, not applicable, declines to answer" = 8888
)

val_labels(data$HHPercNeedWater)      <- val_labels_list
val_labels(data$HHPercNeedFood)       <- val_labels_list
val_labels(data$HHPercNeedHousing)    <- val_labels_list
val_labels(data$HHPercNeedToilet)     <- val_labels_list
val_labels(data$HHPercNeedHygiene)    <- val_labels_list
val_labels(data$HHPercNeedClothTex)   <- val_labels_list
val_labels(data$HHPercNeedLivelihood) <- val_labels_list
val_labels(data$HHPercNeedDisabIll)   <- val_labels_list
val_labels(data$HHPercNeedHealth)     <- val_labels_list
val_labels(data$HHPercNeedSafety)     <- val_labels_list
val_labels(data$HHPercNeedEducation)  <- val_labels_list
val_labels(data$HHPercNeedCaregive)   <- val_labels_list
val_labels(data$HHPercNeedInfo)       <- val_labels_list
val_labels(data$HHPercNeedAsstInfo)   <- val_labels_list
val_labels(data$CMPercNeedJustice)    <- val_labels_list
val_labels(data$CMPercNeedGBViolence) <- val_labels_list
val_labels(data$CMPercNeedSubstAbuse) <- val_labels_list
val_labels(data$CMPercNeedMentalCare) <- val_labels_list
val_labels(data$CMPercNeedCaregiving) <- val_labels_list

val_labels_problem <- c(
  "Drinking water" = 1, "Food" = 2, "Place to live in" = 3, "Toilets" = 4, "Keeping clean" = 5,
  "Clothes, shoes, bedding or blankets" = 6, "Income or livelihood" = 7, "Physical health" = 8,
  "Health care" = 9, "Safety" = 10, "Education for your children" = 11, "Care for family members" = 12,
  "Information" = 13, "The way aid is provided" = 14, "Law and injustice in your community" = 15,
  "Safety or protection from violence for women in your community" = 16, "Alcohol or drug use in your community" = 17,
  "Mental illness in your community" = 18, "Care for people in your community who are on their own" = 19,
  "Other problem" = 20
)

val_labels(data$CMPercNeedRFirst) <- val_labels_problem
val_labels(data$CMPercNeedRSec)   <- val_labels_problem
val_labels(data$CMPercNeedRThird) <- val_labels_problem

# ------------------------------------------------------------------------------#
# For each aspect/question, report the share of households who indicated it as a "serious problem"
# ------------------------------------------------------------------------------#

# Frequencies
perc_need_summary <- data %>%
  select(HHPercNeedWater:HHPercNeedCaregiving) %>%
  summarise(across(everything(), ~ mean(. == 1, na.rm = TRUE) * 100))

print(perc_need_summary)

# Show only the share of households that reported an aspect as a serious problem out of the total population (including those that did not answer)
data <- data %>%
  mutate(across(starts_with("HHPercNeed"), ~ replace_na(. == 1, 0)))

perc_need_summary <- data %>%
  select(HHPercNeedWater:HHPercNeedCaregiving) %>%
  summarise(across(everything(), ~ mean(. == 1, na.rm = TRUE) * 100))

print(perc_need_summary)

# ------------------------------------------------------------------------------#
# For each aspect/question, report the share of households who indicated it among their top three problems
# ------------------------------------------------------------------------------#

# Generate variables indicating if the respondent mentioned it among their top three problems
data <- data %>%
  mutate(
    Top3_Water      = (CMPercNeedRFirst == 1 | CMPercNeedRSec == 1 | CMPercNeedRThird == 1),
    Top3_Food       = (CMPercNeedRFirst == 2 | CMPercNeedRSec == 2 | CMPercNeedRThird == 2),
    Top3_Housing    = (CMPercNeedRFirst == 3 | CMPercNeedRSec == 3 | CMPercNeedRThird == 3),
    Top3_Toilet     = (CMPercNeedRFirst == 4 | CMPercNeedRSec == 4 | CMPercNeedRThird == 4),
    Top3_Hygiene    = (CMPercNeedRFirst == 5 | CMPercNeedRSec == 5 | CMPercNeedRThird == 5),
    Top3_ClothTex   = (CMPercNeedRFirst == 6 | CMPercNeedRSec == 6 | CMPercNeedRThird == 6),
    Top3_Livelihood = (CMPercNeedRFirst == 7 | CMPercNeedRSec == 7 | CMPercNeedRThird == 7),
    Top3_Disabil    = (CMPercNeedRFirst == 8 | CMPercNeedRSec == 8 | CMPercNeedRThird == 8),
    Top3_Health     = (CMPercNeedRFirst == 9 | CMPercNeedRSec == 9 | CMPercNeedRThird == 9),
    Top3_Safety     = (CMPercNeedRFirst == 10 | CMPercNeedRSec == 10 | CMPercNeedRThird == 10),
    Top3_Education  = (CMPercNeedRFirst == 11 | CMPercNeedRSec == 11 | CMPercNeedRThird == 11),
    Top3_Caregive   = (CMPercNeedRFirst == 12 | CMPercNeedRSec == 12 | CMPercNeedRThird == 12),
    Top3_Info       = (CMPercNeedRFirst == 13 | CMPercNeedRSec == 13 | CMPercNeedRThird == 13),
    Top3_AsstInfo   = (CMPercNeedRFirst == 14 | CMPercNeedRSec == 14 | CMPercNeedRThird == 14),
    Top3_Justice    = (CMPercNeedRFirst == 15 | CMPercNeedRSec == 15 | CMPercNeedRThird == 15),
    Top3_GBViolence = (CMPercNeedRFirst == 16 | CMPercNeedRSec == 16 | CMPercNeedRThird == 16),
    Top3_SubstAbuse = (CMPercNeedRFirst == 17 | CMPercNeedRSec == 17 | CMPercNeedRThird == 17),
    Top3_MentalCare = (CMPercNeedRFirst == 18 | CMPercNeedRSec == 18 | CMPercNeedRThird == 18),
    Top3_Caregiving = (CMPercNeedRFirst == 19 | CMPercNeedRSec == 19 | CMPercNeedRThird == 19),
    Top3_Other      = (CMPercNeedRFirst == 20 | CMPercNeedRSec == 20 | CMPercNeedRThird == 20)
  )

# Recode missings to zero
data <- data %>%
  mutate(across(starts_with("Top3_"), ~ replace_na(., 0)))

# Report share of households who indicated an area among their top three problems
top3_summary <- data %>%
  select(starts_with("Top3_")) %>%
  summarise(across(everything(), ~ mean(. == 1, na.rm = TRUE) * 100))

print(top3_summary)

# ------------------------------------------------------------------------------#
# Mean/median number of aspects indicated as "serious problems"
# ------------------------------------------------------------------------------#

# Create a variable that counts the number of aspects perceived as serious problems
data <- data %>%
  mutate(Perceived_total = rowSums(select(., starts_with("HHPercNeed")) == 1, na.rm = TRUE))

var_label(data$Perceived_total) <- "Total number of problems identified"

# Report mean and median number of aspects indicated as "serious problems"
summary_perceived_total <- data %>%
  summarise(
    mean_perceived_total = mean(Perceived_total, na.rm = TRUE),
    median_perceived_total = median(Perceived_total, na.rm = TRUE)
  )

print(summary_perceived_total)

# End of Scripts