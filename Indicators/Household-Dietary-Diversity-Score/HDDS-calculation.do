*------------------------------------------------------------------------------*
*                           WFP Standardized Scripts
*             Calculating Household Dietary Diversity Score (HDDS)
*------------------------------------------------------------------------------*

* Variable labels
label variable HDDSStapCer  "Cereals consumption in the previous 24 hours"
label variable HDDSStapRoot "Roots and tubers consumption in the previous 24 hours"
label variable HDDSVeg      "Vegetable consumption in the previous 24 hours"
label variable HDDSFruit    "Fruit consumption in the previous 24 hours"
label variable HDDSPrMeat   "Meat/poultry consumption in the previous 24 hours"
label variable HDDSPrEggs   "Eggs consumption in the previous 24 hours"
label variable HDDSPrFish   "Fish consumption in the previous 24 hours"
label variable HDDSPulse    "Pulses/legumes consumption in the previous 24 hours"
label variable HDDSDairy    "Milk and dairy product consumption in the previous 24 hours"
label variable HDDSFat      "Oil/fats consumption in the previous 24 hours"
label variable HDDSSugar    "Sugar/honey consumption in the previous 24 hours"
label variable HDDSCond     "Miscellaneous/condiments consumption in the previous 24 hours"

* Compute HDDS
gen HDDS = HDDSStapCer + HDDSStapRoot + HDDSVeg + HDDSFruit + HDDSPrMeat + HDDSPrEggs + HDDSPrFish + HDDSPulse + HDDSDairy + HDDSFat + HDDSSugar + HDDSCond
* egen HDDS = rowtotal(HDDS*) depending on the missing value checking and cleaning

label variable HDDS "Household Dietary Diversity Score"

* Recode HDDS into categories
recode HDDS (0/2 = 1) (3/4 = 2) (5/12 = 3), generate(HDDSCat_IPC)

label variable HDDSCat_IPC "HDDS categories using IPC severity scale"
label define HDDSCat_IPC 1 "0-2 food groups (phase 4 to 5)" ///
                         2 "3-4 food groups (phase 3)"      ///
                         3 "5-12 food groups (phase 1 to 2)"
label values HDDSCat_IPC HDDSCat_IPC

* End of Scripts