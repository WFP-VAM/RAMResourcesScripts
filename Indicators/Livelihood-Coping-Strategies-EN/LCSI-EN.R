# ------------------------------------------------------------
# WFP Standardized Scripts
# Livelihood Coping Strategies – Essential Needs (LCS-EN)
# Last Updated: January 2026
# ------------------------------------------------------------

library(dplyr)

# ------------------------------------------------------------
# 1) LCS-EN strategy variables (example set)
#    NOTE: Replace / adapt based on strategies selected in the assessment
# ------------------------------------------------------------

stress_vars <- c(
  "LcsEN_stress_DomAsset",
  "LcsEN_stress_Utilities",
  "LcsEN_stress_Saving",
  "LcsEN_stress_BorrowCash"
)

crisis_vars <- c(
  "LcsEN_crisis_ProdAssets",
  "LcsEN_crisis_Health",
  "LcsEN_crisis_OutSchool"
)

emergency_vars <- c(
  "LcsEN_em_ResAsset",
  "LcsEN_em_Begged",
  "LcsEN_em_IllegalAct"
)

all_lcs_vars <- c(stress_vars, crisis_vars, emergency_vars)

# Expected coding:
# 10 = No, did not need to
# 20 = No, already exhausted / cannot continue
# 30 = Yes
# 9999 = Not applicable

# ------------------------------------------------------------
# 2) Check individual strategies
# ------------------------------------------------------------
lcs_overview <- lapply(df[all_lcs_vars], function(x) table(x, useNA = "ifany"))
lcs_overview


# ------------------------------------------------------------
# 3) Compute stress coping (binary, weighted as 2)
#    SPSS: if ANY stress strategy is 20 or 30 → Stress = 2
# ------------------------------------------------------------
df <- df %>%
  mutate(
    Stress_coping_EN = ifelse(
      rowSums(across(all_of(stress_vars),
                     ~ .x %in% c(20, 30))) > 0,
      2L, 0L
    )
  )

# ------------------------------------------------------------
# 4) Compute crisis coping (binary, weighted as 3)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    Crisis_coping_EN = ifelse(
      rowSums(across(all_of(crisis_vars),
                     ~ .x %in% c(20, 30))) > 0,
      3L, 0L
    )
  )

# ------------------------------------------------------------
# 5) Compute emergency coping (binary, weighted as 4)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    Emergency_coping_EN = ifelse(
      rowSums(across(all_of(emergency_vars),
                     ~ .x %in% c(20, 30))) > 0,
      4L, 0L
    )
  )

# ------------------------------------------------------------
# 6) Highest coping behaviour (EN)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    Max_coping_behaviourEN = pmax(
      Stress_coping_EN,
      Crisis_coping_EN,
      Emergency_coping_EN,
      na.rm = TRUE
    ),
    Max_coping_behaviourEN = ifelse(Max_coping_behaviourEN == 0, 1L, Max_coping_behaviourEN),
    Max_coping_behaviourEN = factor(
      Max_coping_behaviourEN,
      levels = c(1,2,3,4),
      labels = c(
        "Household did not apply coping strategies",
        "Household applied stress coping strategies",
        "Household applied crisis coping strategies",
        "Household applied emergency coping strategies"
      )
    )
  )

# Distribution check
table(df$Stress_coping_EN, useNA = "ifany")
table(df$Crisis_coping_EN, useNA = "ifany")
table(df$Emergency_coping_EN, useNA = "ifany")
table(df$Max_coping_behaviourEN, useNA = "ifany")

# ------------------------------------------------------------
# 7) Reasons for adopting coping strategies (multiple choice)
#    Assumes MoDa export with split-select (0/1)
#    and variables renamed as in SPSS:
#    LhCSIEnAccess1 ... LhCSIEnAccess8, LhCSIEnAccess999
# ------------------------------------------------------------

access_vars <- c(
  "LhCSIEnAccess.1","LhCSIEnAccess.2","LhCSIEnAccess.3","LhCSIEnAccess.4",
  "LhCSIEnAccess.5","LhCSIEnAccess.6","LhCSIEnAccess.7","LhCSIEnAccess.8",
  "LhCSIEnAccess.999"
)

# Descriptives (mean share of HHs selecting each reason)
access_stats <- df %>%
  summarise(across(all_of(access_vars), ~ mean(.x, na.rm = TRUE)))

access_stats

# ------------------------------------------------------------
# 8) Convert LCS-EN → LCS-FS for CARI
#      If "to buy food" (Access1) NOT selected → not coping (1)
#      If selected → inherit Max_coping_behaviourEN
# ------------------------------------------------------------
df <- df %>%
  mutate(
    Max_coping_behaviourFS = ifelse(
        dplyr::coalesce(LhCSIEnAccess.1, 0) == 1,
        as.numeric(Max_coping_behaviourEN),
        1L
    ),
    Max_coping_behaviourFS = factor(
      Max_coping_behaviourFS,
      levels = c(1,2,3,4),
      labels = c(
        "Household did not apply coping strategies",
        "Household applied stress coping strategies",
        "Household applied crisis coping strategies",
        "Household applied emergency coping strategies"
      )
    )
  )

table(df$Max_coping_behaviourFS, useNA = "ifany")

# ------------------------------------------------------------
# 9) Optional IPC classification (ONLY for LCS-FS, never LCS-EN)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    Max_coping_behaviourFS_IPC = factor(
      as.numeric(Max_coping_behaviourFS),
      levels = c(1,2,3,4),
      labels = c(
        "LCSI [none] - IPC Phase 1",
        "LCSI [stress] - IPC Phase 2",
        "LCSI [crisis] - IPC Phase 3",
        "LCSI [emergency] - IPC Phase 4-5"
      )
    )
  )

table(df$Max_coping_behaviourFS_IPC, useNA = "ifany")

