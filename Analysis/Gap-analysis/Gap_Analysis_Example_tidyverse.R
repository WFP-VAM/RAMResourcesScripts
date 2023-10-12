#------------------------------------------------------------------------------#
#
#	                         WFP RAM Standardized Scripts
#                            Example of gap analysis
#
#------------------------------------------------------------------------------#

# Clear the environment
rm(list = ls())

## Install Packages --------------------------------------------------------------#
# Install relevant packages. The wfptheme library can be installed using the below
#install.packages("remotes") 
#remotes::install_github("WFP-VAM/wfpthemes")


## Load Packages --------------------------------------------------------------#
# Instal;l relevant packages from cranr. The wfptheme library can be installed using the below
#install.packages("remotes") 
#remotes::install_github("WFP-VAM/wfpthemes")


library(tidyverse)
library(dplyr)
library(tidyr)
library(labelled)
library(ggplot2)
library(wfpthemes)
library(readr)


# Set Path and Open Sample Data -----------------------------------------------#

# Set the working directory to your data file path
# Replace 'path/to/your/Syntax_Data' with the actual path to your dataset file.

projectFolder <- file.path("path/to/your/Syntax_Data")   # <- put your path here 
setwd(projectFolder)

# Load the dataset (replace 'Gap_Analysis_Sample.csv' with your actual data file)
data <- read_csv("Gap_Analysis_Sample.csv")

# -----------------------------------------------------------------------------#
#  Estimate the gap 
# -----------------------------------------------------------------------------#

# Step 1 - Identifying the cost of essential needs ----------------------------#

# A MEB is already available in the dataset, expressed in per capita monthly term,
# and differentiated by groups of household size to account for household economies of scale
## No code required in R

# Step 2 - Computing the household economic capacity --------------------------#

# The computation of the household economic capacity should follow the methodology
# used for the ECMEN indicator (version excluding assistance).

data <- data %>%
  mutate(
# Sum food expenditures, value of consumed food from own-production, and non-food
# expenditures
    PCExp_ECMEN = rowSums(select(data, PC_HHExp_Food_Purch_MN_1M, 
                                       PC_HHExp_Food_Own_MN_1M,
                                       PC_HHExpNFTotal_Purch_MN_1M),
                          na.rm = TRUE),
    # will be missing if all sub-aggregates are missing
# Deduct the value of cash assistance received from WFP and partner humanitarian
# organizations
    PCExp_ECMEN = ifelse(!is.na(PC_HHAsstCBTRec_Cons_1M),
                         PCExp_ECMEN - PC_HHAsstCBTRec_Cons_1M,
                         PCExp_ECMEN),
    PCExp_ECMEN = ifelse(PCExp_ECMEN < 0, 0, PCExp_ECMEN)
   # set negative values to zero
  )

var_label(data$PCExp_ECMEN) <- "Household Economic Capacity per capita - monthly"

summary(data$PCExp_ECMEN)

# Step 3 - Identifying the gap analysis cohort --------------------------------#

# In this example the gap analysis group is made of the households with economic
# capacity below the MEB and who are moderately or severely food insecure based
# on CARI

data <- data %>%
  mutate(
    # create a variable to identify the cohort
    Gap_ref = ifelse(PCExp_ECMEN < MEB & 
                    (CARI_ECMEN == "Moderately food insecure" | 
                     CARI_ECMEN == "Severely food insecure"), 1, 0)
  )
    # convert to factor
data$Gap_ref <- 
  factor(data$Gap_ref,
         levels = c(0,1),
         labels = c("Not part of cohort", "Part of cohort"))

var_label(data$Gap_ref) <- "Gap analysis cohort (below MEB and food insecure)"
summary(data$Gap_ref)

# Step 4 - Estimating the gap -------------------------------------------------#

data <- data %>%
  mutate(
# Compute per capita gap for each household
    PCGap = ifelse(PCExp_ECMEN < MEB, MEB - PCExp_ECMEN, NA),
    # the gap is defined only for hh with economic capacity below the MEB
    # store calculated average into a variable (defined only for the cohort)
    PCGap_avg = ifelse(Gap_ref == "Part of cohort", 
                       mean(PCGap[Gap_ref == "Part of cohort"], 
                            na.rm = T), NA),
# Calculate the average MEB for the reference cohort (reminder: in this example 
# the MEB is differentiated by groups of household size - if this is not the case
# this passage is not needed)
    PCGap_share_MEB = ifelse(Gap_ref == "Part of cohort", 
                             PCGap_avg/mean(MEB, 
    # use the average MEB calculated in the previous line. Note: this variable 
    # is defined only for the cohort
                             na.rm = T), NA)
  )

