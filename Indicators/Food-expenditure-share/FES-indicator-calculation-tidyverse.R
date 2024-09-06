#------------------------------------------------------------------------------#
#	                        WFP Standardized Scripts
#                      Calculating Food Expenditure Share (FES)
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#
library(dplyr)
library(readr)
library(labelled)

# Load Sample Data ------------------------------------------------------------#
#data <- read_csv("FES_Sample_Survey.csv")

# Label Variables -------------------------------------------------------------#
var_label(data$HHExpFCer_Purch_MN_7D)        <- "Expenditures on cereals"
var_label(data$HHExpFCer_GiftAid_MN_7D)      <- "Value of consumed in-kind assistance and gifts - cereals"
var_label(data$HHExpFCer_Own_MN_7D)          <- "Value of consumed own production - cereals"
var_label(data$HHExpFTub_Purch_MN_7D)        <- "Expenditures on tubers"
var_label(data$HHExpFTub_GiftAid_MN_7D)      <- "Value of consumed in-kind assistance and gifts - tubers"
var_label(data$HHExpFTub_Own_MN_7D)          <- "Value of consumed own production - tubers"
var_label(data$HHExpFPuls_Purch_MN_7D)       <- "Expenditures on pulses & nuts"
var_label(data$HHExpFPuls_GiftAid_MN_7D)     <- "Value of consumed in-kind assistance and gifts - pulses and nuts"
var_label(data$HHExpFPuls_Own_MN_7D)         <- "Value of consumed own production - pulses & nuts"
var_label(data$HHExpFVeg_Purch_MN_7D)        <- "Expenditures on vegetables"
var_label(data$HHExpFVeg_GiftAid_MN_7D)      <- "Value of consumed in-kind assistance and gifts - vegetables"
var_label(data$HHExpFVeg_Own_MN_7D)          <- "Value of consumed own production - vegetables"
var_label(data$HHExpFFrt_Purch_MN_7D)        <- "Expenditures on fruits"
var_label(data$HHExpFFrt_GiftAid_MN_7D)      <- "Value of consumed in-kind assistance and gifts - fruits"
var_label(data$HHExpFFrt_Own_MN_7D)          <- "Value of consumed own production - fruits"
var_label(data$HHExpFAnimMeat_Purch_MN_7D)   <- "Expenditures on meat"
var_label(data$HHExpFAnimMeat_GiftAid_MN_7D) <- "Value of consumed in-kind assistance and gifts - meat"
var_label(data$HHExpFAnimMeat_Own_MN_7D)     <- "Value of consumed own production - meat"
var_label(data$HHExpFAnimFish_Purch_MN_7D)   <- "Expenditures on fish"
var_label(data$HHExpFAnimFish_GiftAid_MN_7D) <- "Value of consumed in-kind assistance and gifts - fish"
var_label(data$HHExpFAnimFish_Own_MN_7D)     <- "Value of consumed own production - fish"
var_label(data$HHExpFFats_Purch_MN_7D)       <- "Expenditures on fats"
var_label(data$HHExpFFats_GiftAid_MN_7D)     <- "Value of consumed in-kind assistance and gifts - fats"
var_label(data$HHExpFFats_Own_MN_7D)         <- "Value of consumed own production - fats"
var_label(data$HHExpFDairy_Purch_MN_7D)      <- "Expenditures on milk/dairy products"
var_label(data$HHExpFDairy_GiftAid_MN_7D)    <- "Value of consumed in-kind assistance and gifts - milk/dairy products"
var_label(data$HHExpFDairy_Own_MN_7D)        <- "Value of consumed own production - milk/dairy products"
var_label(data$HHExpFEgg_Purch_MN_7D)        <- "Expenditures on eggs"
var_label(data$HHExpFEgg_GiftAid_MN_7D)      <- "Value of consumed in-kind assistance and gifts - eggs"
var_label(data$HHExpFEgg_Own_MN_7D)          <- "Value of consumed own production - eggs"
var_label(data$HHExpFSgr_Purch_MN_7D)        <- "Expenditures on sugar/confectionery/desserts"
var_label(data$HHExpFSgr_GiftAid_MN_7D)      <- "Value of consumed in-kind assistance and gifts - sugar/confectionery/desserts"
var_label(data$HHExpFSgr_Own_MN_7D)          <- "Value of consumed own production - sugar/confectionery/desserts"
var_label(data$HHExpFCond_Purch_MN_7D)       <- "Expenditures on condiments"
var_label(data$HHExpFCond_GiftAid_MN_7D)     <- "Value of consumed in-kind assistance and gifts - condiments"
var_label(data$HHExpFCond_Own_MN_7D)         <- "Value of consumed own production - condiments"
var_label(data$HHExpFBev_Purch_MN_7D)        <- "Expenditures on beverages"
var_label(data$HHExpFBev_GiftAid_MN_7D)      <- "Value of consumed in-kind assistance and gifts - beverages"
var_label(data$HHExpFBev_Own_MN_7D)          <- "Value of consumed own production - beverages"
var_label(data$HHExpFOut_Purch_MN_7D)        <- "Expenditures on snacks/meals prepared outside"
var_label(data$HHExpFOut_GiftAid_MN_7D)      <- "Value of consumed in-kind assistance and gifts - snacks/meals prepared outside"
var_label(data$HHExpFOut_Own_MN_7D)          <- "Value of consumed own production - snacks/meals prepared outside"

