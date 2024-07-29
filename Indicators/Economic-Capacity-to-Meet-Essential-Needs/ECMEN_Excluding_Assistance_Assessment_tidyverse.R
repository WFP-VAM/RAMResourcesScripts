# ------------------------------------------------------------------------------

# R scripts for the Economic Capacity to Meet Essential Needs (ECMEN)
# Version excluding assistance (for assessments)

# ------------------------------------------------------------------------------

## ECMEN calculation is based on the standard module available here: 
#   https://docs.wfp.org/api/documents/WFP-0000115416/download/
## Detailed guidance on the computation of the ECMEN can be found here: 
#   https://docs.wfp.org/api/documents/WFP-0000145644/download/

## Note 1: 
#  In the version used for assessment: 
#     a) the household economic capacity aggregate should not include the value 
#     of consumed in-kind assistance gifts; 
#     b) the value of the cash assistance received from the humanitarian sector 
#     should be deducted from the household economic capacity aggregate (but 
#     only for the estimated share of the cash assistance that is used for 
#     consumption, when available).

## Note 2: 
#    The computation of the ECMEN requires having already established a Minimum 
#    Expenditure Basket (MEB). More information on MEBs can be found here: 
#    https://docs.wfp.org/api/documents/WFP-0000074198/download/

# Load Package -----------------------------------------------------------------

library(tidyverse)
library(labelled)
library(expss)
library(dplyr)

# Set path ---------------------------------------------------------------------

getwd()   # Display current working directory
dir()     # Display working directory content

# change path to your working folder
#setwd("/Users/nicolewu/Desktop")
# add sample data
#data <- read_csv("sample_data.csv") #read.spss and other formats can also work

# Set switches -----------------------------------------------------------------

EXP_food_label     = T
EXP_food_cc        = T
EXP_food_gift      = T
EXP_food_own       = T
EXP_nonfood_label  = T
EXP_nonfood_cc     = T
EXP_nonfood_gift   = T
EXP_total          = T
DED_assistance     = T
ECMEN_percapita    = T
ECMEN_MEB          = T
ECMEN_SMEB         = T

# 1. Create variables for food expenditure, by source --------------------------
# Important note: add recall period of _7D or _1M to the variables names below 
# depending on what has been selected for your CO. It is recommended to follow 
# standard recall periods as in the module.

## 1.a Label variables ---------------------------------------------------------

