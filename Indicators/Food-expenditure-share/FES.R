# ------------------------------------------------------------
# WFP Standardized Scripts
# Food Expenditure Share (FES)
# Last Updated: January 2026
# ------------------------------------------------------------

library(dplyr)

# -----------------------------
# 0) Variable lists (7D food)
# -----------------------------
food_purch_7d <- c(
  "HHExpFCer_Purch_MN_7D","HHExpFTub_Purch_MN_7D","HHExpFPuls_Purch_MN_7D",
  "HHExpFVeg_Purch_MN_7D","HHExpFFrt_Purch_MN_7D","HHExpFAnimMeat_Purch_MN_7D",
  "HHExpFAnimFish_Purch_MN_7D","HHExpFFats_Purch_MN_7D","HHExpFDairy_Purch_MN_7D",
  "HHExpFEgg_Purch_MN_7D","HHExpFSgr_Purch_MN_7D","HHExpFCond_Purch_MN_7D",
  "HHExpFBev_Purch_MN_7D","HHExpFOut_Purch_MN_7D"
)

food_gift_7d <- c(
  "HHExpFCer_GiftAid_MN_7D","HHExpFTub_GiftAid_MN_7D","HHExpFPuls_GiftAid_MN_7D",
  "HHExpFVeg_GiftAid_MN_7D","HHExpFFrt_GiftAid_MN_7D","HHExpFAnimMeat_GiftAid_MN_7D",
  "HHExpFAnimFish_GiftAid_MN_7D","HHExpFFats_GiftAid_MN_7D","HHExpFDairy_GiftAid_MN_7D",
  "HHExpFEgg_GiftAid_MN_7D","HHExpFSgr_GiftAid_MN_7D","HHExpFCond_GiftAid_MN_7D",
  "HHExpFBev_GiftAid_MN_7D","HHExpFOut_GiftAid_MN_7D"
)

food_own_7d <- c(
  "HHExpFCer_Own_MN_7D","HHExpFTub_Own_MN_7D","HHExpFPuls_Own_MN_7D",
  "HHExpFVeg_Own_MN_7D","HHExpFFrt_Own_MN_7D","HHExpFAnimMeat_Own_MN_7D",
  "HHExpFAnimFish_Own_MN_7D","HHExpFFats_Own_MN_7D","HHExpFDairy_Own_MN_7D",
  "HHExpFEgg_Own_MN_7D","HHExpFSgr_Own_MN_7D","HHExpFCond_Own_MN_7D",
  "HHExpFBev_Own_MN_7D","HHExpFOut_Own_MN_7D"
)

# -----------------------------
# 1) Non-food variables (1M)
# -----------------------------
nf_purch_1m <- c(
  "HHExpNFHyg_Purch_MN_1M","HHExpNFTransp_Purch_MN_1M","HHExpNFFuel_Purch_MN_1M",
  "HHExpNFWat_Purch_MN_1M","HHExpNFElec_Purch_MN_1M","HHExpNFEnerg_Purch_MN_1M",
  "HHExpNFDwelSer_Purch_MN_1M","HHExpNFPhone_Purch_MN_1M","HHExpNFRecr_Purch_MN_1M",
  "HHExpNFAlcTobac_Purch_MN_1M"
)

nf_gift_1m <- c(
  "HHExpNFHyg_GiftAid_MN_1M","HHExpNFTransp_GiftAid_MN_1M","HHExpNFFuel_GiftAid_MN_1M",
  "HHExpNFWat_GiftAid_MN_1M","HHExpNFElec_GiftAid_MN_1M","HHExpNFEnerg_GiftAid_MN_1M",
  "HHExpNFDwelSer_GiftAid_MN_1M","HHExpNFPhone_GiftAid_MN_1M","HHExpNFRecr_GiftAid_MN_1M",
  "HHExpNFAlcTobac_GiftAid_MN_1M"
)

# -----------------------------
# 2) Non-food variables (6M)
# -----------------------------
nf_purch_6m <- c(
  "HHExpNFMedServ_Purch_MN_6M","HHExpNFMedGood_Purch_MN_6M","HHExpNFCloth_Purch_MN_6M",
  "HHExpNFEduFee_Purch_MN_6M","HHExpNFEduGood_Purch_MN_6M","HHExpNFRent_Purch_MN_6M",
  "HHExpNFHHSoft_Purch_MN_6M","HHExpNFHHMaint_Purch_MN_6M"
)

nf_gift_6m <- c(
  "HHExpNFMedServ_GiftAid_MN_6M","HHExpNFMedGood_GiftAid_MN_6M","HHExpNFCloth_GiftAid_MN_6M",
  "HHExpNFEduFee_GiftAid_MN_6M","HHExpNFEduGood_GiftAid_MN_6M","HHExpNFRent_GiftAid_MN_6M",
  "HHExpNFHHSoft_GiftAid_MN_6M","HHExpNFHHMaint_GiftAid_MN_6M"
)

# Helper: row sum that returns NA if all inputs are NA
rowSum_na <- function(mat) {
  s <- rowSums(mat, na.rm = TRUE)
  all_na <- rowSums(!is.na(mat)) == 0
  s[all_na] <- NA_real_
  s
}

