library(tidyverse)
library(labelled)
library(expss)

#add sample data
data <- read_csv("~/GitHub/RAMResourcesScripts/Static/Nut_MAD_Sample_Survey/MAD_submodule_RepeatMAD.csv")

#can only download repeat csv data as zip file from moda with group names - will update this code with more elegant solution to remove group names or if you download as SPSS you can skip this step
#rename to remove group names
data <- data %>% rename(PCMADChildAge_months = 'MAD_submodule/RepeatMAD/PCMADChildAge_months',
                        PCMADBreastfeed = 'MAD_submodule/RepeatMAD/PCMADBreastfeed',
                        PCMADInfFormula = 'MAD_submodule/RepeatMAD/PCMADInfFormula',
                        PCMADInfFormulaNum = 'MAD_submodule/RepeatMAD/PCMADInfFormulaNum',
                        PCMADMilk = 'MAD_submodule/RepeatMAD/PCMADMilk',
                        PCMADMilkNum = 'MAD_submodule/RepeatMAD/PCMADMilkNum',
                        PCMADYogurtDrink = 'MAD_submodule/RepeatMAD/PCMADYogurtDrink',
                        PCMADYogurtDrinkNum = 'MAD_submodule/RepeatMAD/PCMADYogurtDrinkNum',
                        PCMADYogurt = 'MAD_submodule/RepeatMAD/PCMADYogurt',
                        PCMADStapCer = 'MAD_submodule/RepeatMAD/PCMADStapCer',
                        PCMADVegOrg = 'MAD_submodule/RepeatMAD/PCMADVegOrg',
                        PCMADStapRoo = 'MAD_submodule/RepeatMAD/PCMADStapRoo',
                        PCMADVegGre = 'MAD_submodule/RepeatMAD/PCMADVegGre',
                        PCMADVegOth = 'MAD_submodule/RepeatMAD/PCMADVegOth',
                        PCMADFruitOrg = 'MAD_submodule/RepeatMAD/PCMADFruitOrg',
                        PCMADFruitOth = 'MAD_submodule/RepeatMAD/PCMADFruitOth',
                        PCMADPrMeatO = 'MAD_submodule/RepeatMAD/PCMADPrMeatO',
                        PCMADPrMeatPro = 'MAD_submodule/RepeatMAD/PCMADPrMeatPro',
                        PCMADPrMeatF = 'MAD_submodule/RepeatMAD/PCMADPrMeatF', 
                        PCMADPrEgg = 'MAD_submodule/RepeatMAD/PCMADPrEgg',
                        PCMADPrFish = 'MAD_submodule/RepeatMAD/PCMADPrFish',
                        PCMADPulse = 'MAD_submodule/RepeatMAD/PCMADPulse',
                        PCMADCheese = 'MAD_submodule/RepeatMAD/PCMADCheese',
                        PCMADSnf = 'MAD_submodule/RepeatMAD/PCMADSnf',
                        PCMADMeals = 'MAD_submodule/RepeatMAD/PCMADMeals'
                        )

