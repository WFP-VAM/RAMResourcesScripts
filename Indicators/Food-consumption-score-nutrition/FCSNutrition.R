# ------------------------------------------------------------
# WFP Standardized Scripts - Food Consumption Score - Nutrition (FCS-N)
# Last Updated: January 2026
# ------------------------------------------------------------

library(dplyr)

# Required subgroup variables (FCS-N module)
fcsn_vars <- c(
  "FCSNPrMeatF","FCSNPrMeatO","FCSNPrFish","FCSNPrEggs",
  "FCSNVegOrg","FCSNVegGre","FCSNFruiOrg"
)

# Required main-group variables from the standard FCS module (for flags + aggregates)
# Protein main group: FCSPr; Vegetable main group: FCSVeg; Fruit main group: FCSFruit
# Also used in aggregates: FCSDairy, FCSPulse
main_needed <- c("FCSPr","FCSVeg","FCSFruit","FCSDairy","FCSPulse")

# ------------------------------------------------------------
# 0) (Optional) quick descriptive check of subgroup distributions
# ------------------------------------------------------------
fcsn_stats_before <- df %>%
  summarise(across(all_of(fcsn_vars),
                   list(min = ~min(as.numeric(.x), na.rm = TRUE),
                        max = ~max(as.numeric(.x), na.rm = TRUE),
                        mean = ~mean(as.numeric(.x), na.rm = TRUE))))
fcsn_stats_before

# ------------------------------------------------------------
# 1) Recode subgroup missing to 0 (Survey Designer behavior)
# ------------------------------------------------------------
df <- df %>%
  mutate(across(all_of(fcsn_vars), ~ as.numeric(.x))) %>%
  mutate(across(all_of(fcsn_vars), ~ ifelse(is.na(.x), 0, .x)))

# ------------------------------------------------------------
# 2) Clean impossible subgroup values
# ------------------------------------------------------------
df <- df %>%
  mutate(across(all_of(fcsn_vars), ~ ifelse(.x < 0 | .x >= 8, NA_real_, .x)))

# ------------------------------------------------------------
# 3) Flags: subgroup exceeds main group
# ------------------------------------------------------------
df <- df %>%
  mutate(
    FCSN_flag_protein = ifelse(
      !is.na(FCSPr) & (
        ( !is.na(FCSNPrMeatF) & FCSNPrMeatF > FCSPr ) |
          ( !is.na(FCSNPrMeatO) & FCSNPrMeatO > FCSPr ) |
          ( !is.na(FCSNPrFish)  & FCSNPrFish  > FCSPr ) |
          ( !is.na(FCSNPrEggs)  & FCSNPrEggs  > FCSPr )
      ),
      1L, 0L
    ),
    FCSN_flag_veg = ifelse(
      !is.na(FCSVeg) & (
        ( !is.na(FCSNVegOrg) & FCSNVegOrg > FCSVeg ) |
          ( !is.na(FCSNVegGre) & FCSNVegGre > FCSVeg )
      ),
      1L, 0L
    ),
    FCSN_flag_fruit = ifelse(
      !is.na(FCSFruit) & !is.na(FCSNFruiOrg) & (FCSNFruiOrg > FCSFruit),
      1L, 0L
    )
  )

# Flag distributions
table(df$FCSN_flag_protein, useNA = "ifany")
table(df$FCSN_flag_veg,     useNA = "ifany")
table(df$FCSN_flag_fruit,   useNA = "ifany")

# ------------------------------------------------------------
# 4) Compute nutrient aggregates (Vitamin A, Protein, Hem Iron)
# ------------------------------------------------------------

# Helper: row sum that returns NA when all inputs are NA
rowSum_na <- function(mat) {
  s <- rowSums(mat, na.rm = TRUE)
  all_na <- rowSums(!is.na(mat)) == 0
  s[all_na] <- NA_real_
  s
}

df <- df %>%
  mutate(
    FGVitA = rowSum_na(cbind(FCSDairy, FCSNPrMeatO, FCSNPrEggs, FCSNVegOrg, FCSNVegGre, FCSNFruiOrg)),
    FGProtein = rowSum_na(cbind(FCSPulse, FCSDairy, FCSNPrMeatF, FCSNPrMeatO, FCSNPrFish, FCSNPrEggs)),
    FGHIron = rowSum_na(cbind(FCSNPrMeatF, FCSNPrMeatO, FCSNPrFish))
  )

# ------------------------------------------------------------
# 5) Recode aggregates into 3 categories:
#    0 -> 1 (never), 1-6 -> 2 (sometimes), 7-42 -> 3 (daily)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    VitA_Cat = case_when(
      is.na(FGVitA)        ~ NA_integer_,
      FGVitA == 0          ~ 1L,
      FGVitA >= 1 & FGVitA <= 6  ~ 2L,
      FGVitA >= 7 & FGVitA <= 42 ~ 3L,
      TRUE ~ NA_integer_   # outside expected range
    ),
    Protein_Cat = case_when(
      is.na(FGProtein)        ~ NA_integer_,
      FGProtein == 0          ~ 1L,
      FGProtein >= 1 & FGProtein <= 6  ~ 2L,
      FGProtein >= 7 & FGProtein <= 42 ~ 3L,
      TRUE ~ NA_integer_
    ),
    Haem_iron_Cat = case_when(
      is.na(FGHIron)        ~ NA_integer_,
      FGHIron == 0          ~ 1L,
      FGHIron >= 1 & FGHIron <= 6  ~ 2L,
      FGHIron >= 7 & FGHIron <= 42 ~ 3L,
      TRUE ~ NA_integer_
    ),
    
    # Apply labels as factors (mirrors SPSS VALUE LABELS)
    VitA_Cat = factor(VitA_Cat, levels = c(1,2,3),
                      labels = c("0 time (never consumed)",
                                 "1-6 times (consumed sometimes)",
                                 "7 times or more (consumed at least daily)")),
    Protein_Cat = factor(Protein_Cat, levels = c(1,2,3),
                         labels = c("0 time (never consumed)",
                                    "1-6 times (consumed sometimes)",
                                    "7 times or more (consumed at least daily)")),
    Haem_iron_Cat = factor(Haem_iron_Cat, levels = c(1,2,3),
                           labels = c("0 time (never consumed)",
                                      "1-6 times (consumed sometimes)",
                                      "7 times or more (consumed at least daily)"))
  )

# ------------------------------------------------------------
# 6) Check results
# ------------------------------------------------------------
table(df$VitA_Cat,      useNA = "ifany")
table(df$Protein_Cat,   useNA = "ifany")
table(df$Haem_iron_Cat, useNA = "ifany")