if(EXP_food_label){

    var_label(data$HHExpFCer_Purch_MN_7D)         <- "Expenditures on cereals"
    var_label(data$HHExpFCer_GiftAid_MN_7D)       <- "Value of consumed in-kind assistance and gifts - cereals"
    var_label(data$HHExpFCer_Own_MN_7D)           <- "Value of consumed own production - cereals"
    
    var_label(data$HHExpFTub_Purch_MN_7D)         <- "Expenditures on tubers"
    var_label(data$HHExpFTub_GiftAid_MN_7D)       <- "Value of consumed in-kind assistance and gifts - tubers"
    var_label(data$HHExpFTub_Own_MN_7D)           <- "Value of consumed own production - tubers"
    
    var_label(data$HHExpFPuls_Purch_MN_7D)        <- "Expenditures on pulses & nuts"
    var_label(data$HHExpFPuls_GiftAid_MN_7D)      <- "Value of consumed in-kind assistance and gifts - pulses and nuts"
    var_label(data$HHExpFPuls_Own_MN_7D)          <- "Value of consumed own production - pulses & nuts"
    
    var_label(data$HHExpFVeg_Purch_MN_7D)         <- "Expenditures on vegetables"
    var_label(data$HHExpFVeg_GiftAid_MN_7D)       <- "Value of consumed in-kind assistance and gifts - vegetables"
    var_label(data$HHExpFVeg_Own_MN_7D)           <- "Value of consumed own production - vegetables"
   
    var_label(data$HHExpFFrt_Purch_MN_7D)         <- "Expenditures on fruits"
    var_label(data$HHExpFFrt_GiftAid_MN_7D)       <- "Value of consumed in-kind assistance and gifts - fruits"
    var_label(data$HHExpFFrt_Own_MN_7D)           <- "Value of consumed own production - fruits"
    
    var_label(data$HHExpFAnimMeat_Purch_MN_7D)    <- "Expenditures on meat"
    var_label(data$HHExpFAnimMeat_GiftAid_MN_7D)  <- "Value of consumed in-kind assistance and gifts - meat"
    var_label(data$HHExpFAnimMeat_Own_MN_7D)      <- "Value of consumed own production - meat"
    
    var_label(data$HHExpFAnimFish_Purch_MN_7D)    <- "Expenditures on fish"
    var_label(data$HHExpFAnimFish_GiftAid_MN_7D)  <- "Value of consumed in-kind assistance and gifts - fish"
    var_label(data$HHExpFAnimFish_Own_MN_7D)      <- "Value of consumed own production - fish"
    
    var_label(data$HHExpFFats_Purch_MN_7D)        <- "Expenditures on fats"
    var_label(data$HHExpFFats_GiftAid_MN_7D)      <- "Value of consumed in-kind assistance and gifts - fats"
    var_label(data$HHExpFFats_Own_MN_7D)          <- "Value of consumed own production - fats"
    
    var_label(data$HHExpFDairy_Purch_MN_7D)       <- "Expenditures on milk/dairy products"
    var_label(data$HHExpFDairy_GiftAid_MN_7D)     <- "Value of consumed in-kind assistance and gifts - milk/dairy products"
    var_label(data$HHExpFDairy_Own_MN_7D)         <- "Value of consumed own production - milk/dairy products"
    
    var_label(data$HHExpFEgg_Purch_MN_7D)         <- "Expenditures on eggs"
    var_label(data$HHExpFEgg_GiftAid_MN_7D)       <- "Value of consumed in-kind assistance and gifts - eggs"
    var_label(data$HHExpFEgg_Own_MN_7D)           <- "Value of consumed own production - eggs"
    
    var_label(data$HHExpFSgr_Purch_MN_7D)         <- "Expenditures on sugar/confectionery/desserts"
    var_label(data$HHExpFSgr_GiftAid_MN_7D)       <- "Value of consumed in-kind assistance and gifts - sugar/confectionery/desserts"
    var_label(data$HHExpFSgr_Own_MN_7D)           <- "Value of consumed own production - sugar/confectionery/desserts"
    
    var_label(data$HHExpFCond_Purch_MN_7D)        <- "Expenditures on condiments"
    var_label(data$HHExpFCond_GiftAid_MN_7D)      <- "Value of consumed in-kind assistance and gifts - condiments"
    var_label(data$HHExpFCond_Own_MN_7D)          <- "Value of consumed own production - condiments"
    
    var_label(data$HHExpFBev_Purch_MN_7D)         <- "Expenditures on beverages"
    var_label(data$HHExpFBev_GiftAid_MN_7D)       <- "Value of consumed in-kind assistance and gifts - beverages"
    var_label(data$HHExpFBev_Own_MN_7D)           <- "Value of consumed own production - beverages"
    
    var_label(data$HHExpFOut_Purch_MN_7D)         <- "Expenditures on snacks/meals prepared outside"
    var_label(data$HHExpFOut_GiftAid_MN_7D)       <- "Value of consumed in-kind assistance and gifts - snacks/meals prepared outside"
    var_label(data$HHExpFOut_Own_MN_7D)           <- "Value of consumed own production - snacks/meals prepared outside"
    
  # If the questionnaire included further food categories/items label the respective variables
  # var_label(data$)   <- ""
}

## 1.b Calculate total value of food expenditures/consumption by source --------

# If the expenditure recall period is 7 days; make sure to express the newly 
# created variables in monthly terms by multiplying by 30/7

# Monthly food expenditures in cash/credit -------------------------------------

