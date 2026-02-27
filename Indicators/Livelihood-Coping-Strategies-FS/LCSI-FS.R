# ------------------------------------------------------------
# WFP Standardized Scripts
# Livelihood Coping Strategies – Food Security (LCS-FS)
# Last Updated: January 2026
# ------------------------------------------------------------

library(dplyr)

# ------------------------------------------------------------
# 1) Strategy variables (EXAMPLE SET – adapt per assessment)
# ------------------------------------------------------------

stress_vars <- c(
  "Lcs_stress_DomAsset",
  "Lcs_stress_Utilities",
  "Lcs_stress_Saving",
  "Lcs_stress_BorrowCash"
)

crisis_vars <- c(
  "Lcs_crisis_ProdAssets",
  "Lcs_crisis_Health",
  "Lcs_crisis_OutSchool"
)

emergency_vars <- c(
  "Lcs_em_ResAsset",
  "Lcs_em_Begged",
  "Lcs_em_IllegalAct"
)

all_lcs_vars <- c(stress_vars, crisis_vars, emergency_vars)

# Expected coding:
# 10 = No, because we did not need to
# 20 = No, because already exhausted / cannot continue
# 30 = Yes
# 9999 = Not applicable

# ------------------------------------------------------------
# 2) Check individual strategies (SPSS FREQUENCIES equivalent)
# ------------------------------------------------------------
lcs_fs_overview <- lapply(df[all_lcs_vars], function(x) table(x, useNA = "ifany"))
lcs_fs_overview

# ------------------------------------------------------------
# 3) Compute stress coping (binary, weighted = 2)
#    SPSS: if ANY stress strategy is 20 or 30 → Stress = 2
# ------------------------------------------------------------
df <- df %>%
  mutate(
    Stress_coping_FS = ifelse(
      rowSums(across(all_of(stress_vars), ~ .x %in% c(20, 30))) > 0,
      2L, 0L
    )
  )

# ------------------------------------------------------------
# 4) Compute crisis coping (binary, weighted = 3)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    Crisis_coping_FS = ifelse(
      rowSums(across(all_of(crisis_vars), ~ .x %in% c(20, 30))) > 0,
      3L, 0L
    )
  )

# ------------------------------------------------------------
# 5) Compute emergency coping (binary, weighted = 4)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    Emergency_coping_FS = ifelse(
      rowSums(across(all_of(emergency_vars), ~ .x %in% c(20, 30))) > 0,
      4L, 0L
    )
  )

# ------------------------------------------------------------
# 6) Highest coping behaviour (FS)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    Max_coping_behaviourFS = pmax(
      Stress_coping_FS,
      Crisis_coping_FS,
      Emergency_coping_FS,
      na.rm = TRUE
    ),
    Max_coping_behaviourFS = ifelse(Max_coping_behaviourFS == 0, 1L, Max_coping_behaviourFS),
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

# ------------------------------------------------------------
# 7) Distribution checks
# ------------------------------------------------------------
table(df$Stress_coping_FS, useNA = "ifany")
table(df$Crisis_coping_FS, useNA = "ifany")
table(df$Emergency_coping_FS, useNA = "ifany")
table(df$Max_coping_behaviourFS, useNA = "ifany")

# ------------------------------------------------------------
# 8) Optional IPC classification (LCS-FS only)
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
