# ------------------------------------------------------------
# WFP Standardized Scripts
# Reduced Coping Strategies Index (rCSI)
# Last Updated: January 2026
# ------------------------------------------------------------

library(dplyr)

# rCSI strategy variables (Survey Designer naming)
rcsi_vars <- c(
  "rCSILessQlty",
  "rCSIBorrow",
  "rCSIMealNb",
  "rCSIMealSize",
  "rCSIMealAdult"
)

# ------------------------------------------------------------
# 1) Check individual strategies
# ------------------------------------------------------------
rcsi_stats_before <- df %>%
  summarise(across(all_of(rcsi_vars),
                   list(min  = ~min(as.numeric(.x), na.rm = TRUE),
                        max  = ~max(as.numeric(.x), na.rm = TRUE),
                        mean = ~mean(as.numeric(.x), na.rm = TRUE))))
rcsi_stats_before

# ------------------------------------------------------------
# 2) Clean impossible values
# ------------------------------------------------------------
df <- df %>%
  mutate(across(all_of(rcsi_vars), ~ as.numeric(.x))) %>%
  mutate(across(all_of(rcsi_vars),
                ~ ifelse(.x < 0 | .x >= 8, NA_real_, .x)))

# ------------------------------------------------------------
# 3) Compute rCSI
# ------------------------------------------------------------
df <- df %>%
  mutate(
    rCSI = (rCSILessQlty * 1) +
      (rCSIBorrow   * 2) +
      (rCSIMealNb   * 1) +
      (rCSIMealSize * 1) +
      (rCSIMealAdult* 3)
  )

# ------------------------------------------------------------
# 4) Clean impossible rCSI values
#    Expected range: 0–56
# ------------------------------------------------------------
df <- df %>%
  mutate(
    rCSI = ifelse(rCSI < 0 | rCSI >= 57, NA_real_, rCSI)
  )

# ------------------------------------------------------------
# 5) Data quality flags
# ------------------------------------------------------------
df <- df %>%
  mutate(
    rCSI_flag_low  = ifelse(!is.na(rCSI) & rCSI <= 3,  1L, 0L),
    rCSI_flag_high = ifelse(!is.na(rCSI) & rCSI >= 42, 1L, 0L)
  )

# Flag distributions
table(df$rCSI_flag_low,  useNA = "ifany")
table(df$rCSI_flag_high, useNA = "ifany")

# ------------------------------------------------------------
# 6) Distribution check of rCSI
# ------------------------------------------------------------
c(
  mean = mean(df$rCSI, na.rm = TRUE),
  sd   = sd(df$rCSI,   na.rm = TRUE),
  min  = min(df$rCSI,  na.rm = TRUE),
  max  = max(df$rCSI,  na.rm = TRUE)
)

# ------------------------------------------------------------
# 7) Optional IPC classification (standard)
# ------------------------------------------------------------

df <- df %>%
  mutate(
    rCSI_IPC = case_when(
      is.na(rCSI)        ~ NA_integer_,
      rCSI <= 3          ~ 1L,
      rCSI >= 4 & rCSI <= 18 ~ 2L,
      rCSI >= 19         ~ 3L
    ),
    rCSI_IPC = factor(
      rCSI_IPC,
      levels = c(1,2,3),
      labels = c("rCSI [0–3] - IPC Phase 1",
                 "rCSI [4–18] - IPC Phase 2",
                 "rCSI [≥19] - IPC Phase 3–5")
    )
  )

table(df$rCSI_IPC, useNA = "ifany")

# ------------------------------------------------------------
# 8) Optional IPC classification – high values (potential Phase 4)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    rCSI_IPC_HighValues = case_when(
      is.na(rCSI)             ~ NA_integer_,
      rCSI <= 3               ~ 1L,
      rCSI >= 4  & rCSI <= 18 ~ 2L,
      rCSI >= 19 & rCSI <= 42 ~ 3L,
      rCSI >= 43              ~ 4L
    ),
    rCSI_IPC_HighValues = factor(
      rCSI_IPC_HighValues,
      levels = c(1,2,3,4),
      labels = c("rCSI [0–3]  - IPC Phase 1",
                 "rCSI [4–18] - IPC Phase 2",
                 "rCSI [19–42] - IPC Phase 3",
                 "rCSI [>42] - IPC Phase 4")
    )
  )

table(df$rCSI_IPC_HighValues, useNA = "ifany")
