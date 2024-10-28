*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*     Consolidated Approach for Reporting Indicators of Food Security (CARI)
*                CALCULATE CARI using FCS, rCSI, LCS and ECMEN
*------------------------------------------------------------------------------*

* Note that there are two ways to calculate CARI - using ECMEN or FES. This syntax 
* file is for calculating CARI using ECMEN (version excluding assistance). However, 
* please navigate to the script for CARI using FES as relevant. 
* Guidance on CARI can be found here: 
* https://www.wfp.org/publications/consolidated-approach-reporting-indicators-food-security-cari-guidelines.

* Note: this syntax file is based on the assumption that the scripts of the various 
* indicators that compose this version of the CARI (FCS, rCSI, LCS-FS, ECMEN) have 
* already been run. You can find these scripts here: 
* https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Indicators.
* The following variables should have been defined before running this file:
*   FCSCat21 and/or FCSCat28 
*   rCSI
*   Max_coping_behaviourFS	
*   ECMEN_exclAsst 
*   ECMEN_exclAsst_SMEB.		

*------------------------------------------------------------------------------*
* Process FCS for CARI computation
*------------------------------------------------------------------------------*

* Create FCS_4pt for CARI calculation.
recode FCSCat21 (1=4) (2=3) (3=1), generate(FCS_4pt)
label variable FCS_4pt "4pt FCG"
label define FCS_4pt 1 "Acceptable" 3 "Borderline" 4 "Poor"
label values FCS_4pt FCS_4pt

*------------------------------------------------------------------------------*
* Combine rCSI with FCS_4pt for CARI calculation (current consumption)
*------------------------------------------------------------------------------*

recode FCS_4pt (1=2) if rCSI >= 4
label define FCS_4pt_lbl 1 "Acceptable" 2 "Acceptable and rCSI>4" 3 "Borderline" 4 "Poor"
label values FCS_4pt FCS_4pt_lbl

*------------------------------------------------------------------------------*
* Process ECMEN for CARI computation
*------------------------------------------------------------------------------*

* Recode ECMEN.
gen ECMEN_MEB = .
replace ECMEN_MEB = 1 if ECMEN_exclAsst == 1
replace ECMEN_MEB = 2 if ECMEN_exclAsst == 0 & ECMEN_exclAsst_SMEB == 1
replace ECMEN_MEB = 3 if ECMEN_exclAsst == 0 & ECMEN_exclAsst_SMEB == 0

* Recode the `ECMEN_MEB' variable into a 4pt scale for CARI console.
recode ECMEN_MEB (1=1) (2=3) (3=4), generate(ECMEN_class_4pt)
label variable ECMEN_class_4pt "ECMEN 4pt"
label define ECMEN_class_4pt_lbl 1 "Least vulnerable" 3 "Vulnerable" 4 "Highly vulnerable"
label values ECMEN_class_4pt ECMEN_class_4pt_lbl

*------------------------------------------------------------------------------*
* Computation of CARI
*------------------------------------------------------------------------------*

egen Mean_coping_capacity_ECMEN = rowmean(Max_coping_behaviourFS ECMEN_class_4pt)
egen CARI_unrounded_ECMEN = rowmean(FCS_4pt Mean_coping_capacity_ECMEN)
gen CARI_ECMEN = round(CARI_unrounded_ECMEN)
label variable CARI_ECMEN "CARI classification (using ECMEN)"
label define CARI_ECMEN_lbl 1 "Food secure" 2 "Marginally food secure" 3 "Moderately food insecure" 4 "Severely food insecure"
label values CARI_ECMEN CARI_ECMEN_lbl

tabulate CARI_ECMEN

* Create population distribution table to explore how the domains interact within 
* the different food security categories.
table (ECMEN_class_4pt) (FCS_4pt Max_coping_behaviourFS), statistic(percent, across(Max_coping_behaviourFS)) nototal

*------------------------------------------------------------------------------*
* Drop variables that are not needed
*------------------------------------------------------------------------------*

drop ECMEN_MEB Mean_coping_capacity_ECMEN CARI_unrounded_ECMEN

* End of Scripts