# Calculate total value of food expenditures/consumption by source -------------#

# Calculate total value of food expenditures/consumption by source -------------#

# Monthly food expenditures in cash/credit
data$HHExp_Food_Purch_MN_1M <- rowSums(data[c("HHExpFCer_Purch_MN_7D", 
                                              "HHExpFTub_Purch_MN_7D", 
                                              "HHExpFPuls_Purch_MN_7D", 
                                              "HHExpFVeg_Purch_MN_7D",
                                              "HHExpFFrt_Purch_MN_7D", 
                                              "HHExpFAnimMeat_Purch_MN_7D",
                                              "HHExpFAnimFish_Purch_MN_7D",
                                              "HHExpFFats_Purch_MN_7D",
                                              "HHExpFDairy_Purch_MN_7D",
                                              "HHExpFEgg_Purch_MN_7D",
                                              "HHExpFSgr_Purch_MN_7D",
                                              "HHExpFCond_Purch_MN_7D",
                                              "HHExpFBev_Purch_MN_7D", 
                                              "HHExpFOut_Purch_MN_7D")], 
                                       na.rm = TRUE) * (30/7)
var_label(data$HHExp_Food_Purch_MN_1M)      <- "Total monthly food expenditure (cash and credit)"

# Monthly value of consumed food from gifts/aid
data$HHExp_Food_GiftAid_MN_1M <- rowSums(data[c("HHExpFCer_GiftAid_MN_7D", 
                                                "HHExpFTub_GiftAid_MN_7D", 
                                                "HHExpFPuls_GiftAid_MN_7D", 
                                                "HHExpFVeg_GiftAid_MN_7D",
                                                "HHExpFFrt_GiftAid_MN_7D", 
                                                "HHExpFAnimMeat_GiftAid_MN_7D",
                                                "HHExpFAnimFish_GiftAid_MN_7D",
                                                "HHExpFFats_GiftAid_MN_7D",
                                                "HHExpFDairy_GiftAid_MN_7D",
                                                "HHExpFEgg_GiftAid_MN_7D",
                                                "HHExpFSgr_GiftAid_MN_7D",
                                                "HHExpFCond_GiftAid_MN_7D",
                                                "HHExpFBev_GiftAid_MN_7D", 
                                                "HHExpFOut_GiftAid_MN_7D")], 
                                         na.rm = TRUE) * (30/7)
var_label(data$HHExp_Food_GiftAid_MN_1M)    <- "Total monthly food consumption from gifts/aid"

# Monthly value of consumed food from own-production
data$HHExp_Food_Own_MN_1M <- rowSums(data[c("HHExpFCer_Own_MN_7D", 
                                            "HHExpFTub_Own_MN_7D", 
                                            "HHExpFPuls_Own_MN_7D", 
                                            "HHExpFVeg_Own_MN_7D",
                                            "HHExpFFrt_Own_MN_7D", 
                                            "HHExpFAnimMeat_Own_MN_7D",
                                            "HHExpFAnimFish_Own_MN_7D",
                                            "HHExpFFats_Own_MN_7D",
                                            "HHExpFDairy_Own_MN_7D",
                                            "HHExpFEgg_Own_MN_7D",
                                            "HHExpFSgr_Own_MN_7D",
                                            "HHExpFCond_Own_MN_7D",
                                            "HHExpFBev_Own_MN_7D", 
                                            "HHExpFOut_Own_MN_7D")], 
                                     na.rm = TRUE) * (30/7)
var_label(data$HHExp_Food_Own_MN_1M)       <- "Total monthly food consumption from own-production"