#assign variable and value labels
var_label(data$PCMADChildAge_months) <- 'What is the age in months of ${PCMADChildName} ?'
var_label(data$PCMADBreastfeed) <- 'Was ${PCMADChildName} breastfed yesterday during the day or at night?'
var_label(data$PCMADInfFormula) <- 'Infant formula, such as [insert local names of common formula]?'
var_label(data$PCMADInfFormulaNum) <- 'How many times did ${PCMADChildName} drink formula'
var_label(data$PCMADMilk) <- 'Milk from animals, such as fresh, tinned or powdered milk?'
var_label(data$PCMADMilkNum) <- 'How many times did ${PCMADChildName} drink milk from animals, such as fresh, tinned or powdered milk?'
var_label(data$PCMADYogurtDrink) <- 'Yogurt drinks such as [insert local names of common types of yogurt drinks]?'
var_label(data$PCMADYogurtDrinkNum) <- 'How many times did  ${PCMADChildName} drink Yogurt drinks such as [insert local names of common types of yogurt drinks]?'
var_label(data$PCMADYogurt) <- 'Yogurt, other than yogurt drinks?'
var_label(data$PCMADStapCer) <- 'Porridge, bread, rice, noodles, pasta or [insert other commonly consumed grains, including foods made from grains like rice dishes, noodle dishes, etc.]?'
var_label(data$PCMADVegOrg) <- 'Pumpkin, carrots, sweet red peppers, squash or sweet potatoes that are yellow or orange inside? [any additions to this list should meet “Criteria for defining foods and liquids as ‘sources’ of vitamin A”]'
var_label(data$PCMADStapRoo) <- 'Plantains, white potatoes, white yams, manioc, cassava or [insert other commonly consumed starchy tubers or starchy tuberous roots that are white or pale inside]'
var_label(data$PCMADVegGre) <- 'Dark green leafy vegetables, such as [insert  commonly consumed vitamin A-rich dark green leafy vegetables]?'
var_label(data$PCMADVegOth) <- 'Any other vegetables, such as [insert commonly consumed vegetables]?'
var_label(data$PCMADFruitOrg) <- 'Ripe mangoes or ripe papayas or [insert other commonly consumed vitamin A-rich fruits]?'
var_label(data$PCMADFruitOth) <- 'Any other fruits, such as [insert commonly consumed fruits]?'
var_label(data$PCMADPrMeatO) <- 'Liver, kidney, heart or [insert other commonly consumed organ meats]?'
var_label(data$PCMADPrMeatPro) <- 'Sausages, hot dogs/frankfurters, ham, bacon, salami, canned meat or [insert other commonly consumed processed meats]?'
var_label(data$PCMADPrMeatF) <- 'Any other meat, such as beef, pork, lamb, goat, chicken, duck or [insert other commonly consumed meat]?'
var_label(data$PCMADPrEgg) <- 'Eggs'
var_label(data$PCMADPrFish) <- 'Fresh or dried fish, shellfish or seafood'
var_label(data$PCMADPulse) <- 'Beans, peas, lentils, nuts , seeds or [insert commonly consumed foods made from beans, peas, lentils, nuts, or seeds]?'
var_label(data$PCMADCheese) <- 'Hard or soft cheese such as [insert commonly consumed types of cheese]?'
var_label(data$PCMADSnf) <- 'Specialized Nutritious Foods (SNF) such as [insert the SNFs distributed by WFP]?'
var_label(data$PCMADMeals) <- 'How many times did ${PCMADChildName}  eat any solid, semi -solid or soft foods yesterday during the day or night?'

data <- data %>%
  mutate(across(c(PCMADBreastfeed,PCMADInfFormula,PCMADMilk,PCMADYogurtDrink, PCMADYogurt,PCMADStapCer,PCMADVegOrg,PCMADStapRoo,PCMADVegGre,PCMADVegOth,PCMADFruitOrg,
                  PCMADFruitOth,PCMADPrMeatO,PCMADPrMeatPro,PCMADPrMeatF,PCMADPrEgg,PCMADPrFish,PCMADPulse,PCMADCheese,PCMADSnf), ~labelled(., labels = c(
    "No" = 0,
    "Yes" = 1,
    "Don't know" = 888
  ))))


#Creat Minimum Dietary Diversity 6-23 months (MDD)
# for population assesments - SNF is counted in cereals group (MDD)
# for WFP programme monitoring - SNF is counted in meats group (MDD_wfp)

