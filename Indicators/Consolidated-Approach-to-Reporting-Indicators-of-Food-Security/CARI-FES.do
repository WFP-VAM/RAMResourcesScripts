*** ----------------------------------------------------------------------------------------------------------------*

***	                 		WFP Standard Scripts
***     Consolidated Approach for Reporting Indicators of Food Security (CARI)
***                 CALCULATE CARI using FCS, rCSI, LCS and FES

*** ----------------------------------------------------------------------------------------------------------------*
/*
Note that there are two ways to calculate CARI - using ECMEN or FES. This syntax file is for calculating CARI using FES. However, please navigate to the script for CARI using ECMEN as relevant. 
Guidance on CARI can be found here: https://www.wfp.org/publications/consolidated-approach-reporting-indicators-food-security-cari-guidelines.

Note: this syntax file is based on the assumption that the scripts of the various indicators that compose this version of the CARI (FCS, rCSI, LCS-FS, FES)  have already been run. 
You can find these scripts here: https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Indicators.
The following variables should have been defined before running this file:
                FCSCat21 and/or FCSCat28 
                rCSI
                Max_coping_behaviourFS	
                FES
                Foodexp_4pt.		
*/

*-------------------------------------------------------------------------------*
* Process FCS for CARI computation
*-------------------------------------------------------------------------------*

* Create FCS_4pt for CARI calculation.
recode FCSCat21 (1=4) (2=3) (3=1), generate(FCS_4pt)
label variable FCS_4pt "4pt FCG"
label define FCS_4pt 1 "Acceptable" 3 "Borderline" 4 "Poor"
label values FCS_4pt FCS_4pt

*-------------------------------------------------------------------------------*
* Combine rCSI with FCS_4pt for CARI calculation (current consumption) 
*-------------------------------------------------------------------------------*

recode FCS_4pt (1=2) if rCSI >= 4
label define FCS_4pt_lbl 1 "Acceptable" 2 "Acceptable and rCSI>4" 3 "Borderline" 4 "Poor"
label values FCS_4pt FCS_4pt_lbl

*-------------------------------------------------------------------------------*
* Computation of CARI
*-------------------------------------------------------------------------------*

egen Mean_coping_capacity_FES = rowmean(Max_coping_behaviourFS Foodexp_4pt)
egen CARI_unrounded_FES = rowmean(FCS_4pt Mean_coping_capacity_FES)
gen CARI_FES = round(CARI_unrounded_FES)
label variable CARI_FES "CARI classification (using FES)"
label define CARI_FES_lbl 1 "Food secure" 2 "Marginally food secure" 3 "Moderately food insecure" 4 "Severely food insecure"
label values CARI_FES CARI_FES_lbl

tabulate CARI_FES

* Create population distribution table, to explore how the domains interact within the different food security categories 
table (Foodexp_4pt) (FCS_4pt  Max_coping_behaviourFS ), statistic(percent, across(Max_coping_behaviourFS)) nototal

*-------------------------------------------------------------------------------*
* Drop variables that are not needed
*-------------------------------------------------------------------------------*
drop Mean_coping_capacity_FES CARI_unrounded_FES