# Label variables for non-food expenditures -----------------------------------#
# Non-food expenditures (1 month recall period)
var_label(data$HHExpNFHyg_Purch_MN_1M)        <- "Expenditures on hygiene"
var_label(data$HHExpNFHyg_GiftAid_MN_1M)      <- "Value of consumed in-kind assistance-gifts - hygiene"
var_label(data$HHExpNFTransp_Purch_MN_1M)     <- "Expenditures on transport"
var_label(data$HHExpNFTransp_GiftAid_MN_1M)   <- "Value of consumed in-kind assistance-gifts - transport"
var_label(data$HHExpNFFuel_Purch_MN_1M)       <- "Expenditures on fuel"
var_label(data$HHExpNFFuel_GiftAid_MN_1M)     <- "Value of consumed in-kind assistance-gifts - fuel"
var_label(data$HHExpNFWat_Purch_MN_1M)        <- "Expenditures on water"
var_label(data$HHExpNFWat_GiftAid_MN_1M)      <- "Value of consumed in-kind assistance-gifts - water"
var_label(data$HHExpNFElec_Purch_MN_1M)       <- "Expenditures on electricity"
var_label(data$HHExpNFElec_GiftAid_MN_1M)     <- "Value of consumed in-kind assistance-gifts - electricity"
var_label(data$HHExpNFEnerg_Purch_MN_1M)      <- "Expenditures on energy (not electricity)"
var_label(data$HHExpNFEnerg_GiftAid_MN_1M)    <- "Value of consumed in-kind assistance-gifts - energy (not electricity)"
var_label(data$HHExpNFDwelSer_Purch_MN_1M)    <- "Expenditures on services related to dwelling"
var_label(data$HHExpNFDwelSer_GiftAid_MN_1M)  <- "Value of consumed in-kind assistance-gifts - services related to dwelling"
var_label(data$HHExpNFPhone_Purch_MN_1M)      <- "Expenditures on communication"
var_label(data$HHExpNFPhone_GiftAid_MN_1M)    <- "Value of consumed in-kind assistance-gifts - communication"
var_label(data$HHExpNFRecr_Purch_MN_1M)       <- "Expenditures on recreation"
var_label(data$HHExpNFRecr_GiftAid_MN_1M)     <- "Value of consumed in-kind assistance-gifts - recreation"
var_label(data$HHExpNFAlcTobac_Purch_MN_1M)   <- "Expenditures on alcohol/tobacco"
var_label(data$HHExpNFAlcTobac_GiftAid_MN_1M) <- "Value of consumed in-kind assistance-gifts - alcohol/tobacco"

# Non-food expenditures (6 months recall period)
var_label(data$HHExpNFMedServ_Purch_MN_6M)    <- "Expenditures on health services"
var_label(data$HHExpNFMedServ_GiftAid_MN_6M)  <- "Value of consumed in-kind assistance-gifts - health services"
var_label(data$HHExpNFMedGood_Purch_MN_6M)    <- "Expenditures on medicines and health products"
var_label(data$HHExpNFMedGood_GiftAid_MN_6M)  <- "Value of consumed in-kind assistance-gifts - medicines and health products"
var_label(data$HHExpNFCloth_Purch_MN_6M)      <- "Expenditures on clothing and footwear"
var_label(data$HHExpNFCloth_GiftAid_MN_6M)    <- "Value of consumed in-kind assistance-gifts - clothing and footwear"
var_label(data$HHExpNFEduFee_Purch_MN_6M)     <- "Expenditures on education services"
var_label(data$HHExpNFEduFee_GiftAid_MN_6M)   <- "Value of consumed in-kind assistance-gifts - education services"
var_label(data$HHExpNFEduGood_Purch_MN_6M)    <- "Expenditures on education goods"
var_label(data$HHExpNFEduGood_GiftAid_MN_6M)  <- "Value of consumed in-kind assistance-gifts - education goods"
var_label(data$HHExpNFRent_Purch_MN_6M)       <- "Expenditures on rent"
var_label(data$HHExpNFRent_GiftAid_MN_6M)     <- "Value of consumed in-kind assistance-gifts - rent"
var_label(data$HHExpNFHHSoft_Purch_MN_6M)     <- "Expenditures on non-durable furniture/utensils"
var_label(data$HHExpNFHHSoft_GiftAid_MN_6M)   <- "Value of consumed in-kind assistance-gifts - non-durable furniture/utensils"
var_label(data$HHExpNFHHMaint_Purch_MN_6M)    <- "Expenditures on household routine maintenance"
var_label(data$HHExpNFHHMaint_GiftAid_MN_6M)  <- "Value of consumed in-kind assistance-gifts - household routine maintenance"

