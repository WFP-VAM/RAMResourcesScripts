#------------------------------------------------------------------------------#

#	                        WFP APP Standardized Scripts
#                   Calculating Food Consumption Score (FCS)

#------------------------------------------------------------------------------#

## Load Packages --------------------------------------------------------------#

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg))
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages<-c('psych','diveRsity','expss')
ipak(packages)

library('psych')
library("diveRsity")

# Set working directory -------------------------------------------------------#

## Get working directory
getwd()# Display current working directory
dir()# Display working directory content

setwd("C:\\Users\\name.lastname\\Documents\\Rfolder")
# This is just an example. Copy and paste your own working directory. Remember to use "\\" instead of "/"
# The data base to be used should be part of the content

# Load Sample Data ------------------------------------------------------------#

#data <- read.csv("../../Static/FCS_Sample_Survey.csv",na.strings = "n/a")
#names(data)# Display var names for the entire data base
#attach(data)# Attach the data base for easy access to var names. 

# Prepare FCS related variables -----------------------------------------------# 

# 1. Re-coding missing values to zero
data$FCSStap[is.na(data$FCSStap)]   <-0 
data$FCSVeg[is.na(data$FCSVeg)]     <-0 
data$FCSFruit[is.na(data$FCSFruit)] <-0  
data$FCSPr[is.na(data$FCSPr)]       <-0  
data$FCSPulse[is.na(data$FCSPulse)] <-0   
data$FCSDairy[is.na(data$FCSDairy)] <-0  
data$FCSSugar[is.na(data$FCSSugar)] <-0  
data$FCSFat[is.na(data$FCSFat)]     <-0  
data$FCSCond[is.na(data$FCSCond)]   <-0

# Test results
print(data$FCSStap) # How data looks like?

## 2. Variables creation and statistics testing
# Var FCSStapCer FCSStapTub
# although deprecated, in case two staples are collected separately, then:
if ("FCSStap" %in% colnames(data)) {"x"} else 
 { 
  data$FCSStap <- mapply(max, data$FCSStapCer, data$FCSStapTub, na.rm=T)
 }
count(data$FCSStap)
basicStats(data$FCSStap, ci=0.95)
plot(density(data$FCSStap))

# Legumes/nuts (FCSPulse)
data$FCSPulse
count(data$FCSPulse)
basicStats(data$FCSPulse, ci=0.95)
plot(density(data$FCSPulse))

# Milk and other dairy products (FCSDairy)
data$FCSDairy
count(data$FCSDairy)
basicStats(data$FCSDairy, ci=0.95)
plot(density(data$FCSDairy))

# Meat, fish and eggs (FCSPr)
data$FCSPr
count(data$FCSPr)
basicStats(data$FCSPr, ci=0.95)
plot(density(data$FCSPr))

# Vegetables and leaves (FCSVeg)
data$FCSVeg 
count(data$FCSVeg)
basicStats(data$FCSVeg, ci=0.95)
plot(density(data$FCSVeg))

# Fruits (FCSFruit)
data$FCSFruit 
count(data$FCSFruit)
basicStats(data$FCSFruit, ci=0.95)
plot(density(data$FCSFruit))

# Oil, fat and butter (FCSFat)  
data$FCSFat 
count(data$FCSFat)
basicStats(data$FCSFat, ci=0.95)
plot(density(data$FCSFat))

# Sugar and sweet (FCSSugar)
data$FCSSugar
count(data$FCSSugar)
basicStats(data$FCSSugar, ci=0.95)
plot(density(data$FCSSugar))

# Condiments / Spices
data$FCSCond
count(data$FCSCond)
basicStats(data$FCSCond, ci=0.95)
plot(density(data$FCSCond))

# 2.1 Recode above 7 to 7 (only if necessary)
data$Ncertub[data$FCSStap>7]   <- 7
data$FCSPulse[data$FCSPulse>7] <- 7
data$FCSDairy[data$FCSDairy>7] <- 7
data$FCSPr[data$FCSPr>7]       <- 7
data$FCSVeg[data$FCSVeg>7]     <- 7
data$FCSFruit[data$FCSFruit>7] <- 7
data$FCSFat[data$FCSFat>7]     <- 7
data$FCSSugar[data$FCSSugar>7] <- 7
data$FCSCond[data$FCSCond>7]   <- 7

# Calculate FCS ---------------------------------------------------------------# 
data$FCS <- mapply(sum,(data$FCSStap*2),(data$FCSPulse*3),(data$FCSDairy*4),
                   (data$FCSPr*4),(data$FCSVeg),(data$FCSFruit),(data$FCSFat*0.5),
                   (data$FCSSugar*0.5))
###### Test  #####
head(data$FCS, n=10)
psych::describe(data$FCS)
summary(data$FCS)
stat.desc(data$FCS, basic = F)
plot(density(data$FCS))

# Create FCG groups based on 21/55 or 28/42 thresholds ------------------------# 
###Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35
data$FCSCat21 <-cut(data$FCS,
                    breaks=c(0,21,35,Inf),
                    include.lowest=TRUE,
                    #labels=c("Poor","Borderline","Acceptable"))
                    labels=FALSE)

### define value labels and properties for "FCS Categories".
val_lab(data$FCSCat21) = num_lab("
             1 Poor
             2 Borderline
             3 Acceptable
")

### Important note: pay attention to the threshold used by your CO when selecting the syntax (21 cat. vs 28 cat.)
### Use this when analyzing a country with high consumption of sugar and oil - thresholds 28-42
data$FCSCat28 <-cut(data$FCS,
                    breaks=c(0,28,42,Inf),
                    include.lowest=TRUE,
                    #labels=c("Poor","Borderline","Acceptable"))
                    labels=FALSE)
### define value labels and properties for "FCS Categories".
val_lab(data$FCSCat28) = num_lab("
             1 Poor
             2 Borderline
             3 Acceptable
")

# End of Scripts