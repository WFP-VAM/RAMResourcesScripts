*** --------------------------------------------------------------------------
 
***                           WFP RAM Standardized Scripts
***              Calculating Household Dietary Diversity Score (HDDS)
 
*** --------------------------------------------------------------------------
 
* Encoding: UTF-8.
 
***Create Household Dietary Diversity Score – 24hr recall  from HDDS module ***
**remember that you need 12 food groups to compute the HDDS, recall period is past 24 hours before the survey
 
Variable labels
HDDSStapCer   Cereals consumption in the previous 24 hours
HDDSStapRoot  Roots and tubers consumption in the previous 24 hours
HDDSVeg       Vegetable consumption in the previous 24 hours
HDDSFruit     Fruit consumption in the previous 24 hours
HDDSPrMeat    Meat/poultry consumption in the previous 24 hours
HDDSPrEggs    Eggs consumption in the previous 24 hours
HDDSPrFish    Fish consumption in the previous 24 hours
HDDSPulse     Pulses/legumes consumption in the previous 24 hours
HDDSDairy     Milk and dairy product consumption in the previous 24 hours
HDDSFat       Oil/fats consumption in the previous 24 hours
HDDSSugar     Sugar/honey consumption in the previous 24 hours
HDDSCond      Miscellaneous/condiments consumption in the previous 24 hours.

**Note that it is advised to use + instead of SUM() as cases with missing values should not be included in the calcuation. 
 
Compute HDDS = HDDSStapCer + HDDSStapRoot + HDDSVeg + HDDSFruit + HDDSPrMeat + HDDSPrEggs + HDDSPrFish + HDDSPulse + HDDSDairy + HDDSFat + HDDSSugar + HDDSCond.
Variable labels HDDS 'Household Dietary Diversity Score'.
EXECUTE.
 
Recode HDDS (lowest thru 2=1) (3 thru 4=2) (5 thru highest = 3) into HDDSCat_IPC. 
Value labels HDDSCat_IPC 1 '0-2 food groups (phase 4 to 5)' 2 '3-4 food groups (phase 3)' 3 '5-12 food groups (phase 1 to 2)'. 
Variable labels HDDSCat_IPC 'HDDS categories using IPC severity scale'.
EXECUTE.
