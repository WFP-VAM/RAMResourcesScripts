*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*     Consolidated Approach for Reporting Indicators of Food Security (CARI)
*                CALCULATE CARI using FCS, rCSI, LCS and FES
*------------------------------------------------------------------------------*

* Note that there are two ways to calculate CARI - using ECMEN or FES. This syntax 
* file is for calculating CARI using FES. However, please navigate to the script 
* for CARI using ECMEN as relevant. 
* Guidance on CARI can be found here: 
* https://www.wfp.org/publications/consolidated-approach-reporting-indicators-food-security-cari-guidelines.

* Note: this syntax file is based on the assumption that the scripts of the various 
* indicators that compose this version of the CARI (FCS, rCSI, LCS-FS, FES) have 
* already been run. You can find these scripts here: 
* https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Indicators.
* The following variables should have been defined before running this file:
*   FCSCat21 and/or FCSCat28 
*   rCSI
*   Max_coping_behaviourFS	
*   FES
*   Foodexp_4pt.		

*-------------------------------------------------------------------------------*
* Process FCS for CARI computation
*-------------------------------------------------------------------------------*

* Important note: pay attention to the threshold used by your CO when selecting 
* the syntax (FCSCat21 or FCSCat28). In this example, the 21-35 threshold is used.  
    
* Create FCS_4pt for CARI calculation.
RECODE FCSCat21 (1=4) (2=3) (3=1) INTO FCS_4pt. 
VARIABLE LABELS FCS_4pt '4pt FCG'.
VALUE LABELS FCS_4pt 1.00 'Acceptable' 3.00 'Borderline' 4.00 'Poor'. 
EXECUTE.

*-------------------------------------------------------------------------------*
* Combine rCSI with FCS_4pt for CARI calculation (current consumption) 
*-------------------------------------------------------------------------------*

DO IF (rCSI >= 4).
    RECODE FCS_4pt (1=2).
END IF.
EXECUTE.

VALUE LABELS FCS_4pt 1.00 'Acceptable' 2.00 'Acceptable and rCSI>4' 3.00 'Borderline' 4.00 'Poor'. 
EXECUTE.

*-------------------------------------------------------------------------------*
* Computation of CARI
*-------------------------------------------------------------------------------*

COMPUTE Mean_coping_capacity_FES = MEAN(Max_coping_behaviourFS, Foodexp_4pt).  
COMPUTE CARI_unrounded_FES = MEAN(FCS_4pt, Mean_coping_capacity_FES). 
COMPUTE CARI_FES = RND(CARI_unrounded_FES).
VARIABLE LABELS CARI_FES 'CARI classification (using FES)'.
EXECUTE. 

VALUE LABELS CARI_FES 1 'Food secure' 2 'Marginally food secure' 3 'Moderately food insecure' 4 'Severely food insecure'.
EXECUTE.

FREQUENCIES CARI_FES.

* Create population distribution table to explore how the domains interact within 
* the different food security categories.
CTABLES
  /VLABELS VARIABLES=Foodexp_4pt FCS_4pt Max_coping_behaviourFS DISPLAY=LABEL
  /TABLE Foodexp_4pt [C] BY FCS_4pt [C] > Max_coping_behaviourFS [C][ROWPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=Foodexp_4pt ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=FCS_4pt Max_coping_behaviourFS ORDER=A KEY=VALUE EMPTY=INCLUDE.

*-------------------------------------------------------------------------------*
* Drop variables that are not needed
*-------------------------------------------------------------------------------*

DELETE VARIABLES Mean_coping_capacity_FES CARI_unrounded_FES.
EXECUTE.

* End of Scripts