if(EXP_food_cc){

  data$HHExp_Food_Purch_MN_1M <- rowSums(data[c("HHExpFCer_Purch_MN_7D", 
                                                "HHExpFTub_Purch_MN_7D", 
                                                "HHExpFPuls_Purch_MN_7D", 
                                                "HHExpFVeg_Purch_MN_7D",
                                                "HHExpFFrt_Purch_MN_7D" , 
                                                "HHExpFAnimMeat_Purch_MN_7D",
                                                "HHExpFAnimFish_Purch_MN_7D",
                                                "HHExpFFats_Purch_MN_7D",
                                                "HHExpFDairy_Purch_MN_7D",
                                                "HHExpFEgg_Purch_MN_7D",
                                                "HHExpFSgr_Purch_MN_7D",
                                                "HHExpFCond_Purch_MN_7D",
                                                "HHExpFBev_Purch_MN_7D", 
                                                "HHExpFOut_Purch_MN_7D")],
                                         na.rm = TRUE)
  
  data$HHExp_Food_Purch_MN_1M <- ifelse(is.na( data$HHExp_Food_Purch_MN_1M), 0, data$HHExp_Food_Purch_MN_1M)
  
  data$HHExp_Food_Purch_MN_1M <- data$HHExp_Food_Purch_MN_1M * 30 / 7
  
# conversion in monthly terms - do it only if recall period for food was 7 days
  var_label(data$HHExp_Food_Purch_MN_1M)           <- "Total monthly food expenditure (cash and credit)"

  }

# Monthly value of consumed food from gift/aid ---------------------------------

if(EXP_food_gift){
  
  data$HHExp_Food_GiftAid_MN_1M <- rowSums(data[c("HHExpFCer_GiftAid_MN_7D",
                                                  "HHExpFTub_GiftAid_MN_7D", 
                                                  "HHExpFPuls_GiftAid_MN_7D", 
                                                  "HHExpFVeg_GiftAid_MN_7D",
                                                  "HHExpFFrt_GiftAid_MN_7D" , 
                                                  "HHExpFAnimMeat_GiftAid_MN_7D",
                                                  "HHExpFAnimFish_GiftAid_MN_7D",
                                                  "HHExpFFats_GiftAid_MN_7D",
                                                  "HHExpFDairy_GiftAid_MN_7D",
                                                  "HHExpFEgg_GiftAid_MN_7D",
                                                  "HHExpFSgr_GiftAid_MN_7D",
                                                  "HHExpFCond_GiftAid_MN_7D",
                                                  "HHExpFBev_GiftAid_MN_7D", 
                                                  "HHExpFOut_GiftAid_MN_7D")],
                                          na.rm = TRUE)
  
  data$HHExp_Food_GiftAid_MN_1M <- ifelse(is.na(data$HHExp_Food_GiftAid_MN_1M), 0, data$HHExp_Food_GiftAid_MN_1M)
  
  data$HHExp_Food_GiftAid_MN_1M <- data$HHExp_Food_GiftAid_MN_1M * 30 / 7
  
  # conversion in monthly terms - do it only if recall period for food was 7 days
  var_label(data$HHExp_Food_GiftAid_MN_1M)           <- "Total monthly food consumption from gifts/aid"
  
}

# Monthly value of consumed food from own-production ---------------------------

if(EXP_food_own){
  
  data$HHExp_Food_Own_MN_1M <- rowSums(data[c("HHExpFCer_Own_MN_7D", 
                                              "HHExpFTub_Own_MN_7D", 
                                              "HHExpFPuls_Own_MN_7D", 
                                              "HHExpFVeg_Own_MN_7D",
                                              "HHExpFFrt_Own_MN_7D" , 
                                              "HHExpFAnimMeat_Own_MN_7D",
                                              "HHExpFAnimFish_Own_MN_7D",
                                              "HHExpFFats_Own_MN_7D",
                                              "HHExpFDairy_Own_MN_7D",
                                              "HHExpFEgg_Own_MN_7D",
                                              "HHExpFSgr_Own_MN_7D",
                                              "HHExpFCond_Own_MN_7D",
                                              "HHExpFBev_Own_MN_7D", 
                                              "HHExpFOut_Own_MN_7D")],
                                         na.rm = TRUE)
  
  data$HHExp_Food_Own_MN_1M <- ifelse(is.na(data$HHExp_Food_Own_MN_1M), 0, data$HHExp_Food_Own_MN_1M)
 
  data$HHExp_Food_Own_MN_1M <- data$HHExp_Food_Own_MN_1M * 30 / 7
  
  # conversion in monthly terms - do it only if recall period for food was 7 days
  var_label(data$HHExp_Food_Own_MN_1M)           <- "Total monthly food consumption from own-production"
  
}