#this version is for population assessments - SNF is counted in cereals group
data <- data %>% mutate(
                        MAD_BreastMilk = case_when( 
                          PCMADBreastfeed == 1 ~ 1, TRUE ~ 0),
                        MAD_PWMDDWStapCer = case_when( 
                          PCMADStapCer == 1 | PCMADStapRoo == 1  | PCMADSnf == 1 ~ 1, TRUE ~ 0),
                        MAD_PulsesNutsSeeds = case_when( 
                          PCMADPulse == 1 ~ 1, TRUE ~ 0),
                        MAD_Dairy = case_when( 
                          PCMADInfFormula == 1 | PCMADMilk == 1 | PCMADYogurtDrink == 1 | PCMADYogurt == 1 | PCMADCheese == 1 ~ 1,  TRUE ~ 0),
                        MAD_MeatFish = case_when( 
                          PCMADPrMeatO == 1 |  PCMADPrMeatPro == 1 | PCMADPrMeatF == 1 | PCMADPrFish == 1 ~ 1, TRUE ~ 0),  
                        MAD_Eggs = case_when( 
                          PCMADPrEgg == 1 ~ 1,  TRUE ~ 0),
                        MAD_VitA = case_when( 
                          PCMADVegOrg == 1 | PCMADVegGre == 1 | PCMADFruitOrg == 1 ~ 1, TRUE ~ 0),
                        MAD_OtherVegFruits = case_when( 
                          PCMADFruitOth == 1 | PCMADVegOth == 1 ~ 1, TRUE ~ 0)
                        )
#add together food groups to see how many food groups consumed
data <- data %>% mutate(MDD_score = MAD_BreastMilk +MAD_PWMDDWStapCer +MAD_PulsesNutsSeeds +MAD_Dairy +MAD_MeatFish +MAD_Eggs +MAD_VitA +MAD_OtherVegFruits)
#create MDD variable which records whether child consumed five or more food groups
data <- data %>% mutate(MDD = case_when(
                              MDD_score >= 5 ~ 1, TRUE ~ 0))

