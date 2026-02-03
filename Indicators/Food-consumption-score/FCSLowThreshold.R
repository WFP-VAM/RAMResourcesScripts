# ------------------------------------------------------------
# WFP Standardized Scripts - Food Consumption Score (FCS)
# LOW thresholds (21-35) for low sugar/oil consuming populations
# Last Updated: January 2026
# ------------------------------------------------------------

library(dplyr)

# Expected variables in df:
# FCSStap, FCSPulse, FCSDairy, FCSPr, FCSVeg, FCSFruit, FCSFat, FCSSugar
# (Optional: FCSCond is not used in standard FCS calculation.)

fcs_vars <- c("FCSStap","FCSPulse","FCSDairy","FCSPr","FCSVeg","FCSFruit","FCSFat","FCSSugar")

df <- df %>%
  
# ----------------------------------------------------------
# 1) Clean impossible food group values
# ----------------------------------------------------------
mutate(across(all_of(fcs_vars), ~ ifelse(.x < 0 | .x >= 8, NA_real_, as.numeric(.x)))) %>%
  
# ----------------------------------------------------------
# 2) Compute FCS
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
# 3) Clean impossible FCS values (should be 0-112)
# ----------------------------------------------------------
mutate(
  FCS = ifelse(FCS < 0 | FCS >= 113, NA_real_, FCS)
) %>%
  
  # ----------------------------------------------------------
# 4) Data quality flags
#    low if FCS < 14; high if FCS > 100
# ----------------------------------------------------------
mutate(
  FCS_flag_low  = ifelse(!is.na(FCS) & FCS < 14, 1L, 0L),
  FCS_flag_high = ifelse(!is.na(FCS) & FCS > 100, 1L, 0L)
) %>%
  
  # ----------------------------------------------------------
# 5) Recode into LOW-threshold categories (21-35)
# ----------------------------------------------------------
mutate(
  FCSCat21 = case_when(
    is.na(FCS)           ~ NA_integer_,
    FCS <= 21            ~ 1L,           # Poor
    FCS > 21 & FCS <= 35 ~ 2L,           # Borderline
    FCS > 35             ~ 3L            # Acceptable
  ),
  FCSCat21 = factor(FCSCat21, levels = c(1,2,3),
                    labels = c("Poor","Borderline","Acceptable"))
)

# ------------------------------------------------------------
# Data Quality Diagnostics
# ------------------------------------------------------------

# Descriptives for FCS
summary(df$FCS)
sd(df$FCS, na.rm = TRUE)

# Frequencies of flags
table(df$FCS_flag_low,  useNA = "ifany")
table(df$FCS_flag_high, useNA = "ifany")

# Distribution of final categories
table(df$FCSCat21, useNA = "ifany")

# Sample check of food group distributions: min/max/mean
food_group_stats <- df %>%
  summarise(across(all_of(fcs_vars),
                   list(min  = ~min(.x, na.rm = TRUE),
                        max  = ~max(.x, na.rm = TRUE),
                        mean = ~mean(.x, na.rm = TRUE))))
food_group_stats