var_label(data$PCGap)           <- "Gap, per capita, monthly"
var_label(data$PCGap_avg)       <- "Average per capita gap (cohort: below MEB and food insecure)"
var_label(data$PCGap_share_MEB) <- "Gap/MEB per capita (cohort: below MEB and food insecure)"

summary(data$PCGap)
summary(data$PCGap_avg)
summary(data$PCGap_share_MEB)

# -----------------------------------------------------------------------------#
#  Estimate the gap by household size
# -----------------------------------------------------------------------------#

# In this dataset different MEB values are provided for 4 categories of household
# size, to take into account household economies of scale: small (1-3), medium(4-6),
# large(7-9), extra-large (10+). Accordingly, different gaps will be estimated

# Create a variable representing the different categories of household size
data <- data %>%
  mutate(
    hhsize_cat = case_when(
      hhsize %in% 1:3 ~ "Small",
      hhsize %in% 4:6 ~ "Medium",
      hhsize %in% 7:9 ~ "Large",
      TRUE ~ "Extra large"
    ),
    hhsize_cat = factor(hhsize_cat, 
                        levels = c("Small", "Medium", "Large", "Extra large"))
  )
summary(data$hhsize_cat)

# Create a variable taking the average gap value for each household size category
data <- data %>%
  mutate(PCGap_avg_hhcat = NA)

var_label(data$PCGap_avg_hhcat) <- "Average per capita gap per hh size (cohort: below MEB and food insecure)"

# Compute the average gap for household size categories and store in PCGap_avg_hhcat
for (i in 1:4) {
  data <- data %>%
    # we will loop through the four household size categories
    group_by(Gap_ref, hhsize_cat) %>%
    mutate(PCGap_avg_hhcat = 
             ifelse(Gap_ref == "Part of cohort" & 
                    hhsize_cat == levels(hhsize_cat)[i], 
                    mean(PCGap, na.rm = TRUE), PCGap_avg_hhcat)) %>%
   # compute average for hh size cat within the gap analysis cohort
   # store average into variable
    ungroup()
}
summary(data$PCGap_avg_hhcat)

# Display the different gaps by household size (bar chart)
ggplot(data, aes(x = hhsize_cat, y = PCGap_avg_hhcat)) +
  geom_bar(stat = "summary", 
           fun = "mean", 
           width = 0.7) +
  labs(title = "Gap by Household Size Groups",
       x = "Household Size",
       y = "Mean PCGap") +
  geom_text(stat = "summary", 
            fun = "mean", 
            aes(label = round(..y.., 2)), 
            vjust = -0.5) +
  theme_wfp() 

# -----------------------------------------------------------------------------#
#  Compare the gap with and without assistance
# -----------------------------------------------------------------------------#

# See Box 3 in the guidance note

# The gap without assistance has already been computed in the previous section. 
# Now the objective is repeating the procedure but using a version of the household
# economic capacity "including assistance"
  
# Step 1 - Identifying the cost of essential needs ----------------------------#
# Same as in previous section

# Step 2 - Computing the household economic capacity --------------------------#
# The computation of the household economic capacity should follow the methodology
# used for the ECMEN indicator (version including assistance).
  
# Sum food expenditures, value of food consumed from in-kind assistance and 
# gifts, value of consumed food from own-production, non-food expenditures, and 
# the value of non-food from in-kind assistance and gifts. 

data <- data %>%
  mutate(
    # Sum food expenditures, value of consumed food from own-production, and non-food
    # expenditures
    PCExp_ECMEN_inclAsst = rowSums(select(data, PC_HHExp_Food_Purch_MN_1M,
                                                PC_HHExp_Food_GiftAid_MN_1M,
                                                PC_HHExp_Food_Own_MN_1M,
                                                PC_HHExpNFTotal_Purch_MN_1M,
                                                PC_HHExpNFTotal_GiftAid_MN_1M),
                                          na.rm = TRUE))
    # Note that in this time the value of received cash assistance should not be deducted

var_label(data$PCExp_ECMEN_inclAsst) <- "Household Economic Capacity per capita - incl assistance - monthly"

summary(data$PCExp_ECMEN_inclAsst)

# Step 3 - Identifying the gap analysis cohort --------------------------------#
# In this example the gap analysis group is made of the households with economic 
# capacity below the MEB and who are moderately or severely food insecure based 
# on CARI

