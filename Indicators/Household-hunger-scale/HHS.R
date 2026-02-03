# ------------------------------------------------------------
# WFP Standardized Scripts
# Household Hunger Scale (HHS)
# Last Updated: January 2026
# ------------------------------------------------------------

library(dplyr)

# Main HHS occurrence variables (Yes/No)
hhs_main <- c("HHSNoFood","HHSBedHung","HHSNotEat")

# Follow-up frequency variables (1–3)
hhs_freq <- c("HHSNoFood_FR","HHSBedHung_FR","HHSNotEat_FR")

# ------------------------------------------------------------
# 1) Check main indicators (SPSS FREQUENCIES equivalent)
# ------------------------------------------------------------
hhs_main_stats <- df %>%
  summarise(across(all_of(hhs_main),
                   list(min = ~min(as.numeric(.x), na.rm = TRUE),
                        max = ~max(as.numeric(.x), na.rm = TRUE))))
hhs_main_stats

# ------------------------------------------------------------
# 2) Clean main indicators
#    Valid range: 0–1
# ------------------------------------------------------------
df <- df %>%
  mutate(across(all_of(hhs_main), ~ as.numeric(.x))) %>%
  mutate(across(all_of(hhs_main),
                ~ ifelse(.x < 0 | .x >= 2, NA_real_, .x)))

# ------------------------------------------------------------
# 3) Check frequency follow-ups
# ------------------------------------------------------------
hhs_freq_stats <- df %>%
  summarise(across(all_of(hhs_freq),
                   list(min = ~min(as.numeric(.x), na.rm = TRUE),
                        max = ~max(as.numeric(.x), na.rm = TRUE))))
hhs_freq_stats

# ------------------------------------------------------------
# 4) Clean frequency follow-ups
#    Valid range: 1–3
# ------------------------------------------------------------
df <- df %>%
  mutate(across(all_of(hhs_freq), ~ as.numeric(.x))) %>%
  mutate(across(all_of(hhs_freq),
                ~ ifelse(.x < 1 | .x > 3, NA_real_, .x)))

# ------------------------------------------------------------
# 5) Recode frequency into occurrence scores
# ------------------------------------------------------------
df <- df %>%
  mutate(
    HHSQ1 = case_when(HHSNoFood_FR %in% c(1,2) ~ 1L,
                      HHSNoFood_FR == 3        ~ 2L,
                      TRUE                     ~ 0L),
    HHSQ2 = case_when(HHSBedHung_FR %in% c(1,2) ~ 1L,
                      HHSBedHung_FR == 3        ~ 2L,
                      TRUE                      ~ 0L),
    HHSQ3 = case_when(HHSNotEat_FR %in% c(1,2) ~ 1L,
                      HHSNotEat_FR == 3        ~ 2L,
                      TRUE                     ~ 0L)
  )

# ------------------------------------------------------------
# 6) Compute HHS score (0–6)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    HHS = HHSQ1 + HHSQ2 + HHSQ3
  )

# ------------------------------------------------------------
# 7) Flag potential famine conditions
# ------------------------------------------------------------
df <- df %>%
  mutate(
    HHS_flag = ifelse(!is.na(HHS) & HHS >= 5, 1L, 0L)
  )

table(df$HHS_flag, useNA = "ifany")

# ------------------------------------------------------------
# 8) Reporting categories (standard HHS)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    HHSCat = case_when(
      HHS >= 0 & HHS <= 1 ~ 1L,
      HHS >= 2 & HHS <= 3 ~ 2L,
      HHS >= 4 & HHS <= 6 ~ 3L,
      TRUE                ~ NA_integer_
    ),
    HHSCat = factor(
      HHSCat,
      levels = c(1,2,3),
      labels = c("Little to no hunger in the household",
                 "Moderate hunger in the household",
                 "Severe hunger in the household")
    )
  )

# Distribution check
c(
  mean   = mean(df$HHS, na.rm = TRUE),
  median = median(df$HHS, na.rm = TRUE),
  min    = min(df$HHS, na.rm = TRUE),
  max    = max(df$HHS, na.rm = TRUE)
)

table(df$HHSCat, useNA = "ifany")

# ------------------------------------------------------------
# 9) Optional: IPC-oriented HHS categories
# ------------------------------------------------------------
df <- df %>%
  mutate(
    HHSCat_IPC = case_when(
      HHS == 0           ~ 1L,
      HHS == 1           ~ 2L,
      HHS %in% c(2,3)    ~ 3L,
      HHS == 4           ~ 4L,
      HHS %in% c(5,6)    ~ 5L,
      TRUE               ~ NA_integer_
    ),
    HHSCat_IPC = factor(
      HHSCat_IPC,
      levels = c(1,2,3,4,5),
      labels = c(
        "HHS [0] - IPC Phase 1: No hunger in the household",
        "HHS [1] - IPC Phase 2: Slight hunger in the household",
        "HHS [2–3] - IPC Phase 3: Moderate hunger in the household",
        "HHS [4] - IPC Phase 4: Severe hunger in the household",
        "HHS [5–6] - IPC Phase 5: Severe hunger in the household"
      )
    )
  )

table(df$HHSCat_IPC, useNA = "ifany")
