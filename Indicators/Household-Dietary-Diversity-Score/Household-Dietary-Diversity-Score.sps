* Encoding: UTF-8.
*** ----------------------------------------------------------------------------------------------------

***	                        WFP Standardized Scripts
***                                     Household Dietary Diversity Score (HDDS)


*** Last Update: Nov 2025
*** Purpose: This script calculates the Household Dietary Diversity Score

***   Data Quality Guidance References:
***   - Recommended coding (can also be used for high frequency checks): Page 17
***   - Recommended cleaning steps: Page 37

*** ----------------------------------------------------------------------------------------------------

*** Define group labels-  these should match Survey Designer naming conventions

VARIABLE LABELS
HDDSStapCer         "Cereals consumption in the previous 24 hours"
HDDSStapRoot       "Roots and tubers consumption in the previous 24 hours"
HDDSPulse             "Pulses/legume consumption in the previous 24 hours"
HDDSDairy               "Milk and dairy product consumption in the previous 24 hours"
HDDSPrMeat           "Meat/poultry consumption in the previous 24 hours"
HDDSPrEggs          "Eggs consumption in the previous 24 hours"
HDDSPrFish            "Fish consumption in the previous 24 hours"
HDDSVeg                 "Vegetable consumption in the previous 24 hours"
HDDSFruit                "Fruit consumption in the previous 24 hours"
HDDSFat                  "Oil/fat consumption in the previous 24 hours"
HDDSSugar             "Sugar/honey consumption in the previous 24 hours"
HDDSCond              "Miscellaneous/condiments consumption in the previous 24 hours".

*** Check individual food groups
    
FREQUENCIES VARIABLES = HDDSStapCer HDDSStapRoot HDDSPulse HDDSDairy HDDSPrMeat HDDSPrFish HDDSPrEggs HDDSVeg HDDSFruit HDDSFat HDDSSugar HDDSCond
  /FORMAT = NOTABLE
  /STATISTICS = MINIMUM MAXIMUM MEAN.
  
 *** Harmonize Data Quality Guidance measures
*** Clean impossible values 

RECODE HDDSStapCer HDDSStapRoot HDDSPulse HDDSDairy HDDSPrMeat HDDSPrFish HDDSPrEggs HDDSVeg HDDSFruit HDDSFat HDDSSugar HDDSCond (LOWEST THRU -1 = SYSMIS).
RECODE HDDSStapCer HDDSStapRoot HDDSPulse HDDSDairy HDDSPrMeat HDDSPrFish HDDSPrEggs HDDSVeg HDDSFruit HDDSFat HDDSSugar HDDSCond (2 THRU HIGHEST = SYSMIS).
EXECUTE.

*** Calculate HDDS (use + instead of SUM to automatically drop missing values from the final HDDS)
 
COMPUTE HDDS = HDDSStapCer + HDDSStapRoot + HDDSPulse + HDDSDairy + HDDSPrMeat + HDDSPrFish + HDDSPrEggs + HDDSVeg + HDDSFruit + HDDSFat + HDDSSugar + HDDSCond.
VARIABLE LABELS HDDS 'Household Dietary Diversity Score'.
EXECUTE.

*** Check distribution of final categories

FREQUENCIES VARIABLES=HDDSStapCer HDDSStapRoot HDDSPulse HDDSDairy HDDSPrMeat HDDSPrFish HDDSPrEggs HDDSVeg HDDSFruit HDDSFat HDDSSugar HDDSCond
  /ORDER=ANALYSIS.

*** Harmonize Data Quality Guidance measures
*** Check that HDDS is between 0-12

DESCRIPTIVES VARIABLES=HDDS
  /STATISTICS=MEAN STDDEV MIN MAX.

*** Clean any impossible HDDS values

RECODE HDDS (LOWEST THRU -1 = SYSMIS).
RECODE HDDS (13 THRU HIGHEST = SYSMIS).
EXECUTE.

*** Flagging potential Data Quality issues. If any cases reflected here, refer to the Data Quality Guidance note page 37. This can be found on the VAM Ressource Centre, 
*** Note that while the HDDS data can be validated using FCS data, the opposite is not possible since HDDS considers food consumed in small quantities and anyone in
the household (not the majority like FCS).

COMPUTE HDDS_flag_zero = 0.    
IF (HDDS = 0) HDDS_flag_zero = 1.
VARIABLE LABELS HDDS_flag_zero "HDDS has a zero value, meaning that the HH did not eat anything in the past 24 hours. Flag to team leader".
VALUE LABELS HDDS_flag_zero
    0 "No"
    1 "Yes".

COMPUTE HDDS_flag_low = 0.    
IF (HDDS LE 2) HDDS_flag_low = 1.
VARIABLE LABELS HDDS_flag_low "HDDS has low values. Flag to team leader if acceptable FCS".
VALUE LABELS HDDS_flag_low
    0 "No"
    1 "Yes".

COMPUTE HDDS_flag_high = 0.    
IF (HDDS GE 10) HDDS_flag_high = 1.
VARIABLE LABELS HDDS_flag_high "HDDS has high values. Flag to team leader if poor or borderline FCS".
VALUE LABELS HDDS_flag_high
    0 "No"
    1 "Yes".