data <- data %>%
  mutate(
    Gap_ref_inclAsst = ifelse(PCExp_ECMEN_inclAsst < MEB & 
                             (CARI_ECMEN == "Moderately food insecure" | 
                              CARI_ECMEN == "Severely food insecure"), 1, 0))
# convert to factor
data$Gap_ref_inclAsst <- 
  factor(data$Gap_ref_inclAsst,
         levels = c(0,1),
         labels = c("Not part of cohort", "Part of cohort"))

var_label(data$Gap_ref_inclAsst) <- "Gap analysis cohort (below MEB and food insecure) - incl assistance"
summary(data$Gap_ref_inclAsst)

# Step 4 - Estimating the gap -------------------------------------------------#

# Compute per capita gap for each household
data <- data %>%
  mutate(
    PCGap_inclAsst   = ifelse(PCExp_ECMEN_inclAsst < MEB, 
                              MEB - PCExp_ECMEN_inclAsst, NA),
    # the gap is defined only for hh with economic capacity below the MEB
    # Calculate average gap for the gap analysis cohort
    # Compute average gap for the gap analysis cohort and save to a variable
    PCGap_avg_inclAsst = ifelse(Gap_ref_inclAsst == "Part of cohort", 
                                mean(PCGap_inclAsst[Gap_ref_inclAsst == "Part of cohort"], 
                                     na.rm = TRUE), NA),
    # store calculated average into a variable (defined only for the cohort)
    # Calculate the average MEB for the reference cohort
    avg_MEB_inclAsst = ifelse(Gap_ref_inclAsst == "Part of cohort", 
                              mean(MEB[Gap_ref_inclAsst == "Part of cohort"], 
                                   na.rm = TRUE), NA),
    PCGap_share_MEB_inclAsst = ifelse(Gap_ref_inclAsst == "Part of cohort",
                                      PCGap_avg_inclAsst/avg_MEB_inclAsst, NA)
    # use the average MEB calculated in the previous line. 
    # Note: this variable is defined only for the cohort
    )

# Label the variables
var_label(data$PCGap_inclAsst)           <- "Gap, per capita, monthly - incl assistance"
var_label(data$PCGap_avg_inclAsst)       <- "Average gap - incl assistance (cohort: below MEB and food insecure)"
var_label(data$avg_MEB_inclAsst)         <- "Average MEB - incl assistance (cohort: below MEB and food insecure"
var_label(data$PCGap_share_MEB_inclAsst) <- "Gap/MEB per capita - incl assist (cohort: below MEB and food insecure)"

summary(data$PCGap_inclAsst)
summary(data$PCGap_avg_inclAsst)
summary(data$avg_MEB_inclAsst)
summary(data$PCGap_share_MEB_inclAsst)

# Compare the gaps (expressed as percentage of the MEB) without and with assistance
  # Create a data frame for comparison
comparison_data <- data.frame(
  Scenario = factor(c("Without Assistance", "With Assistance")),
  PCGap_share_MEB = c(mean(data$PCGap_share_MEB, na.rm = TRUE), 
                      mean(data$PCGap_share_MEB_inclAsst, na.rm = TRUE))
)

  # Create graph to compare the gaps
ggplot(comparison_data, 
       aes(x = Scenario, 
           y = PCGap_share_MEB, 
           fill = Scenario)) +
  geom_bar(stat = "identity", 
           position = "dodge", 
           width = 0.7) +
  labs(title = "Gap as Percentage of the MEB",
       x = NULL) +
  geom_text(aes(label = paste0(round(PCGap_share_MEB, 2))), 
            position = position_dodge(width = 0.7), 
            vjust = -0.5) +
  theme_wfp()

# the difference is very small, because in this dataset the population does not 
# receive much assistance

#------------------------------------------------------------------------------#
#  Estimate the food gap
#------------------------------------------------------------------------------#

# Step 1: Identifying the cost of food needs ----------------------------------#
# A food MEB is already available in the dataset
# This should be used as cost of food needs

# Step 2: Computing household economic capacity used for food -----------------#

# Sum food expenditures and the value of consumed food from own-production
data <- data %>%
  mutate(
    PCExpF_ECMEN = rowSums(select(data, 
                                  PC_HHExp_Food_Purch_MN_1M, 
                                  PC_HHExp_Food_Own_MN_1M), na.rm = TRUE)
  )
var_label(data$PCExpF_ECMEN)     <- "Household Economic Capacity - food - per capita, monthly"
summary(data$PCExpF_ECMEN)

# Deduct the value of cash assistance received from WFP and partner humanitarian
# organizations, that is likely spent on food
  
