* Encoding: UTF-8.

********************************************************************************
* SPSS Syntax for the Multidimensional Deprivation Index (MDDI)
********************************************************************************
					 
*Construction of the Multidimensional Deprivation Index (MDDI) is based on the codebook questions prepared for the MDDI module available at: 
https://docs.wfp.org/api/documents/WFP-0000134356/download/

*-------------------------------------------------------------------------------*
*  1. Creation of variables of deprivations for each dimension
*-------------------------------------------------------------------------------*

*** FOOD DIMENSION

    ** Food Consumption Score 	
	
*Define labels (skip if already done).
variable labels
FCSStap           Consumption over the past 7 days (cereals and tubers)
FCSVeg            Consumption over the past 7 days (vegetables)
FCSFruit           Consumption over the past 7 days (fruit)
FCSPr              Consumption over the past 7 days (protein-rich foods)
FCSPulse         Consumption over the past 7 days (pulses)
FCSDairy          Consumption over the past 7 days (dairy products)
FCSFat             Consumption over the past 7 days (oil)
FCSSugar         Consumption over the past 7 days (sugar).

*Calculate FCS (skip if already done).
compute FCS = sum(FCSStap*2, FCSVeg, FCSFruit, FCSPr*4, FCSPulse*3, FCSDairy*4, FCSFat*0.5, FCSSugar*0.5).
variable labels FCS "Food Consumption Score".
execute.

*Categorize FCS (skip if already done).

    *Use this when analyzing a country with high consumption of sugar and oil – thresholds 28-42.
recode FCS (0 thru 28 =1) (28.5 thru 42 =2) (42.5 thru highest =3) into FCSCat28.
variable labels FCSCat28 "FCS Categories".
execute.
 
    *Use this when analyzing a country with low consumption of sugar and oil - thresholds 21-35.
recode FCS (0 thru 21 =1) (21.5 thru 35 =2) (35.5 thru highest =3) into FCSCat21.
variable labels FCSCat21 "FCS Categories".
execute.

*Define labels  for "FCS Categories".
value labels FCSCat21
 1.00 'poor'
 2.00 'borderline'
 3.00 'acceptable '.

value labels FCSCat28
 1.00 'poor'
 2.00 'borderline'
 3.00 'acceptable '.
execute.

frequencies FCSCat21 FCSCat28.