# 2. Create variables for non-food expenditure, by source ----------------------

## 2.a Label variables ---------------------------------------------------------

if(EXP_nonfood_label){
# 1 month recall period - variables labels
    var_label(data$HHExpNFHyg_Purch_MN_1M)               <- "Expenditures on hygiene"
    var_label(data$HHExpNFHyg_GiftAid_MN_1M)             <- "Value of consumed in-kind assistance-gifts - hygiene"
    var_label(data$HHExpNFTransp_Purch_MN_1M)            <- "Expenditures on transport"
    var_label(data$HHExpNFTransp_GiftAid_MN_1M)          <- "Value of consumed in-kind assistance-gifts - transport"
    var_label(data$HHExpNFFuel_Purch_MN_1M)              <- "Expenditures on fuel"
    var_label(data$HHExpNFFuel_GiftAid_MN_1M)            <- "Value of consumed in-kind assistance-gifts - fuel"
    var_label(data$HHExpNFWat_Purch_MN_1M)               <- "Expenditures on water"
    var_label(data$HHExpNFWat_GiftAid_MN_1M)             <- "Value of consumed in-kind assistance-gifts - water"
    var_label(data$HHExpNFElec_Purch_MN_1M)              <- "Expenditures on electricity"
    var_label(data$HHExpNFElec_GiftAid_MN_1M)            <- "Value of consumed in-kind assistance-gifts - electricity"
    var_label(data$HHExpNFEnerg_Purch_MN_1M)             <- "Expenditures on energy (not electricity)"
    var_label(data$HHExpNFEnerg_GiftAid_MN_1M)           <- "Value of consumed in-kind assistance-gifts - energy (not electricity)"
    var_label(data$HHExpNFDwelSer_Purch_MN_1M)           <- "Expenditures on services related to dwelling"
    var_label(data$HHExpNFDwelSer_GiftAid_MN_1M)         <- "Value of consumed in-kind assistance-gifts - services related to dwelling"
    var_label(data$HHExpNFPhone_Purch_MN_1M)             <- "Expenditures on communication"
    var_label(data$HHExpNFPhone_GiftAid_MN_1M)           <- "Value of consumed in-kind assistance-gifts - communication"
    var_label(data$HHExpNFRecr_Purch_MN_1M)              <- "Expenditures on recreation"
    var_label(data$HHExpNFRecr_GiftAid_MN_1M)            <- "Value of consumed in-kind assistance-gifts - recreation"
    var_label(data$HHExpNFAlcTobac_Purch_MN_1M)          <- "Expenditures on alcohol/tobacco"
    var_label(data$HHExpNFAlcTobac_GiftAid_MN_1M)        <- "Value of consumed in-kind assistance-gifts - alcohol/tobacco"

# 6 months recall period - variables labels 
    var_label(data$HHExpNFMedServ_Purch_MN_6M)           <- "Expenditures on health services"
    var_label(data$HHExpNFMedServ_GiftAid_MN_6M)         <- "Value of consumed in-kind assistance-gifts - health services"
    var_label(data$HHExpNFMedGood_Purch_MN_6M)           <- "Expenditures on medicines and health products"
    var_label(data$HHExpNFMedGood_GiftAid_MN_6M)         <- "Value of consumed in-kind assistance-gifts - medicines and health products"
    var_label(data$HHExpNFCloth_Purch_MN_6M)             <- "Expenditures on clothing and footwear"
    var_label(data$HHExpNFCloth_GiftAid_MN_6M)           <- "Value of consumed in-kind assistance-gifts - clothing and footwear"
    var_label(data$HHExpNFEduFee_Purch_MN_6M)            <- "Expenditures on education services"
    var_label(data$HHExpNFEduFee_GiftAid_MN_6M)          <- "Value of consumed in-kind assistance-gifts - education services"
    var_label(data$HHExpNFEduGood_Purch_MN_6M)           <- "Expenditures on education goods"
    var_label(data$HHExpNFEduGood_GiftAid_MN_6M)         <- "Value of consumed in-kind assistance-gifts - education goods"
    var_label(data$HHExpNFRent_Purch_MN_6M)              <- "Expenditures on rent"
    var_label(data$HHExpNFRent_GiftAid_MN_6M)            <- "Value of consumed in-kind assistance-gifts - rent"
    var_label(data$HHExpNFHHSoft_Purch_MN_6M)            <- "Expenditures on non-durable furniture/utensils"
    var_label(data$HHExpNFHHSoft_GiftAid_MN_6M)          <- "Value of consumed in-kind assistance-gifts - non-durable furniture/utensils"
    var_label(data$HHExpNFHHMaint_Purch_MN_6M)           <- "Expenditures on household routine maintenance"
    var_label(data$HHExpNFHHMaint_GiftAid_MN_6M)         <- "Value of consumed in-kind assistance-gifts - household routine maintenance"

 # If the questionnaire included further food categories/items label the respective variables
 # var_label(data$)   <- ""
    
}

