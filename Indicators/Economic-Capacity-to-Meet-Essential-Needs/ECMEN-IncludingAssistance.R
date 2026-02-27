# ------------------------------------------------------------
# WFP Standardized Scripts
# Economic Capacity to Meet Essential Needs (ECMEN) – Monitoring
# Version INCLUDING assistance (in-kind gifts/aid included)
# Last Updated: January 2026
# ------------------------------------------------------------

library(dplyr)

# -----------------------------
# 0) Food expenditure inputs (7D recall)
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
# 1) Non-food expenditure inputs (1M recall + 6M recall)
# Purchases (cash/credit) and GiftAid both used in monitoring ECMEN
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

# Set these to your actual names if different
hh_size_var <- "HHSize"   # household size
meb_var     <- "MEB"      # per-capita MEB
smeb_var    <- "sMEB"     # per-capita SMEB (optional)

# -----------------------------
# 2) Convert NA to 0 for expenditure inputs
# -----------------------------
all_inputs <- c(food_purch_7d, food_gift_7d, food_own_7d,
                nf_purch_1m, nf_gift_1m, nf_purch_6m, nf_gift_6m)

df <- df %>%
  mutate(across(all_of(all_inputs), ~ as.numeric(.x))) %>%
  mutate(across(all_of(all_inputs), ~ dplyr::coalesce(.x, 0)))

# -----------------------------
# 3) Compute monthly food totals by source (7D -> 1M with 30/7)
# -----------------------------
df <- df %>%
  mutate(
    HHExp_Food_Purch_MN_1M   = rowSums(across(all_of(food_purch_7d))) * (30/7),
    HHExp_Food_GiftAid_MN_1M = rowSums(across(all_of(food_gift_7d)))  * (30/7),
    HHExp_Food_Own_MN_1M     = rowSums(across(all_of(food_own_7d)))   * (30/7)
  )

# -----------------------------
# 4) Compute monthly non-food totals (purchases + gift/aid)
#    30D + (6M/6)
# -----------------------------
df <- df %>%
  mutate(
    HHExpNFTotal_Purch_MN_30D   = rowSums(across(all_of(nf_purch_1m))),
    HHExpNFTotal_Purch_MN_6M    = rowSums(across(all_of(nf_purch_6m))),
    HHExpNFTotal_Purch_MN_1M    = HHExpNFTotal_Purch_MN_30D + (HHExpNFTotal_Purch_MN_6M / 6),
    
    HHExpNFTotal_GiftAid_MN_30D = rowSums(across(all_of(nf_gift_1m))),
    HHExpNFTotal_GiftAid_MN_6M  = rowSums(across(all_of(nf_gift_6m))),
    HHExpNFTotal_GiftAid_MN_1M  = HHExpNFTotal_GiftAid_MN_30D + (HHExpNFTotal_GiftAid_MN_6M / 6)
  )

# -----------------------------
# 5) Household economic capacity (MONITORING, including assistance)
#    Food: Purch + GiftAid + Own
#    Non-food: Purch + GiftAid
# -----------------------------
df <- df %>%
  mutate(
    HHExpF_ECMEN  = HHExp_Food_Purch_MN_1M + HHExp_Food_GiftAid_MN_1M + HHExp_Food_Own_MN_1M,
    HHExpNF_ECMEN = HHExpNFTotal_Purch_MN_1M + HHExpNFTotal_GiftAid_MN_1M,
    HHExp_ECMEN   = HHExpF_ECMEN + HHExpNF_ECMEN
  )

# -----------------------------
# 6) Per-capita economic capacity
# -----------------------------
df <- df %>%
  mutate(
    PCExp_ECMEN = HHExp_ECMEN / .data[[hh_size_var]]
  )

# -----------------------------
# 7) ECMEN classification vs MEB (per-capita)
# -----------------------------
df <- df %>%
  mutate(
    ECMEN_inclAsst = if_else(
      !is.na(PCExp_ECMEN) & !is.na(.data[[meb_var]]),
      as.integer(PCExp_ECMEN > .data[[meb_var]]),
      NA_integer_
    )
  )

df <- df %>%
  mutate(
    ECMEN_inclAsst = factor(
      ECMEN_inclAsst,
      levels = c(0, 1),
      labels = c("Below MEB", "Above MEB")
    )
  )

print(table(df$ECMEN_inclAsst, useNA = "ifany"))

# -----------------------------
# 8) Optional SMEB version (if SMEB exists)
# -----------------------------
if (smeb_var %in% names(df)) {
  df <- df %>%
    mutate(
      ECMEN_inclAsst_SMEB = if_else(
        !is.na(PCExp_ECMEN) & !is.na(.data[[smeb_var]]),
        as.integer(PCExp_ECMEN > .data[[smeb_var]]),
        NA_integer_
      )
    )
  
  df <- df %>%
    mutate(
      ECMEN_inclAsst_SMEB = factor(
        ECMEN_inclAsst_SMEB,,
        levels = c(0, 1),
        labels = c("Below MEB", "Above MEB")
      )
    )
  
  
  print(table(df$ECMEN_inclAsst_SMEB, useNA = "ifany"))
}
