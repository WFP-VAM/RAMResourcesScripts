*STATA Syntax for the Multidimensional Deprivation Index (MDDI)
					 
*Construction of the Multidimensional Deprivation Index (MDDI) is based on the codebook questions prepared for the MDDI module available at:
*https://docs.wfp.org/api/documents/WFP-0000121341/download/

*1. Creation of variables of deprivations for each dimension

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*MDDI FOOD DIMENSION
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
    *Food Consumption Score 	
*Define labels 
lab var FCSStap "Consumption over the past 7 days (cereals and tubers)"
lab var FCSVeg "Consumption over the past 7 days (vegetables)"
lab var FCSFruit "Consumption over the past 7 days (fruit)"
lab var FCSPr "Consumption over the past 7 days (protein-rich foods)"
lab var FCSPulse "Consumption over the past 7 days (pulses)"
lab var FCSDairy "Consumption over the past 7 days (dairy products)"
lab var FCSFat "Consumption over the past 7 days (oil)"
lab var FCSSugar "Consumption over the past 7 days (sugar)"

*Calculate FCS
gen FCS=(FCSStap*2) + FCSVeg + FCSFruit + (FCSPr*4) + (FCSPulse*3) + (FCSDairy*4) + (FCSFat*0.5) + (FCSSugar*0.5)
lab var FCS "Food Consumption Score"

*Categorize FCS
***Use this when analyzing a country with high consumption of sugar and oil – thresholds 28-42
recode FCS (0/28=1 "poor") (28/42=2 "borderline") (42/max=3 "acceptable"), gen(FCSCat28)
lab var FCSCat28 "FCS Categories"
sum FCSCat28, d
 
***Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35
recode FCS (0/21=1 "poor") (21/35=2 "borderline") (35/max=3 "acceptable"), gen (FCSCat21)
lab var FCSCat21 "FCS Categories"
sum FCSCat21, d

*Turn into MDDI variable (with high consumption of sugar and oil countries)
** Note: Construct the same indicators with different threshold (21) for low consumption of sugar and oil countries
gen byte MDDI_food1= (FCSCat28==1 | FCSCat28==2)   
lab var MDDI_food1 "Percentage of HH with unacceptable food consumption"
tab MDDI_food1


    *rCSI (Reduced Consumption Strategies Index)
*Define Lables  
lab var rCSILessQlty "Relied on less preferred, less expensive food"
lab var rCSIMealNb "Borrowed food or relied on help from friends or relatives"
lab var rCSIMealNb "Reduced the number of meals eaten per day"
lab var rCSIMealSize "Reduced portion size of meals at meals time"
lab var rCSIMealAdult "Restrict consumption by adults in order for young-children to eat"

*Compute rCSI
gen rCSI=(rCSILessQlty*1) + (rCSIBorrow*2) + (rCSIMealNb*1) + (rCSIMealSize*3) + (rCSIMealAdult*1)
lab var rCSI "Reduced Consumption Strategies Index"

*Turn into MDDI variable 
*For the rCSI, use the threshold as 18 - this is defined as IPC3+
gen byte MDDI_food2= rCSI>18
lab var MDDI_food2 "Percentage of HH with high level of consumption coping strategies"
tab MDDI_food2


*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*MDDI EDUCATION DIMENSION
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
   *At least one school age children (6-17) (Adjust to country context) not attending school in the last 6 months 
gen byte MDDI_edu=HHNoSchoolAttNb_6M>0
lab var MDDI_edu "Households with at least one school-age children not attending school"
tab MDDI_edu


*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*MDDI HEALTH DIMENSION
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
    *Medical treatment - Did household members being chronically or acutely ill receive medical attention while sick? (answers - 0= No 1=Yes, some of them 2=Yes, all of them)
gen byte MDDI_health1=(HHENHealthMed==0 | HHENHealthMed==1)
lab var MDDI_health1 "At least one member did not reeive medical treatment while sick"
tab MDDI_health1

    *Number of sick people > 1 or >50% of household members 
egen HHSickNb=rowtotal (HHDisabledNb HHChronIllNb)
gen HHSickShare= HHSickNb/HHSize

gen byte MDDI_health2=(HHSickNb>1 | HHSickShare>0.5)
lab var MDDI_health2 "HH with more than half members or at least one member sick"
tab MDDI_health2

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*MDDI DIMENSION SHELTER
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
    *Source of energy for cooking - for MDDI calculation make sure to distinguish between solid and non-solid fuels.
gen byte MDDI_shelter1=(HEnerCookSRC=0 | HEnerCookSRC=100 | HEnerCookSRC=200 | HEnerCookSRC=500 | HEnerCookSRC=600 | HEnerCookSRC=900 | HEnerCookSRC=999)
lab var MDDI_shelter1 "Households with no improved energy source for cooking"
tab MDDI_shelter1

    *Crowding Index  (Number of HH members/Number of rooms (excluding kitchen, corridors))>3 