var_label(data$MDD) <- 'Minimum Dietary Diversity (MDD)'
val_lab(data$MDD) = num_lab("
             0 Does not meet MDD
             1 Meets MDD
")

##this version for WFP programme monitoring - SNF is counted in meats group
data <- data %>% mutate(
  MAD_BreastMilk_wfp = case_when( 
    PCMADBreastfeed == 1 ~ 1, TRUE ~ 0),
  MAD_PWMDDWStapCer_wfp = case_when( 
    PCMADStapCer == 1 | PCMADStapRoo == 1 ~ 1, TRUE ~ 0),
  MAD_PulsesNutsSeeds_wfp = case_when( 
    PCMADPulse == 1 ~ 1, TRUE ~ 0),
  MAD_Dairy_wfp = case_when( 
    PCMADInfFormula == 1 | PCMADMilk == 1 | PCMADYogurtDrink == 1 | PCMADYogurt == 1 | PCMADCheese == 1 ~ 1,  TRUE ~ 0),
  MAD_MeatFish_wfp = case_when( 
    PCMADPrMeatO == 1 |  PCMADPrMeatPro == 1 | PCMADPrMeatF == 1 | PCMADPrFish == 1 | PCMADSnf == 1 ~ 1, TRUE ~ 0),  
  MAD_Eggs_wfp = case_when( 
    PCMADPrEgg == 1 ~ 1,  TRUE ~ 0),
  MAD_VitA_wfp = case_when( 
    PCMADVegOrg == 1 | PCMADVegGre == 1 | PCMADFruitOrg == 1 ~ 1, TRUE ~ 0),
  MAD_OtherVegFruits_wfp = case_when( 
    PCMADFruitOth == 1 | PCMADVegOth == 1 ~ 1, TRUE ~ 0)
)
#add together food groups to see how many food groups consumed
data <- data %>% mutate(MDD_score_wfp = MAD_BreastMilk_wfp +MAD_PWMDDWStapCer_wfp +MAD_PulsesNutsSeeds_wfp +MAD_Dairy_wfp +MAD_MeatFish_wfp +MAD_Eggs_wfp +MAD_VitA_wfp +MAD_OtherVegFruits_wfp)
#create MDD variable which records whether child consumed five or more food groups
data <- data %>% mutate(MDD_wfp = case_when(
  MDD_score_wfp >= 5 ~ 1, TRUE ~ 0))

var_label(data$MDD_wfp) <- 'Minimum Dietary Diversity for WFP program monitoring (MDD)'
val_lab(data$MDD_wfp) = num_lab("
             0 Does not meet MDD
             1 Meets MDD 
")


table(data$MDD)
table(data$MDD_wfp)

#Calculate Minimum Meal Frequency 6-23 months (MMF) 

#Recode into new variables turning dont know and missing valules into 0  - this makes syntax for calculation simpler

data <- data %>% mutate(PCMADBreastfeed_yn = case_when(
                                            PCMADBreastfeed == 1 ~ 1, TRUE ~ 0),
                        PCMADMeals_r = case_when(
                                            between(PCMADMeals,1,7) == 1 ~ PCMADMeals, TRUE ~ 0),
                        PCMADInfFormulaNum_r = case_when(
                                            between(PCMADInfFormulaNum,1,7) == 1 ~ PCMADInfFormulaNum, TRUE ~ 0),
                        PCMADMilkNum_r = case_when(
                                            between(PCMADMilkNum,1,7) == 1 ~ PCMADMilkNum, TRUE ~ 0),
                        PCMADYogurtDrinkNum_r = case_when(
                                            between(PCMADYogurtDrinkNum,1,7) == 1 ~ PCMADYogurtDrinkNum, TRUE ~ 0)
                        )

data <- data %>% mutate(MMF = case_when(
   PCMADBreastfeed_yn == 1 & between(PCMADChildAge_months,6,8) & (PCMADMeals_r >= 2)  ~ 1, #for child breast fed yesterday - between 6 - 8 months minimum number of meals is 2
   PCMADBreastfeed_yn == 1 & between(PCMADChildAge_months,9,23) & (PCMADMeals_r >= 3) ~ 1, #for child breast fed yesterday - for children above 8 months minimum number of meals is 3
   #for child non breast fed regardless of age , child must have had 1 or more meal of solid/semisolid/soft food and child had 4 or more liquid + solid/semisolid/soft meals 
   PCMADBreastfeed_yn == 0 & (PCMADMeals_r >= 1) & (PCMADMeals_r + PCMADInfFormulaNum_r + PCMADMilkNum_r + PCMADYogurtDrinkNum_r >= 4) ~ 1,
   TRUE ~ 0)
)

var_label(data$MMF) <- 'Minimum Meal Frequency (MMF)'
val_lab(data$MMF) = num_lab("
             0 Does not meet MMF
             1 Meets MMF
")

#Calculate Minimum Milk Feeding Frequency for non-breastfed children 6-23 months (MMFF) 

data <- data %>% mutate(MMFF = case_when(
                              PCMADBreastfeed_yn == 0 & (PCMADInfFormulaNum_r + PCMADMilkNum_r + PCMADYogurtDrinkNum_r >= 2) ~ 1,
                              TRUE ~ 0)
)
                    
var_label(data$MMFF) <- 'Minimum Milk Feeding Frequency for non-breastfed children (MMFF)'
val_lab(data$MMFF) = num_lab("
             0 Does not meet MMFF
             1 Meets MMFF
")


# Minimum Acceptable Diet (MAD)

#For breastfed infants: if MDD and MMF are both achieved, then MAD is achieved
#For nonbreastfed infants: if MDD, MMF and MMFF are all achieved, then MAD is achieved


#using MDD for population assesments
data <- data %>% mutate(MAD = case_when(
                        PCMADBreastfeed_yn == 1 & MDD == 1 & MMF == 1 ~ 1,
                        PCMADBreastfeed_yn == 0 & MDD == 1 & MMF == 1 & MMFF == 1 ~ 1,
                        TRUE ~ 0))

#using MDD for WFP program monitoring
data <- data %>% mutate(MAD = case_when(
  PCMADBreastfeed_yn == 1 & MDD_wfp == 1 & MMF == 1 ~ 1,
  PCMADBreastfeed_yn == 0 & MDD_wfp == 1 & MMF == 1 & MMFF == 1 ~ 1,
  TRUE ~ 0))

var_label(data$MAD) <- 'Minimum Acceptable Diet (MAD)'
val_lab(data$MAD) = num_lab("
             0 Does not meet MAD
             1 Meets MAD
")


#creates a table of the weighted percentage of MAD
#and providing the option to use weights if needed

MAD_table_wide <- data %>% 
  drop_na(MAD) %>%
  count(MAD) %>% # if weights are needed use instead the row below 
  #count(MAD, wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = MAD,
              values_from = Percentage,
              values_fill =  0) 
