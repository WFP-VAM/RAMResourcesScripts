# ------------------------------------------------------------
# WFP Standardized Scripts - Food Consumption Score (FCS)
# High thresholds (28-42) for sugar/oil consuming populations
# Last Updated: January 2026
# ------------------------------------------------------------

library(dplyr)

# Expect a data.frame called df with these variables:
# FCSStap, FCSPulse, FCSDairy, FCSPr, FCSVeg, FCSFruit, FCSFat, FCSSugar, (optional) FCSCond

fcs_vars <- c("FCSStap","FCSPulse","FCSDairy","FCSPr","FCSVeg","FCSFruit","FCSFat","FCSSugar")

df <- df %>%
  # ----------------------------------------------------------
# 1) Harmonize Data Quality Guidance measures:
#    Clean impossible values: set <0 or >=8 to NA
# ----------------------------------------------------------
mutate(across(all_of(fcs_vars), ~ ifelse(.x < 0 | .x >= 8, NA_real_, as.numeric(.x)))) %>%
  
# ----------------------------------------------------------
# 2) Compute FCS
#    Condiments are NOT included
# ----------------------------------------------------------
mutate(
  FCS = rowSums(
    cbind(
      FCSStap  * 2,
      FCSPulse * 3,
      FCSDairy * 4,
      FCSPr    * 4,
      FCSVeg   * 1,
      FCSFruit * 1,
      FCSFat   * 0.5,
      FCSSugar * 0.5
    ),
    na.rm = TRUE
  )
) %>%
  
# ----------------------------------------------------------
# 3) Clean any impossible FCS values (should be 0-112)
# ----------------------------------------------------------
mutate(
  FCS = ifelse(FCS < 0 | FCS >= 113, NA_real_, FCS)
) %>%
  
# ----------------------------------------------------------
# 4) Flag potential Data Quality issues
# ----------------------------------------------------------
mutate(
  FCS_flag_low  = ifelse(!is.na(FCS) & FCS < 14, 1L, 0L),
  FCS_flag_high = ifelse(!is.na(FCS) & FCS > 100, 1L, 0L)
) %>%
  
# ----------------------------------------------------------
# 5) Recode into FCS categories using HIGH thresholds (28-42)
# ----------------------------------------------------------
mutate(
  FCSCat28 = case_when(
    is.na(FCS)        ~ NA_integer_,
    FCS <= 28         ~ 1L,   # Poor
    FCS > 28 & FCS <= 42 ~ 2L, # Borderline
    FCS > 42          ~ 3L    # Acceptable
  ),
  FCSCat28 = factor(FCSCat28, levels = c(1,2,3),
                    labels = c("Poor","Borderline","Acceptable"))
)

# ------------------------------------------------------------
# Data Quality Diagnostics
# ------------------------------------------------------------

# Descriptives for FCS
summary(df$FCS)
sd(df$FCS, na.rm = TRUE)

# Flag frequencies
table(df$FCS_flag_low, useNA = "ifany")
table(df$FCS_flag_high, useNA = "ifany")

# Category distribution
table(df$FCSCat28, useNA = "ifany")

# Sample check of food group distributions (min/max/mean)
food_group_stats <- df %>%
  summarise(across(all_of(fcs_vars),
                   list(min = ~min(.x, na.rm = TRUE),
                        max = ~max(.x, na.rm = TRUE),
                        mean = ~mean(.x, na.rm = TRUE))))
food_group_stats