# In this case, the part of received cash assistance spent on food can be be
# approximated using the Food Expenditure Share of the gap analysis cohort. 
# The Food Expenditure Share is already provided in the dataset.

# Calculate average FES for the gap analysis cohort - we still use the old 
# reference cohort (for the general gap) as that for the food gap is defined 
# at the next step.

data <- data %>%
  mutate(
    avg_FES = mean(FES[Gap_ref == "Part of cohort"]),  
    # Calculate average FES for the gap analysis cohort - we still use the old
    # reference cohort (for the general gap) as that for the food gap is defined 
    # at the next step.
    PC_HHAsstCBTRec_ConsF_1M = PC_HHAsstCBTRec_Cons_1M * avg_FES,  
    # obtain the part of consumed cash assistance spent on food by multiplying
    # consumed received cash assistance by the average FES of the cohort.
    PCExpF_ECMEN = ifelse(!is.na(PC_HHAsstCBTRec_ConsF_1M), 
                          PCExpF_ECMEN - PC_HHAsstCBTRec_ConsF_1M, 
                          PCExpF_ECMEN)
  )
var_label(data$PC_HHAsstCBTRec_ConsF_1M)     <- "Monthly PC cash received by human. sector used for food consumption"
summary(data$PCExpF_ECMEN)

# Step 3 - Identifying the gap analysis cohort --------------------------------#

# In this example the gap analysis group is made of the households with economic
# capacity used for food below the food MEB and who are moderately or severely 
# food insecure based on CARI

##  create a variable to identify the cohort

data <- data %>%
  mutate(
    # create a variable to identify the cohort
    FGap_ref = ifelse(PCExpF_ECMEN < Food_MEB & 
                       (CARI_ECMEN == "Moderately food insecure" | 
                        CARI_ECMEN == "Severely food insecure"), 1, 0)
  )
# convert to factor
data$FGap_ref <- 
  factor(data$FGap_ref,
         levels = c(0,1),
         labels = c("Not part of cohort", "Part of cohort"))

var_label(data$FGap_ref) <- "Gap analysis cohort (below food MEB and food insecure)"
summary(data$FGap_ref)

# Step 4 - Estimating the gap -------------------------------------------------#

# Compute per capita gap for each household
data <- data %>%
  mutate(
    # Compute per capita food gap for each household
    PCFGap   = ifelse(PCExpF_ECMEN < Food_MEB, 
                      Food_MEB - PCExpF_ECMEN, NA),
    # the food gap is defined only for hh with economic capacity used for food 
    # below the food MEB
    # Calculate average gap for the gap analysis cohort
    # Compute average food gap for the gap analysis cohort and save to a variable
    PCFGap_avg = ifelse(FGap_ref == "Part of cohort", 
                        mean(PCFGap[FGap_ref == "Part of cohort"], 
                        na.rm = TRUE), NA),
    # store calculated average into a variable (defined only for the cohort)
    # Express the average food gap as share of the average food MEB
    PCFGap_share_Food_MEB = ifelse(FGap_ref == "Part of cohort",
                                   PCFGap_avg / Food_MEB, NA)
    # Note: in this example the food MEB is the same for all households, 
    # so no need to average the MEB
  )

# Label the variables
var_label(data$PCFGap)                 <- "Food gap, per capita, monthly"
var_label(data$PCFGap_avg)             <- "Average per capita food gap (cohort: below food MEB and food insecure)"
var_label(data$PCFGap_share_Food_MEB)  <- "Food Gap/Food MEB per capita (cohort: below food MEB and food insecure)"

summary(data$PCFGap)
summary(data$PCFGap_avg)
summary(data$PCFGap_share_Food_MEB)

# Compare the gap and the food gap
# Create a data frame for comparison
comparison_data <- data.frame(
  Scenario = factor(c("Gap", "Food Gap")),
  PCGap_Com_avg = c(mean(data$PCGap_avg,  na.rm = TRUE), 
                    mean(data$PCFGap_avg, na.rm = TRUE))
)

# Create graph to compare the gaps
ggplot(comparison_data, 
       aes(x = Scenario, 
           y = PCGap_Com_avg, 
           fill = Scenario)) +
  geom_bar(stat = "identity", 
           position = "dodge", 
           width = 0.5) +
  labs(title = "Gap and Food Gap, monthly per capita",
       x = NULL) +
  geom_text(aes(label = paste0(round(PCGap_Com_avg, 2))), 
            position = position_dodge(width = 0.7), 
            vjust = -0.5) +
  theme_wfp()
