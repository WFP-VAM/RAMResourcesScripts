# ------------------------------------------------------------
# WFP Standardized Scripts
# Household Dietary Diversity Score (HDDS)
# Last Updated: January 2026
# ------------------------------------------------------------

library(dplyr)

# HDDS food groups (0/1 consumption in last 24h)
hdds_vars <- c(
  "HDDSStapCer","HDDSStapRoot","HDDSPulse","HDDSDairy",
  "HDDSPrMeat","HDDSPrFish","HDDSPrEggs",
  "HDDSVeg","HDDSFruit","HDDSFat","HDDSSugar","HDDSCond"
)

# ------------------------------------------------------------
# 1) Check individual food groups
# ------------------------------------------------------------
hdds_stats_before <- df %>%
  summarise(across(all_of(hdds_vars),
                   list(min  = ~min(as.numeric(.x), na.rm = TRUE),
                        max  = ~max(as.numeric(.x), na.rm = TRUE),
                        mean = ~mean(as.numeric(.x), na.rm = TRUE))))
hdds_stats_before

# ------------------------------------------------------------
# 2) Clean impossible values
# ------------------------------------------------------------
df <- df %>%
  mutate(across(all_of(hdds_vars), ~ as.numeric(.x))) %>%
  mutate(across(all_of(hdds_vars),
                ~ ifelse(.x < 0 | .x >= 2, NA_real_, .x)))

# ------------------------------------------------------------
# 3) Compute HDDS
# ------------------------------------------------------------
df <- df %>%
  mutate(
    HDDS = HDDSStapCer + HDDSStapRoot + HDDSPulse + HDDSDairy +
      HDDSPrMeat + HDDSPrFish + HDDSPrEggs +
      HDDSVeg + HDDSFruit + HDDSFat + HDDSSugar + HDDSCond
  )

# ------------------------------------------------------------
# 4) Clean impossible HDDS values
#    Valid range: 0–12
# ------------------------------------------------------------
df <- df %>%
  mutate(
    HDDS = ifelse(HDDS < 0 | HDDS >= 13, NA_real_, HDDS)
  )


# ------------------------------------------------------------
# 5) Data quality flags (HDDS internal + cross-check with FCS)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    # Absolute HDDS checks
    HDDS_flag_zero = ifelse(!is.na(HDDS) & HDDS == 0, 1L, 0L),
    HDDS_flag_low  = ifelse(!is.na(HDDS) & HDDS <= 2, 1L, 0L),
    HDDS_flag_high = ifelse(!is.na(HDDS) & HDDS >= 10, 1L, 0L),
    
    # Cross-checks against FCS module (7 days)
    HDDS_flag_cereal  = ifelse(FCSStap  == 7 & HDDSStapCer == 0 & HDDSStapRoot == 0, 1L, 0L),
    HDDS_flag_pulses  = ifelse(FCSPulse == 7 & HDDSPulse   == 0, 1L, 0L),
    HDDS_flag_dairy   = ifelse(FCSDairy == 7 & HDDSDairy   == 0, 1L, 0L),
    HDDS_flag_protein = ifelse(FCSPr == 7 &
                                 HDDSPrMeat == 0 & HDDSPrEggs == 0 & HDDSPrFish == 0, 1L, 0L),
    HDDS_flag_veg     = ifelse(FCSVeg   == 7 & HDDSVeg     == 0, 1L, 0L),
    HDDS_flag_fruit   = ifelse(FCSFruit == 7 & HDDSFruit   == 0, 1L, 0L),
    HDDS_flag_fat     = ifelse(FCSFat   == 7 & HDDSFat     == 0, 1L, 0L),
    HDDS_flag_sugar   = ifelse(FCSSugar == 7 & HDDSSugar   == 0, 1L, 0L),
    HDDS_flag_cond    = ifelse(FCSCond  == 7 & HDDSCond    == 0, 1L, 0L)
  )

# ------------------------------------------------------------
# 6) Check flagged cases
# ------------------------------------------------------------
flag_vars <- c(
  "HDDS_flag_zero","HDDS_flag_low","HDDS_flag_high",
  "HDDS_flag_cereal","HDDS_flag_pulses","HDDS_flag_dairy",
  "HDDS_flag_protein","HDDS_flag_veg","HDDS_flag_fruit",
  "HDDS_flag_fat","HDDS_flag_sugar","HDDS_flag_cond"
)

lapply(flag_vars, function(v) table(df[[v]], useNA = "ifany"))

# ------------------------------------------------------------
# 7) Optional: IPC-oriented HDDS categories
# ------------------------------------------------------------
df <- df %>%
  mutate(
    HDDSCat_IPC = case_when(
      is.na(HDDS) ~ NA_integer_,
      HDDS <= 2   ~ 3L,
      HDDS %in% c(3,4) ~ 2L,
      HDDS >= 5   ~ 1L
    ),
    HDDSCat_IPC = factor(
      HDDSCat_IPC,
      levels = c(1,2,3),
      labels = c(
        "5–12 food groups (IPC phase 1–2)",
        "3–4 food groups (IPC phase 3)",
        "0–2 food groups (IPC phase 4–5)"
      )
    )
  )

table(df$HDDSCat_IPC, useNA = "ifany")

