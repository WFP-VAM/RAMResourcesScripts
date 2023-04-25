library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/FCSN_Sample_Survey.csv")

#assign variable and value labels
#variable labels
var_label(data$FCSNPrMeatF) <- "Consumption in past 7 days: Flesh meat"
var_label(data$FCSNPrMeatO) <- "Consumption in past 7 days: Organ meat"
var_label(data$FCSNPrFish)  <- "Consumption in past 7 days: Fish/shellfish"
var_label(data$FCSNPrEggs)  <- "Consumption in past 7 days: Eggs"
var_label(data$FCSNVegOrg)  <- "Consumption in past 7 days: Orange vegetables (vegetables rich in Vitamin A)"
var_label(data$FCSNVegGre)  <- "Consumption in past 7 days: Green leafy vegetables"
var_label(data$FCSNFruiOrg) <- "Consumption in past 7 days: Orange fruits (Fruits rich in Vitamin A)"
	
#recode "n/a" values to 0
vars2recode <- c("FCSNPrMeatF","FCSNPrMeatO","FCSNPrFish","FCSNPrEggs","FCSNVegOrg","FCSNVegGre","FCSNFruiOrg")

data <- data %>% mutate_at(vars2recode, ~replace(., . == "n/a", "0"))
data <- data %>% mutate_at(vars2recode, as.numeric)
  
#compute aggregates of key micronutrient consumption of vitamin, iron and protein 
data <- data %>% mutate(FGVitA = FCSDairy +FCSNPrMeatO +FCSNPrEggs +FCSNVegOrg +FCSNVegGre +FCSNFruiOrg)
var_label(data$FGVitA) <- "Consumption of vitamin A-rich foods"

data <- data %>% mutate(FGProtein = FCSPulse +FCSDairy +FCSNPrMeatF +FCSNPrMeatO +FCSNPrFish +FCSNPrEggs)
var_label(data$FGProtein) <- "Consumption of protein-rich foods"

data <- data %>% mutate(FGHIron = FCSNPrMeatF +FCSNPrMeatO +FCSNPrFish)
var_label(data$FGHIron) <- "Consumption of hem iron-rich foods"

#recode into nutritious groups  
data <- data %>% mutate(FGVitACat = case_when(FGVitA == 0 ~ 1, between(FGVitA,1,6) ~ 2, FGVitA >= 7 ~ 3),
                        FGProteinCat = case_when(FGProtein == 0 ~ 1, between(FGProtein,1,6) ~ 2,  FGProtein >= 7 ~ 3),
                        FGHIronCat = case_when(FGHIron == 0 ~ 1, between(FGHIron,1,6) ~ 2,  FGHIron >= 7 ~ 3)
                        )


# define variables labels and properties for FGVitACat FGProteinCat FGHIronCat
data <- data %>%
  mutate(across(c(FGVitACat, FGProteinCat, FGHIronCat), ~labelled(., labels = c(
    "Never consumed" = 1,
    "Consumed sometimes" = 2,
    "Consumed at least 7 times" = 3
  ))))

var_label(data$FGVitACat) <- "Consumption group of vitamin A-rich foods"
var_label(data$FGProteinCat) <- "Consumption group of protein-rich foods"
var_label(data$FGHIronCat) <- "Consumption group of hem iron-rich foods"
