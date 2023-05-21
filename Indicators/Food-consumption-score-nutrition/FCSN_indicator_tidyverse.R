library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/FCSN_Sample_Survey.csv")

#assign variable and value labels
#variable labels
var_label(data$FCSNPrMeatF) <- "Flesh meat, such as:"
var_label(data$FCSNPrMeatO) <- "Organ meat, such as:"
var_label(data$FCSNPrFish) <- "Fish/shellfish, such as:"
var_label(data$FCSNPrEggs) <- "Eggs:"
var_label(data$FCSNVegOrg) <- "Orange vegetables (vegetables rich in Vitamin A), such as:"
var_label(data$FCSNVegGre) <- "Green leafy vegetables, such as:"
var_label(data$FCSNFruiOrg) <- "Orange fruits (Fruits rich in Vitamin A), such as:"
	
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

var_label(data$FGVitACat) <- "Consumption of vitamin A-rich foods"
var_label(data$FGProteinCat) <- "Consumption of protein-rich foods"
var_label(data$FGHIronCat) <- "Consumption of hem iron-rich foods"