## 2.b Calculate total value of non-food expenditures/consumption by source ----

# Total non-food expenditure (cash/credit) -------------------------------------

if(EXP_nonfood_cc){
  # 30 days recall
  data$HHExpNFTotal_Purch_MN_30D <- rowSums(data[c("HHExpNFHyg_Purch_MN_1M", 
                                                   "HHExpNFTransp_Purch_MN_1M", 
                                                   "HHExpNFFuel_Purch_MN_1M",
                                                   "HHExpNFWat_Purch_MN_1M",
                                                   "HHExpNFElec_Purch_MN_1M", 
                                                   "HHExpNFEnerg_Purch_MN_1M",
                                                   "HHExpNFDwelSer_Purch_MN_1M",
                                                   "HHExpNFPhone_Purch_MN_1M",
                                                   "HHExpNFRecr_Purch_MN_1M",
                                                   "HHExpNFAlcTobac_Purch_MN_1M")],
                                            na.rm = TRUE)
  
  data$HHExpNFTotal_Purch_MN_30D <- ifelse(is.na(data$HHExpNFTotal_Purch_MN_30D), 0, data$HHExpNFTotal_Purch_MN_30D)
  
  # 6 months recall
  data$HHExpNFTotal_Purch_MN_6M <- rowSums(data[c("HHExpNFMedServ_Purch_MN_6M", 
                                                  "HHExpNFMedGood_Purch_MN_6M", 
                                                  "HHExpNFCloth_Purch_MN_6M",
                                                  "HHExpNFEduFee_Purch_MN_6M",
                                                  "HHExpNFEduGood_Purch_MN_6M", 
                                                  "HHExpNFRent_Purch_MN_6M",
                                                  "HHExpNFHHSoft_Purch_MN_6M",
                                                  "HHExpNFHHMaint_Purch_MN_6M")],
                                           na.rm = TRUE)

  data$HHExpNFTotal_Purch_MN_6M <- ifelse(is.na(data$HHExpNFTotal_Purch_MN_6M), 0, data$HHExpNFTotal_Purch_MN_6M)
  # careful with rent: should include only if also included in MEB
  
  # Express 6 months in monthly terms
  data$HHExpNFTotal_Purch_MN_6M <- data$HHExpNFTotal_Purch_MN_6M/6
  
  # Sum
  data$HHExpNFTotal_Purch_MN_1M <- rowSums(data[c("HHExpNFTotal_Purch_MN_30D", 
                                                  "HHExpNFTotal_Purch_MN_6M")],
                                           na.rm = TRUE)
  
  data$HHExpNFTotal_Purch_MN_1M <- ifelse(is.na(data$HHExpNFTotal_Purch_MN_1M), 0, data$HHExpNFTotal_Purch_MN_1M)
  
  var_label(data$HHExpNFTotal_Purch_MN_1M)            <- "Total monthly non-food expenditure (cash and credit)"

  # Drop intermediate variables
  data <- select(data, -c(HHExpNFTotal_Purch_MN_6M, HHExpNFTotal_Purch_MN_30D))
  
}

# Total value of consumed non-food from gift/aid -------------------------------