gen crowding=HHSize/HHRoomUsed

gen byte MDDI_shelter3=crowding>3
lab var MDDI_shelter3 "Households with at least 3 HH members sharing one room to sleep"
tab MDDI_shelter3
    
    *Source of energy for lighting - HH has no electricity
gen byte energy_deprived= HEnerLightSRC!=401 | HEnerLightSRC!=402 
lab var MDDI_shelter2 "Households with no  improved source of energy for lighting"
tab MDDI_shelter2

    
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*MDDI DIMENSION WASH
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
    *Toilet Type (not-improved facility)
gen byte MDDI_wash1=HToiletType==20100 | HToiletType==20200 | HToiletType==20300 | HToiletType==20400 | HToiletType==20500
lab var MDDI_wash1 "Households with not improved toilet facility"
tab MDDI_wash1.

    *Water source (not-improved facility)
gen byte MDDI_wash2=(HWaterSRC==500 | HWaterSRC==600 | HWaterSRC==700 | HWaterSRC==800)
lab var MDDI_wash2 "Households with not improved facility for drinking water source"
tab MDDI_wash2


*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*MDDI DIMENSION SAFETY
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
    *Safety : Felt unsafe or suffered violence
gen byte MDDI_safety1=HHPercSafe==0
lab var MDDI_safety1 "One or more HH members felt unsafe or suffered violence"
tab MDDI_safety1.

    *Displaced by forced in the last 12 months (calculate a new variable for arrivals within the last 12 months)
***Example of calculating the arrival time by months (adjust if you already have a variable for the date of data collection and use it instead of `today' variable)
*****Step 1. Create current date as new variable in data (adjust "11/25/21" to current date)
gen today = date("11/25/21", "MD20Y")

******Step 2. Show current date in date format (check if HHHDisplArrive is not alreadt in %td)
format today HHHDisplArrive %td 

******Step 3. Compute the difference
gen Arrival_time = datediff(today, HHHDisplArrive,"month")

****Step 4. Calculate if arrival time is less than 12 months
gen byte MDDI_safety2=Arrival_time<13
lab var MDDI_safety2 "HH has been displaced in the last 12 months"
tab MDDI_safety2


*2. Multidimensional Deprivation Index
*Calculate the overall deprivation score of each dimension, we can use it to have a spider chart to show overall percentage of deprivation for each dimension

*Weighting: Method of nesting with equal weights
gen MDDI_food=(MDDI_food1*1/2) + (MDDI_food2*1/2)
gen MDDI_edu=MDDI_edu*1
gen MDDI_health=(MDDI_health1*1/2) + (MDDI_health2*1/2)
gen MDDI_shelter=(MDDI_shelter1*1/3) +(MDDI_shelter2*1/3) + (MDDI_shelter3*1/3)
gen MDDI_wash=(MDDI_wash1*1/2) + (MDDI_wash2*1/2)
gen MDDI_safety=(MDDI_safety1*1/2) + (MDDI_safety2*1/2)

*Label Variables:
lab var MDDI_food "Deprivation score for food dimension"
lab var MDDI_edu "Deprivation score for education dimension"
lab var MDDI_health "Deprivation score for health dimension"
lab var MDDI_shelter "Deprivation score for shelter dimension"
lab var MDDI_wash "Deprivation score for WASH dimension"
lab var MDDI_safety "Deprivation score for safety and displacement dimension"

tabstat MDDI_food MDDI_edu MDDI_health MDDI_shelter MDDI_wash MDDI_safety, stat(mean sd min max)

*Calculate the Overall MDDI Score
gen MDDI= (MDDI_food+MDDI_edu+MDDI_health+MDDI_shelter+MDDI_wash+MDDI_safety)/6
lab var MDDI "MDDI score"
sum MDDI, d

*Calculate MDDI Incidence (H)
*Thresholds are 0.50 for severe deprivation and 0.33 for deprivation – it can be adjusted according to the context
gen byte MDDI_poor_severe=MDDI>=0.33
lab var MDDI_poor_severe "MDDI Incidence – severe deprivation"

gen byte MDDI_poor=MDDI>=0.50
lab var MDDI_poor "MDDI Incidence"

lab def MDDI_label 0"HH is not deprived" 1"HH is deprived"
lab val MDDI_poor_severe MDDI_label
lab val MDDI_poor MDDI_label

*Calculate the Average MDDI Intensity (A)
gen MDDI_intensity==MDDI if MDDI_poor=1
lab var MDDI_intensity "Average MDDI Intensity (A)"
sum MDDI_intensity, d

*Calculate Combined MDDI (M= HxA)
gen MDDI_combined=MDDI_poor*MDDI_intensity
lab var MDDI_combined "Combined MDDI (M)"

*Show results 
tabstat MDDI_poor MDDI_poor_severe, stat(mean sd min max)
tabstat MDDI_intensity MDDI_combined, stat(mean sd min max)