# 1 month recall period
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

# Label variable for total monthly non-food expenditure (cash and credit)
var_label(data$HHExpNFTotal_Purch_MN_1M) <- "Total monthly non-food expenditure (cash and credit)"
# Drop intermediate columns
data <- data %>% select(-HHExpNFTotal_Purch_MN_6M, -HHExpNFTotal_Purch_MN_30D)

data$HHExpNFTotal_Purch_MN_6M <- rowSums(data[c("HHExpNFMedServ_Purch_MN_6M", 
                                                "HHExpNFMedGood_Purch_MN_6M", 
                                                "HHExpNFCloth_Purch_MN_6M", 
                                                "HHExpNFEduFee_Purch_MN_6M", 
                                                "HHExpNFEduGood_Purch_MN_6M", 
                                                "HHExpNFRent_Purch_MN_6M", 
                                                "HHExpNFHHSoft_Purch_MN_6M", 
                                                "HHExpNFHHMaint_Purch_MN_6M")], 
                                         na.rm = TRUE) / 6

data$HHExpNFTotal_Purch_MN_1M <- data$HHExpNFTotal_Purch_MN_30D + data$HHExpNFTotal_Purch_MN_6M

# Monthly value of consumed non-food from gifts/aid
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

# Label variable for total monthly non-food consumption from gifts/aid
var_label(data$HHExpNFTotal_GiftAid_MN_1M) <- "Total monthly non-food consumption from gifts/aid"
# Drop intermediate columns
data <- data %>% select(-HHExpNFTotal_GiftAid_MN_6M, -HHExpNFTotal_GiftAid_MN_30D)

data$HHExpNFTotal_GiftAid_MN_6M <- rowSums(data[c("HHExpNFMedServ_GiftAid_MN_6M", 
                                                  "HHExpNFMedGood_GiftAid_MN_6M", 
                                                  "HHExpNFCloth_GiftAid_MN_6M", 
                                                  "HHExpNFEduFee_GiftAid_MN_6M", 
                                                  "HHExpNFEduGood_GiftAid_MN_6M", 
                                                  "HHExpNFRent_GiftAid_MN_6M", 
                                                  "HHExpNFHHSoft_GiftAid_MN_6M", 
                                                  "HHExpNFHHMaint_GiftAid_MN_6M")], 
                                           na.rm = TRUE) / 6

data$HHExpNFTotal_GiftAid_MN_1M <- data$HHExpNFTotal_GiftAid_MN_30D + data$HHExpNFTotal_GiftAid_MN_6M

# Aggregate food expenditures, value of consumed food from gifts/assistance, and value of consumed food from own production
data$HHExpF_1M <- rowSums(data[c("HHExp_Food_Purch_MN_1M", 
                                 "HHExp_Food_GiftAid_MN_1M", 
                                 "HHExp_Food_Own_MN_1M")], 
                          na.rm = TRUE)

# Aggregate NF expenditures and value of consumed non-food from gifts/assistance
data$HHExpNF_1M <- rowSums(data[c("HHExpNFTotal_Purch_MN_1M", 
                                  "HHExpNFTotal_GiftAid_MN_1M")], 
                           na.rm = TRUE)

# Compute FES
# Aggregate total food and non-food expenditures
data$HHExpTot_1M <- rowSums(data[c("HHExpF_1M", "HHExpNF_1M")], 
                            na.rm = TRUE)

# Compute FES for each household
data$FES <- data$HHExpF_1M / data$HHExpTot_1M
var_label(data$FES) <- "Household food expenditure share"

# Drop intermediate column
data <- data %>% select(-HHExpTot_1M)

# Transform FES to 4 categories
data$Foodexp_4pt <- cut(data$FES, 
                        breaks = c(-Inf, 0.4999999, 0.65, 0.75, Inf), 
                        labels = c("<50%", "50-65%", "65-75%", ">=75%"))

var_label(data$Foodexp_4pt) <- "Food expenditure share categories"

# Define value labels for Foodexp_4pt
data$Foodexp_4pt <- factor(data$Foodexp_4pt, 
                           levels = c("<50%", "50-65%", "65-75%", ">=75%"))

# Compute FES indicator
table(data$Foodexp_4pt)

# End of Scripts