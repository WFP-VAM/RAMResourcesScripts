* Encoding: UTF-8.

*** ----------------------------------------------------------------------------------------------------------------*

***	                 		WFP Standard Scripts
***     Consolidated Approach for Reporting Indicators of Food Security (CARI)
***                 CALCULATE CARI using FCS, rCSI, LCS and ECMEN

*** ----------------------------------------------------------------------------------------------------------------*

*Note that there are two ways to calculate CARI - using ECMEN or FES. This syntax file is for calculating CARI using ECMEN (version excluding assistance). However, please navigate to the script for CARI using FES as relevant. 
* Guidance on CARI can be found here: https://www.wfp.org/publications/consolidated-approach-reporting-indicators-food-security-cari-guidelines.

*Note: this syntax file is based on the assumption that the scripts of the various indicators that compose this version of the CARI (FCS, rCSI, LCS-FS, ECMEN)  have already been run. 
* You can find these scripts here: https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Indicators.
*The following variables should have been defined before running this file:
                FCSCat21 and/or FCSCat28 
                rCSI
                Max_coping_behaviourFS	
                ECMEN_exclAsst 
                ECMEN_exclAsst_SMEB.		

*-------------------------------------------------------------------------------*
* Process FCS for CARI computation
*-------------------------------------------------------------------------------*

* Important note: pay attention to the threshold used by your CO when selecting the syntax (FCSCat21 or FCSCat28). In this example, the 21-35 treshold is used.  
    
 *** Create FCS_4pt for CARI calculation.
Recode FCSCat21 (1=4) (2=3) (3=1) INTO FCS_4pt. 
Variable labels FCS_4pt '4pt FCG'.
Value labels FCS_4pt 1.00 'Acceptable' 3.00 'Borderline' 4.00 'Poor'. 
EXECUTE.

*-------------------------------------------------------------------------------*
* Combine rCSI with FCS_4pt for CARI calculation (current consumption) 
*-------------------------------------------------------------------------------*

Do if (rCSI  >= 4).
Recode FCS_4pt (1=2).
End if.
EXECUTE.

Value labels FCS_4pt 1.00 'Acceptable' 2.00 ' Acceptable and rCSI>4' 3.00 'Borderline' 4.00 'Poor'. 
EXECUTE.

*-------------------------------------------------------------------------------*
* Process ECMEN for CARI computation
*-------------------------------------------------------------------------------*

***Recode ECMEN. 
IF (ECMEN_exclAsst=1) ECMEN_MEB=1. 
IF (ECMEN_exclAsst=0 & ECMEN_exclAsst_SMEB=1) ECMEN_MEB=2. 
IF (ECMEN_exclAsst=0 & ECMEN_exclAsst_SMEB=0) ECMEN_MEB=3.

***Recode the `ECMEN_MEB' variable into a 4pt scale for CARI console.
Recode ECMEN_MEB (1=1) (2=3) (3=4) INTO ECMEN_class_4pt. 
Variable labels ECMEN_class_4pt 'ECMEN 4pt'.
EXECUTE.
 
Value labels ECMEN_class_4pt 1.00 'Least vulnerable' 3.00 'Vulnerable' 4.00 'Highly vulnerable'. 
EXECUTE.	

*-------------------------------------------------------------------------------*
* Computation of CARI
*-------------------------------------------------------------------------------*

Compute Mean_coping_capacity_ECMEN = MEAN (Max_coping_behaviourFS, ECMEN_class_4pt).  
Compute CARI_unrounded_ECMEN = MEAN (FCS_4pt, Mean_coping_capacity_ECMEN). 
Compute CARI_ECMEN = RND (CARI_unrounded_ECMEN).  
Variable labels CARI_ECMEN 'CARI classification (using ECMEN)'.
EXECUTE. 

Value labels CARI_ECMEN 1 'Food secure'   2 'Marginally food secure'   3 'Moderately food insecure'   4 'Severely food insecure'.
EXECUTE.

Frequencies CARI_ECMEN.

***create population distribution table, to to explore how the domains interact within the different food security categories. 
CTABLES
  /VLABELS VARIABLES= ECMEN_class_4pt FCS_4pt Max_coping_behaviourFS DISPLAY=LABEL
  /TABLE ECMEN_class_4pt [C] BY FCS_4pt [C] > Max_coping_behaviourFS [C][ROWPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES= ECMEN_class_4pt ORDER=A KEY=VALUE EMPTY=EXCLUDE
  /CATEGORIES VARIABLES=FCS_4pt Max_coping_behaviourFS ORDER=A KEY=VALUE EMPTY=INCLUDE.

*-------------------------------------------------------------------------------*
* Drop variables that are not needed
*-------------------------------------------------------------------------------*

DELETE VARIABLES ECMEN_MEB Mean_coping_capacity_ECMEN CARI_unrounded_ECMEN.
EXECUTE.
