#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#                  Resilience Capacity Score (RCS) Calculation
#------------------------------------------------------------------------------

# The RCS is calculated from 9 sub-statements using a five-point Likert scale 
# (ranging from 'strongly disagree' to 'strongly agree') to capture the household 
# perception of existing resilience capacities or livelihood capital. 
# The Resilience Capacity Score aggregates the unweighted answers to the nine 
# statements and is normalized to provide a score ranging from 0 to 100. 
# This result is used to classify households in three groups (low, medium, or high). 
# The percentages at each level are used later in following the changes over time 
# in these percentages for a specific target group of households. 
# Progress achieved or change over time in any of the 9 items is also calculated 
# to understand which capacities or capitals contribute the most to the final score 
# and which need to be reinforced to enhance future climate resilience.

library(tidyverse)
library(labelled)
library(expss)

# Load the data
data <- read_csv("path/to/RCS_Sample_Survey.csv")

# Label variables and values
var_label(data$HHRCSBounce)          <- "Your household can bounce back from any challenge that life throws at it."
var_label(data$HHRCSRevenue)         <- "During times of hardship your household can change its primary income or source of livelihood if needed."
var_label(data$HHRCSIncrease)        <- "If threats to your household became more frequent and intense, you would still find a way to get by."
var_label(data$HHRCSFinAccess)       <- "During times of hardship your household can access the financial support you need."
var_label(data$HHRCSSupportCommunity)<- "Your household can rely on the support of family or friends when you need help."
var_label(data$HHRCSLessonsLearnt)   <- "Your household has learned important lessons from past hardships that will help you to better prepare for future challenges."
var_label(data$HHRCSSupportPublic)   <- "Your household can rely on the support from public administration/government or other institutions when you need help."
var_label(data$HHRCSFutureChallenge) <- "Your household is fully prepared for any future challenges or threats that life throws at it."
var_label(data$HHRCSWarningAccess)   <- "Your household receives useful information warning you about future risks in advance."

data <- data %>%
  mutate(across(
    c(HHRCSBounce, HHRCSRevenue, HHRCSIncrease, HHRCSFinAccess, HHRCSSupportCommunity, HHRCSSupportPublic, HHRCSLessonsLearnt, HHRCSFutureChallenge, HHRCSWarningAccess), 
    ~labelled(., labels = c(
      "Strongly Agree" = 1, 
      "Partially agree" = 2, 
      "Neutral" = 3, 
      "Somewhat disagree" = 4, 
      "Totally disagree" = 5
    ))
  ))

# Calculate the Resilience Capacity Score (RCS)
data <- data %>%
  mutate(
    RCS = (rowSums(across(c(HHRCSBounce, HHRCSRevenue, HHRCSIncrease, HHRCSFinAccess, HHRCSSupportCommunity, HHRCSSupportPublic, HHRCSLessonsLearnt, HHRCSFutureChallenge, HHRCSWarningAccess))) / 9 - 1) * (100 / 4)
  )

var_label(data$RCS) <- "Resilience Capacity Score"

# Classify households into RCS categories
data <- data %>%
  mutate(
    RCSCat33 = case_when(
      RCS < 33 ~ 1,
      RCS < 66 ~ 2,
      TRUE     ~ 3
    )
  )

var_label(data$RCSCat33) <- "RCS Categories, thresholds 33-66"
val_lab(data$RCSCat33)    = num_lab("
             1 low RCS
             2 medium RCS
             3 high RCS
")

# Calculate RCS components
data <- data %>%
  mutate(
    RCSAnticipatory = (HHRCSFutureChallenge - 1) * (100 / 4),
    RCSAbsorptive   = (HHRCSBounce - 1) * (100 / 4),
    RCSTransformative = (HHRCSRevenue - 1) * (100 / 4),
    RCSAdaptive     = (HHRCSIncrease - 1) * (100 / 4)
  )

data <- data %>%
  mutate(
    RCSAnticipatoryCat33 = case_when(
      RCSAnticipatory < 33 ~ 1,
      RCSAnticipatory < 66 ~ 2,
      TRUE                  ~ 3
    ),
    RCSAbsorptiveCat33 = case_when(
      RCSAbsorptive < 33 ~ 1,
      RCSAbsorptive < 66 ~ 2,
      TRUE               ~ 3
    ),
    RCSTransformativeCat33 = case_when(
      RCSTransformative < 33 ~ 1,
      RCSTransformative < 66 ~ 2,
      TRUE                   ~ 3
    ),
    RCSAdaptiveCat33 = case_when(
      RCSAdaptive < 33 ~ 1,
      RCSAdaptive < 66 ~ 2,
      TRUE             ~ 3
    )
  )

val_lab(data$RCSAnticipatoryCat33) = num_lab("
             1 low
             2 medium
             3 high
")
val_lab(data$RCSAbsorptiveCat33)   = num_lab("
             1 low
             2 medium
             3 high
")
val_lab(data$RCSTransformativeCat33) = num_lab("
             1 low
             2 medium
             3 high
")
val_lab(data$RCSAdaptiveCat33)     = num_lab("
             1 low
             2 medium
             3 high
")

# Create a table of results for COMET reporting
RCS_summary <- data %>%
  group_by(RCSCat33) %>%
  summarize(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)

write.csv(RCS_summary, "RCS_COMET.csv")

# End of Scripts