if(EXP_nonfood_gift){
  # 30 days recall
  data$HHExpNFTotal_GiftAid_MN_30D <- rowSums(data[c("HHExpNFHyg_GiftAid_MN_1M", 
                                                     "HHExpNFTransp_GiftAid_MN_1M", 
                                                     "HHExpNFFuel_GiftAid_MN_1M",
                                                     "HHExpNFWat_GiftAid_MN_1M",
                                                     "HHExpNFElec_GiftAid_MN_1M", 
                                                     "HHExpNFEnerg_GiftAid_MN_1M",
                                                     "HHExpNFDwelSer_GiftAid_MN_1M",
                                                     "HHExpNFPhone_GiftAid_MN_1M",
                                                     "HHExpNFRecr_GiftAid_MN_1M",
                                                     "HHExpNFAlcTobac_GiftAid_MN_1M")],
                                            na.rm = TRUE)
  
  data$HHExpNFTotal_GiftAid_MN_30D <- ifelse(is.na(data$HHExpNFTotal_GiftAid_MN_30D), 0, data$HHExpNFTotal_GiftAid_MN_30D)
  
  # 6 months recall
  data$HHExpNFTotal_GiftAid_MN_6M <- rowSums(data[c("HHExpNFMedServ_GiftAid_MN_6M", 
                                                    "HHExpNFMedGood_GiftAid_MN_6M", 
                                                    "HHExpNFCloth_GiftAid_MN_6M",
                                                    "HHExpNFEduFee_GiftAid_MN_6M",
                                                    "HHExpNFEduGood_GiftAid_MN_6M", 
                                                    "HHExpNFRent_GiftAid_MN_6M",
                                                    "HHExpNFHHSoft_GiftAid_MN_6M",
                                                    "HHExpNFHHMaint_GiftAid_MN_6M")],
                                             na.rm = TRUE)
  
  data$HHExpNFTotal_GiftAid_MN_6M <- ifelse(is.na(data$HHExpNFTotal_GiftAid_MN_6M), 0, data$HHExpNFTotal_GiftAid_MN_6M)
  # careful with rent: should include only if also included in MEB
  
  # Express 6 months in monthly terms
  data$HHExpNFTotal_GiftAid_MN_6M <- data$HHExpNFTotal_GiftAid_MN_6M/6
  
  # Sum
  data$HHExpNFTotal_GiftAid_MN_1M <- rowSums(data[c("HHExpNFTotal_GiftAid_MN_30D", 
                                                    "HHExpNFTotal_GiftAid_MN_6M")],
                                             na.rm = TRUE)
  
  data$HHExpNFTotal_GiftAid_MN_1M <- ifelse(is.na(data$HHExpNFTotal_GiftAid_MN_1M), 0, data$HHExpNFTotal_GiftAid_MN_1M)
  
  var_label(data$HHExpNFTotal_GiftAid_MN_1M)            <- "Total monthly non-food consumption from gifts/aid"
  
  # Drop intermediate variables
  data <- select(data, -c(HHExpNFTotal_GiftAid_MN_6M, HHExpNFTotal_GiftAid_MN_30D))
  
}

# 3. Calculate household economic capacity -------------------------------------
# Note: Remember that for the version of ECMEN used for assessments (excluding 
# assistance), the value of consumed in-kind assistance and gifts should be 
# excluded from the household economic capacity aggregate.

if(EXP_total){
  
  # Aggregate food expenditures and value of consumed food from own production
  data$HHExpF_ECMEN <- rowSums(data[c("HHExp_Food_Purch_MN_1M", 
                                      "HHExp_Food_Own_MN_1M")],
                               na.rm = TRUE)
  
  data$HHExpF_ECMEN <- ifelse(is.na(data$HHExpF_ECMEN), 0, data$HHExpF_ECMEN)

  # For NF only expenditures are considered
  data$HHExpNF_ECMEN <- data$HHExpNFTotal_Purch_MN_1M
  
  # Aggregate food and non-food
  data$HHExp_ECMEN <- rowSums(data[c("HHExpF_ECMEN", 
                                     "HHExpNF_ECMEN")],
                               na.rm = TRUE)
  
  data$HHExp_ECMEN <- ifelse(is.na(data$HHExp_ECMEN), 0, data$HHExp_ECMEN)
  
  var_label(data$HHExp_ECMEN)            <- "Household Economic Capacity - monthly"
  
}  