*Turn into MDDI variable (with high consumption of sugar and oil countries).
    /* Note: Use FCSCat21 for low consumption of sugar and oil countries.
compute MDDI_food1 = (FCSCat28=1 | FCSCat28=2).
execute.
frequencies MDDI_food1.
variable labels MDDI_food1 ‘HH with unacceptable food consumption’.

    ***rCSI (Reduced Consumption Strategies Index).
    
/***variable labels 
/*1. Relied on less preferred, less expensive food -rCSILessQlty
/*2. Borrowed food or relied on help from friends or relatives-rCSIBorrow
/*3. Reduced the number of meals eaten per day- rCSIMealNb
/*4. Reduced portion size of meals at meals time-rCSIMealSize
/*5. Restrict consumption by adults in order for young-children to eat-rCSIMealAdult

*Compute rCSI (skip if already done).
compute rCSI=(rCSILessQlty * 1) + (rCSIBorrow* 2) + (rCSIMealNb * 1) + (rCSIMealSize * 1) + (rCSIMealAdult * 3).
execute.

*Turn into MDDI variable 
    *For the rCSI, use the threshold as 18 - this is defined as IPC3+.
compute MDDI_food2 = rCSI>18.
execute.
variable labels MDDI_food2 ‘HH with high level of consumption coping strategies’.
frequencies MDDI_food2.

*** EDUCATION DIMENSION

   **At least one school age children (6-17) (adjust to country context) not attending school in the last 6 months.   
compute MDDI_edu1= HHNoSchool=1.
execute.
variable labels MDDI_edu1 ‘HH with at least one school-age children not attending school’.
frequencies MDDI_edu1.

*** HEALTH DIMENSION
    
       **Medical treatment - Did household members being chronically or acutely ill receive medical attention while sick? (answers - 0="No", 1="Yes, some of them", 2="Yes, all of them").
compute MDDI_health1= (HHENHealthMed=0 | HHENHealthMed=1).
execute.
variable labels MDDI_health1 ‘HH with at least one member did not receive medical treatment while sick’.
frequencies MDDI_health1.

   **Number of sick or disabled people > 1 or >50% of household members.
compute HHSickNb= sum(HHDisabledNb, HHChronIllNb).
compute HHSickShare= HHSickNb/ HHSizeCalc.
compute MDDI_health2 = (HHSickNb>1 | HHSickShare>0.5).
execute.
variable labels MDDI_health2 ‘HH with more than half members or more than one member sick’.
frequencies MDDI_health2.

*** SHELTER DIMENSION

    **Source of energy for cooking - HH uses solid fuels for cooking.
compute MDDI_shelter1= ( HEnerCookSRC=0 | HEnerCookSRC=100 | HEnerCookSRC=102  | HEnerCookSRC=200 | HEnerCookSRC=500 | HEnerCookSRC=600 | HEnerCookSRC=900 | HEnerCookSRC=999) .
execute.
variable labels MDDI_shelter1 ‘HH with no improved energy source for cooking’.
frequencies MDDI_shelter1.

    **Source of energy for lighting - HH has no electricity.
compute MDDI_shelter2= (HEnerLightSRC<>401 AND HEnerLightSRC<>402) .
execute.
variable labels MDDI_shelter2 ‘HH with no improved source of energy for lighting’.
execute.
frequencies MDDI_shelter2.

    **Crowding Index - (Number of HH members/Number of rooms (excluding kitchen, corridors))>3 .
compute crowding= HHSizeCalc/HHRoomUsed.
compute MDDI_shelter3= ( crowding > 3).
execute.
variable labels MDDI_shelter3 ‘HH with at least 3 HH members sharing one room to sleep’.
    
*** WASH DIMENSION

    **Toilet Type (not-improved facility).
compute MDDI_wash1= ( HToiletType=20100 | HToiletType=20200 | HToiletType=20300 | HToiletType=20400 | HToiletType=20500).
execute.
variable labels MDDI_wash1 ‘HH with not improved toilet facility’.
frequencies MDDI_wash1.
    
    **Water source (not-improved source).
compute MDDI_wash2= ( HWaterSRC=500 | HWaterSRC=600 | HWaterSRC=700 | HWaterSRC=800).
execute.
variable labels MDDI_wash2 'HH with not improved drinking water source'.
frequencies MDDI_wash2.
    

** SAFETY DIMENSION 

    **Safety: HH felt unsafe or suffered violence.
compute MDDI_safety1 = (HHPercSafe=0 OR HHShInsec1Y=1).
execute.
variable labels MDDI_safety1 ‘HH with one or more members who felt unsafe or suffered violence’.
frequencies MDDI_safety1.

    **Displaced by forced in the last 12 months
        /*Example of calculating months since arrival (adjust if you already have a variable for the date of data collection and use it instead of ‘interview_date’ variable)

*Step 1. Create fictitious day of data collection.
string  interview_date_str (A10).
compute interview_date_str='25.11.2021'.
compute interview_date=number(interview_date_str, DATE10).
execute.

*Step 2. Show current date in date format.
formats interview_date HHHDisplArrive  (edate10).

*Step 3. Compute the difference.
compute Arrival_time = datediff(interview_date, HHHDisplArrive,'months').
execute.
formats Arrival_time (f4). /* don't show decimal places.

*Step 4. Turn into MDDI variable.
compute MDDI_safety2= (Arrival_time < 13 AND HHDisplChoice=0). 
if (HHDispl=0) MDDI_safety2 = 0. /* household not deprived if not displaced.
execute.
frequencies MDDI_safety2.
variable labels MDDI_safety2 ‘HH displaced by force in the last 12 months’.

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*  2. Calculate deprivation score of each dimension
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
    
/*Weighting : Method of nesting with equal weights 
/* Note: by default if any indicator is missing for a case, its deprivation score for the dimension of that indicator will be missing. 
/* Consequently, also MDDI measures will be missing. Be careful with indicators that are missing for many observations (e.g. >10% of the sample). 

compute MDDI_food= (MDDI_food1*1/2)+ (MDDI_food2*1/2).
compute MDDI_edu=MDDI_edu1*1.
compute MDDI_health= (MDDI_health1*1/2)+ (MDDI_health2*1/2).
compute MDDI_shelter=(MDDI_shelter1*1/3)+(MDDI_shelter2*1/3)+ (MDDI_shelter3*1/3).
compute MDDI_wash=(MDDI_wash1*1/2) + (MDDI_wash2*1/2).
compute MDDI_safety= (MDDI_safety1*1/2) + (MDDI_safety2*1/2).
execute.

variable labels 
MDDI_food ‘Deprivation score for food dimension’
MDDI_edu ‘Deprivation score for education dimension’
MDDI_health ‘Deprivation score for health dimension’
MDDI_shelter ‘Deprivation score for shelter dimension’
MDDI_wash ‘Deprivation score for WASH dimension’
MDDI_safety ‘Deprivation score for safety and displacement dimension’.
execute.

frequencies MDDI_food MDDI_edu MDDI_health MDDI_shelter MDDI_wash MDDI_safety.

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*  3. Calculate MDDI-related measures
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*

*Calculate the overall MDDI Score.
compute MDDI=sum(MDDI_food, MDDI_edu, MDDI_health, MDDI_shelter, MDDI_wash, MDDI_safety)/6.
execute.
variable labels MDDI ‘MDDI score’.
frequencies MDDI.

*Calculate MDDI Incidence (H)
    *Thresholds are 0.50 for severe deprivation and 0.33 for deprivation – it can be adjusted according to the context.
compute MDDI_poor_severe= MDDI GE 0.50.
variable labels MDDI_poor_severe ‘MDDI Incidence – severe deprivation’.
execute.

compute MDDI_poor = MDDI GE 0.33.
variable labels MDDI_poor ‘MDDI Incidence’.
execute.

Value labels MDDI_poor MDDI_poor_severe 
    1 ‘ HH is deprived’
    0 ‘HH is not deprived’.

*Calculate the Average MDDI Intensity (A).
if (MDDI_poor=1) MDDI_intensity=MDDI. /* the variable is missing for non MDDI-poor households.
variable labels MDDI_intensity 'Average MDDI Intensity (A)'.
execute.
frequencies MDDI_intensity.

/***Calculate Combined MDDI (M= HxA).
compute MDDI_combined=MDDI_poor*MDDI_intensity.
if (MDDI_poor=0) MDDI_combined=0.
variable labels MDDI_combined ‘Combined MDDI (M)’.
execute.

*Show results. 
descriptives variables = MDDI_poor MDDI_poor_severe MDDI_intensity MDDI_combined
/statistics = mean.