# ------------------------------------------------------------
# 3) Convert system-missing (NA) expenditures to 0 
#    Applied to all food and non-food expenditure inputs
# ------------------------------------------------------------
all_exp_vars <- c(food_purch_7d, food_gift_7d, food_own_7d, nf_purch_1m, nf_gift_1m, nf_purch_6m, nf_gift_6m)

df <- df %>%
  mutate(across(all_of(all_exp_vars), ~ as.numeric(.x))) %>%
  mutate(across(all_of(all_exp_vars), ~ ifelse(is.na(.x), 0, .x)))

# ------------------------------------------------------------
# 4) Quick overview (min/max/mean) for potential outliers
# ------------------------------------------------------------
exp_overview <- df %>%
  summarise(across(all_of(all_exp_vars),
                   list(min = ~min(.x, na.rm = TRUE),
                        max = ~max(.x, na.rm = TRUE),
                        mean = ~mean(.x, na.rm = TRUE))))
exp_overview

# ------------------------------------------------------------
# 5) Compute monthly FOOD totals by source (7D → 1M with 30/7)
# ------------------------------------------------------------
df <- df %>%
  mutate(
    HHExp_Food_Purch_MN_1M   = rowSums(across(all_of(food_purch_7d))) * (30/7),
    HHExp_Food_GiftAid_MN_1M = rowSums(across(all_of(food_gift_7d)))  * (30/7),
    HHExp_Food_Own_MN_1M     = rowSums(across(all_of(food_own_7d)))   * (30/7)
  )

# ------------------------------------------------------------
# 6) Compute monthly NON-FOOD totals (1M + (6M/6))
# ------------------------------------------------------------
df <- df %>%
  mutate(
    HHExpNFTotal_Purch_MN_30D   = rowSums(across(all_of(nf_purch_1m))),
    HHExpNFTotal_Purch_MN_6M    = rowSums(across(all_of(nf_purch_6m))),
    HHExpNFTotal_Purch_MN_1M    = HHExpNFTotal_Purch_MN_30D + (HHExpNFTotal_Purch_MN_6M / 6),
    
    HHExpNFTotal_GiftAid_MN_30D = rowSums(across(all_of(nf_gift_1m))),
    HHExpNFTotal_GiftAid_MN_6M  = rowSums(across(all_of(nf_gift_6m))),
    HHExpNFTotal_GiftAid_MN_1M  = HHExpNFTotal_GiftAid_MN_30D + (HHExpNFTotal_GiftAid_MN_6M / 6)
  )

# ------------------------------------------------------------
# 7) Compute total food, non-food, and total monthly expenditures
# ------------------------------------------------------------
df <- df %>%
  mutate(
    HHExpF_1M  = HHExp_Food_Purch_MN_1M + HHExp_Food_GiftAid_MN_1M + HHExp_Food_Own_MN_1M,
    HHExpNF_1M = HHExpNFTotal_Purch_MN_1M + HHExpNFTotal_GiftAid_MN_1M,
    HHExp_1M   = HHExpF_1M + HHExpNF_1M
  )

# Optional quick check of totals
totals_check <- df %>%
  summarise(
    food_min = min(HHExpF_1M, na.rm = TRUE), food_max = max(HHExpF_1M, na.rm = TRUE), food_mean = mean(HHExpF_1M, na.rm = TRUE),
    nf_min   = min(HHExpNF_1M, na.rm = TRUE), nf_max   = max(HHExpNF_1M, na.rm = TRUE), nf_mean   = mean(HHExpNF_1M, na.rm = TRUE),
    tot_min  = min(HHExp_1M,  na.rm = TRUE), tot_max  = max(HHExp_1M,  na.rm = TRUE), tot_mean  = mean(HHExp_1M,  na.rm = TRUE)
  )

totals_check

# ------------------------------------------------------------
# 8) Compute FES and 4-point classification
#      <0.50, 0.50–0.65, 0.65–0.75, >=0.75
# ------------------------------------------------------------
df <- df %>%
  mutate(
    FES = ifelse(HHExp_1M > 0, HHExpF_1M / HHExp_1M, NA_real_),
    
    Foodexp_4pt = case_when(
      is.na(FES)               ~ NA_integer_,
      FES < 0.50               ~ 1L,
      FES >= 0.50 & FES < 0.65 ~ 2L,
      FES >= 0.65 & FES < 0.75 ~ 3L,
      FES >= 0.75              ~ 4L
    ),
    Foodexp_4pt = factor(
      Foodexp_4pt,
      levels = c(1,2,3,4),
      labels = c("Low Food Expenditure Share (<50%)",
                 "Medium Food Expenditure Share (50-65%)",
                 "High Food Expenditure Share (65-75%)",
                 "Very High Food Expenditure Share (> 75%)")
    )
  )

table(df$Foodexp_4pt, useNA = "ifany")

# Optional: express as percent (0–100) for reporting
df <- df %>% mutate(FES_pct = 100 * FES)
summary(df$FES_pct)