# 4. Deduct cash assistance ----------------------------------------------------

if(DED_assistance){
  
  var_label(data$HHAsstWFPCBTRecTot)         <- "Amount of cash assistance received from WFP - last 3 months"
  var_label(data$HHAsstUNNGOCBTRecTot)       <- "Amount of cash assistance received by other humanitarian partners - last 3 months"
  var_label(data$HHAsstCBTCShare)            <- "Share of cash assistance spent on consumption"
  
# Sum the amount of cash assistance received by WFP and other humanitarian partners 
# (UN Agencies and NGOs) - do not include cash received from government, other 
# organizations, and other households
  
  data$HHAsstCBTRec <- rowSums(data[c("HHAsstWFPCBTRecTot", 
                                      "HHAsstUNNGOCBTRecTot")],
                              na.rm = TRUE)
  
  data$HHAsstCBTRec <- ifelse(is.na(data$HHAsstCBTRec), 0, data$HHAsstCBTRec)

# Express in monthly terms 
  data$HHAsstCBTRec_1M <- data$HHAsstCBTRec / 3 
  # Attention: if recall period is different than standard 3 months, divide by the 
  # relevant number of months
  
# Estimate the median share of assistance used for consumption
  data$HHAsstCBTCShare_med <- median(data$HHAsstCBTCShare, na.rm = TRUE)

# Multiply the cash assistance received by the median share used for consumption
  data$HHAsstCBTRec_Cons_1M = data$HHAsstCBTRec_1M * (data$HHAsstCBTCShare_med/100)

# Deduct the cash assistance from the hh economic capacity
  data$HHExp_ECMEN <- ifelse(is.na(data$HHAsstCBTRec_Cons_1M), 
                             data$HHExp_ECMEN - 0, 
                             data$HHExp_ECMEN - data$HHAsstCBTRec_Cons_1M)
# here we specify that if cash assistance is missing it should be interpreted as = 0

}
    
# 5. Express household economic capacity in per capita terms -------------------

if(ECMEN_percapita){
  
  data$PCExp_ECMEN <- data$HHExp_ECMEN / data$HHSize
  # Make sure to rename the hh size variable as appropriate
  
  var_label(data$PCExp_ECMEN)            <- "Household Economic Capacity per capita - monthly"
  summary(data$PCExp_ECMEN)
  
}

# 6. Compute ECMEN -------------------------------------------------------------
# Important: make sure that MEB and SMEB variables are expressed in per capita terms!

## 6.a MEB ---------------------------------------------------------------------
# Define variable indicating if PC Household Economic Capacity is equal or 
# greater than MEB

if(ECMEN_MEB){
  
  data$ECMEN_exclAsst <- ifelse((!is.na(data$PCExp_ECMEN) & !is.na(data$MEB)), 
                                (data$PCExp_ECMEN > data$MEB), NA)
  
  # Make sure to rename MEB variable as appropriate
  var_label(data$ECMEN_exclAsst)            <- "Economic capacity to meet essential needs - excluding assistance"
  
  val_lab(data$ECMEN_exclAsst) = num_lab("
             1 Above MEB
             0 Below MEB
          ")
  # Compute the indicator (use weights when applicable!)
  table(data$ECMEN_exclAsst)
  
}

## 6.b SMEB (when applicable) --------------------------------------------------
# * Define variable indicating if PC Household Economic Capacity is equal or 
# greater than SMEB

if(ECMEN_SMEB){
  
  data$ECMEN_exclAsst_SMEB <- ifelse((!is.na(data$PCExp_ECMEN) & !is.na(data$SMEB)), 
                                     (data$PCExp_ECMEN > data$SMEB), NA)
  # Make sure to rename SMEB variable as appropriate
  var_label(data$ECMEN_exclAsst_SMEB)            <- "Economic capacity to meet essential needs - SMEB - excluding assistance"
  
  val_lab(data$ECMEN_exclAsst_SMEB) = num_lab("
             1 Above SMEB
             0 Below SMEB
          ")
  # Compute the indicator (use weights when applicable!)
  table(data$ECMEN_exclAsst_SMEB)
  
}

# END OF SCRIPTS
