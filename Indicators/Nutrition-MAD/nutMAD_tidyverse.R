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
var_label(data$PCMADYogurt) <- 'Yogurt, other than yogurt drinks [insert other commonly consumed grains, including foods made from grains like rice dishes, noodle dishes, etc.]?'
var_label(data$PCMADStapCer) <- 'Porridge, bread, rice, noodles, pasta or [any additions to this list should meet “Criteria for defining foods and liquids as ‘sources’ of vitamin A”]?'
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
  mutate(across(c(PCMADBreastfeed,PCMADInfFormula,PCMADInfFormulaNum,PCMADMilk,PCMADMilkNum,PCMADYogurtDrink,PCMADYogurtDrinkNum,PCMADYogurt,PCMADStapCer,PCMADVegOrg,PCMADStapRoo,PCMADVegGre,PCMADVegOth,PCMADFruitOrg,PCMADFruitOth,PCMADPrMeatO,PCMADPrMeatPro,PCMADPrMeatF,PCMADPrEgg,PCMADPrFish,PCMADPulse,PCMADCheese,PCMADSnf,PCMADMeals
                  
  ), ~labelled(., labels = c(
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

var_label(data$MDD) <- 'Minimum Dietary Diversity'
val_lab(data$MDD) = num_lab("
             0 Does not meet Minimum Dietary Diversity
             1 Meets Minimum Dietary Diversity
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

var_label(data$MDD_wfp) <- 'Minimum Dietary Diversity for WFP program monitoring'
val_lab(data$MDD_wfp) = num_lab("
             0 Does not meet Minimum Dietary Diversity
             1 Meets Minimum Dietary Diversity
")


table(data$MDD)
table(data$MDD_wfp)

#Calculate Minimum Meal Frequency 6-23 months (MMF) 

data <- data %>% mutate(MMF = case_when(
   PCMADBreastfeed == 1 & between(PCMADChildAge_months,6,8) & (PCMADMeals >= 2 & PCMADMeals != 888)  ~ 1, #for child breast fed yesterday - between 6 - 8 months minimum number of meals is 2
   PCMADBreastfeed == 1 & between(PCMADChildAge_months,9,23) & (PCMADMeals >= 3 & PCMADMeals != 888) ~ 1, #for child breast fed yesterday - for children above 8 months minimum number of meals is 3
   #for child non breast fed regardless of age , child must have had 1 or more meal of solid/semisolid/soft food and child had 4 or more liquid + solid/semisolid/soft meals 
   PCMADBreastfeed == 0 & (PCMADMeals >= 1 & PCMADMeals != 888) & (PCMADMeals + PCMADInfFormulaNum + PCMADMilkNum + PCMADYogurtDrinkNum >= 4) ~ 1,
   TRUE ~ 0)
)

var_label(data$MMF) <- 'Minimum Meal Frequency'
val_lab(data$MMF) = num_lab("
             0 Does not meet Minimum Meal Frequency
             1 Meets Minimum Meal Frequency
")

#Minimum Milk Feeding Frequency for non-breastfed children 6-23 months (MMFF) 

data <- data %>% mutate(PCMADInfFormulaNum_yn = recode())


PCMADInfFormulaNum + PCMADMilkNum + PCMADYogurtDrinkNum >= 2 



#create new variable where missing and dont_knows are considered no - makes the syntax a lot easier
data <- data %>% mutate(MMF = case_when(
                              (PCMADBreastfeed != 1 | is.na(PCMADBreastfeed)) ~ 1,
                              
                              #& (PCMADInfFormulaNum + PCMADMilkNum + PCMADYogurtDrinkNum >= 2) & (PCMADInfFormulaNum != 888 & PCMADMilkNum != 888 & PCMADYogurtDrinkNum != 888) ~ 1,
                              TRUE ~ 0)
)
                    






























#Calculate 2 MDDW indicators based on WFP guidelines https://docs.wfp.org/api/documents/WFP-0000140197/download/ pg.8
#Standard MDDW Indicator for population based surveys - counts SNF in home group (refer to https://docs.wfp.org/api/documents/WFP-0000139484/download/ for "home group")
#WFP Modified MDDW WFP programme monitoring - counts SNF in "Meat, poultry and fish" Category

#Standard MDDW method - in this example SNF home group will be grains
#in this example fortified foods PWMDDWFortFoodwflour,PWMDDWFortFoodmflour,PWMDDWFortFoodrice,PWMDDWFortFooddrink will also count in grains
#classifying PWMDDWFortFoodother_oth will likely involve classifying line by line 
data <- data %>% mutate(
                        MDDW_Staples = case_when(
                            PWMDDWStapCer == 1 |  PWMDDWStapRoo == 1 | PWMDDWSnf == 1 | PWMDDWFortFoodwflour == 1 | PWMDDWFortFoodmflour == 1 | PWMDDWFortFoodrice == 1 | PWMDDWFortFooddrink == 1 ~ 1, TRUE ~ 0),
                        MDDW_Pulses = case_when(
                            PWMDDWPulse == 1 ~ 1, TRUE ~ 0),
                        MDDW_NutsSeeds  = case_when(
                            PWMDDWNuts == 1 ~ 1, TRUE ~ 0),
                        MDDW_Dairy  = case_when(
                            PWMDDWDairy == 1 | PWMDDWMilk == 1 ~ 1, TRUE ~ 0),
                        MDDW_MeatFish  = case_when(
                            PWMDDWPrMeatO == 1 | PWMDDWPrMeatF == 1 | PWMDDWPrMeatPro == 1 | PWMDDWPrMeatWhite == 1 |  PWMDDWPrFish == 1 ~ 1, TRUE ~ 0),
                        MDDW_Eggs  = case_when(
                            PWMDDWPrEgg == 1 ~ 1, TRUE ~ 0),
                        MDDW_LeafGreenVeg  = case_when(
                            PWMDDWVegGre == 1 ~ 1, TRUE ~ 0),
                        MDDW_VitA  = case_when(
                            PWMDDWVegOrg == 1 | PWMDDWFruitOrg == 1 ~ 1, TRUE ~ 0),
                        MDDW_OtherVeg  = case_when(
                            PWMDDWVegOth == 1 ~ 1, TRUE ~ 0),
                        MDDW_OtherFruits  = case_when(
                            PWMDDWFruitOth == 1 ~ 1, TRUE ~ 0)
                        )

#WFP MDDW method for program monitoring - SNF will count in the meats group
#in this example fortified foods PWMDDWFortFoodwflour,PWMDDWFortFoodmflour,PWMDDWFortFoodrice,PWMDDWFortFooddrink will also count in grains
#classifying PWMDDWFortFoodother_oth will likely involve classifying line by line 
data <- data %>% mutate(
  MDDW_Staples_wfp = case_when(
    PWMDDWStapCer == 1 |  PWMDDWStapRoo == 1 | PWMDDWFortFoodwflour == 1 | PWMDDWFortFoodmflour == 1 | PWMDDWFortFoodrice == 1 | PWMDDWFortFooddrink == 1 ~ 1, TRUE ~ 0),
  MDDW_Pulses_wfp = case_when(
    PWMDDWPulse == 1 ~ 1, TRUE ~ 0),
  MDDW_NutsSeeds_wfp  = case_when(
    PWMDDWNuts == 1 ~ 1, TRUE ~ 0),
  MDDW_Dairy_wfp  = case_when(
    PWMDDWDairy == 1 | PWMDDWMilk == 1 ~ 1, TRUE ~ 0),
  MDDW_MeatFish_wfp  = case_when(
    PWMDDWPrMeatO == 1 | PWMDDWPrMeatF == 1 | PWMDDWPrMeatPro == 1 | PWMDDWPrMeatWhite == 1 |  PWMDDWPrFish == 1 | PWMDDWSnf == 1 ~ 1, TRUE ~ 0),
  MDDW_Eggs_wfp  = case_when(
    PWMDDWPrEgg == 1 ~ 1, TRUE ~ 0),
  MDDW_LeafGreenVeg_wfp  = case_when(
    PWMDDWVegGre == 1 ~ 1, TRUE ~ 0),
  MDDW_VitA_wfp  = case_when(
    PWMDDWVegOrg == 1 | PWMDDWFruitOrg == 1 ~ 1, TRUE ~ 0),
  MDDW_OtherVeg_wfp  = case_when(
    PWMDDWVegOth == 1 ~ 1, TRUE ~ 0),
  MDDW_OtherFruits_wfp  = case_when(
    PWMDDWFruitOth == 1 ~ 1, TRUE ~ 0)
)


#calculate MDDW variable for both methods by adding together food groups and classifying whether the woman consumed 5 or more food groups

#Standard MDDW method where SNF is counted in grains
data <- data %>% mutate(MDDW = MDDW_Staples +MDDW_Pulses +MDDW_NutsSeeds +MDDW_Dairy +MDDW_MeatFish +MDDW_Eggs +MDDW_LeafGreenVeg +MDDW_VitA +MDDW_OtherVeg +MDDW_OtherFruits)
#count how many women consumed 5 or more groups
data <- data %>% mutate(MDDW_5 = case_when(
                        MDDW >= 5 ~ ">=5", TRUE ~ "<5"
))
#WFP MDDW method for program monitoring - SNF will count in the meats group
data <- data %>% mutate(MDDW_wfp = MDDW_Staples_wfp +MDDW_Pulses_wfp +MDDW_NutsSeeds_wfp +MDDW_Dairy_wfp +MDDW_MeatFish_wfp +MDDW_Eggs_wfp +MDDW_LeafGreenVeg_wfp +MDDW_VitA_wfp +MDDW_OtherVeg_wfp +MDDW_OtherFruits_wfp)
#count how many women consumed 5 or more groups
data <- data %>% mutate(MDDW_5_wfp = case_when(
  MDDW_wfp >= 5 ~ ">=5", TRUE ~ "<5"
))

#creates a table of the weighted percentage of Standard MDDW Method - MDDW_5 
#and providing the option to use weights if needed

MDDW_5_table_wide <- data %>% 
  drop_na(MDDW_5) %>%
  count(MDDW_5) %>% # if weights are needed use instead the row below 
  #count(MDDW_5, wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = MDDW_5,
              values_from = Percentage,
              values_fill =  0) 

#creates a table of the weighted percentage of WFP MDDW method for program monitoring MDDW_5_wfp
#and providing the option to use weights if needed


MDDW_5_wfp_table_wide <- data %>% 
  drop_na(MDDW_5_wfp) %>%
  count(MDDW_5_wfp) %>% # if weights are needed use instead the row below 
  #count(MDDW_5_wfp, wt = nameofweightvariable)
  mutate(Percentage = 100 * n / sum(n)) %>%
  ungroup() %>% select(-n) %>%
  pivot_wider(names_from = MDDW_5_wfp,
              values_from = Percentage,
              values_fill =  0) 