COMPUTE HDDS_flag_cereal = 0.    
IF (FCSStap = 7 AND HDDSStapCer = 0 AND HDDSStapRoot = 0) HDDS_flag_cereal = 1.
VARIABLE LABELS HDDS_flag_cereal "HH consumed cereal in FCS module but not in HDDS module. Flag issue to team leader".
VALUE LABELS HDDS_flag_cereal
    0 "No"
    1 "Yes".

COMPUTE HDDS_flag_pulses = 0.    
IF (FCSPulse = 7 AND HDDSPulse = 0) HDDS_flag_pulses = 1.
VARIABLE LABELS HDDS_flag_pulses "HH consumed pulses in FCS module but not in HDDS module. Flag issue to team leader".
VALUE LABELS HDDS_flag_pulses
    0 "No"
    1 "Yes".

COMPUTE HDDS_flag_dairy = 0.    
IF (FCSDairy = 7 AND HDDSDairy  = 0) HDDS_flag_dairy = 1.
VARIABLE LABELS HDDS_flag_dairy "HH consumed dairy in FCS module but not in HDDS module. Flag issue to team leader".
VALUE LABELS HDDS_flag_dairy
    0 "No"
    1 "Yes".

COMPUTE HDDS_flag_protein = 0.    
IF (FCSPr = 7 AND HDDSPrMeat  = 0 AND HDDSPrEggs = 0 AND HDDSPrFish = 0) HDDS_flag_protein = 1.
VARIABLE LABELS HDDS_flag_protein "HH consumed protein in FCS module but not in HDDS module. Flag issue to team leader".
VALUE LABELS HDDS_flag_protein
    0 "No"
    1 "Yes".

COMPUTE HDDS_flag_veg = 0.    
IF (FCSVeg = 7 AND HDDSVeg  = 0) HDDS_flag_veg = 1.
VARIABLE LABELS HDDS_flag_veg "HH consumed vegetables in FCS module but not in HDDS module. Flag issue to team leader".
VALUE LABELS HDDS_flag_veg
    0 "No"
    1 "Yes".

COMPUTE HDDS_flag_fruit = 0.    
IF (FCSFruit = 7 AND HDDSFruit  = 0) HDDS_flag_fruit = 1.
VARIABLE LABELS HDDS_flag_fruit "HH consumed fruit in FCS module but not in HDDS module. Flag issue to team leader".
VALUE LABELS HDDS_flag_fruit
    0 "No"
    1 "Yes".

COMPUTE HDDS_flag_fat = 0.    
IF (FCSFat = 7 AND HDDSFat  = 0) HDDS_flag_fat = 1.
VARIABLE LABELS HDDS_flag_fat "HH consumed fat in FCS module but not in HDDS module. Flag issue to team leader".
VALUE LABELS HDDS_flag_fat
    0 "No"
    1 "Yes".

COMPUTE HDDS_flag_sugar = 0.    
IF (FCSSugar = 7 AND HDDSSugar  = 0) HDDS_flag_sugar = 1.
VARIABLE LABELS HDDS_flag_sugar "HH consumed sugar in FCS module but not in HDDS module. Flag issue to team leader".
VALUE LABELS HDDS_flag_sugar
    0 "No"
    1 "Yes".
    
COMPUTE HDDS_flag_cond = 0.    
IF (FCSCond = 7 AND HDDSCond  = 0) HDDS_flag_cond = 1.
VARIABLE LABELS HDDS_flag_cond "HH consumed condiments in FCS module but not in HDDS module. Flag issue to team leader".
VALUE LABELS HDDS_flag_cond
    0 "No"
    1 "Yes".
 
*** Check flagged cases
*** If it is found that flags might be data quality issues (i.e. high number of flag_low in very food insecure areas or flag_high in seeminly food secure areas), 
it is recommended to do a crosstab to see the frequency by enumerator to understand if flags are coming from the same few enumerators. Cases of flag_zero 
will be impossible in most contexts    

FREQUENCIES VARIABLES = HDDS_flag_zero HDDS_flag_low HDDS_flag_high HDDS_flag_cereal HDDS_flag_pulses HDDS_flag_dairy HDDS_flag_protein 
  HDDS_flag_veg HDDS_flag_fruit HDDS_flag_fat HDDS_flag_sugar
  /ORDER = ANALYSIS.    

*** Optional: Compute the same variable to be used directly for IPC analysis (referring to IPC phases)

*IF (HDDS LE 2) HDDSCat_IPC = 3.
*IF (HDDS = 3 OR HDDS = 4) HDDSCat_IPC = 2.
*IF (HDDS GE 5) HDDSCat_IPC = 1.    
*VARIABLE LABELS HDDSCat_IPC 'HDDS categories using the IPC severity scale'.
*VALUE LABELS HDDSCat_IPC 
    1 "5-12 food groups (IPC phase 1 to 2)"
    2 "3-4 food groups (IPC phase 3)"
    3 "0-2 food groups (IPC phase 4 to 5)".
EXECUTE.

*** Check distribution of final categories

*FREQUENCIES VARIABLES=HDDSCat_IPC
  /ORDER=ANALYSIS.

*** ----------------------------------------------------------------------------------------------------
*** END OF SCRIPT
*** ----------------------------------------------------------------------------------------------------
