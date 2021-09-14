#### Title: R syntax for Food security indicators ####

###### Intall/load packages ####

###### Set working directory #####
## Select the working directory where the data base is stored. 
setwd("C:\\Users\\name.lastname\\Documents\\Rfolder")
# This is just an example. Copy and paste your own working directory. Remember to use "\\" instead of "/"
# The data base to be used should be part of the content

## Get working directory
getwd()# Display current working directory
dir()# Display working directory content

### Load data base ####
data <- read_excel(".\\DBCohortExample.xlsx", sheet="CohortExample")
names(data)# Display var names for the entire data base
attach(data)# Attach the data base for easy access to var names. 

###### Food Security Indicators Development ##########

## Food Consumption Score (FCS) ####

# 1. Re-coding missing values to zero
data$CN1A[is.na(data$CN1A)] <-0 
data$CN1B[is.na(data$CN1B)] <-0 
data$CN2[is.na(data$CN2)] <-0  
data$CN3[is.na(data$CN3)] <-0  
data$CN4[is.na(data$CN4)] <-0   
data$CN5[is.na(data$CN5)] <-0  
data$CN6[is.na(data$CN6)] <-0  
data$CN7[is.na(data$CN7)] <-0  
data$CN8[is.na(data$CN8)] <-0
data$CN9[is.na(data$CN9)] <-0

# Test results
print(data$CN1A) # How data looks like?
print(data$CN6) # How data looks like?

## 2. Variables creation and statistics testing
# Var Ncertub (FCSStap)
data$Ncertub <- mapply(max, data$CN1A, data$CN1B, na.rm=T)
count(data$Ncertub)
basicStats(data$Ncertub, ci=0.95)
plot(density(data$Ncertub))

# Legumes/nuts (FCSPulse)
data$CN2
count(data$CN2)
basicStats(data$CN2, ci=0.95)
plot(density(data$CN2))

# Milk and other dairy products (FCSDairy)
data$CN3
count(data$CN3)
basicStats(data$CN3, ci=0.95)
plot(density(data$CN3))

# Meat, fish and eggs (FCSPr)
data$CN4
count(data$CN4)
basicStats(data$CN4, ci=0.95)
plot(density(data$CN4))

# Vegetables and leaves (FCSVeg)
data$CN5 
count(data$CN5)
basicStats(data$CN5, ci=0.95)
plot(density(data$CN5))

# Fruits (FCSFruit)
data$CN6 
count(data$CN6)
basicStats(data$CN6, ci=0.95)
plot(density(data$CN6))

# Oil, fat and butter (FCSFat)  
data$CN7 
count(data$CN7)
basicStats(data$CN7, ci=0.95)
plot(density(data$CN7))

# Sugar and sweet (FCSSugar)
data$CN8
count(data$CN8)
basicStats(data$CN8, ci=0.95)
plot(density(data$CN8))

# Condiments / Spices
data$CN9
count(data$CN9)
basicStats(data$CN9, ci=0.95)
plot(density(data$CN9))

# 2.1 Recode above 7 to 7 (only if necesary)
data$Ncertub[data$Ncertub>7] <- 7
data$CN2[data$CN2>7] <- 7
data$CN3[data$CN3>7] <- 7
data$CN4[data$CN4>7] <- 7
data$CN5[data$CN5>7] <- 7
data$CN6[data$CN6>7] <- 7
data$CN7[data$CN7>7] <- 7
data$CN8[data$CN8>7] <- 7
data$CN9[data$CN9>7] <- 7

# 3. Multiplying food groups by weight and creates FCS1
data$fcs1 <- mapply(sum,(data$Ncertub*2),(data$CN2*3),(data$CN3*4),(data$CN4*4),(data$CN5),(data$CN6),(data$CN7*0.5),(data$CN8*0.5))

# Test 
head(data$fcs1, n=10)
psych::describe(data$fcs1)
summary(data$fcs1)
stat.desc(data$fcs1, basic = F)
plot(density(data$fcs1))