# ------------------------------------------------------------
# WFP Standardized Scripts
# Economic Capacity to Meet Essential Needs (ECMEN) – Assessments
# Version excluding assistance (and deducting humanitarian cash used for consumption)
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
# 1) Non-food expenditure inputs (cash/credit only for ECMEN)
#    1M recall (short-term)
# -----------------------------
nf_purch_1m <- c(
  "HHExpNFHyg_Purch_MN_1M","HHExpNFTransp_Purch_MN_1M","HHExpNFFuel_Purch_MN_1M",
  "HHExpNFWat_Purch_MN_1M","HHExpNFElec_Purch_MN_1M","HHExpNFEnerg_Purch_MN_1M",
  "HHExpNFDwelSer_Purch_MN_1M","HHExpNFPhone_Purch_MN_1M","HHExpNFRecr_Purch_MN_1M",
  "HHExpNFAlcTobac_Purch_MN_1M"
)

# 6M recall (long-term) converted to monthly average by /6
nf_purch_6m <- c(
  "HHExpNFMedServ_Purch_MN_6M","HHExpNFMedGood_Purch_MN_6M","HHExpNFCloth_Purch_MN_6M",
  "HHExpNFEduFee_Purch_MN_6M","HHExpNFEduGood_Purch_MN_6M","HHExpNFRent_Purch_MN_6M",
  "HHExpNFHHSoft_Purch_MN_6M","HHExpNFHHMaint_Purch_MN_6M"
)

# -----------------------------
# 2) Assistance variables (assessments)
# -----------------------------
asst_vars <- c("HHAsstWFPCBTRecTot","HHAsstUNNGOCBTRecTot","HHAsstCBTCShare")

# If your HH size variable is not HHSize, rename here:
hh_size_var <- "HHSize"   # <-- change if needed (e.g., "hh_size")

# If your MEB variables are named differently, rename here:
meb_var  <- "MEB"   # per capita MEB
smeb_var <- "sMEB"  # per capita SMEB (optional)

# -----------------------------
# 3) Convert SYSMIS (NA) expenditures to 0 (SPSS: SYSMIS=0)
# -----------------------------
all_exp_inputs <- c(food_purch_7d, food_gift_7d, food_own_7d, nf_purch_1m, nf_purch_6m)

df <- df %>%
  mutate(across(all_of(all_exp_inputs), ~ as.numeric(.x))) %>%
  mutate(across(all_of(all_exp_inputs), ~ dplyr::coalesce(.x, 0)))

# -----------------------------
# 4) (Optional) quick overview for outliers (min/max/mean)
# -----------------------------
exp_overview <- df %>%
  summarise(across(all_of(all_exp_inputs),
                   list(min = ~min(.x, na.rm = TRUE),
                        max = ~max(.x, na.rm = TRUE),
                        mean = ~mean(.x, na.rm = TRUE))))
exp_overview

# -----------------------------
# 5) Compute monthly food totals by source (7D -> 1M with 30/7)
# -----------------------------
df <- df %>%
  mutate(
    HHExp_Food_Purch_MN_1M   = rowSums(across(all_of(food_purch_7d))) * (30/7),
    HHExp_Food_GiftAid_MN_1M = rowSums(across(all_of(food_gift_7d)))  * (30/7),
    HHExp_Food_Own_MN_1M     = rowSums(across(all_of(food_own_7d)))   * (30/7)
  )

# -----------------------------
# 6) Compute monthly non-food (cash/credit only) = 30D + (6M/6)
# -----------------------------
df <- df %>%
  mutate(
    HHExpNFTotal_Purch_MN_30D = rowSums(across(all_of(nf_purch_1m))),
    HHExpNFTotal_Purch_MN_6M  = rowSums(across(all_of(nf_purch_6m))),
    HHExpNFTotal_Purch_MN_1M  = HHExpNFTotal_Purch_MN_30D + (HHExpNFTotal_Purch_MN_6M / 6)
  )

# -----------------------------
# 7) Household economic capacity for ECMEN (ASSESSMENTS)
#    IMPORTANT: exclude in-kind gifts/aid from the aggregate
#    Food: Purch + Own (exclude GiftAid)
#    Non-food: Purch only
# -----------------------------
df <- df %>%
  mutate(
    HHExpF_ECMEN  = HHExp_Food_Purch_MN_1M + HHExp_Food_Own_MN_1M,
    HHExpNF_ECMEN = HHExpNFTotal_Purch_MN_1M,
    HHExp_ECMEN   = HHExpF_ECMEN + HHExpNF_ECMEN
  )

# -----------------------------
# 8) Deduct humanitarian cash assistance used for consumption (ASSESSMENTS)
# -----------------------------
df <- df %>%
  mutate(
    HHAsstWFPCBTRecTot     = dplyr::coalesce(as.numeric(HHAsstWFPCBTRecTot), 0),
    HHAsstUNNGOCBTRecTot   = dplyr::coalesce(as.numeric(HHAsstUNNGOCBTRecTot), 0),
    HHAsstCBTCShare        = as.numeric(HHAsstCBTCShare),
    
    HHAsstCBTRec       = HHAsstWFPCBTRecTot + HHAsstUNNGOCBTRecTot,
    HHAsstCBTRec_1M    = HHAsstCBTRec / 3
  )

# Median share used for consumption (if all missing -> treat as 0)
asst_share_med <- median(df$HHAsstCBTCShare, na.rm = TRUE)
if (is.na(asst_share_med)) asst_share_med <- 0

df <- df %>%
  mutate(
    HHAsstCBTCShare_med      = asst_share_med,
    HHAsstCBTRec_Cons_1M     = HHAsstCBTRec_1M * (HHAsstCBTCShare_med / 100),
    HHAsstCBTRec_Cons_1M     = dplyr::coalesce(HHAsstCBTRec_Cons_1M, 0),
    HHExp_ECMEN              = HHExp_ECMEN - HHAsstCBTRec_Cons_1M
  )

# -----------------------------
# 9) Per-capita economic capacity (monthly)
# -----------------------------
df <- df %>%
  mutate(
    PCExp_ECMEN = HHExp_ECMEN / .data[[hh_size_var]]
  )

# -----------------------------
# 10) ECMEN classification vs MEB (per-capita)
# -----------------------------
df <- df %>%
  mutate(
    ECMEN_exclAsst = if_else(
      !is.na(PCExp_ECMEN) & !is.na(.data[[meb_var]]),
      as.integer(PCExp_ECMEN > .data[[meb_var]]),
      NA_integer_
    )
  )

df <- df %>%
  mutate(
    ECMEN_exclAsst = factor(
      ECMEN_exclAsst,
      levels = c(0, 1),
      labels = c("Below MEB", "Above MEB")
    )
  )


table(df$ECMEN_exclAsst, useNA = "ifany")

# Optional SMEB version (only if SMEB exists in your dataset)
if (smeb_var %in% names(df)) {
  df <- df %>%
    mutate(
      ECMEN_exclAsst_SMEB = if_else(
        !is.na(PCExp_ECMEN) & !is.na(.data[[smeb_var]]),
        as.integer(PCExp_ECMEN > .data[[smeb_var]]),
        NA_integer_
      )
    )
  
  df <- df %>%
    mutate(
      ECMEN_exclAsst_SMEB = factor(
        ECMEN_exclAsst_SMEB,
        levels = c(0, 1),
        labels = c("Below MEB", "Above MEB")
      )
    )
  
  smeb_tab <- table(df$ECMEN_exclAsst_SMEB, useNA = "ifany")
  print(smeb_tab)
}


