* Encoding: UTF-8.
*------------------------------------------------------------------------------#
*	                    WFP Standardized Scripts
*                      Cleaning Expenditures Module
*------------------------------------------------------------------------------#
*Note:
*This script is based on WFP's standard expenditure module in Survey Desginer.
*If you are using a different module or if the module was partially edited 
*(e.g. some expenditure variables added or removed), the List of variables needs to be edited accordingly.
*Important: The script assumes that a single currency is used. 
*If multiple currencies are used, convert to a single currency before running the script.

*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*
*  Preparatory steps
*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*

* The recommended folder structure for this syntax file is:
* Yourfolder
*	Raw
*	Clean
*	Outputs
*		Tables
*			1.Preliminary_Check
*			2.Manual_Stage
*			3.Cleaning_Impact
*	Gtraphs
*			2.Manual_Stage
*			3.Cleaning_Impact

*-------------------------------------------------------------------------------*
* Defining variables needed to run the syntax
*-------------------------------------------------------------------------------*
* Make sure your dataset includes the household size and admin level variables that are needed for this cleaning procedure

*COMPUTE HHSize =  /* Enter here the variable that represents hh hh size in your dataset. Skip if already named HHID.
VARIABLE LABELS HHSize 'Size of the household'.
EXECUTE.

*COMPUTE ADMIN0Name = /* enter here the existing variable name representing the ADMIN0Name level. Skip if already defined.
* Transform admin level variable into numeric if it was string. Otherwise skip.
  AUTORECODE VARIABLES=ADMIN0Name 
  /INTO n_ADMIN0Name
  /GROUP
  /BLANK=MISSING.
EXECUTE.
DELETE VARIABLES ADMIN0Name.
COMPUTE ADMIN0Name = n_ADMIN0Name.
EXECUTE.
DELETE VARIABLES n_ADMIN0Name.
EXECUTE.

*COMPUTE ADMIN1Name = /* enter here the existing variable name representing the ADMIN1Name level. Skip if already defined.
* Transform admin level variable into numeric if it was string. Otherwise skip.
AUTORECODE VARIABLES=ADMIN1Name 
  /INTO n_ADMIN1Name
  /GROUP
  /BLANK=MISSING.
EXECUTE.
DELETE VARIABLES ADMIN1Name.
COMPUTE ADMIN1Name = n_ADMIN1Name.
EXECUTE.
DELETE VARIABLES n_ADMIN1Name.
EXECUTE.

*COMPUTE ADMIN2Name = /* enter here the existing variable name representing the ADMIN2Name level. Skip if already defined.
* Transform admin level variable into numeric if it was string. Otherwise skip.
AUTORECODE VARIABLES=ADMIN2Name 
  /INTO n_ADMIN2Name
  /GROUP
  /BLANK=MISSING.
EXECUTE.
DELETE VARIABLES ADMIN2Name.
COMPUTE ADMIN2Name = n_ADMIN2Name.
EXECUTE.
DELETE VARIABLES n_ADMIN2Name.
EXECUTE.

*COMPUTE ADMIN3Name = /* enter here the existing variable name representing the ADMIN3Name level. Skip if already defined.
* Transform admin level variable into numeric if it was string. Otherwise skip.
AUTORECODE VARIABLES=ADMIN3Name 
  /INTO n_ADMIN3Name
  /GROUP
  /BLANK=MISSING.
EXECUTE.
DELETE VARIABLES ADMIN3Name.
COMPUTE ADMIN3Name = n_ADMIN3Name.
EXECUTE.
DELETE VARIABLES n_ADMIN3Name.
EXECUTE.

*COMPUTE ADMIN4Name = /* enter here the existing variable name representing the ADMIN4Name level. Skip if already defined.
* Transform admin level variable into numeric if it was string. Otherwise skip.
AUTORECODE VARIABLES=ADMIN4Name 
  /INTO n_ADMIN4Name
  /GROUP
  /BLANK=MISSING.
EXECUTE.
DELETE VARIABLES ADMIN4Name.
COMPUTE ADMIN4Name = n_ADMIN4Name.
EXECUTE.
DELETE VARIABLES n_ADMIN4Name.
EXECUTE.

*-------------------------------------------------------------------------------*
* Declare expenditure variables
*-------------------------------------------------------------------------------*

*** Order expenditure variables. The variables expressing the monetary value of consumption expenditure should be ordered in this way to allow commands in the rest of this syntax.
 /* Note: by deafult the variables will be placed at the beginning. However you might specify where they should be placed  specifying. 
 *           "VARX" as the first variable in your dataset and.
 *           "VARY" as the variable after which you want the expenditure variables to be placed.

 ADD FILES FILE *
              /KEEP /* VARX TO VARY*/ HHExpFCer_Purch_MN_7D HHExpFCer_GiftAid_MN_7D HHExpFCer_Own_MN_7D 
            HHExpFTub_Purch_MN_7D HHExpFTub_GiftAid_MN_7D HHExpFTub_Own_MN_7D 
            HHExpFPuls_Purch_MN_7D  HHExpFPuls_GiftAid_MN_7D HHExpFPuls_Own_MN_7D 
            HHExpFVeg_Purch_MN_7D HHExpFVeg_GiftAid_MN_7D HHExpFVeg_Own_MN_7D 
            HHExpFFrt_Purch_MN_7D HHExpFFrt_GiftAid_MN_7D HHExpFFrt_Own_MN_7D 
            HHExpFAnimMeat_Purch_MN_7D HHExpFAnimMeat_GiftAid_MN_7D HHExpFAnimMeat_Own_MN_7D 
            HHExpFAnimFish_Purch_MN_7D HHExpFAnimFish_GiftAid_MN_7D HHExpFAnimFish_Own_MN_7D 
            HHExpFFats_Purch_MN_7D HHExpFFats_GiftAid_MN_7D HHExpFFats_Own_MN_7D 
            HHExpFDairy_Purch_MN_7D HHExpFDairy_GiftAid_MN_7D HHExpFDairy_Own_MN_7D 
            HHExpFEgg_Purch_MN_7D HHExpFEgg_GiftAid_MN_7D HHExpFEgg_Own_MN_7D 
            HHExpFSgr_Purch_MN_7D HHExpFSgr_GiftAid_MN_7D HHExpFSgr_Own_MN_7D 
            HHExpFCond_Purch_MN_7D HHExpFCond_GiftAid_MN_7D HHExpFCond_Own_MN_7D 
            HHExpFBev_Purch_MN_7D HHExpFBev_GiftAid_MN_7D HHExpFBev_Own_MN_7D 
            HHExpFOut_Purch_MN_7D HHExpFOut_GiftAid_MN_7D HHExpFOut_Own_MN_7D
            HHExpNFHyg_Purch_MN_1M HHExpNFHyg_GiftAid_MN_1M 
            HHExpNFTransp_Purch_MN_1M HHExpNFTransp_GiftAid_MN_1M 
            HHExpNFFuel_Purch_MN_1M HHExpNFFuel_GiftAid_MN_1M 
            HHExpNFWat_Purch_MN_1M HHExpNFWat_GiftAid_MN_1M 
            HHExpNFElec_Purch_MN_1M HHExpNFElec_GiftAid_MN_1M 
            HHExpNFEnerg_Purch_MN_1M HHExpNFEnerg_GiftAid_MN_1M 
            HHExpNFDwelSer_Purch_MN_1M HHExpNFDwelSer_GiftAid_MN_1M 
            HHExpNFPhone_Purch_MN_1M HHExpNFPhone_GiftAid_MN_1M 
            HHExpNFRecr_Purch_MN_1M HHExpNFRecr_GiftAid_MN_1M 
            HHExpNFAlcTobac_Purch_MN_1M HHExpNFAlcTobac_GiftAid_MN_1M
            HHExpNFMedServ_Purch_MN_6M HHExpNFMedServ_GiftAid_MN_6M 
            HHExpNFMedGood_Purch_MN_6M HHExpNFMedGood_GiftAid_MN_6M 
            HHExpNFCloth_Purch_MN_6M HHExpNFCloth_GiftAid_MN_6M 
            HHExpNFEduFee_Purch_MN_6M HHExpNFEduFee_GiftAid_MN_6M 
            HHExpNFEduGood_Purch_MN_6M HHExpNFEduGood_GiftAid_MN_6M 
            HHExpNFRent_Purch_MN_6M HHExpNFRent_GiftAid_MN_6M 
            HHExpNFHHSoft_Purch_MN_6M HHExpNFHHSoft_GiftAid_MN_6M 
            HHExpNFHHMaint_Purch_MN_6M HHExpNFHHMaint_GiftAid_MN_6M
           all.
EXECUTE.

*------------------------------------------------------------------------------*
*               Setting zero and negative values to Missing
*------------------------------------------------------------------------------*

*** Set zero values as missing. Using the standard expenditure module, there should not any zero values. However, if a different expenditure module was used, zero values need to be set as missing.
DO REPEAT v = HHExpFCer_Purch_MN_7D TO HHExpNFHHMaint_GiftAid_MN_6M.
IF (v<=0) v=$SYSMIS.
END REPEAT.
EXECUTE.

*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*
*  Preliminary checks regarding the usability of the expenditure data
*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------*
*  Compute aggregates
*------------------------------------------------------------------------------*

*** Food aggregate.
COMPUTE temp_HHExpF_1M  = SUM(HHExpFCer_Purch_MN_7D TO HHExpFOut_Own_MN_7D).
COMPUTE temp_HHExpF_1M  = temp_HHExpF_1M*30/7. /* convert monthly only if recall period is 7D.
EXECUTE.

*** NF aggregate. 
COMPUTE temp_HHExpNF_30D = SUM(HHExpNFHyg_Purch_MN_1M TO HHExpNFAlcTobac_GiftAid_MN_1M). /* 1M recall.
COMPUTE temp_HHExpNF_6M  = SUM(HHExpNFMedServ_Purch_MN_6M TO HHExpNFHHMaint_GiftAid_MN_6M). /* 6M recall.
COMPUTE temp_HHExpNF_6M = temp_HHExpNF_6M/6. /* convert to monthly exp with 6M recall.
COMPUTE temp_HHExpNF_1M = SUM(temp_HHExpNF_30D, temp_HHExpNF_6M). /* total NF.
EXECUTE.
DELETE VARIABLES temp_HHExpNF_30D temp_HHExpNF_6M. /* drop unnecessary variables.
EXECUTE.

*------------------------------------------------------------------------------*
*  Computing share of observtions with zero food or non-food expenditures
*------------------------------------------------------------------------------*

* Define dummy variables based on whether the expenditure is 0 or not.
COMPUTE zero_F = 1.
IF (temp_HHExpF_1M <> 0) zero_F = 0.
VARIABLE LABELS zero_F 'Zero total food expenditures'.

COMPUTE zero_NF = 1.
IF (temp_HHExpNF_1M <> 0) zero_NF = 0.
VARIABLE LABELS zero_NF 'Zero total nonfood expenditures'.

COMPUTE zero_Total = 1.
IF (temp_HHExpF_1M <> 0 OR temp_HHExpNF_1M <> 0) zero_Total = 0.
VARIABLE LABELS zero_Total 'Zero total expenditures'.

VARIABLE LEVEL zero_F zero_NF zero_Total (scale).
EXECUTE.

*** Produce and export tables.
* Admin0.
CTABLES
  /VLABELS VARIABLES=ADMIN0Name zero_F zero_NF zero_Total DISPLAY=LABEL
  /TABLE ADMIN0Name BY zero_F [MEAN] + zero_NF [MEAN] + zero_Total [MEAN]
  /CATEGORIES VARIABLES=ADMIN0Name ORDER=A KEY=LABEL EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
   /TITLES
    TITLE='Share of observations with zero consumption expenditures - Whole sample'.

* Admin1.
CTABLES
  /VLABELS VARIABLES=ADMIN1Name zero_F zero_NF zero_Total DISPLAY=LABEL
  /TABLE ADMIN1Name BY zero_F [MEAN] + zero_NF [MEAN] + zero_Total [MEAN]
  /CATEGORIES VARIABLES=ADMIN1Name ORDER=A KEY=LABEL EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
   /TITLES
    TITLE='Share of observations with zero consumption expenditures - Admin 1'.

* ADMIN2.
CTABLES
  /VLABELS VARIABLES=ADMIN2Name zero_F zero_NF zero_Total DISPLAY=LABEL
  /TABLE ADMIN2Name BY zero_F [MEAN] + zero_NF [MEAN] + zero_Total [MEAN]
  /CATEGORIES VARIABLES=ADMIN2Name ORDER=A KEY=LABEL EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
   /TITLES
    TITLE='Share of observations with zero consumption expenditures - Admin 2'.

* ADMIN3.
CTABLES
  /VLABELS VARIABLES=ADMIN3Name zero_F zero_NF zero_Total DISPLAY=LABEL
  /TABLE ADMIN3Name BY zero_F [MEAN] + zero_NF [MEAN] + zero_Total [MEAN]
  /CATEGORIES VARIABLES=ADMIN3Name ORDER=A KEY=LABEL EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
   /TITLES
    TITLE='Share of observations with zero consumption expenditures - Admin 3'.

* ADMIN4.
CTABLES
  /VLABELS VARIABLES=ADMIN4Name zero_F zero_NF zero_Total DISPLAY=LABEL
  /TABLE ADMIN4Name BY zero_F [MEAN] + zero_NF [MEAN] + zero_Total [MEAN]
  /CATEGORIES VARIABLES=ADMIN4Name ORDER=A KEY=LABEL EMPTY=EXCLUDE
  /CRITERIA CILEVEL=95
   /TITLES
    TITLE='Share of observations with zero consumption expenditures - Admin 4'.

* Saving the tables to your computer.
OUTPUT EXPORT
/PDF DOCUMENTFILE='C:\Users\ali.assi\OneDrive - World Food Programme\Desktop\Py HQ\Standardized_FS_Scripts\Exp\Cleaning\Outputs\Tables\1.Preliminary_Check\Preliminary_check'
/CONTENTS EXPORT= VISIBLE.

*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*
*  Stage 1: cleaning variable by variable, manual
*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*

*** Show bottom/top 5 values and generate a boxplot for each variable.

* Food variables.
EXAMINE VARIABLES=HHExpFCer_Purch_MN_7D HHExpFCer_GiftAid_MN_7D HHExpFCer_Own_MN_7D 
    HHExpFTub_Purch_MN_7D HHExpFTub_GiftAid_MN_7D HHExpFTub_Own_MN_7D HHExpFPuls_Purch_MN_7D 
    HHExpFPuls_GiftAid_MN_7D HHExpFPuls_Own_MN_7D HHExpFVeg_Purch_MN_7D HHExpFVeg_GiftAid_MN_7D 
    HHExpFVeg_Own_MN_7D HHExpFFrt_Purch_MN_7D HHExpFFrt_GiftAid_MN_7D HHExpFFrt_Own_MN_7D 
    HHExpFAnimMeat_Purch_MN_7D HHExpFAnimMeat_GiftAid_MN_7D HHExpFAnimMeat_Own_MN_7D 
    HHExpFAnimFish_Purch_MN_7D HHExpFAnimFish_GiftAid_MN_7D HHExpFAnimFish_Own_MN_7D 
    HHExpFFats_Purch_MN_7D HHExpFFats_GiftAid_MN_7D HHExpFFats_Own_MN_7D HHExpFDairy_Purch_MN_7D 
    HHExpFDairy_GiftAid_MN_7D HHExpFDairy_Own_MN_7D HHExpFEgg_Purch_MN_7D HHExpFEgg_GiftAid_MN_7D 
    HHExpFEgg_Own_MN_7D HHExpFSgr_Purch_MN_7D HHExpFSgr_GiftAid_MN_7D HHExpFSgr_Own_MN_7D 
    HHExpFCond_Purch_MN_7D HHExpFCond_GiftAid_MN_7D HHExpFCond_Own_MN_7D HHExpFBev_Purch_MN_7D 
    HHExpFBev_GiftAid_MN_7D HHExpFBev_Own_MN_7D HHExpFOut_Purch_MN_7D HHExpFOut_GiftAid_MN_7D 
    HHExpFOut_Own_MN_7D 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=EXTREME
  /NOTOTAL
  /MISSING=PAIRWISE.

* NF variables (30 days recall).
EXAMINE VARIABLES=HHExpNFHyg_Purch_MN_1M HHExpNFHyg_GiftAid_MN_1M 
            HHExpNFTransp_Purch_MN_1M HHExpNFTransp_GiftAid_MN_1M 
            HHExpNFFuel_Purch_MN_1M HHExpNFFuel_GiftAid_MN_1M 
            HHExpNFWat_Purch_MN_1M HHExpNFWat_GiftAid_MN_1M 
            HHExpNFElec_Purch_MN_1M HHExpNFElec_GiftAid_MN_1M 
            HHExpNFEnerg_Purch_MN_1M HHExpNFEnerg_GiftAid_MN_1M 
            HHExpNFDwelSer_Purch_MN_1M HHExpNFDwelSer_GiftAid_MN_1M 
            HHExpNFPhone_Purch_MN_1M HHExpNFPhone_GiftAid_MN_1M 
            HHExpNFRecr_Purch_MN_1M HHExpNFRecr_GiftAid_MN_1M 
            HHExpNFAlcTobac_Purch_MN_1M HHExpNFAlcTobac_GiftAid_MN_1M
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=EXTREME
  /NOTOTAL
  /MISSING=PAIRWISE.

* NF variables (6 months recall).
EXAMINE VARIABLES=HHExpNFMedServ_Purch_MN_6M HHExpNFMedServ_GiftAid_MN_6M 
           HHExpNFMedGood_Purch_MN_6M HHExpNFMedGood_GiftAid_MN_6M 
           HHExpNFCloth_Purch_MN_6M HHExpNFCloth_GiftAid_MN_6M 
           HHExpNFEduFee_Purch_MN_6M HHExpNFEduFee_GiftAid_MN_6M 
           HHExpNFEduGood_Purch_MN_6M HHExpNFEduGood_GiftAid_MN_6M 
           HHExpNFRent_Purch_MN_6M HHExpNFRent_GiftAid_MN_6M 
           HHExpNFHHSoft_Purch_MN_6M HHExpNFHHSoft_GiftAid_MN_6M 
           HHExpNFHHMaint_Purch_MN_6M HHExpNFHHMaint_GiftAid_MN_6M 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=EXTREME
  /NOTOTAL
  /MISSING=PAIRWISE.

* Saving the graph to your computer.
OUTPUT EXPORT
/PDF DOCUMENTFILE='C:\Users\ali.assi\OneDrive - World Food Programme\Desktop\Py HQ\Standardized_FS_Scripts\Exp\Cleaning\Outputs\Graphs\2.Manual_Stage\boxplots'
/CONTENTS EXPORT= VISIBLE.

* Drop temporary columns.
DELETE VARIABLES zero_F  TO zero_Total.

*** Based on the outputs generated above, correct values that are obvious mitaskes whose true value can be logically deducted. 
    *Correct them adding syntax here and explaining the corrections
************************************************************************************
* ENTER HERE SYNTAX TO MANUALLY CORRECT DATA ENTRY MISTAKES *
************************************************************************************

*------------------------------------------------------------------------------*
*  Step 1.2: Automatic cleaning
*------------------------------------------------------------------------------*

**** A. Identify outliers.

*** Set negative values as missing.
DO REPEAT v = HHExpFCer_Purch_MN_7D TO HHExpNFHHMaint_GiftAid_MN_6M.
IF (v<0) v=$SYSMIS.
END REPEAT.
EXECUTE.

*** Express all variables into per capita terms.
COMPUTE pc_HHExpFCer_Purch_MN_7D = HHExpFCer_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFCer_GiftAid_MN_7D = HHExpFCer_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFCer_Own_MN_7D = HHExpFCer_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFTub_Purch_MN_7D = HHExpFTub_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFTub_GiftAid_MN_7D = HHExpFTub_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFTub_Own_MN_7D = HHExpFTub_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFPuls_Purch_MN_7D = HHExpFPuls_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFPuls_GiftAid_MN_7D = HHExpFPuls_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFPuls_Own_MN_7D = HHExpFPuls_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFVeg_Purch_MN_7D = HHExpFVeg_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFVeg_GiftAid_MN_7D = HHExpFVeg_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFVeg_Own_MN_7D = HHExpFVeg_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFFrt_Purch_MN_7D = HHExpFFrt_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFFrt_GiftAid_MN_7D = HHExpFFrt_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFFrt_Own_MN_7D = HHExpFFrt_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFAnimMeat_Purch_MN_7D = HHExpFAnimMeat_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFAnimMeat_GiftAid_MN_7D = HHExpFAnimMeat_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFAnimMeat_Own_MN_7D = HHExpFAnimMeat_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFAnimFish_Purch_MN_7D = HHExpFAnimFish_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFAnimFish_GiftAid_MN_7D = HHExpFAnimFish_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFAnimFish_Own_MN_7D = HHExpFAnimFish_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFFats_Purch_MN_7D = HHExpFFats_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFFats_GiftAid_MN_7D = HHExpFFats_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFFats_Own_MN_7D = HHExpFFats_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFDairy_Purch_MN_7D = HHExpFDairy_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFDairy_GiftAid_MN_7D = HHExpFDairy_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFDairy_Own_MN_7D = HHExpFDairy_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFEgg_Purch_MN_7D = HHExpFEgg_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFEgg_GiftAid_MN_7D = HHExpFEgg_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFEgg_Own_MN_7D = HHExpFEgg_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFSgr_Purch_MN_7D = HHExpFSgr_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFSgr_GiftAid_MN_7D = HHExpFSgr_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFSgr_Own_MN_7D = HHExpFSgr_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFCond_Purch_MN_7D = HHExpFCond_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFCond_GiftAid_MN_7D = HHExpFCond_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFCond_Own_MN_7D = HHExpFCond_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFBev_Purch_MN_7D = HHExpFBev_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFBev_GiftAid_MN_7D = HHExpFBev_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFBev_Own_MN_7D = HHExpFBev_Own_MN_7D/HHSize.
COMPUTE pc_HHExpFOut_Purch_MN_7D = HHExpFOut_Purch_MN_7D/HHSize.
COMPUTE pc_HHExpFOut_GiftAid_MN_7D = HHExpFOut_GiftAid_MN_7D/HHSize.
COMPUTE pc_HHExpFOut_Own_MN_7D = HHExpFOut_Own_MN_7D/HHSize.
COMPUTE pc_HHExpNFHyg_Purch_MN_1M = HHExpNFHyg_Purch_MN_1M/HHSize.
COMPUTE pc_HHExpNFHyg_GiftAid_MN_1M = HHExpNFHyg_GiftAid_MN_1M/HHSize.
COMPUTE pc_HHExpNFTransp_Purch_MN_1M = HHExpNFTransp_Purch_MN_1M/HHSize.
COMPUTE pc_HHExpNFTransp_GiftAid_MN_1M = HHExpNFTransp_GiftAid_MN_1M/HHSize.
COMPUTE pc_HHExpNFFuel_Purch_MN_1M = HHExpNFFuel_Purch_MN_1M/HHSize.
COMPUTE pc_HHExpNFFuel_GiftAid_MN_1M = HHExpNFFuel_GiftAid_MN_1M/HHSize.
COMPUTE pc_HHExpNFWat_Purch_MN_1M = HHExpNFWat_Purch_MN_1M/HHSize.
COMPUTE pc_HHExpNFWat_GiftAid_MN_1M = HHExpNFWat_GiftAid_MN_1M/HHSize.
COMPUTE pc_HHExpNFElec_Purch_MN_1M = HHExpNFElec_Purch_MN_1M/HHSize.
COMPUTE pc_HHExpNFElec_GiftAid_MN_1M = HHExpNFElec_GiftAid_MN_1M/HHSize.
COMPUTE pc_HHExpNFEnerg_Purch_MN_1M = HHExpNFEnerg_Purch_MN_1M/HHSize.
COMPUTE pc_HHExpNFEnerg_GiftAid_MN_1M = HHExpNFEnerg_GiftAid_MN_1M/HHSize.
COMPUTE pc_HHExpNFDwelSer_Purch_MN_1M = HHExpNFDwelSer_Purch_MN_1M/HHSize.
COMPUTE pc_HHExpNFDwelSer_GiftAid_MN_1M = HHExpNFDwelSer_GiftAid_MN_1M/HHSize.
COMPUTE pc_HHExpNFPhone_Purch_MN_1M = HHExpNFPhone_Purch_MN_1M/HHSize.
COMPUTE pc_HHExpNFPhone_GiftAid_MN_1M = HHExpNFPhone_GiftAid_MN_1M/HHSize.
COMPUTE pc_HHExpNFRecr_Purch_MN_1M = HHExpNFRecr_Purch_MN_1M/HHSize.
COMPUTE pc_HHExpNFRecr_GiftAid_MN_1M = HHExpNFRecr_GiftAid_MN_1M/HHSize.
COMPUTE pc_HHExpNFAlcTobac_Purch_MN_1M = HHExpNFAlcTobac_Purch_MN_1M/HHSize.
COMPUTE pc_HHExpNFAlcTobac_GiftAid_MN_1M = HHExpNFAlcTobac_GiftAid_MN_1M/HHSize.
COMPUTE pc_HHExpNFMedServ_Purch_MN_6M = HHExpNFMedServ_Purch_MN_6M/HHSize.
COMPUTE pc_HHExpNFMedServ_GiftAid_MN_6M = HHExpNFMedServ_GiftAid_MN_6M/HHSize.
COMPUTE pc_HHExpNFMedGood_Purch_MN_6M = HHExpNFMedGood_Purch_MN_6M/HHSize.
COMPUTE pc_HHExpNFMedGood_GiftAid_MN_6M = HHExpNFMedGood_GiftAid_MN_6M/HHSize.
COMPUTE pc_HHExpNFCloth_Purch_MN_6M = HHExpNFCloth_Purch_MN_6M/HHSize.
COMPUTE pc_HHExpNFCloth_GiftAid_MN_6M = HHExpNFCloth_GiftAid_MN_6M/HHSize.
COMPUTE pc_HHExpNFEduFee_Purch_MN_6M = HHExpNFEduFee_Purch_MN_6M/HHSize.
COMPUTE pc_HHExpNFEduFee_GiftAid_MN_6M = HHExpNFEduFee_GiftAid_MN_6M/HHSize.
COMPUTE pc_HHExpNFEduGood_Purch_MN_6M = HHExpNFEduGood_Purch_MN_6M/HHSize.
COMPUTE pc_HHExpNFEduGood_GiftAid_MN_6M = HHExpNFEduGood_GiftAid_MN_6M/HHSize.
COMPUTE pc_HHExpNFRent_Purch_MN_6M = HHExpNFRent_Purch_MN_6M/HHSize.
COMPUTE pc_HHExpNFRent_GiftAid_MN_6M = HHExpNFRent_GiftAid_MN_6M/HHSize.
COMPUTE pc_HHExpNFHHSoft_Purch_MN_6M = HHExpNFHHSoft_Purch_MN_6M/HHSize.
COMPUTE pc_HHExpNFHHSoft_GiftAid_MN_6M = HHExpNFHHSoft_GiftAid_MN_6M/HHSize.
COMPUTE pc_HHExpNFHHMaint_Purch_MN_6M = HHExpNFHHMaint_Purch_MN_6M/HHSize.
COMPUTE pc_HHExpNFHHMaint_GiftAid_MN_6M = HHExpNFHHMaint_GiftAid_MN_6M/HHSize.
EXECUTE.

*** Transform all variables to approximate normality using inverse hyperbolic sine transformation.
COMPUTE tpcHHExpFCer_Purch_MN_7D =LN(pc_HHExpFCer_Purch_MN_7D+ sqrt(pc_HHExpFCer_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFCer_GiftAid_MN_7D =LN(pc_HHExpFCer_GiftAid_MN_7D+ sqrt(pc_HHExpFCer_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFCer_Own_MN_7D =LN(pc_HHExpFCer_Own_MN_7D+ sqrt(pc_HHExpFCer_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFTub_Purch_MN_7D =LN(pc_HHExpFTub_Purch_MN_7D+ sqrt(pc_HHExpFTub_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFTub_GiftAid_MN_7D =LN(pc_HHExpFTub_GiftAid_MN_7D+ sqrt(pc_HHExpFTub_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFTub_Own_MN_7D =LN(pc_HHExpFTub_Own_MN_7D+ sqrt(pc_HHExpFTub_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFPuls_Purch_MN_7D =LN(pc_HHExpFPuls_Purch_MN_7D+ sqrt(pc_HHExpFPuls_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFPuls_GiftAid_MN_7D =LN(pc_HHExpFPuls_GiftAid_MN_7D+ sqrt(pc_HHExpFPuls_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFPuls_Own_MN_7D =LN(pc_HHExpFPuls_Own_MN_7D+ sqrt(pc_HHExpFPuls_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFVeg_Purch_MN_7D =LN(pc_HHExpFVeg_Purch_MN_7D+ sqrt(pc_HHExpFVeg_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFVeg_GiftAid_MN_7D =LN(pc_HHExpFVeg_GiftAid_MN_7D+ sqrt(pc_HHExpFVeg_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFVeg_Own_MN_7D =LN(pc_HHExpFVeg_Own_MN_7D+ sqrt(pc_HHExpFVeg_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFFrt_Purch_MN_7D =LN(pc_HHExpFFrt_Purch_MN_7D+ sqrt(pc_HHExpFFrt_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFFrt_GiftAid_MN_7D =LN(pc_HHExpFFrt_GiftAid_MN_7D+ sqrt(pc_HHExpFFrt_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFFrt_Own_MN_7D =LN(pc_HHExpFFrt_Own_MN_7D+ sqrt(pc_HHExpFFrt_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFAnimMeat_Purch_MN_7D =LN(pc_HHExpFAnimMeat_Purch_MN_7D+ sqrt(pc_HHExpFAnimMeat_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFAnimMeat_GiftAid_MN_7D =LN(pc_HHExpFAnimMeat_GiftAid_MN_7D+ sqrt(pc_HHExpFAnimMeat_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFAnimMeat_Own_MN_7D =LN(pc_HHExpFAnimMeat_Own_MN_7D+ sqrt(pc_HHExpFAnimMeat_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFAnimFish_Purch_MN_7D =LN(pc_HHExpFAnimFish_Purch_MN_7D+ sqrt(pc_HHExpFAnimFish_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFAnimFish_GiftAid_MN_7D =LN(pc_HHExpFAnimFish_GiftAid_MN_7D+ sqrt(pc_HHExpFAnimFish_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFAnimFish_Own_MN_7D =LN(pc_HHExpFAnimFish_Own_MN_7D+ sqrt(pc_HHExpFAnimFish_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFFats_Purch_MN_7D =LN(pc_HHExpFFats_Purch_MN_7D+ sqrt(pc_HHExpFFats_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFFats_GiftAid_MN_7D =LN(pc_HHExpFFats_GiftAid_MN_7D+ sqrt(pc_HHExpFFats_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFFats_Own_MN_7D =LN(pc_HHExpFFats_Own_MN_7D+ sqrt(pc_HHExpFFats_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFDairy_Purch_MN_7D =LN(pc_HHExpFDairy_Purch_MN_7D+ sqrt(pc_HHExpFDairy_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFDairy_GiftAid_MN_7D =LN(pc_HHExpFDairy_GiftAid_MN_7D+ sqrt(pc_HHExpFDairy_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFDairy_Own_MN_7D =LN(pc_HHExpFDairy_Own_MN_7D+ sqrt(pc_HHExpFDairy_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFEgg_Purch_MN_7D =LN(pc_HHExpFEgg_Purch_MN_7D+ sqrt(pc_HHExpFEgg_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFEgg_GiftAid_MN_7D =LN(pc_HHExpFEgg_GiftAid_MN_7D+ sqrt(pc_HHExpFEgg_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFEgg_Own_MN_7D =LN(pc_HHExpFEgg_Own_MN_7D+ sqrt(pc_HHExpFEgg_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFSgr_Purch_MN_7D =LN(pc_HHExpFSgr_Purch_MN_7D+ sqrt(pc_HHExpFSgr_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFSgr_GiftAid_MN_7D =LN(pc_HHExpFSgr_GiftAid_MN_7D+ sqrt(pc_HHExpFSgr_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFSgr_Own_MN_7D =LN(pc_HHExpFSgr_Own_MN_7D+ sqrt(pc_HHExpFSgr_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFCond_Purch_MN_7D =LN(pc_HHExpFCond_Purch_MN_7D+ sqrt(pc_HHExpFCond_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFCond_GiftAid_MN_7D =LN(pc_HHExpFCond_GiftAid_MN_7D+ sqrt(pc_HHExpFCond_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFCond_Own_MN_7D =LN(pc_HHExpFCond_Own_MN_7D+ sqrt(pc_HHExpFCond_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFBev_Purch_MN_7D =LN(pc_HHExpFBev_Purch_MN_7D+ sqrt(pc_HHExpFBev_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFBev_GiftAid_MN_7D =LN(pc_HHExpFBev_GiftAid_MN_7D+ sqrt(pc_HHExpFBev_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFBev_Own_MN_7D =LN(pc_HHExpFBev_Own_MN_7D+ sqrt(pc_HHExpFBev_Own_MN_7D**2+1)).
COMPUTE tpcHHExpFOut_Purch_MN_7D =LN(pc_HHExpFOut_Purch_MN_7D+ sqrt(pc_HHExpFOut_Purch_MN_7D**2+1)).
COMPUTE tpcHHExpFOut_GiftAid_MN_7D =LN(pc_HHExpFOut_GiftAid_MN_7D+ sqrt(pc_HHExpFOut_GiftAid_MN_7D**2+1)).
COMPUTE tpcHHExpFOut_Own_MN_7D =LN(pc_HHExpFOut_Own_MN_7D+ sqrt(pc_HHExpFOut_Own_MN_7D**2+1)).
COMPUTE tpcHHExpNFHyg_Purch_MN_1M =LN(pc_HHExpNFHyg_Purch_MN_1M+ sqrt(pc_HHExpNFHyg_Purch_MN_1M**2+1)).
COMPUTE tpcHHExpNFHyg_GiftAid_MN_1M =LN(pc_HHExpNFHyg_GiftAid_MN_1M+ sqrt(pc_HHExpNFHyg_GiftAid_MN_1M**2+1)).
COMPUTE tpcHHExpNFTransp_Purch_MN_1M =LN(pc_HHExpNFTransp_Purch_MN_1M+ sqrt(pc_HHExpNFTransp_Purch_MN_1M**2+1)).
COMPUTE tpcHHExpNFTransp_GiftAid_MN_1M =LN(pc_HHExpNFTransp_GiftAid_MN_1M+ sqrt(pc_HHExpNFTransp_GiftAid_MN_1M**2+1)).
COMPUTE tpcHHExpNFFuel_Purch_MN_1M =LN(pc_HHExpNFFuel_Purch_MN_1M+ sqrt(pc_HHExpNFFuel_Purch_MN_1M**2+1)).
COMPUTE tpcHHExpNFFuel_GiftAid_MN_1M =LN(pc_HHExpNFFuel_GiftAid_MN_1M+ sqrt(pc_HHExpNFFuel_GiftAid_MN_1M**2+1)).
COMPUTE tpcHHExpNFWat_Purch_MN_1M =LN(pc_HHExpNFWat_Purch_MN_1M+ sqrt(pc_HHExpNFWat_Purch_MN_1M**2+1)).
COMPUTE tpcHHExpNFWat_GiftAid_MN_1M =LN(pc_HHExpNFWat_GiftAid_MN_1M+ sqrt(pc_HHExpNFWat_GiftAid_MN_1M**2+1)).
COMPUTE tpcHHExpNFElec_Purch_MN_1M =LN(pc_HHExpNFElec_Purch_MN_1M+ sqrt(pc_HHExpNFElec_Purch_MN_1M**2+1)).
COMPUTE tpcHHExpNFElec_GiftAid_MN_1M =LN(pc_HHExpNFElec_GiftAid_MN_1M+ sqrt(pc_HHExpNFElec_GiftAid_MN_1M**2+1)).
COMPUTE tpcHHExpNFEnerg_Purch_MN_1M =LN(pc_HHExpNFEnerg_Purch_MN_1M+ sqrt(pc_HHExpNFEnerg_Purch_MN_1M**2+1)).
COMPUTE tpcHHExpNFEnerg_GiftAid_MN_1M =LN(pc_HHExpNFEnerg_GiftAid_MN_1M+ sqrt(pc_HHExpNFEnerg_GiftAid_MN_1M**2+1)).
COMPUTE tpcHHExpNFDwelSer_Purch_MN_1M =LN(pc_HHExpNFDwelSer_Purch_MN_1M+ sqrt(pc_HHExpNFDwelSer_Purch_MN_1M**2+1)).
COMPUTE tpcHHExpNFDwelSer_GiftAid_MN_1M =LN(pc_HHExpNFDwelSer_GiftAid_MN_1M+ sqrt(pc_HHExpNFDwelSer_GiftAid_MN_1M**2+1)).
COMPUTE tpcHHExpNFPhone_Purch_MN_1M =LN(pc_HHExpNFPhone_Purch_MN_1M+ sqrt(pc_HHExpNFPhone_Purch_MN_1M**2+1)).
COMPUTE tpcHHExpNFPhone_GiftAid_MN_1M =LN(pc_HHExpNFPhone_GiftAid_MN_1M+ sqrt(pc_HHExpNFPhone_GiftAid_MN_1M**2+1)).
COMPUTE tpcHHExpNFRecr_Purch_MN_1M =LN(pc_HHExpNFRecr_Purch_MN_1M+ sqrt(pc_HHExpNFRecr_Purch_MN_1M**2+1)).
COMPUTE tpcHHExpNFRecr_GiftAid_MN_1M =LN(pc_HHExpNFRecr_GiftAid_MN_1M+ sqrt(pc_HHExpNFRecr_GiftAid_MN_1M**2+1)).
COMPUTE tpcHHExpNFAlcTobac_Purch_MN_1M =LN(pc_HHExpNFAlcTobac_Purch_MN_1M+ sqrt(pc_HHExpNFAlcTobac_Purch_MN_1M**2+1)).
COMPUTE tpcHHExpNFAlcTobac_GiftAid_MN_1M =LN(pc_HHExpNFAlcTobac_GiftAid_MN_1M+ sqrt(pc_HHExpNFAlcTobac_GiftAid_MN_1M**2+1)).
COMPUTE tpcHHExpNFMedServ_Purch_MN_6M =LN(pc_HHExpNFMedServ_Purch_MN_6M+ sqrt(pc_HHExpNFMedServ_Purch_MN_6M**2+1)).
COMPUTE tpcHHExpNFMedServ_GiftAid_MN_6M =LN(pc_HHExpNFMedServ_GiftAid_MN_6M+ sqrt(pc_HHExpNFMedServ_GiftAid_MN_6M**2+1)).
COMPUTE tpcHHExpNFMedGood_Purch_MN_6M =LN(pc_HHExpNFMedGood_Purch_MN_6M+ sqrt(pc_HHExpNFMedGood_Purch_MN_6M**2+1)).
COMPUTE tpcHHExpNFMedGood_GiftAid_MN_6M =LN(pc_HHExpNFMedGood_GiftAid_MN_6M+ sqrt(pc_HHExpNFMedGood_GiftAid_MN_6M**2+1)).
COMPUTE tpcHHExpNFCloth_Purch_MN_6M =LN(pc_HHExpNFCloth_Purch_MN_6M+ sqrt(pc_HHExpNFCloth_Purch_MN_6M**2+1)).
COMPUTE tpcHHExpNFCloth_GiftAid_MN_6M =LN(pc_HHExpNFCloth_GiftAid_MN_6M+ sqrt(pc_HHExpNFCloth_GiftAid_MN_6M**2+1)).
COMPUTE tpcHHExpNFEduFee_Purch_MN_6M =LN(pc_HHExpNFEduFee_Purch_MN_6M+ sqrt(pc_HHExpNFEduFee_Purch_MN_6M**2+1)).
COMPUTE tpcHHExpNFEduFee_GiftAid_MN_6M =LN(pc_HHExpNFEduFee_GiftAid_MN_6M+ sqrt(pc_HHExpNFEduFee_GiftAid_MN_6M**2+1)).
COMPUTE tpcHHExpNFEduGood_Purch_MN_6M =LN(pc_HHExpNFEduGood_Purch_MN_6M+ sqrt(pc_HHExpNFEduGood_Purch_MN_6M**2+1)).
COMPUTE tpcHHExpNFEduGood_GiftAid_MN_6M =LN(pc_HHExpNFEduGood_GiftAid_MN_6M+ sqrt(pc_HHExpNFEduGood_GiftAid_MN_6M**2+1)).
COMPUTE tpcHHExpNFRent_Purch_MN_6M =LN(pc_HHExpNFRent_Purch_MN_6M+ sqrt(pc_HHExpNFRent_Purch_MN_6M**2+1)).
COMPUTE tpcHHExpNFRent_GiftAid_MN_6M =LN(pc_HHExpNFRent_GiftAid_MN_6M+ sqrt(pc_HHExpNFRent_GiftAid_MN_6M**2+1)).
COMPUTE tpcHHExpNFHHSoft_Purch_MN_6M =LN(pc_HHExpNFHHSoft_Purch_MN_6M+ sqrt(pc_HHExpNFHHSoft_Purch_MN_6M**2+1)).
COMPUTE tpcHHExpNFHHSoft_GiftAid_MN_6M =LN(pc_HHExpNFHHSoft_GiftAid_MN_6M+ sqrt(pc_HHExpNFHHSoft_GiftAid_MN_6M**2+1)).
COMPUTE tpcHHExpNFHHMaint_Purch_MN_6M =LN(pc_HHExpNFHHMaint_Purch_MN_6M+ sqrt(pc_HHExpNFHHMaint_Purch_MN_6M**2+1)).
COMPUTE tpcHHExpNFHHMaint_GiftAid_MN_6M =LN(pc_HHExpNFHHMaint_GiftAid_MN_6M+ sqrt(pc_HHExpNFHHMaint_GiftAid_MN_6M**2+1)).
EXE.

*** Standardize the transformed variable using median and minimum absolute deviation (MAD).
    
** Calculate the median of each variable.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=
  /tpcHHExpFCer_Purch_MN_7D_median=MEDIAN(tpcHHExpFCer_Purch_MN_7D) 
  /tpcHHExpFCer_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFCer_GiftAid_MN_7D) 
  /tpcHHExpFCer_Own_MN_7D_median=MEDIAN(tpcHHExpFCer_Own_MN_7D) 
  /tpcHHExpFTub_Purch_MN_7D_median=MEDIAN(tpcHHExpFTub_Purch_MN_7D) 
  /tpcHHExpFTub_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFTub_GiftAid_MN_7D) 
  /tpcHHExpFTub_Own_MN_7D_median=MEDIAN(tpcHHExpFTub_Own_MN_7D) 
  /tpcHHExpFPuls_Purch_MN_7D_median=MEDIAN(tpcHHExpFPuls_Purch_MN_7D) 
  /tpcHHExpFPuls_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFPuls_GiftAid_MN_7D) 
  /tpcHHExpFPuls_Own_MN_7D_median=MEDIAN(tpcHHExpFPuls_Own_MN_7D) 
  /tpcHHExpFVeg_Purch_MN_7D_median=MEDIAN(tpcHHExpFVeg_Purch_MN_7D) 
  /tpcHHExpFVeg_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFVeg_GiftAid_MN_7D) 
  /tpcHHExpFVeg_Own_MN_7D_median=MEDIAN(tpcHHExpFVeg_Own_MN_7D) 
  /tpcHHExpFFrt_Purch_MN_7D_median=MEDIAN(tpcHHExpFFrt_Purch_MN_7D) 
  /tpcHHExpFFrt_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFFrt_GiftAid_MN_7D) 
  /tpcHHExpFFrt_Own_MN_7D_median=MEDIAN(tpcHHExpFFrt_Own_MN_7D) 
  /tpcHHExpFAnimMeat_Purch_MN_7D_median=MEDIAN(tpcHHExpFAnimMeat_Purch_MN_7D) 
  /tpcHHExpFAnimMeat_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFAnimMeat_GiftAid_MN_7D) 
  /tpcHHExpFAnimMeat_Own_MN_7D_median=MEDIAN(tpcHHExpFAnimMeat_Own_MN_7D) 
  /tpcHHExpFAnimFish_Purch_MN_7D_median=MEDIAN(tpcHHExpFAnimFish_Purch_MN_7D) 
  /tpcHHExpFAnimFish_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFAnimFish_GiftAid_MN_7D) 
  /tpcHHExpFAnimFish_Own_MN_7D_median=MEDIAN(tpcHHExpFAnimFish_Own_MN_7D) 
  /tpcHHExpFFats_Purch_MN_7D_median=MEDIAN(tpcHHExpFFats_Purch_MN_7D) 
  /tpcHHExpFFats_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFFats_GiftAid_MN_7D) 
  /tpcHHExpFFats_Own_MN_7D_median=MEDIAN(tpcHHExpFFats_Own_MN_7D) 
  /tpcHHExpFDairy_Purch_MN_7D_median=MEDIAN(tpcHHExpFDairy_Purch_MN_7D) 
  /tpcHHExpFDairy_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFDairy_GiftAid_MN_7D) 
  /tpcHHExpFDairy_Own_MN_7D_median=MEDIAN(tpcHHExpFDairy_Own_MN_7D) 
  /tpcHHExpFEgg_Purch_MN_7D_median=MEDIAN(tpcHHExpFEgg_Purch_MN_7D) 
  /tpcHHExpFEgg_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFEgg_GiftAid_MN_7D) 
  /tpcHHExpFEgg_Own_MN_7D_median=MEDIAN(tpcHHExpFEgg_Own_MN_7D) 
  /tpcHHExpFSgr_Purch_MN_7D_median=MEDIAN(tpcHHExpFSgr_Purch_MN_7D) 
  /tpcHHExpFSgr_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFSgr_GiftAid_MN_7D) 
  /tpcHHExpFSgr_Own_MN_7D_median=MEDIAN(tpcHHExpFSgr_Own_MN_7D) 
  /tpcHHExpFCond_Purch_MN_7D_median=MEDIAN(tpcHHExpFCond_Purch_MN_7D) 
  /tpcHHExpFCond_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFCond_GiftAid_MN_7D) 
  /tpcHHExpFCond_Own_MN_7D_median=MEDIAN(tpcHHExpFCond_Own_MN_7D) 
  /tpcHHExpFBev_Purch_MN_7D_median=MEDIAN(tpcHHExpFBev_Purch_MN_7D) 
  /tpcHHExpFBev_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFBev_GiftAid_MN_7D) 
  /tpcHHExpFBev_Own_MN_7D_median=MEDIAN(tpcHHExpFBev_Own_MN_7D) 
  /tpcHHExpFOut_Purch_MN_7D_median=MEDIAN(tpcHHExpFOut_Purch_MN_7D) 
  /tpcHHExpFOut_GiftAid_MN_7D_median=MEDIAN(tpcHHExpFOut_GiftAid_MN_7D) 
  /tpcHHExpFOut_Own_MN_7D_median=MEDIAN(tpcHHExpFOut_Own_MN_7D) 
  /tpcHHExpNFHyg_Purch_MN_1M_median=MEDIAN(tpcHHExpNFHyg_Purch_MN_1M) 
  /tpcHHExpNFHyg_GiftAid_MN_1M_median=MEDIAN(tpcHHExpNFHyg_GiftAid_MN_1M) 
  /tpcHHExpNFTransp_Purch_MN_1M_median=MEDIAN(tpcHHExpNFTransp_Purch_MN_1M) 
  /tpcHHExpNFTransp_GiftAid_MN_1M_median=MEDIAN(tpcHHExpNFTransp_GiftAid_MN_1M) 
  /tpcHHExpNFFuel_Purch_MN_1M_median=MEDIAN(tpcHHExpNFFuel_Purch_MN_1M) 
  /tpcHHExpNFFuel_GiftAid_MN_1M_median=MEDIAN(tpcHHExpNFFuel_GiftAid_MN_1M) 
  /tpcHHExpNFWat_Purch_MN_1M_median=MEDIAN(tpcHHExpNFWat_Purch_MN_1M) 
  /tpcHHExpNFWat_GiftAid_MN_1M_median=MEDIAN(tpcHHExpNFWat_GiftAid_MN_1M) 
  /tpcHHExpNFElec_Purch_MN_1M_median=MEDIAN(tpcHHExpNFElec_Purch_MN_1M) 
  /tpcHHExpNFElec_GiftAid_MN_1M_median=MEDIAN(tpcHHExpNFElec_GiftAid_MN_1M) 
  /tpcHHExpNFEnerg_Purch_MN_1M_median=MEDIAN(tpcHHExpNFEnerg_Purch_MN_1M) 
  /tpcHHExpNFEnerg_GiftAid_MN_1M_median=MEDIAN(tpcHHExpNFEnerg_GiftAid_MN_1M) 
  /tpcHHExpNFDwelSer_Purch_MN_1M_median=MEDIAN(tpcHHExpNFDwelSer_Purch_MN_1M) 
  /tpcHHExpNFDwelSer_GiftAid_MN_1M_median=MEDIAN(tpcHHExpNFDwelSer_GiftAid_MN_1M) 
  /tpcHHExpNFPhone_Purch_MN_1M_median=MEDIAN(tpcHHExpNFPhone_Purch_MN_1M) 
  /tpcHHExpNFPhone_GiftAid_MN_1M_median=MEDIAN(tpcHHExpNFPhone_GiftAid_MN_1M) 
  /tpcHHExpNFRecr_Purch_MN_1M_median=MEDIAN(tpcHHExpNFRecr_Purch_MN_1M) 
  /tpcHHExpNFRecr_GiftAid_MN_1M_median=MEDIAN(tpcHHExpNFRecr_GiftAid_MN_1M) 
  /tpcHHExpNFAlcTobac_Purch_MN_1M_median=MEDIAN(tpcHHExpNFAlcTobac_Purch_MN_1M) 
  /tpcHHExpNFAlcTobac_GiftAid_MN_1M_median=MEDIAN(tpcHHExpNFAlcTobac_GiftAid_MN_1M) 
  /tpcHHExpNFMedServ_Purch_MN_6M_median=MEDIAN(tpcHHExpNFMedServ_Purch_MN_6M) 
  /tpcHHExpNFMedServ_GiftAid_MN_6M_median=MEDIAN(tpcHHExpNFMedServ_GiftAid_MN_6M) 
  /tpcHHExpNFMedGood_Purch_MN_6M_median=MEDIAN(tpcHHExpNFMedGood_Purch_MN_6M) 
  /tpcHHExpNFMedGood_GiftAid_MN_6M_median=MEDIAN(tpcHHExpNFMedGood_GiftAid_MN_6M) 
  /tpcHHExpNFCloth_Purch_MN_6M_median=MEDIAN(tpcHHExpNFCloth_Purch_MN_6M) 
  /tpcHHExpNFCloth_GiftAid_MN_6M_median=MEDIAN(tpcHHExpNFCloth_GiftAid_MN_6M) 
  /tpcHHExpNFEduFee_Purch_MN_6M_median=MEDIAN(tpcHHExpNFEduFee_Purch_MN_6M) 
  /tpcHHExpNFEduFee_GiftAid_MN_6M_median=MEDIAN(tpcHHExpNFEduFee_GiftAid_MN_6M) 
  /tpcHHExpNFEduGood_Purch_MN_6M_median=MEDIAN(tpcHHExpNFEduGood_Purch_MN_6M) 
  /tpcHHExpNFEduGood_GiftAid_MN_6M_median=MEDIAN(tpcHHExpNFEduGood_GiftAid_MN_6M) 
  /tpcHHExpNFRent_Purch_MN_6M_median=MEDIAN(tpcHHExpNFRent_Purch_MN_6M) 
  /tpcHHExpNFRent_GiftAid_MN_6M_median=MEDIAN(tpcHHExpNFRent_GiftAid_MN_6M) 
  /tpcHHExpNFHHSoft_Purch_MN_6M_median=MEDIAN(tpcHHExpNFHHSoft_Purch_MN_6M) 
  /tpcHHExpNFHHSoft_GiftAid_MN_6M_median=MEDIAN(tpcHHExpNFHHSoft_GiftAid_MN_6M) 
  /tpcHHExpNFHHMaint_Purch_MN_6M_median=MEDIAN(tpcHHExpNFHHMaint_Purch_MN_6M) 
  /tpcHHExpNFHHMaint_GiftAid_MN_6M_median=MEDIAN(tpcHHExpNFHHMaint_GiftAid_MN_6M).
EXE.

* Absolute value of diff between var and median for each observations.
COMPUTE dHHExpFCer_Purch_MN_7D = ABS(tpcHHExpFCer_Purch_MN_7D - tpcHHExpFCer_Purch_MN_7D_median).
COMPUTE dHHExpFCer_GiftAid_MN_7D = ABS(tpcHHExpFCer_GiftAid_MN_7D - tpcHHExpFCer_GiftAid_MN_7D_median).
COMPUTE dHHExpFCer_Own_MN_7D = ABS(tpcHHExpFCer_Own_MN_7D - tpcHHExpFCer_Own_MN_7D_median).
COMPUTE dHHExpFTub_Purch_MN_7D = ABS(tpcHHExpFTub_Purch_MN_7D - tpcHHExpFTub_Purch_MN_7D_median).
COMPUTE dHHExpFTub_GiftAid_MN_7D = ABS(tpcHHExpFTub_GiftAid_MN_7D - tpcHHExpFTub_GiftAid_MN_7D_median).
COMPUTE dHHExpFTub_Own_MN_7D = ABS(tpcHHExpFTub_Own_MN_7D - tpcHHExpFTub_Own_MN_7D_median).
COMPUTE dHHExpFPuls_Purch_MN_7D = ABS(tpcHHExpFPuls_Purch_MN_7D - tpcHHExpFPuls_Purch_MN_7D_median).
COMPUTE dHHExpFPuls_GiftAid_MN_7D = ABS(tpcHHExpFPuls_GiftAid_MN_7D - tpcHHExpFPuls_GiftAid_MN_7D_median).
COMPUTE dHHExpFPuls_Own_MN_7D = ABS(tpcHHExpFPuls_Own_MN_7D - tpcHHExpFPuls_Own_MN_7D_median).
COMPUTE dHHExpFVeg_Purch_MN_7D = ABS(tpcHHExpFVeg_Purch_MN_7D - tpcHHExpFVeg_Purch_MN_7D_median).
COMPUTE dHHExpFVeg_GiftAid_MN_7D = ABS(tpcHHExpFVeg_GiftAid_MN_7D - tpcHHExpFVeg_GiftAid_MN_7D_median).
COMPUTE dHHExpFVeg_Own_MN_7D = ABS(tpcHHExpFVeg_Own_MN_7D - tpcHHExpFVeg_Own_MN_7D_median).
COMPUTE dHHExpFFrt_Purch_MN_7D = ABS(tpcHHExpFFrt_Purch_MN_7D - tpcHHExpFFrt_Purch_MN_7D_median).
COMPUTE dHHExpFFrt_GiftAid_MN_7D = ABS(tpcHHExpFFrt_GiftAid_MN_7D - tpcHHExpFFrt_GiftAid_MN_7D_median).
COMPUTE dHHExpFFrt_Own_MN_7D = ABS(tpcHHExpFFrt_Own_MN_7D - tpcHHExpFFrt_Own_MN_7D_median).
COMPUTE dHHExpFAnimMeat_Purch_MN_7D = ABS(tpcHHExpFAnimMeat_Purch_MN_7D - tpcHHExpFAnimMeat_Purch_MN_7D_median).
COMPUTE dHHExpFAnimMeat_GiftAid_MN_7D = ABS(tpcHHExpFAnimMeat_GiftAid_MN_7D - tpcHHExpFAnimMeat_GiftAid_MN_7D_median).
COMPUTE dHHExpFAnimMeat_Own_MN_7D = ABS(tpcHHExpFAnimMeat_Own_MN_7D - tpcHHExpFAnimMeat_Own_MN_7D_median).
COMPUTE dHHExpFAnimFish_Purch_MN_7D = ABS(tpcHHExpFAnimFish_Purch_MN_7D - tpcHHExpFAnimFish_Purch_MN_7D_median).
COMPUTE dHHExpFAnimFish_GiftAid_MN_7D = ABS(tpcHHExpFAnimFish_GiftAid_MN_7D - tpcHHExpFAnimFish_GiftAid_MN_7D_median).
COMPUTE dHHExpFAnimFish_Own_MN_7D = ABS(tpcHHExpFAnimFish_Own_MN_7D - tpcHHExpFAnimFish_Own_MN_7D_median).
COMPUTE dHHExpFFats_Purch_MN_7D = ABS(tpcHHExpFFats_Purch_MN_7D - tpcHHExpFFats_Purch_MN_7D_median).
COMPUTE dHHExpFFats_GiftAid_MN_7D = ABS(tpcHHExpFFats_GiftAid_MN_7D - tpcHHExpFFats_GiftAid_MN_7D_median).
COMPUTE dHHExpFFats_Own_MN_7D = ABS(tpcHHExpFFats_Own_MN_7D - tpcHHExpFFats_Own_MN_7D_median).
COMPUTE dHHExpFDairy_Purch_MN_7D = ABS(tpcHHExpFDairy_Purch_MN_7D - tpcHHExpFDairy_Purch_MN_7D_median).
COMPUTE dHHExpFDairy_GiftAid_MN_7D = ABS(tpcHHExpFDairy_GiftAid_MN_7D - tpcHHExpFDairy_GiftAid_MN_7D_median).
COMPUTE dHHExpFDairy_Own_MN_7D = ABS(tpcHHExpFDairy_Own_MN_7D - tpcHHExpFDairy_Own_MN_7D_median).
COMPUTE dHHExpFEgg_Purch_MN_7D = ABS(tpcHHExpFEgg_Purch_MN_7D - tpcHHExpFEgg_Purch_MN_7D_median).
COMPUTE dHHExpFEgg_GiftAid_MN_7D = ABS(tpcHHExpFEgg_GiftAid_MN_7D - tpcHHExpFEgg_GiftAid_MN_7D_median).
COMPUTE dHHExpFEgg_Own_MN_7D = ABS(tpcHHExpFEgg_Own_MN_7D - tpcHHExpFEgg_Own_MN_7D_median).
COMPUTE dHHExpFSgr_Purch_MN_7D = ABS(tpcHHExpFSgr_Purch_MN_7D - tpcHHExpFSgr_Purch_MN_7D_median).
COMPUTE dHHExpFSgr_GiftAid_MN_7D = ABS(tpcHHExpFSgr_GiftAid_MN_7D - tpcHHExpFSgr_GiftAid_MN_7D_median).
COMPUTE dHHExpFSgr_Own_MN_7D = ABS(tpcHHExpFSgr_Own_MN_7D - tpcHHExpFSgr_Own_MN_7D_median).
COMPUTE dHHExpFCond_Purch_MN_7D = ABS(tpcHHExpFCond_Purch_MN_7D - tpcHHExpFCond_Purch_MN_7D_median).
COMPUTE dHHExpFCond_GiftAid_MN_7D = ABS(tpcHHExpFCond_GiftAid_MN_7D - tpcHHExpFCond_GiftAid_MN_7D_median).
COMPUTE dHHExpFCond_Own_MN_7D = ABS(tpcHHExpFCond_Own_MN_7D - tpcHHExpFCond_Own_MN_7D_median).
COMPUTE dHHExpFBev_Purch_MN_7D = ABS(tpcHHExpFBev_Purch_MN_7D - tpcHHExpFBev_Purch_MN_7D_median).
COMPUTE dHHExpFBev_GiftAid_MN_7D = ABS(tpcHHExpFBev_GiftAid_MN_7D - tpcHHExpFBev_GiftAid_MN_7D_median).
COMPUTE dHHExpFBev_Own_MN_7D = ABS(tpcHHExpFBev_Own_MN_7D - tpcHHExpFBev_Own_MN_7D_median).
COMPUTE dHHExpFOut_Purch_MN_7D = ABS(tpcHHExpFOut_Purch_MN_7D - tpcHHExpFOut_Purch_MN_7D_median).
COMPUTE dHHExpFOut_GiftAid_MN_7D = ABS(tpcHHExpFOut_GiftAid_MN_7D - tpcHHExpFOut_GiftAid_MN_7D_median).
COMPUTE dHHExpFOut_Own_MN_7D = ABS(tpcHHExpFOut_Own_MN_7D - tpcHHExpFOut_Own_MN_7D_median).
COMPUTE dHHExpNFHyg_Purch_MN_1M = ABS(tpcHHExpNFHyg_Purch_MN_1M - tpcHHExpNFHyg_Purch_MN_1M_median).
COMPUTE dHHExpNFHyg_GiftAid_MN_1M = ABS(tpcHHExpNFHyg_GiftAid_MN_1M - tpcHHExpNFHyg_GiftAid_MN_1M_median).
COMPUTE dHHExpNFTransp_Purch_MN_1M = ABS(tpcHHExpNFTransp_Purch_MN_1M - tpcHHExpNFTransp_Purch_MN_1M_median).
COMPUTE dHHExpNFTransp_GiftAid_MN_1M = ABS(tpcHHExpNFTransp_GiftAid_MN_1M - tpcHHExpNFTransp_GiftAid_MN_1M_median).
COMPUTE dHHExpNFFuel_Purch_MN_1M = ABS(tpcHHExpNFFuel_Purch_MN_1M - tpcHHExpNFFuel_Purch_MN_1M_median).
COMPUTE dHHExpNFFuel_GiftAid_MN_1M = ABS(tpcHHExpNFFuel_GiftAid_MN_1M - tpcHHExpNFFuel_GiftAid_MN_1M_median).
COMPUTE dHHExpNFWat_Purch_MN_1M = ABS(tpcHHExpNFWat_Purch_MN_1M - tpcHHExpNFWat_Purch_MN_1M_median).
COMPUTE dHHExpNFWat_GiftAid_MN_1M = ABS(tpcHHExpNFWat_GiftAid_MN_1M - tpcHHExpNFWat_GiftAid_MN_1M_median).
COMPUTE dHHExpNFElec_Purch_MN_1M = ABS(tpcHHExpNFElec_Purch_MN_1M - tpcHHExpNFElec_Purch_MN_1M_median).
COMPUTE dHHExpNFElec_GiftAid_MN_1M = ABS(tpcHHExpNFElec_GiftAid_MN_1M - tpcHHExpNFElec_GiftAid_MN_1M_median).
COMPUTE dHHExpNFEnerg_Purch_MN_1M = ABS(tpcHHExpNFEnerg_Purch_MN_1M - tpcHHExpNFEnerg_Purch_MN_1M_median).
COMPUTE dHHExpNFEnerg_GiftAid_MN_1M = ABS(tpcHHExpNFEnerg_GiftAid_MN_1M - tpcHHExpNFEnerg_GiftAid_MN_1M_median).
COMPUTE dHHExpNFDwelSer_Purch_MN_1M = ABS(tpcHHExpNFDwelSer_Purch_MN_1M - tpcHHExpNFDwelSer_Purch_MN_1M_median).
COMPUTE dHHExpNFDwelSer_GiftAid_MN_1M = ABS(tpcHHExpNFDwelSer_GiftAid_MN_1M - tpcHHExpNFDwelSer_GiftAid_MN_1M_median).
COMPUTE dHHExpNFPhone_Purch_MN_1M = ABS(tpcHHExpNFPhone_Purch_MN_1M - tpcHHExpNFPhone_Purch_MN_1M_median).
COMPUTE dHHExpNFPhone_GiftAid_MN_1M = ABS(tpcHHExpNFPhone_GiftAid_MN_1M - tpcHHExpNFPhone_GiftAid_MN_1M_median).
COMPUTE dHHExpNFRecr_Purch_MN_1M = ABS(tpcHHExpNFRecr_Purch_MN_1M - tpcHHExpNFRecr_Purch_MN_1M_median).
COMPUTE dHHExpNFRecr_GiftAid_MN_1M = ABS(tpcHHExpNFRecr_GiftAid_MN_1M - tpcHHExpNFRecr_GiftAid_MN_1M_median).
COMPUTE dHHExpNFAlcTobac_Purch_MN_1M = ABS(tpcHHExpNFAlcTobac_Purch_MN_1M - tpcHHExpNFAlcTobac_Purch_MN_1M_median).
COMPUTE dHHExpNFAlcTobac_GiftAid_MN_1M = ABS(tpcHHExpNFAlcTobac_GiftAid_MN_1M - tpcHHExpNFAlcTobac_GiftAid_MN_1M_median).
COMPUTE dHHExpNFMedServ_Purch_MN_6M = ABS(tpcHHExpNFMedServ_Purch_MN_6M - tpcHHExpNFMedServ_Purch_MN_6M_median).
COMPUTE dHHExpNFMedServ_GiftAid_MN_6M = ABS(tpcHHExpNFMedServ_GiftAid_MN_6M - tpcHHExpNFMedServ_GiftAid_MN_6M_median).
COMPUTE dHHExpNFMedGood_Purch_MN_6M = ABS(tpcHHExpNFMedGood_Purch_MN_6M - tpcHHExpNFMedGood_Purch_MN_6M_median).
COMPUTE dHHExpNFMedGood_GiftAid_MN_6M = ABS(tpcHHExpNFMedGood_GiftAid_MN_6M - tpcHHExpNFMedGood_GiftAid_MN_6M_median).
COMPUTE dHHExpNFCloth_Purch_MN_6M = ABS(tpcHHExpNFCloth_Purch_MN_6M - tpcHHExpNFCloth_Purch_MN_6M_median).
COMPUTE dHHExpNFCloth_GiftAid_MN_6M = ABS(tpcHHExpNFCloth_GiftAid_MN_6M - tpcHHExpNFCloth_GiftAid_MN_6M_median).
COMPUTE dHHExpNFEduFee_Purch_MN_6M = ABS(tpcHHExpNFEduFee_Purch_MN_6M - tpcHHExpNFEduFee_Purch_MN_6M_median).
COMPUTE dHHExpNFEduFee_GiftAid_MN_6M = ABS(tpcHHExpNFEduFee_GiftAid_MN_6M - tpcHHExpNFEduFee_GiftAid_MN_6M_median).
COMPUTE dHHExpNFEduGood_Purch_MN_6M = ABS(tpcHHExpNFEduGood_Purch_MN_6M - tpcHHExpNFEduGood_Purch_MN_6M_median).
COMPUTE dHHExpNFEduGood_GiftAid_MN_6M = ABS(tpcHHExpNFEduGood_GiftAid_MN_6M - tpcHHExpNFEduGood_GiftAid_MN_6M_median).
COMPUTE dHHExpNFRent_Purch_MN_6M = ABS(tpcHHExpNFRent_Purch_MN_6M - tpcHHExpNFRent_Purch_MN_6M_median).
COMPUTE dHHExpNFRent_GiftAid_MN_6M = ABS(tpcHHExpNFRent_GiftAid_MN_6M - tpcHHExpNFRent_GiftAid_MN_6M_median).
COMPUTE dHHExpNFHHSoft_Purch_MN_6M = ABS(tpcHHExpNFHHSoft_Purch_MN_6M - tpcHHExpNFHHSoft_Purch_MN_6M_median).
COMPUTE dHHExpNFHHSoft_GiftAid_MN_6M = ABS(tpcHHExpNFHHSoft_GiftAid_MN_6M - tpcHHExpNFHHSoft_GiftAid_MN_6M_median).
COMPUTE dHHExpNFHHMaint_Purch_MN_6M = ABS(tpcHHExpNFHHMaint_Purch_MN_6M - tpcHHExpNFHHMaint_Purch_MN_6M_median).
COMPUTE dHHExpNFHHMaint_GiftAid_MN_6M = ABS(tpcHHExpNFHHMaint_GiftAid_MN_6M - tpcHHExpNFHHMaint_GiftAid_MN_6M_median).
EXE.

* Compute median of these difference for each variable.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=
  /dHHExpFCer_Purch_MN_7D_median=MEDIAN(dHHExpFCer_Purch_MN_7D) 
  /dHHExpFCer_GiftAid_MN_7D_median=MEDIAN(dHHExpFCer_GiftAid_MN_7D) 
  /dHHExpFCer_Own_MN_7D_median=MEDIAN(dHHExpFCer_Own_MN_7D) 
  /dHHExpFTub_Purch_MN_7D_median=MEDIAN(dHHExpFTub_Purch_MN_7D) 
  /dHHExpFTub_GiftAid_MN_7D_median=MEDIAN(dHHExpFTub_GiftAid_MN_7D) 
  /dHHExpFTub_Own_MN_7D_median=MEDIAN(dHHExpFTub_Own_MN_7D) 
  /dHHExpFPuls_Purch_MN_7D_median=MEDIAN(dHHExpFPuls_Purch_MN_7D) 
  /dHHExpFPuls_GiftAid_MN_7D_median=MEDIAN(dHHExpFPuls_GiftAid_MN_7D) 
  /dHHExpFPuls_Own_MN_7D_median=MEDIAN(dHHExpFPuls_Own_MN_7D) 
  /dHHExpFVeg_Purch_MN_7D_median=MEDIAN(dHHExpFVeg_Purch_MN_7D) 
  /dHHExpFVeg_GiftAid_MN_7D_median=MEDIAN(dHHExpFVeg_GiftAid_MN_7D) 
  /dHHExpFVeg_Own_MN_7D_median=MEDIAN(dHHExpFVeg_Own_MN_7D) 
  /dHHExpFFrt_Purch_MN_7D_median=MEDIAN(dHHExpFFrt_Purch_MN_7D) 
  /dHHExpFFrt_GiftAid_MN_7D_median=MEDIAN(dHHExpFFrt_GiftAid_MN_7D) 
  /dHHExpFFrt_Own_MN_7D_median=MEDIAN(dHHExpFFrt_Own_MN_7D) 
  /dHHExpFAnimMeat_Purch_MN_7D_median=MEDIAN(dHHExpFAnimMeat_Purch_MN_7D) 
  /dHHExpFAnimMeat_GiftAid_MN_7D_median=MEDIAN(dHHExpFAnimMeat_GiftAid_MN_7D) 
  /dHHExpFAnimMeat_Own_MN_7D_median=MEDIAN(dHHExpFAnimMeat_Own_MN_7D) 
  /dHHExpFAnimFish_Purch_MN_7D_median=MEDIAN(dHHExpFAnimFish_Purch_MN_7D) 
  /dHHExpFAnimFish_GiftAid_MN_7D_median=MEDIAN(dHHExpFAnimFish_GiftAid_MN_7D) 
  /dHHExpFAnimFish_Own_MN_7D_median=MEDIAN(dHHExpFAnimFish_Own_MN_7D) 
  /dHHExpFFats_Purch_MN_7D_median=MEDIAN(dHHExpFFats_Purch_MN_7D) 
  /dHHExpFFats_GiftAid_MN_7D_median=MEDIAN(dHHExpFFats_GiftAid_MN_7D) 
  /dHHExpFFats_Own_MN_7D_median=MEDIAN(dHHExpFFats_Own_MN_7D) 
  /dHHExpFDairy_Purch_MN_7D_median=MEDIAN(dHHExpFDairy_Purch_MN_7D) 
  /dHHExpFDairy_GiftAid_MN_7D_median=MEDIAN(dHHExpFDairy_GiftAid_MN_7D) 
  /dHHExpFDairy_Own_MN_7D_median=MEDIAN(dHHExpFDairy_Own_MN_7D) 
  /dHHExpFEgg_Purch_MN_7D_median=MEDIAN(dHHExpFEgg_Purch_MN_7D) 
  /dHHExpFEgg_GiftAid_MN_7D_median=MEDIAN(dHHExpFEgg_GiftAid_MN_7D) 
  /dHHExpFEgg_Own_MN_7D_median=MEDIAN(dHHExpFEgg_Own_MN_7D) 
  /dHHExpFSgr_Purch_MN_7D_median=MEDIAN(dHHExpFSgr_Purch_MN_7D) 
  /dHHExpFSgr_GiftAid_MN_7D_median=MEDIAN(dHHExpFSgr_GiftAid_MN_7D) 
  /dHHExpFSgr_Own_MN_7D_median=MEDIAN(dHHExpFSgr_Own_MN_7D) 
  /dHHExpFCond_Purch_MN_7D_median=MEDIAN(dHHExpFCond_Purch_MN_7D) 
  /dHHExpFCond_GiftAid_MN_7D_median=MEDIAN(dHHExpFCond_GiftAid_MN_7D) 
  /dHHExpFCond_Own_MN_7D_median=MEDIAN(dHHExpFCond_Own_MN_7D) 
  /dHHExpFBev_Purch_MN_7D_median=MEDIAN(dHHExpFBev_Purch_MN_7D) 
  /dHHExpFBev_GiftAid_MN_7D_median=MEDIAN(dHHExpFBev_GiftAid_MN_7D) 
  /dHHExpFBev_Own_MN_7D_median=MEDIAN(dHHExpFBev_Own_MN_7D) 
  /dHHExpFOut_Purch_MN_7D_median=MEDIAN(dHHExpFOut_Purch_MN_7D) 
  /dHHExpFOut_GiftAid_MN_7D_median=MEDIAN(dHHExpFOut_GiftAid_MN_7D) 
  /dHHExpFOut_Own_MN_7D_median=MEDIAN(dHHExpFOut_Own_MN_7D) 
  /dHHExpNFHyg_Purch_MN_1M_median=MEDIAN(dHHExpNFHyg_Purch_MN_1M) 
  /dHHExpNFHyg_GiftAid_MN_1M_median=MEDIAN(dHHExpNFHyg_GiftAid_MN_1M) 
  /dHHExpNFTransp_Purch_MN_1M_median=MEDIAN(dHHExpNFTransp_Purch_MN_1M) 
  /dHHExpNFTransp_GiftAid_MN_1M_median=MEDIAN(dHHExpNFTransp_GiftAid_MN_1M) 
  /dHHExpNFFuel_Purch_MN_1M_median=MEDIAN(dHHExpNFFuel_Purch_MN_1M) 
  /dHHExpNFFuel_GiftAid_MN_1M_median=MEDIAN(dHHExpNFFuel_GiftAid_MN_1M) 
  /dHHExpNFWat_Purch_MN_1M_median=MEDIAN(dHHExpNFWat_Purch_MN_1M) 
  /dHHExpNFWat_GiftAid_MN_1M_median=MEDIAN(dHHExpNFWat_GiftAid_MN_1M) 
  /dHHExpNFElec_Purch_MN_1M_median=MEDIAN(dHHExpNFElec_Purch_MN_1M) 
  /dHHExpNFElec_GiftAid_MN_1M_median=MEDIAN(dHHExpNFElec_GiftAid_MN_1M) 
  /dHHExpNFEnerg_Purch_MN_1M_median=MEDIAN(dHHExpNFEnerg_Purch_MN_1M) 
  /dHHExpNFEnerg_GiftAid_MN_1M_median=MEDIAN(dHHExpNFEnerg_GiftAid_MN_1M) 
  /dHHExpNFDwelSer_Purch_MN_1M_median=MEDIAN(dHHExpNFDwelSer_Purch_MN_1M) 
  /dHHExpNFDwelSer_GiftAid_MN_1M_median=MEDIAN(dHHExpNFDwelSer_GiftAid_MN_1M) 
  /dHHExpNFPhone_Purch_MN_1M_median=MEDIAN(dHHExpNFPhone_Purch_MN_1M) 
  /dHHExpNFPhone_GiftAid_MN_1M_median=MEDIAN(dHHExpNFPhone_GiftAid_MN_1M) 
  /dHHExpNFRecr_Purch_MN_1M_median=MEDIAN(dHHExpNFRecr_Purch_MN_1M) 
  /dHHExpNFRecr_GiftAid_MN_1M_median=MEDIAN(dHHExpNFRecr_GiftAid_MN_1M) 
  /dHHExpNFAlcTobac_Purch_MN_1M_median=MEDIAN(dHHExpNFAlcTobac_Purch_MN_1M) 
  /dHHExpNFAlcTobac_GiftAid_MN_1M_median=MEDIAN(dHHExpNFAlcTobac_GiftAid_MN_1M) 
  /dHHExpNFMedServ_Purch_MN_6M_median=MEDIAN(dHHExpNFMedServ_Purch_MN_6M) 
  /dHHExpNFMedServ_GiftAid_MN_6M_median=MEDIAN(dHHExpNFMedServ_GiftAid_MN_6M) 
  /dHHExpNFMedGood_Purch_MN_6M_median=MEDIAN(dHHExpNFMedGood_Purch_MN_6M) 
  /dHHExpNFMedGood_GiftAid_MN_6M_median=MEDIAN(dHHExpNFMedGood_GiftAid_MN_6M) 
  /dHHExpNFCloth_Purch_MN_6M_median=MEDIAN(dHHExpNFCloth_Purch_MN_6M) 
  /dHHExpNFCloth_GiftAid_MN_6M_median=MEDIAN(dHHExpNFCloth_GiftAid_MN_6M) 
  /dHHExpNFEduFee_Purch_MN_6M_median=MEDIAN(dHHExpNFEduFee_Purch_MN_6M) 
  /dHHExpNFEduFee_GiftAid_MN_6M_median=MEDIAN(dHHExpNFEduFee_GiftAid_MN_6M) 
  /dHHExpNFEduGood_Purch_MN_6M_median=MEDIAN(dHHExpNFEduGood_Purch_MN_6M) 
  /dHHExpNFEduGood_GiftAid_MN_6M_median=MEDIAN(dHHExpNFEduGood_GiftAid_MN_6M) 
  /dHHExpNFRent_Purch_MN_6M_median=MEDIAN(dHHExpNFRent_Purch_MN_6M) 
  /dHHExpNFRent_GiftAid_MN_6M_median=MEDIAN(dHHExpNFRent_GiftAid_MN_6M) 
  /dHHExpNFHHSoft_Purch_MN_6M_median=MEDIAN(dHHExpNFHHSoft_Purch_MN_6M) 
  /dHHExpNFHHSoft_GiftAid_MN_6M_median=MEDIAN(dHHExpNFHHSoft_GiftAid_MN_6M) 
  /dHHExpNFHHMaint_Purch_MN_6M_median=MEDIAN(dHHExpNFHHMaint_Purch_MN_6M) 
  /dHHExpNFHHMaint_GiftAid_MN_6M_median=MEDIAN(dHHExpNFHHMaint_GiftAid_MN_6M).

* Compute MAD for each variable.
COMPUTE MADHHExpFCer_Purch_MN_7D = 1.4826*dHHExpFCer_Purch_MN_7D_median.
COMPUTE MADHHExpFCer_GiftAid_MN_7D = 1.4826*dHHExpFCer_GiftAid_MN_7D_median.
COMPUTE MADHHExpFCer_Own_MN_7D = 1.4826*dHHExpFCer_Own_MN_7D_median.
COMPUTE MADHHExpFTub_Purch_MN_7D = 1.4826*dHHExpFTub_Purch_MN_7D_median.
COMPUTE MADHHExpFTub_GiftAid_MN_7D = 1.4826*dHHExpFTub_GiftAid_MN_7D_median.
COMPUTE MADHHExpFTub_Own_MN_7D = 1.4826*dHHExpFTub_Own_MN_7D_median.
COMPUTE MADHHExpFPuls_Purch_MN_7D = 1.4826*dHHExpFPuls_Purch_MN_7D_median.
COMPUTE MADHHExpFPuls_GiftAid_MN_7D = 1.4826*dHHExpFPuls_GiftAid_MN_7D_median.
COMPUTE MADHHExpFPuls_Own_MN_7D = 1.4826*dHHExpFPuls_Own_MN_7D_median.
COMPUTE MADHHExpFVeg_Purch_MN_7D = 1.4826*dHHExpFVeg_Purch_MN_7D_median.
COMPUTE MADHHExpFVeg_GiftAid_MN_7D = 1.4826*dHHExpFVeg_GiftAid_MN_7D_median.
COMPUTE MADHHExpFVeg_Own_MN_7D = 1.4826*dHHExpFVeg_Own_MN_7D_median.
COMPUTE MADHHExpFFrt_Purch_MN_7D = 1.4826*dHHExpFFrt_Purch_MN_7D_median.
COMPUTE MADHHExpFFrt_GiftAid_MN_7D = 1.4826*dHHExpFFrt_GiftAid_MN_7D_median.
COMPUTE MADHHExpFFrt_Own_MN_7D = 1.4826*dHHExpFFrt_Own_MN_7D_median.
COMPUTE MADHHExpFAnimMeat_Purch_MN_7D = 1.4826*dHHExpFAnimMeat_Purch_MN_7D_median.
COMPUTE MADHHExpFAnimMeat_GiftAid_MN_7D = 1.4826*dHHExpFAnimMeat_GiftAid_MN_7D_median.
COMPUTE MADHHExpFAnimMeat_Own_MN_7D = 1.4826*dHHExpFAnimMeat_Own_MN_7D_median.
COMPUTE MADHHExpFAnimFish_Purch_MN_7D = 1.4826*dHHExpFAnimFish_Purch_MN_7D_median.
COMPUTE MADHHExpFAnimFish_GiftAid_MN_7D = 1.4826*dHHExpFAnimFish_GiftAid_MN_7D_median.
COMPUTE MADHHExpFAnimFish_Own_MN_7D = 1.4826*dHHExpFAnimFish_Own_MN_7D_median.
COMPUTE MADHHExpFFats_Purch_MN_7D = 1.4826*dHHExpFFats_Purch_MN_7D_median.
COMPUTE MADHHExpFFats_GiftAid_MN_7D = 1.4826*dHHExpFFats_GiftAid_MN_7D_median.
COMPUTE MADHHExpFFats_Own_MN_7D = 1.4826*dHHExpFFats_Own_MN_7D_median.
COMPUTE MADHHExpFDairy_Purch_MN_7D = 1.4826*dHHExpFDairy_Purch_MN_7D_median.
COMPUTE MADHHExpFDairy_GiftAid_MN_7D = 1.4826*dHHExpFDairy_GiftAid_MN_7D_median.
COMPUTE MADHHExpFDairy_Own_MN_7D = 1.4826*dHHExpFDairy_Own_MN_7D_median.
COMPUTE MADHHExpFEgg_Purch_MN_7D = 1.4826*dHHExpFEgg_Purch_MN_7D_median.
COMPUTE MADHHExpFEgg_GiftAid_MN_7D = 1.4826*dHHExpFEgg_GiftAid_MN_7D_median.
COMPUTE MADHHExpFEgg_Own_MN_7D = 1.4826*dHHExpFEgg_Own_MN_7D_median.
COMPUTE MADHHExpFSgr_Purch_MN_7D = 1.4826*dHHExpFSgr_Purch_MN_7D_median.
COMPUTE MADHHExpFSgr_GiftAid_MN_7D = 1.4826*dHHExpFSgr_GiftAid_MN_7D_median.
COMPUTE MADHHExpFSgr_Own_MN_7D = 1.4826*dHHExpFSgr_Own_MN_7D_median.
COMPUTE MADHHExpFCond_Purch_MN_7D = 1.4826*dHHExpFCond_Purch_MN_7D_median.
COMPUTE MADHHExpFCond_GiftAid_MN_7D = 1.4826*dHHExpFCond_GiftAid_MN_7D_median.
COMPUTE MADHHExpFCond_Own_MN_7D = 1.4826*dHHExpFCond_Own_MN_7D_median.
COMPUTE MADHHExpFBev_Purch_MN_7D = 1.4826*dHHExpFBev_Purch_MN_7D_median.
COMPUTE MADHHExpFBev_GiftAid_MN_7D = 1.4826*dHHExpFBev_GiftAid_MN_7D_median.
COMPUTE MADHHExpFBev_Own_MN_7D = 1.4826*dHHExpFBev_Own_MN_7D_median.
COMPUTE MADHHExpFOut_Purch_MN_7D = 1.4826*dHHExpFOut_Purch_MN_7D_median.
COMPUTE MADHHExpFOut_GiftAid_MN_7D = 1.4826*dHHExpFOut_GiftAid_MN_7D_median.
COMPUTE MADHHExpFOut_Own_MN_7D = 1.4826*dHHExpFOut_Own_MN_7D_median.
COMPUTE MADHHExpNFHyg_Purch_MN_1M = 1.4826*dHHExpNFHyg_Purch_MN_1M_median.
COMPUTE MADHHExpNFHyg_GiftAid_MN_1M = 1.4826*dHHExpNFHyg_GiftAid_MN_1M_median.
COMPUTE MADHHExpNFTransp_Purch_MN_1M = 1.4826*dHHExpNFTransp_Purch_MN_1M_median.
COMPUTE MADHHExpNFTransp_GiftAid_MN_1M = 1.4826*dHHExpNFTransp_GiftAid_MN_1M_median.
COMPUTE MADHHExpNFFuel_Purch_MN_1M = 1.4826*dHHExpNFFuel_Purch_MN_1M_median.
COMPUTE MADHHExpNFFuel_GiftAid_MN_1M = 1.4826*dHHExpNFFuel_GiftAid_MN_1M_median.
COMPUTE MADHHExpNFWat_Purch_MN_1M = 1.4826*dHHExpNFWat_Purch_MN_1M_median.
COMPUTE MADHHExpNFWat_GiftAid_MN_1M = 1.4826*dHHExpNFWat_GiftAid_MN_1M_median.
COMPUTE MADHHExpNFElec_Purch_MN_1M = 1.4826*dHHExpNFElec_Purch_MN_1M_median.
COMPUTE MADHHExpNFElec_GiftAid_MN_1M = 1.4826*dHHExpNFElec_GiftAid_MN_1M_median.
COMPUTE MADHHExpNFEnerg_Purch_MN_1M = 1.4826*dHHExpNFEnerg_Purch_MN_1M_median.
COMPUTE MADHHExpNFEnerg_GiftAid_MN_1M = 1.4826*dHHExpNFEnerg_GiftAid_MN_1M_median.
COMPUTE MADHHExpNFDwelSer_Purch_MN_1M = 1.4826*dHHExpNFDwelSer_Purch_MN_1M_median.
COMPUTE MADHHExpNFDwelSer_GiftAid_MN_1M = 1.4826*dHHExpNFDwelSer_GiftAid_MN_1M_median.
COMPUTE MADHHExpNFPhone_Purch_MN_1M = 1.4826*dHHExpNFPhone_Purch_MN_1M_median.
COMPUTE MADHHExpNFPhone_GiftAid_MN_1M = 1.4826*dHHExpNFPhone_GiftAid_MN_1M_median.
COMPUTE MADHHExpNFRecr_Purch_MN_1M = 1.4826*dHHExpNFRecr_Purch_MN_1M_median.
COMPUTE MADHHExpNFRecr_GiftAid_MN_1M = 1.4826*dHHExpNFRecr_GiftAid_MN_1M_median.
COMPUTE MADHHExpNFAlcTobac_Purch_MN_1M = 1.4826*dHHExpNFAlcTobac_Purch_MN_1M_median.
COMPUTE MADHHExpNFAlcTobac_GiftAid_MN_1M = 1.4826*dHHExpNFAlcTobac_GiftAid_MN_1M_median.
COMPUTE MADHHExpNFMedServ_Purch_MN_6M = 1.4826*dHHExpNFMedServ_Purch_MN_6M_median.
COMPUTE MADHHExpNFMedServ_GiftAid_MN_6M = 1.4826*dHHExpNFMedServ_GiftAid_MN_6M_median.
COMPUTE MADHHExpNFMedGood_Purch_MN_6M = 1.4826*dHHExpNFMedGood_Purch_MN_6M_median.
COMPUTE MADHHExpNFMedGood_GiftAid_MN_6M = 1.4826*dHHExpNFMedGood_GiftAid_MN_6M_median.
COMPUTE MADHHExpNFCloth_Purch_MN_6M = 1.4826*dHHExpNFCloth_Purch_MN_6M_median.
COMPUTE MADHHExpNFCloth_GiftAid_MN_6M = 1.4826*dHHExpNFCloth_GiftAid_MN_6M_median.
COMPUTE MADHHExpNFEduFee_Purch_MN_6M = 1.4826*dHHExpNFEduFee_Purch_MN_6M_median.
COMPUTE MADHHExpNFEduFee_GiftAid_MN_6M = 1.4826*dHHExpNFEduFee_GiftAid_MN_6M_median.
COMPUTE MADHHExpNFEduGood_Purch_MN_6M = 1.4826*dHHExpNFEduGood_Purch_MN_6M_median.
COMPUTE MADHHExpNFEduGood_GiftAid_MN_6M = 1.4826*dHHExpNFEduGood_GiftAid_MN_6M_median.
COMPUTE MADHHExpNFRent_Purch_MN_6M = 1.4826*dHHExpNFRent_Purch_MN_6M_median.
COMPUTE MADHHExpNFRent_GiftAid_MN_6M = 1.4826*dHHExpNFRent_GiftAid_MN_6M_median.
COMPUTE MADHHExpNFHHSoft_Purch_MN_6M = 1.4826*dHHExpNFHHSoft_Purch_MN_6M_median.
COMPUTE MADHHExpNFHHSoft_GiftAid_MN_6M = 1.4826*dHHExpNFHHSoft_GiftAid_MN_6M_median.
COMPUTE MADHHExpNFHHMaint_Purch_MN_6M = 1.4826*dHHExpNFHHMaint_Purch_MN_6M_median.
COMPUTE MADHHExpNFHHMaint_GiftAid_MN_6M = 1.4826*dHHExpNFHHMaint_GiftAid_MN_6M_median.
EXECUTE.

* Standardize.
COMPUTE zHHExpFCer_Purch_MN_7D = (tpcHHExpFCer_Purch_MN_7D - tpcHHExpFCer_Purch_MN_7D_median)/MADHHExpFCer_Purch_MN_7D.
COMPUTE zHHExpFCer_GiftAid_MN_7D = (tpcHHExpFCer_GiftAid_MN_7D - tpcHHExpFCer_GiftAid_MN_7D_median)/MADHHExpFCer_GiftAid_MN_7D.
COMPUTE zHHExpFCer_Own_MN_7D = (tpcHHExpFCer_Own_MN_7D - tpcHHExpFCer_Own_MN_7D_median)/MADHHExpFCer_Own_MN_7D.
COMPUTE zHHExpFTub_Purch_MN_7D = (tpcHHExpFTub_Purch_MN_7D - tpcHHExpFTub_Purch_MN_7D_median)/MADHHExpFTub_Purch_MN_7D.
COMPUTE zHHExpFTub_GiftAid_MN_7D = (tpcHHExpFTub_GiftAid_MN_7D - tpcHHExpFTub_GiftAid_MN_7D_median)/MADHHExpFTub_GiftAid_MN_7D.
COMPUTE zHHExpFTub_Own_MN_7D = (tpcHHExpFTub_Own_MN_7D - tpcHHExpFTub_Own_MN_7D_median)/MADHHExpFTub_Own_MN_7D.
COMPUTE zHHExpFPuls_Purch_MN_7D = (tpcHHExpFPuls_Purch_MN_7D - tpcHHExpFPuls_Purch_MN_7D_median)/MADHHExpFPuls_Purch_MN_7D.
COMPUTE zHHExpFPuls_GiftAid_MN_7D = (tpcHHExpFPuls_GiftAid_MN_7D - tpcHHExpFPuls_GiftAid_MN_7D_median)/MADHHExpFPuls_GiftAid_MN_7D.
COMPUTE zHHExpFPuls_Own_MN_7D = (tpcHHExpFPuls_Own_MN_7D - tpcHHExpFPuls_Own_MN_7D_median)/MADHHExpFPuls_Own_MN_7D.
COMPUTE zHHExpFVeg_Purch_MN_7D = (tpcHHExpFVeg_Purch_MN_7D - tpcHHExpFVeg_Purch_MN_7D_median)/MADHHExpFVeg_Purch_MN_7D.
COMPUTE zHHExpFVeg_GiftAid_MN_7D = (tpcHHExpFVeg_GiftAid_MN_7D - tpcHHExpFVeg_GiftAid_MN_7D_median)/MADHHExpFVeg_GiftAid_MN_7D.
COMPUTE zHHExpFVeg_Own_MN_7D = (tpcHHExpFVeg_Own_MN_7D - tpcHHExpFVeg_Own_MN_7D_median)/MADHHExpFVeg_Own_MN_7D.
COMPUTE zHHExpFFrt_Purch_MN_7D = (tpcHHExpFFrt_Purch_MN_7D - tpcHHExpFFrt_Purch_MN_7D_median)/MADHHExpFFrt_Purch_MN_7D.
COMPUTE zHHExpFFrt_GiftAid_MN_7D = (tpcHHExpFFrt_GiftAid_MN_7D - tpcHHExpFFrt_GiftAid_MN_7D_median)/MADHHExpFFrt_GiftAid_MN_7D.
COMPUTE zHHExpFFrt_Own_MN_7D = (tpcHHExpFFrt_Own_MN_7D - tpcHHExpFFrt_Own_MN_7D_median)/MADHHExpFFrt_Own_MN_7D.
COMPUTE zHHExpFAnimMeat_Purch_MN_7D = (tpcHHExpFAnimMeat_Purch_MN_7D - tpcHHExpFAnimMeat_Purch_MN_7D_median)/MADHHExpFAnimMeat_Purch_MN_7D.
COMPUTE zHHExpFAnimMeat_GiftAid_MN_7D = (tpcHHExpFAnimMeat_GiftAid_MN_7D - tpcHHExpFAnimMeat_GiftAid_MN_7D_median)/MADHHExpFAnimMeat_GiftAid_MN_7D.
COMPUTE zHHExpFAnimMeat_Own_MN_7D = (tpcHHExpFAnimMeat_Own_MN_7D - tpcHHExpFAnimMeat_Own_MN_7D_median)/MADHHExpFAnimMeat_Own_MN_7D.
COMPUTE zHHExpFAnimFish_Purch_MN_7D = (tpcHHExpFAnimFish_Purch_MN_7D - tpcHHExpFAnimFish_Purch_MN_7D_median)/MADHHExpFAnimFish_Purch_MN_7D.
COMPUTE zHHExpFAnimFish_GiftAid_MN_7D = (tpcHHExpFAnimFish_GiftAid_MN_7D - tpcHHExpFAnimFish_GiftAid_MN_7D_median)/MADHHExpFAnimFish_GiftAid_MN_7D.
COMPUTE zHHExpFAnimFish_Own_MN_7D = (tpcHHExpFAnimFish_Own_MN_7D - tpcHHExpFAnimFish_Own_MN_7D_median)/MADHHExpFAnimFish_Own_MN_7D.
COMPUTE zHHExpFFats_Purch_MN_7D = (tpcHHExpFFats_Purch_MN_7D - tpcHHExpFFats_Purch_MN_7D_median)/MADHHExpFFats_Purch_MN_7D.
COMPUTE zHHExpFFats_GiftAid_MN_7D = (tpcHHExpFFats_GiftAid_MN_7D - tpcHHExpFFats_GiftAid_MN_7D_median)/MADHHExpFFats_GiftAid_MN_7D.
COMPUTE zHHExpFFats_Own_MN_7D = (tpcHHExpFFats_Own_MN_7D - tpcHHExpFFats_Own_MN_7D_median)/MADHHExpFFats_Own_MN_7D.
COMPUTE zHHExpFDairy_Purch_MN_7D = (tpcHHExpFDairy_Purch_MN_7D - tpcHHExpFDairy_Purch_MN_7D_median)/MADHHExpFDairy_Purch_MN_7D.
COMPUTE zHHExpFDairy_GiftAid_MN_7D = (tpcHHExpFDairy_GiftAid_MN_7D - tpcHHExpFDairy_GiftAid_MN_7D_median)/MADHHExpFDairy_GiftAid_MN_7D.
COMPUTE zHHExpFDairy_Own_MN_7D = (tpcHHExpFDairy_Own_MN_7D - tpcHHExpFDairy_Own_MN_7D_median)/MADHHExpFDairy_Own_MN_7D.
COMPUTE zHHExpFEgg_Purch_MN_7D = (tpcHHExpFEgg_Purch_MN_7D - tpcHHExpFEgg_Purch_MN_7D_median)/MADHHExpFEgg_Purch_MN_7D.
COMPUTE zHHExpFEgg_GiftAid_MN_7D = (tpcHHExpFEgg_GiftAid_MN_7D - tpcHHExpFEgg_GiftAid_MN_7D_median)/MADHHExpFEgg_GiftAid_MN_7D.
COMPUTE zHHExpFEgg_Own_MN_7D = (tpcHHExpFEgg_Own_MN_7D - tpcHHExpFEgg_Own_MN_7D_median)/MADHHExpFEgg_Own_MN_7D.
COMPUTE zHHExpFSgr_Purch_MN_7D = (tpcHHExpFSgr_Purch_MN_7D - tpcHHExpFSgr_Purch_MN_7D_median)/MADHHExpFSgr_Purch_MN_7D.
COMPUTE zHHExpFSgr_GiftAid_MN_7D = (tpcHHExpFSgr_GiftAid_MN_7D - tpcHHExpFSgr_GiftAid_MN_7D_median)/MADHHExpFSgr_GiftAid_MN_7D.
COMPUTE zHHExpFSgr_Own_MN_7D = (tpcHHExpFSgr_Own_MN_7D - tpcHHExpFSgr_Own_MN_7D_median)/MADHHExpFSgr_Own_MN_7D.
COMPUTE zHHExpFCond_Purch_MN_7D = (tpcHHExpFCond_Purch_MN_7D - tpcHHExpFCond_Purch_MN_7D_median)/MADHHExpFCond_Purch_MN_7D.
COMPUTE zHHExpFCond_GiftAid_MN_7D = (tpcHHExpFCond_GiftAid_MN_7D - tpcHHExpFCond_GiftAid_MN_7D_median)/MADHHExpFCond_GiftAid_MN_7D.
COMPUTE zHHExpFCond_Own_MN_7D = (tpcHHExpFCond_Own_MN_7D - tpcHHExpFCond_Own_MN_7D_median)/MADHHExpFCond_Own_MN_7D.
COMPUTE zHHExpFBev_Purch_MN_7D = (tpcHHExpFBev_Purch_MN_7D - tpcHHExpFBev_Purch_MN_7D_median)/MADHHExpFBev_Purch_MN_7D.
COMPUTE zHHExpFBev_GiftAid_MN_7D = (tpcHHExpFBev_GiftAid_MN_7D - tpcHHExpFBev_GiftAid_MN_7D_median)/MADHHExpFBev_GiftAid_MN_7D.
COMPUTE zHHExpFBev_Own_MN_7D = (tpcHHExpFBev_Own_MN_7D - tpcHHExpFBev_Own_MN_7D_median)/MADHHExpFBev_Own_MN_7D.
COMPUTE zHHExpFOut_Purch_MN_7D = (tpcHHExpFOut_Purch_MN_7D - tpcHHExpFOut_Purch_MN_7D_median)/MADHHExpFOut_Purch_MN_7D.
COMPUTE zHHExpFOut_GiftAid_MN_7D = (tpcHHExpFOut_GiftAid_MN_7D - tpcHHExpFOut_GiftAid_MN_7D_median)/MADHHExpFOut_GiftAid_MN_7D.
COMPUTE zHHExpFOut_Own_MN_7D = (tpcHHExpFOut_Own_MN_7D - tpcHHExpFOut_Own_MN_7D_median)/MADHHExpFOut_Own_MN_7D.
COMPUTE zHHExpNFHyg_Purch_MN_1M = (tpcHHExpNFHyg_Purch_MN_1M - tpcHHExpNFHyg_Purch_MN_1M_median)/MADHHExpNFHyg_Purch_MN_1M.
COMPUTE zHHExpNFHyg_GiftAid_MN_1M = (tpcHHExpNFHyg_GiftAid_MN_1M - tpcHHExpNFHyg_GiftAid_MN_1M_median)/MADHHExpNFHyg_GiftAid_MN_1M.
COMPUTE zHHExpNFTransp_Purch_MN_1M = (tpcHHExpNFTransp_Purch_MN_1M - tpcHHExpNFTransp_Purch_MN_1M_median)/MADHHExpNFTransp_Purch_MN_1M.
COMPUTE zHHExpNFTransp_GiftAid_MN_1M = (tpcHHExpNFTransp_GiftAid_MN_1M - tpcHHExpNFTransp_GiftAid_MN_1M_median)/MADHHExpNFTransp_GiftAid_MN_1M.
COMPUTE zHHExpNFFuel_Purch_MN_1M = (tpcHHExpNFFuel_Purch_MN_1M - tpcHHExpNFFuel_Purch_MN_1M_median)/MADHHExpNFFuel_Purch_MN_1M.
COMPUTE zHHExpNFFuel_GiftAid_MN_1M = (tpcHHExpNFFuel_GiftAid_MN_1M - tpcHHExpNFFuel_GiftAid_MN_1M_median)/MADHHExpNFFuel_GiftAid_MN_1M.
COMPUTE zHHExpNFWat_Purch_MN_1M = (tpcHHExpNFWat_Purch_MN_1M - tpcHHExpNFWat_Purch_MN_1M_median)/MADHHExpNFWat_Purch_MN_1M.
COMPUTE zHHExpNFWat_GiftAid_MN_1M = (tpcHHExpNFWat_GiftAid_MN_1M - tpcHHExpNFWat_GiftAid_MN_1M_median)/MADHHExpNFWat_GiftAid_MN_1M.
COMPUTE zHHExpNFElec_Purch_MN_1M = (tpcHHExpNFElec_Purch_MN_1M - tpcHHExpNFElec_Purch_MN_1M_median)/MADHHExpNFElec_Purch_MN_1M.
COMPUTE zHHExpNFElec_GiftAid_MN_1M = (tpcHHExpNFElec_GiftAid_MN_1M - tpcHHExpNFElec_GiftAid_MN_1M_median)/MADHHExpNFElec_GiftAid_MN_1M.
COMPUTE zHHExpNFEnerg_Purch_MN_1M = (tpcHHExpNFEnerg_Purch_MN_1M - tpcHHExpNFEnerg_Purch_MN_1M_median)/MADHHExpNFEnerg_Purch_MN_1M.
COMPUTE zHHExpNFEnerg_GiftAid_MN_1M = (tpcHHExpNFEnerg_GiftAid_MN_1M - tpcHHExpNFEnerg_GiftAid_MN_1M_median)/MADHHExpNFEnerg_GiftAid_MN_1M.
COMPUTE zHHExpNFDwelSer_Purch_MN_1M = (tpcHHExpNFDwelSer_Purch_MN_1M - tpcHHExpNFDwelSer_Purch_MN_1M_median)/MADHHExpNFDwelSer_Purch_MN_1M.
COMPUTE zHHExpNFDwelSer_GiftAid_MN_1M = (tpcHHExpNFDwelSer_GiftAid_MN_1M - tpcHHExpNFDwelSer_GiftAid_MN_1M_median)/MADHHExpNFDwelSer_GiftAid_MN_1M.
COMPUTE zHHExpNFPhone_Purch_MN_1M = (tpcHHExpNFPhone_Purch_MN_1M - tpcHHExpNFPhone_Purch_MN_1M_median)/MADHHExpNFPhone_Purch_MN_1M.
COMPUTE zHHExpNFPhone_GiftAid_MN_1M = (tpcHHExpNFPhone_GiftAid_MN_1M - tpcHHExpNFPhone_GiftAid_MN_1M_median)/MADHHExpNFPhone_GiftAid_MN_1M.
COMPUTE zHHExpNFRecr_Purch_MN_1M = (tpcHHExpNFRecr_Purch_MN_1M - tpcHHExpNFRecr_Purch_MN_1M_median)/MADHHExpNFRecr_Purch_MN_1M.
COMPUTE zHHExpNFRecr_GiftAid_MN_1M = (tpcHHExpNFRecr_GiftAid_MN_1M - tpcHHExpNFRecr_GiftAid_MN_1M_median)/MADHHExpNFRecr_GiftAid_MN_1M.
COMPUTE zHHExpNFAlcTobac_Purch_MN_1M = (tpcHHExpNFAlcTobac_Purch_MN_1M - tpcHHExpNFAlcTobac_Purch_MN_1M_median)/MADHHExpNFAlcTobac_Purch_MN_1M.
COMPUTE zHHExpNFAlcTobac_GiftAid_MN_1M = (tpcHHExpNFAlcTobac_GiftAid_MN_1M - tpcHHExpNFAlcTobac_GiftAid_MN_1M_median)/MADHHExpNFAlcTobac_GiftAid_MN_1M.
COMPUTE zHHExpNFMedServ_Purch_MN_6M = (tpcHHExpNFMedServ_Purch_MN_6M - tpcHHExpNFMedServ_Purch_MN_6M_median)/MADHHExpNFMedServ_Purch_MN_6M.
COMPUTE zHHExpNFMedServ_GiftAid_MN_6M = (tpcHHExpNFMedServ_GiftAid_MN_6M - tpcHHExpNFMedServ_GiftAid_MN_6M_median)/MADHHExpNFMedServ_GiftAid_MN_6M.
COMPUTE zHHExpNFMedGood_Purch_MN_6M = (tpcHHExpNFMedGood_Purch_MN_6M - tpcHHExpNFMedGood_Purch_MN_6M_median)/MADHHExpNFMedGood_Purch_MN_6M.
COMPUTE zHHExpNFMedGood_GiftAid_MN_6M = (tpcHHExpNFMedGood_GiftAid_MN_6M - tpcHHExpNFMedGood_GiftAid_MN_6M_median)/MADHHExpNFMedGood_GiftAid_MN_6M.
COMPUTE zHHExpNFCloth_Purch_MN_6M = (tpcHHExpNFCloth_Purch_MN_6M - tpcHHExpNFCloth_Purch_MN_6M_median)/MADHHExpNFCloth_Purch_MN_6M.
COMPUTE zHHExpNFCloth_GiftAid_MN_6M = (tpcHHExpNFCloth_GiftAid_MN_6M - tpcHHExpNFCloth_GiftAid_MN_6M_median)/MADHHExpNFCloth_GiftAid_MN_6M.
COMPUTE zHHExpNFEduFee_Purch_MN_6M = (tpcHHExpNFEduFee_Purch_MN_6M - tpcHHExpNFEduFee_Purch_MN_6M_median)/MADHHExpNFEduFee_Purch_MN_6M.
COMPUTE zHHExpNFEduFee_GiftAid_MN_6M = (tpcHHExpNFEduFee_GiftAid_MN_6M - tpcHHExpNFEduFee_GiftAid_MN_6M_median)/MADHHExpNFEduFee_GiftAid_MN_6M.
COMPUTE zHHExpNFEduGood_Purch_MN_6M = (tpcHHExpNFEduGood_Purch_MN_6M - tpcHHExpNFEduGood_Purch_MN_6M_median)/MADHHExpNFEduGood_Purch_MN_6M.
COMPUTE zHHExpNFEduGood_GiftAid_MN_6M = (tpcHHExpNFEduGood_GiftAid_MN_6M - tpcHHExpNFEduGood_GiftAid_MN_6M_median)/MADHHExpNFEduGood_GiftAid_MN_6M.
COMPUTE zHHExpNFRent_Purch_MN_6M = (tpcHHExpNFRent_Purch_MN_6M - tpcHHExpNFRent_Purch_MN_6M_median)/MADHHExpNFRent_Purch_MN_6M.
COMPUTE zHHExpNFRent_GiftAid_MN_6M = (tpcHHExpNFRent_GiftAid_MN_6M - tpcHHExpNFRent_GiftAid_MN_6M_median)/MADHHExpNFRent_GiftAid_MN_6M.
COMPUTE zHHExpNFHHSoft_Purch_MN_6M = (tpcHHExpNFHHSoft_Purch_MN_6M - tpcHHExpNFHHSoft_Purch_MN_6M_median)/MADHHExpNFHHSoft_Purch_MN_6M.
COMPUTE zHHExpNFHHSoft_GiftAid_MN_6M = (tpcHHExpNFHHSoft_GiftAid_MN_6M - tpcHHExpNFHHSoft_GiftAid_MN_6M_median)/MADHHExpNFHHSoft_GiftAid_MN_6M.
COMPUTE zHHExpNFHHMaint_Purch_MN_6M = (tpcHHExpNFHHMaint_Purch_MN_6M - tpcHHExpNFHHMaint_Purch_MN_6M_median)/MADHHExpNFHHMaint_Purch_MN_6M.
COMPUTE zHHExpNFHHMaint_GiftAid_MN_6M = (tpcHHExpNFHHMaint_GiftAid_MN_6M - tpcHHExpNFHHMaint_GiftAid_MN_6M_median)/MADHHExpNFHHMaint_GiftAid_MN_6M.
EXE.

* drop temporary variables.
    SPSSINC SELECT VARIABLES MACRONAME="!trash" 
     /PROPERTIES  PATTERN = "(tpc|_median|dHHExp|MAD)" .
DELETE VARIABLES !trash.

*** Identify outliers (3 MADs from the median).
IF  (NOT(SYSMIS(HHExpFCer_Purch_MN_7D))) o_HHExpFCer_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFCer_GiftAid_MN_7D))) o_HHExpFCer_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFCer_Own_MN_7D))) o_HHExpFCer_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFTub_Purch_MN_7D))) o_HHExpFTub_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFTub_GiftAid_MN_7D))) o_HHExpFTub_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFTub_Own_MN_7D))) o_HHExpFTub_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFPuls_Purch_MN_7D))) o_HHExpFPuls_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFPuls_GiftAid_MN_7D))) o_HHExpFPuls_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFPuls_Own_MN_7D))) o_HHExpFPuls_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFVeg_Purch_MN_7D))) o_HHExpFVeg_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFVeg_GiftAid_MN_7D))) o_HHExpFVeg_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFVeg_Own_MN_7D))) o_HHExpFVeg_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFFrt_Purch_MN_7D))) o_HHExpFFrt_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFFrt_GiftAid_MN_7D))) o_HHExpFFrt_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFFrt_Own_MN_7D))) o_HHExpFFrt_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFAnimMeat_Purch_MN_7D))) o_HHExpFAnimMeat_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFAnimMeat_GiftAid_MN_7D))) o_HHExpFAnimMeat_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFAnimMeat_Own_MN_7D))) o_HHExpFAnimMeat_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFAnimFish_Purch_MN_7D))) o_HHExpFAnimFish_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFAnimFish_GiftAid_MN_7D))) o_HHExpFAnimFish_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFAnimFish_Own_MN_7D))) o_HHExpFAnimFish_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFFats_Purch_MN_7D))) o_HHExpFFats_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFFats_GiftAid_MN_7D))) o_HHExpFFats_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFFats_Own_MN_7D))) o_HHExpFFats_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFDairy_Purch_MN_7D))) o_HHExpFDairy_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFDairy_GiftAid_MN_7D))) o_HHExpFDairy_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFDairy_Own_MN_7D))) o_HHExpFDairy_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFEgg_Purch_MN_7D))) o_HHExpFEgg_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFEgg_GiftAid_MN_7D))) o_HHExpFEgg_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFEgg_Own_MN_7D))) o_HHExpFEgg_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFSgr_Purch_MN_7D))) o_HHExpFSgr_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFSgr_GiftAid_MN_7D))) o_HHExpFSgr_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFSgr_Own_MN_7D))) o_HHExpFSgr_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFCond_Purch_MN_7D))) o_HHExpFCond_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFCond_GiftAid_MN_7D))) o_HHExpFCond_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFCond_Own_MN_7D))) o_HHExpFCond_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFBev_Purch_MN_7D))) o_HHExpFBev_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFBev_GiftAid_MN_7D))) o_HHExpFBev_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFBev_Own_MN_7D))) o_HHExpFBev_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFOut_Purch_MN_7D))) o_HHExpFOut_Purch_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFOut_GiftAid_MN_7D))) o_HHExpFOut_GiftAid_MN_7D=0.
IF  (NOT(SYSMIS(HHExpFOut_Own_MN_7D))) o_HHExpFOut_Own_MN_7D=0.
IF  (NOT(SYSMIS(HHExpNFHyg_Purch_MN_1M))) o_HHExpNFHyg_Purch_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFHyg_GiftAid_MN_1M))) o_HHExpNFHyg_GiftAid_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFTransp_Purch_MN_1M))) o_HHExpNFTransp_Purch_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFTransp_GiftAid_MN_1M))) o_HHExpNFTransp_GiftAid_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFFuel_Purch_MN_1M))) o_HHExpNFFuel_Purch_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFFuel_GiftAid_MN_1M))) o_HHExpNFFuel_GiftAid_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFWat_Purch_MN_1M))) o_HHExpNFWat_Purch_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFWat_GiftAid_MN_1M))) o_HHExpNFWat_GiftAid_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFElec_Purch_MN_1M))) o_HHExpNFElec_Purch_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFElec_GiftAid_MN_1M))) o_HHExpNFElec_GiftAid_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFEnerg_Purch_MN_1M))) o_HHExpNFEnerg_Purch_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFEnerg_GiftAid_MN_1M))) o_HHExpNFEnerg_GiftAid_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFDwelSer_Purch_MN_1M))) o_HHExpNFDwelSer_Purch_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFDwelSer_GiftAid_MN_1M))) o_HHExpNFDwelSer_GiftAid_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFPhone_Purch_MN_1M))) o_HHExpNFPhone_Purch_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFPhone_GiftAid_MN_1M))) o_HHExpNFPhone_GiftAid_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFRecr_Purch_MN_1M))) o_HHExpNFRecr_Purch_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFRecr_GiftAid_MN_1M))) o_HHExpNFRecr_GiftAid_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFAlcTobac_Purch_MN_1M))) o_HHExpNFAlcTobac_Purch_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFAlcTobac_GiftAid_MN_1M))) o_HHExpNFAlcTobac_GiftAid_MN_1M=0.
IF  (NOT(SYSMIS(HHExpNFMedServ_Purch_MN_6M))) o_HHExpNFMedServ_Purch_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFMedServ_GiftAid_MN_6M))) o_HHExpNFMedServ_GiftAid_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFMedGood_Purch_MN_6M))) o_HHExpNFMedGood_Purch_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFMedGood_GiftAid_MN_6M))) o_HHExpNFMedGood_GiftAid_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFCloth_Purch_MN_6M))) o_HHExpNFCloth_Purch_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFCloth_GiftAid_MN_6M))) o_HHExpNFCloth_GiftAid_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFEduFee_Purch_MN_6M))) o_HHExpNFEduFee_Purch_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFEduFee_GiftAid_MN_6M))) o_HHExpNFEduFee_GiftAid_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFEduGood_Purch_MN_6M))) o_HHExpNFEduGood_Purch_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFEduGood_GiftAid_MN_6M))) o_HHExpNFEduGood_GiftAid_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFRent_Purch_MN_6M))) o_HHExpNFRent_Purch_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFRent_GiftAid_MN_6M))) o_HHExpNFRent_GiftAid_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFHHSoft_Purch_MN_6M))) o_HHExpNFHHSoft_Purch_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFHHSoft_GiftAid_MN_6M))) o_HHExpNFHHSoft_GiftAid_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFHHMaint_Purch_MN_6M))) o_HHExpNFHHMaint_Purch_MN_6M=0.
IF  (NOT(SYSMIS(HHExpNFHHMaint_GiftAid_MN_6M))) o_HHExpNFHHMaint_GiftAid_MN_6M=0.

DO REPEAT X =o_HHExpFCer_Purch_MN_7D TO o_HHExpNFHHMaint_GiftAid_MN_6M / Y =zHHExpFCer_Purch_MN_7D TO zHHExpNFHHMaint_GiftAid_MN_6M /*Replace with first and last var of your exp mod.
IF  (NOT(SYSMIS(Y)) AND Y>3) X=2 /* top outliers.
IF  (NOT(SYSMIS(Y)) AND Y<-3) X=1  /* bottom outliers.
END REPEAT PRINT.
EXECUTE.

* drop temporary variables.
    SPSSINC SELECT VARIABLES MACRONAME="!trash" 
     /PROPERTIES  PATTERN = "(zHHExp)" .
DELETE VARIABLES !trash.
EXECUTE.

* label outlier variables.
    SPSSINC SELECT VARIABLES MACRONAME="!list" 
     /PROPERTIES  PATTERN = "(o_HHExp)" .
VALUE LABELS
!list
0 'no out'
1 'bottom out'
2 'top out'.
EXECUTE.

* B. Treat outliers (median imputation by admin levels).

* Step 1: Set outliers to missing in the pc_ variables based on the corresponding o_ variables.
DO REPEAT X = o_HHExpFCer_Purch_MN_7D TO o_HHExpNFHHMaint_GiftAid_MN_6M /
          Y = pc_HHExpFCer_Purch_MN_7D TO pc_HHExpNFHHMaint_GiftAid_MN_6M.
  IF (X = 1 OR X = 2) Y = $sysmis.
END REPEAT.
EXECUTE.

* Step 2: Compute median for each admin level (ADMIN1, ADMIN2, etc.).
* First for ADMIN1 level.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=ADMIN1Name 
  /m1_pc_HHExpFCer_Purch_MN_7D=MEDIAN(pc_HHExpFCer_Purch_MN_7D) 
  /m1_pc_HHExpFCer_GiftAid_MN_7D=MEDIAN(pc_HHExpFCer_GiftAid_MN_7D) 
  /m1_pc_HHExpFCer_Own_MN_7D=MEDIAN(pc_HHExpFCer_Own_MN_7D) 
  /m1_pc_HHExpFTub_Purch_MN_7D=MEDIAN(pc_HHExpFTub_Purch_MN_7D) 
  /m1_pc_HHExpFTub_GiftAid_MN_7D=MEDIAN(pc_HHExpFTub_GiftAid_MN_7D) 
  /m1_pc_HHExpFTub_Own_MN_7D=MEDIAN(pc_HHExpFTub_Own_MN_7D) 
  /m1_pc_HHExpFPuls_Purch_MN_7D=MEDIAN(pc_HHExpFPuls_Purch_MN_7D) 
  /m1_pc_HHExpFPuls_GiftAid_MN_7D=MEDIAN(pc_HHExpFPuls_GiftAid_MN_7D) 
  /m1_pc_HHExpFPuls_Own_MN_7D=MEDIAN(pc_HHExpFPuls_Own_MN_7D) 
  /m1_pc_HHExpFVeg_Purch_MN_7D=MEDIAN(pc_HHExpFVeg_Purch_MN_7D) 
  /m1_pc_HHExpFVeg_GiftAid_MN_7D=MEDIAN(pc_HHExpFVeg_GiftAid_MN_7D) 
  /m1_pc_HHExpFVeg_Own_MN_7D=MEDIAN(pc_HHExpFVeg_Own_MN_7D) 
  /m1_pc_HHExpFFrt_Purch_MN_7D=MEDIAN(pc_HHExpFFrt_Purch_MN_7D) 
  /m1_pc_HHExpFFrt_GiftAid_MN_7D=MEDIAN(pc_HHExpFFrt_GiftAid_MN_7D) 
  /m1_pc_HHExpFFrt_Own_MN_7D=MEDIAN(pc_HHExpFFrt_Own_MN_7D) 
  /m1_pc_HHExpFAnimMeat_Purch_MN_7D=MEDIAN(pc_HHExpFAnimMeat_Purch_MN_7D) 
  /m1_pc_HHExpFAnimMeat_GiftAid_MN_7D=MEDIAN(pc_HHExpFAnimMeat_GiftAid_MN_7D) 
  /m1_pc_HHExpFAnimMeat_Own_MN_7D=MEDIAN(pc_HHExpFAnimMeat_Own_MN_7D) 
  /m1_pc_HHExpFAnimFish_Purch_MN_7D=MEDIAN(pc_HHExpFAnimFish_Purch_MN_7D) 
  /m1_pc_HHExpFAnimFish_GiftAid_MN_7D=MEDIAN(pc_HHExpFAnimFish_GiftAid_MN_7D) 
  /m1_pc_HHExpFAnimFish_Own_MN_7D=MEDIAN(pc_HHExpFAnimFish_Own_MN_7D) 
  /m1_pc_HHExpFFats_Purch_MN_7D=MEDIAN(pc_HHExpFFats_Purch_MN_7D) 
  /m1_pc_HHExpFFats_GiftAid_MN_7D=MEDIAN(pc_HHExpFFats_GiftAid_MN_7D) 
  /m1_pc_HHExpFFats_Own_MN_7D=MEDIAN(pc_HHExpFFats_Own_MN_7D) 
  /m1_pc_HHExpFDairy_Purch_MN_7D=MEDIAN(pc_HHExpFDairy_Purch_MN_7D) 
  /m1_pc_HHExpFDairy_GiftAid_MN_7D=MEDIAN(pc_HHExpFDairy_GiftAid_MN_7D) 
  /m1_pc_HHExpFDairy_Own_MN_7D=MEDIAN(pc_HHExpFDairy_Own_MN_7D) 
  /m1_pc_HHExpFEgg_Purch_MN_7D=MEDIAN(pc_HHExpFEgg_Purch_MN_7D) 
  /m1_pc_HHExpFEgg_GiftAid_MN_7D=MEDIAN(pc_HHExpFEgg_GiftAid_MN_7D) 
  /m1_pc_HHExpFEgg_Own_MN_7D=MEDIAN(pc_HHExpFEgg_Own_MN_7D) 
  /m1_pc_HHExpFSgr_Purch_MN_7D=MEDIAN(pc_HHExpFSgr_Purch_MN_7D) 
  /m1_pc_HHExpFSgr_GiftAid_MN_7D=MEDIAN(pc_HHExpFSgr_GiftAid_MN_7D) 
  /m1_pc_HHExpFSgr_Own_MN_7D=MEDIAN(pc_HHExpFSgr_Own_MN_7D) 
  /m1_pc_HHExpFCond_Purch_MN_7D=MEDIAN(pc_HHExpFCond_Purch_MN_7D) 
  /m1_pc_HHExpFCond_GiftAid_MN_7D=MEDIAN(pc_HHExpFCond_GiftAid_MN_7D) 
  /m1_pc_HHExpFCond_Own_MN_7D=MEDIAN(pc_HHExpFCond_Own_MN_7D) 
  /m1_pc_HHExpFBev_Purch_MN_7D=MEDIAN(pc_HHExpFBev_Purch_MN_7D) 
  /m1_pc_HHExpFBev_GiftAid_MN_7D=MEDIAN(pc_HHExpFBev_GiftAid_MN_7D) 
  /m1_pc_HHExpFBev_Own_MN_7D=MEDIAN(pc_HHExpFBev_Own_MN_7D) 
  /m1_pc_HHExpFOut_Purch_MN_7D=MEDIAN(pc_HHExpFOut_Purch_MN_7D) 
  /m1_pc_HHExpFOut_GiftAid_MN_7D=MEDIAN(pc_HHExpFOut_GiftAid_MN_7D) 
  /m1_pc_HHExpFOut_Own_MN_7D=MEDIAN(pc_HHExpFOut_Own_MN_7D) 
  /m1_pc_HHExpNFHyg_Purch_MN_1M=MEDIAN(pc_HHExpNFHyg_Purch_MN_1M) 
  /m1_pc_HHExpNFHyg_GiftAid_MN_1M=MEDIAN(pc_HHExpNFHyg_GiftAid_MN_1M) 
  /m1_pc_HHExpNFTransp_Purch_MN_1M=MEDIAN(pc_HHExpNFTransp_Purch_MN_1M) 
  /m1_pc_HHExpNFTransp_GiftAid_MN_1M=MEDIAN(pc_HHExpNFTransp_GiftAid_MN_1M) 
  /m1_pc_HHExpNFFuel_Purch_MN_1M=MEDIAN(pc_HHExpNFFuel_Purch_MN_1M) 
  /m1_pc_HHExpNFFuel_GiftAid_MN_1M=MEDIAN(pc_HHExpNFFuel_GiftAid_MN_1M) 
  /m1_pc_HHExpNFWat_Purch_MN_1M=MEDIAN(pc_HHExpNFWat_Purch_MN_1M) 
  /m1_pc_HHExpNFWat_GiftAid_MN_1M=MEDIAN(pc_HHExpNFWat_GiftAid_MN_1M) 
  /m1_pc_HHExpNFElec_Purch_MN_1M=MEDIAN(pc_HHExpNFElec_Purch_MN_1M) 
  /m1_pc_HHExpNFElec_GiftAid_MN_1M=MEDIAN(pc_HHExpNFElec_GiftAid_MN_1M) 
  /m1_pc_HHExpNFEnerg_Purch_MN_1M=MEDIAN(pc_HHExpNFEnerg_Purch_MN_1M) 
  /m1_pc_HHExpNFEnerg_GiftAid_MN_1M=MEDIAN(pc_HHExpNFEnerg_GiftAid_MN_1M) 
  /m1_pc_HHExpNFDwelSer_Purch_MN_1M=MEDIAN(pc_HHExpNFDwelSer_Purch_MN_1M) 
  /m1_pc_HHExpNFDwelSer_GiftAid_MN_1M=MEDIAN(pc_HHExpNFDwelSer_GiftAid_MN_1M) 
  /m1_pc_HHExpNFPhone_Purch_MN_1M=MEDIAN(pc_HHExpNFPhone_Purch_MN_1M) 
  /m1_pc_HHExpNFPhone_GiftAid_MN_1M=MEDIAN(pc_HHExpNFPhone_GiftAid_MN_1M) 
  /m1_pc_HHExpNFRecr_Purch_MN_1M=MEDIAN(pc_HHExpNFRecr_Purch_MN_1M) 
  /m1_pc_HHExpNFRecr_GiftAid_MN_1M=MEDIAN(pc_HHExpNFRecr_GiftAid_MN_1M) 
  /m1_pc_HHExpNFAlcTobac_Purch_MN_1M=MEDIAN(pc_HHExpNFAlcTobac_Purch_MN_1M) 
  /m1_pc_HHExpNFAlcTobac_GiftAid_MN_1M=MEDIAN(pc_HHExpNFAlcTobac_GiftAid_MN_1M) 
  /m1_pc_HHExpNFMedServ_Purch_MN_6M=MEDIAN(pc_HHExpNFMedServ_Purch_MN_6M) 
  /m1_pc_HHExpNFMedServ_GiftAid_MN_6M=MEDIAN(pc_HHExpNFMedServ_GiftAid_MN_6M) 
  /m1_pc_HHExpNFMedGood_Purch_MN_6M=MEDIAN(pc_HHExpNFMedGood_Purch_MN_6M) 
  /m1_pc_HHExpNFMedGood_GiftAid_MN_6M=MEDIAN(pc_HHExpNFMedGood_GiftAid_MN_6M) 
  /m1_pc_HHExpNFCloth_Purch_MN_6M=MEDIAN(pc_HHExpNFCloth_Purch_MN_6M) 
  /m1_pc_HHExpNFCloth_GiftAid_MN_6M=MEDIAN(pc_HHExpNFCloth_GiftAid_MN_6M) 
  /m1_pc_HHExpNFEduFee_Purch_MN_6M=MEDIAN(pc_HHExpNFEduFee_Purch_MN_6M) 
  /m1_pc_HHExpNFEduFee_GiftAid_MN_6M=MEDIAN(pc_HHExpNFEduFee_GiftAid_MN_6M) 
  /m1_pc_HHExpNFEduGood_Purch_MN_6M=MEDIAN(pc_HHExpNFEduGood_Purch_MN_6M) 
  /m1_pc_HHExpNFEduGood_GiftAid_MN_6M=MEDIAN(pc_HHExpNFEduGood_GiftAid_MN_6M) 
  /m1_pc_HHExpNFRent_Purch_MN_6M=MEDIAN(pc_HHExpNFRent_Purch_MN_6M) 
  /m1_pc_HHExpNFRent_GiftAid_MN_6M=MEDIAN(pc_HHExpNFRent_GiftAid_MN_6M) 
  /m1_pc_HHExpNFHHSoft_Purch_MN_6M=MEDIAN(pc_HHExpNFHHSoft_Purch_MN_6M) 
  /m1_pc_HHExpNFHHSoft_GiftAid_MN_6M=MEDIAN(pc_HHExpNFHHSoft_GiftAid_MN_6M) 
  /m1_pc_HHExpNFHHMaint_Purch_MN_6M=MEDIAN(pc_HHExpNFHHMaint_Purch_MN_6M) 
  /m1_pc_HHExpNFHHMaint_GiftAid_MN_6M=MEDIAN(pc_HHExpNFHHMaint_GiftAid_MN_6M)
  /n1_pc_HHExpFCer_Purch_MN_7D=N(pc_HHExpFCer_Purch_MN_7D) 
  /n1_pc_HHExpFCer_GiftAid_MN_7D=N(pc_HHExpFCer_GiftAid_MN_7D) 
  /n1_pc_HHExpFCer_Own_MN_7D=N(pc_HHExpFCer_Own_MN_7D) 
  /n1_pc_HHExpFTub_Purch_MN_7D=N(pc_HHExpFTub_Purch_MN_7D) 
  /n1_pc_HHExpFTub_GiftAid_MN_7D=N(pc_HHExpFTub_GiftAid_MN_7D) 
  /n1_pc_HHExpFTub_Own_MN_7D=N(pc_HHExpFTub_Own_MN_7D) 
  /n1_pc_HHExpFPuls_Purch_MN_7D=N(pc_HHExpFPuls_Purch_MN_7D) 
  /n1_pc_HHExpFPuls_GiftAid_MN_7D=N(pc_HHExpFPuls_GiftAid_MN_7D) 
  /n1_pc_HHExpFPuls_Own_MN_7D=N(pc_HHExpFPuls_Own_MN_7D) 
  /n1_pc_HHExpFVeg_Purch_MN_7D=N(pc_HHExpFVeg_Purch_MN_7D) 
  /n1_pc_HHExpFVeg_GiftAid_MN_7D=N(pc_HHExpFVeg_GiftAid_MN_7D) 
  /n1_pc_HHExpFVeg_Own_MN_7D=N(pc_HHExpFVeg_Own_MN_7D) 
  /n1_pc_HHExpFFrt_Purch_MN_7D=N(pc_HHExpFFrt_Purch_MN_7D) 
  /n1_pc_HHExpFFrt_GiftAid_MN_7D=N(pc_HHExpFFrt_GiftAid_MN_7D) 
  /n1_pc_HHExpFFrt_Own_MN_7D=N(pc_HHExpFFrt_Own_MN_7D) 
  /n1_pc_HHExpFAnimMeat_Purch_MN_7D=N(pc_HHExpFAnimMeat_Purch_MN_7D) 
  /n1_pc_HHExpFAnimMeat_GiftAid_MN_7D=N(pc_HHExpFAnimMeat_GiftAid_MN_7D) 
  /n1_pc_HHExpFAnimMeat_Own_MN_7D=N(pc_HHExpFAnimMeat_Own_MN_7D) 
  /n1_pc_HHExpFAnimFish_Purch_MN_7D=N(pc_HHExpFAnimFish_Purch_MN_7D) 
  /n1_pc_HHExpFAnimFish_GiftAid_MN_7D=N(pc_HHExpFAnimFish_GiftAid_MN_7D) 
  /n1_pc_HHExpFAnimFish_Own_MN_7D=N(pc_HHExpFAnimFish_Own_MN_7D) 
  /n1_pc_HHExpFFats_Purch_MN_7D=N(pc_HHExpFFats_Purch_MN_7D) 
  /n1_pc_HHExpFFats_GiftAid_MN_7D=N(pc_HHExpFFats_GiftAid_MN_7D) 
  /n1_pc_HHExpFFats_Own_MN_7D=N(pc_HHExpFFats_Own_MN_7D) 
  /n1_pc_HHExpFDairy_Purch_MN_7D=N(pc_HHExpFDairy_Purch_MN_7D) 
  /n1_pc_HHExpFDairy_GiftAid_MN_7D=N(pc_HHExpFDairy_GiftAid_MN_7D) 
  /n1_pc_HHExpFDairy_Own_MN_7D=N(pc_HHExpFDairy_Own_MN_7D) 
  /n1_pc_HHExpFEgg_Purch_MN_7D=N(pc_HHExpFEgg_Purch_MN_7D) 
  /n1_pc_HHExpFEgg_GiftAid_MN_7D=N(pc_HHExpFEgg_GiftAid_MN_7D) 
  /n1_pc_HHExpFEgg_Own_MN_7D=N(pc_HHExpFEgg_Own_MN_7D) 
  /n1_pc_HHExpFSgr_Purch_MN_7D=N(pc_HHExpFSgr_Purch_MN_7D) 
  /n1_pc_HHExpFSgr_GiftAid_MN_7D=N(pc_HHExpFSgr_GiftAid_MN_7D) 
  /n1_pc_HHExpFSgr_Own_MN_7D=N(pc_HHExpFSgr_Own_MN_7D) 
  /n1_pc_HHExpFCond_Purch_MN_7D=N(pc_HHExpFCond_Purch_MN_7D) 
  /n1_pc_HHExpFCond_GiftAid_MN_7D=N(pc_HHExpFCond_GiftAid_MN_7D) 
  /n1_pc_HHExpFCond_Own_MN_7D=N(pc_HHExpFCond_Own_MN_7D) 
  /n1_pc_HHExpFBev_Purch_MN_7D=N(pc_HHExpFBev_Purch_MN_7D) 
  /n1_pc_HHExpFBev_GiftAid_MN_7D=N(pc_HHExpFBev_GiftAid_MN_7D) 
  /n1_pc_HHExpFBev_Own_MN_7D=N(pc_HHExpFBev_Own_MN_7D) 
  /n1_pc_HHExpFOut_Purch_MN_7D=N(pc_HHExpFOut_Purch_MN_7D) 
  /n1_pc_HHExpFOut_GiftAid_MN_7D=N(pc_HHExpFOut_GiftAid_MN_7D) 
  /n1_pc_HHExpFOut_Own_MN_7D=N(pc_HHExpFOut_Own_MN_7D) 
  /n1_pc_HHExpNFHyg_Purch_MN_1M=N(pc_HHExpNFHyg_Purch_MN_1M) 
  /n1_pc_HHExpNFHyg_GiftAid_MN_1M=N(pc_HHExpNFHyg_GiftAid_MN_1M) 
  /n1_pc_HHExpNFTransp_Purch_MN_1M=N(pc_HHExpNFTransp_Purch_MN_1M) 
  /n1_pc_HHExpNFTransp_GiftAid_MN_1M=N(pc_HHExpNFTransp_GiftAid_MN_1M) 
  /n1_pc_HHExpNFFuel_Purch_MN_1M=N(pc_HHExpNFFuel_Purch_MN_1M) 
  /n1_pc_HHExpNFFuel_GiftAid_MN_1M=N(pc_HHExpNFFuel_GiftAid_MN_1M) 
  /n1_pc_HHExpNFWat_Purch_MN_1M=N(pc_HHExpNFWat_Purch_MN_1M) 
  /n1_pc_HHExpNFWat_GiftAid_MN_1M=N(pc_HHExpNFWat_GiftAid_MN_1M) 
  /n1_pc_HHExpNFElec_Purch_MN_1M=N(pc_HHExpNFElec_Purch_MN_1M) 
  /n1_pc_HHExpNFElec_GiftAid_MN_1M=N(pc_HHExpNFElec_GiftAid_MN_1M) 
  /n1_pc_HHExpNFEnerg_Purch_MN_1M=N(pc_HHExpNFEnerg_Purch_MN_1M) 
  /n1_pc_HHExpNFEnerg_GiftAid_MN_1M=N(pc_HHExpNFEnerg_GiftAid_MN_1M) 
  /n1_pc_HHExpNFDwelSer_Purch_MN_1M=N(pc_HHExpNFDwelSer_Purch_MN_1M) 
  /n1_pc_HHExpNFDwelSer_GiftAid_MN_1M=N(pc_HHExpNFDwelSer_GiftAid_MN_1M) 
  /n1_pc_HHExpNFPhone_Purch_MN_1M=N(pc_HHExpNFPhone_Purch_MN_1M) 
  /n1_pc_HHExpNFPhone_GiftAid_MN_1M=N(pc_HHExpNFPhone_GiftAid_MN_1M) 
  /n1_pc_HHExpNFRecr_Purch_MN_1M=N(pc_HHExpNFRecr_Purch_MN_1M) 
  /n1_pc_HHExpNFRecr_GiftAid_MN_1M=N(pc_HHExpNFRecr_GiftAid_MN_1M) 
  /n1_pc_HHExpNFAlcTobac_Purch_MN_1M=N(pc_HHExpNFAlcTobac_Purch_MN_1M) 
  /n1_pc_HHExpNFAlcTobac_GiftAid_MN_1M=N(pc_HHExpNFAlcTobac_GiftAid_MN_1M) 
  /n1_pc_HHExpNFMedServ_Purch_MN_6M=N(pc_HHExpNFMedServ_Purch_MN_6M) 
  /n1_pc_HHExpNFMedServ_GiftAid_MN_6M=N(pc_HHExpNFMedServ_GiftAid_MN_6M) 
  /n1_pc_HHExpNFMedGood_Purch_MN_6M=N(pc_HHExpNFMedGood_Purch_MN_6M) 
  /n1_pc_HHExpNFMedGood_GiftAid_MN_6M=N(pc_HHExpNFMedGood_GiftAid_MN_6M) 
  /n1_pc_HHExpNFCloth_Purch_MN_6M=N(pc_HHExpNFCloth_Purch_MN_6M) 
  /n1_pc_HHExpNFCloth_GiftAid_MN_6M=N(pc_HHExpNFCloth_GiftAid_MN_6M) 
  /n1_pc_HHExpNFEduFee_Purch_MN_6M=N(pc_HHExpNFEduFee_Purch_MN_6M) 
  /n1_pc_HHExpNFEduFee_GiftAid_MN_6M=N(pc_HHExpNFEduFee_GiftAid_MN_6M) 
  /n1_pc_HHExpNFEduGood_Purch_MN_6M=N(pc_HHExpNFEduGood_Purch_MN_6M) 
  /n1_pc_HHExpNFEduGood_GiftAid_MN_6M=N(pc_HHExpNFEduGood_GiftAid_MN_6M) 
  /n1_pc_HHExpNFRent_Purch_MN_6M=N(pc_HHExpNFRent_Purch_MN_6M) 
  /n1_pc_HHExpNFRent_GiftAid_MN_6M=N(pc_HHExpNFRent_GiftAid_MN_6M) 
  /n1_pc_HHExpNFHHSoft_Purch_MN_6M=N(pc_HHExpNFHHSoft_Purch_MN_6M) 
  /n1_pc_HHExpNFHHSoft_GiftAid_MN_6M=N(pc_HHExpNFHHSoft_GiftAid_MN_6M) 
  /n1_pc_HHExpNFHHMaint_Purch_MN_6M=N(pc_HHExpNFHHMaint_Purch_MN_6M) 
  /n1_pc_HHExpNFHHMaint_GiftAid_MN_6M=N(pc_HHExpNFHHMaint_GiftAid_MN_6M).

* Then for ADMIN2 level.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=ADMIN1Name
    /m2_pc_HHExpFCer_Purch_MN_7D=MEDIAN(pc_HHExpFCer_Purch_MN_7D) 
  /m2_pc_HHExpFCer_GiftAid_MN_7D=MEDIAN(pc_HHExpFCer_GiftAid_MN_7D) 
  /m2_pc_HHExpFCer_Own_MN_7D=MEDIAN(pc_HHExpFCer_Own_MN_7D) 
  /m2_pc_HHExpFTub_Purch_MN_7D=MEDIAN(pc_HHExpFTub_Purch_MN_7D) 
  /m2_pc_HHExpFTub_GiftAid_MN_7D=MEDIAN(pc_HHExpFTub_GiftAid_MN_7D) 
  /m2_pc_HHExpFTub_Own_MN_7D=MEDIAN(pc_HHExpFTub_Own_MN_7D) 
  /m2_pc_HHExpFPuls_Purch_MN_7D=MEDIAN(pc_HHExpFPuls_Purch_MN_7D) 
  /m2_pc_HHExpFPuls_GiftAid_MN_7D=MEDIAN(pc_HHExpFPuls_GiftAid_MN_7D) 
  /m2_pc_HHExpFPuls_Own_MN_7D=MEDIAN(pc_HHExpFPuls_Own_MN_7D) 
  /m2_pc_HHExpFVeg_Purch_MN_7D=MEDIAN(pc_HHExpFVeg_Purch_MN_7D) 
  /m2_pc_HHExpFVeg_GiftAid_MN_7D=MEDIAN(pc_HHExpFVeg_GiftAid_MN_7D) 
  /m2_pc_HHExpFVeg_Own_MN_7D=MEDIAN(pc_HHExpFVeg_Own_MN_7D) 
  /m2_pc_HHExpFFrt_Purch_MN_7D=MEDIAN(pc_HHExpFFrt_Purch_MN_7D) 
  /m2_pc_HHExpFFrt_GiftAid_MN_7D=MEDIAN(pc_HHExpFFrt_GiftAid_MN_7D) 
  /m2_pc_HHExpFFrt_Own_MN_7D=MEDIAN(pc_HHExpFFrt_Own_MN_7D) 
  /m2_pc_HHExpFAnimMeat_Purch_MN_7D=MEDIAN(pc_HHExpFAnimMeat_Purch_MN_7D) 
  /m2_pc_HHExpFAnimMeat_GiftAid_MN_7D=MEDIAN(pc_HHExpFAnimMeat_GiftAid_MN_7D) 
  /m2_pc_HHExpFAnimMeat_Own_MN_7D=MEDIAN(pc_HHExpFAnimMeat_Own_MN_7D) 
  /m2_pc_HHExpFAnimFish_Purch_MN_7D=MEDIAN(pc_HHExpFAnimFish_Purch_MN_7D) 
  /m2_pc_HHExpFAnimFish_GiftAid_MN_7D=MEDIAN(pc_HHExpFAnimFish_GiftAid_MN_7D) 
  /m2_pc_HHExpFAnimFish_Own_MN_7D=MEDIAN(pc_HHExpFAnimFish_Own_MN_7D) 
  /m2_pc_HHExpFFats_Purch_MN_7D=MEDIAN(pc_HHExpFFats_Purch_MN_7D) 
  /m2_pc_HHExpFFats_GiftAid_MN_7D=MEDIAN(pc_HHExpFFats_GiftAid_MN_7D) 
  /m2_pc_HHExpFFats_Own_MN_7D=MEDIAN(pc_HHExpFFats_Own_MN_7D) 
  /m2_pc_HHExpFDairy_Purch_MN_7D=MEDIAN(pc_HHExpFDairy_Purch_MN_7D) 
  /m2_pc_HHExpFDairy_GiftAid_MN_7D=MEDIAN(pc_HHExpFDairy_GiftAid_MN_7D) 
  /m2_pc_HHExpFDairy_Own_MN_7D=MEDIAN(pc_HHExpFDairy_Own_MN_7D) 
  /m2_pc_HHExpFEgg_Purch_MN_7D=MEDIAN(pc_HHExpFEgg_Purch_MN_7D) 
  /m2_pc_HHExpFEgg_GiftAid_MN_7D=MEDIAN(pc_HHExpFEgg_GiftAid_MN_7D) 
  /m2_pc_HHExpFEgg_Own_MN_7D=MEDIAN(pc_HHExpFEgg_Own_MN_7D) 
  /m2_pc_HHExpFSgr_Purch_MN_7D=MEDIAN(pc_HHExpFSgr_Purch_MN_7D) 
  /m2_pc_HHExpFSgr_GiftAid_MN_7D=MEDIAN(pc_HHExpFSgr_GiftAid_MN_7D) 
  /m2_pc_HHExpFSgr_Own_MN_7D=MEDIAN(pc_HHExpFSgr_Own_MN_7D) 
  /m2_pc_HHExpFCond_Purch_MN_7D=MEDIAN(pc_HHExpFCond_Purch_MN_7D) 
  /m2_pc_HHExpFCond_GiftAid_MN_7D=MEDIAN(pc_HHExpFCond_GiftAid_MN_7D) 
  /m2_pc_HHExpFCond_Own_MN_7D=MEDIAN(pc_HHExpFCond_Own_MN_7D) 
  /m2_pc_HHExpFBev_Purch_MN_7D=MEDIAN(pc_HHExpFBev_Purch_MN_7D) 
  /m2_pc_HHExpFBev_GiftAid_MN_7D=MEDIAN(pc_HHExpFBev_GiftAid_MN_7D) 
  /m2_pc_HHExpFBev_Own_MN_7D=MEDIAN(pc_HHExpFBev_Own_MN_7D) 
  /m2_pc_HHExpFOut_Purch_MN_7D=MEDIAN(pc_HHExpFOut_Purch_MN_7D) 
  /m2_pc_HHExpFOut_GiftAid_MN_7D=MEDIAN(pc_HHExpFOut_GiftAid_MN_7D) 
  /m2_pc_HHExpFOut_Own_MN_7D=MEDIAN(pc_HHExpFOut_Own_MN_7D) 
  /m2_pc_HHExpNFHyg_Purch_MN_1M=MEDIAN(pc_HHExpNFHyg_Purch_MN_1M) 
  /m2_pc_HHExpNFHyg_GiftAid_MN_1M=MEDIAN(pc_HHExpNFHyg_GiftAid_MN_1M) 
  /m2_pc_HHExpNFTransp_Purch_MN_1M=MEDIAN(pc_HHExpNFTransp_Purch_MN_1M) 
  /m2_pc_HHExpNFTransp_GiftAid_MN_1M=MEDIAN(pc_HHExpNFTransp_GiftAid_MN_1M) 
  /m2_pc_HHExpNFFuel_Purch_MN_1M=MEDIAN(pc_HHExpNFFuel_Purch_MN_1M) 
  /m2_pc_HHExpNFFuel_GiftAid_MN_1M=MEDIAN(pc_HHExpNFFuel_GiftAid_MN_1M) 
  /m2_pc_HHExpNFWat_Purch_MN_1M=MEDIAN(pc_HHExpNFWat_Purch_MN_1M) 
  /m2_pc_HHExpNFWat_GiftAid_MN_1M=MEDIAN(pc_HHExpNFWat_GiftAid_MN_1M) 
  /m2_pc_HHExpNFElec_Purch_MN_1M=MEDIAN(pc_HHExpNFElec_Purch_MN_1M) 
  /m2_pc_HHExpNFElec_GiftAid_MN_1M=MEDIAN(pc_HHExpNFElec_GiftAid_MN_1M) 
  /m2_pc_HHExpNFEnerg_Purch_MN_1M=MEDIAN(pc_HHExpNFEnerg_Purch_MN_1M) 
  /m2_pc_HHExpNFEnerg_GiftAid_MN_1M=MEDIAN(pc_HHExpNFEnerg_GiftAid_MN_1M) 
  /m2_pc_HHExpNFDwelSer_Purch_MN_1M=MEDIAN(pc_HHExpNFDwelSer_Purch_MN_1M) 
  /m2_pc_HHExpNFDwelSer_GiftAid_MN_1M=MEDIAN(pc_HHExpNFDwelSer_GiftAid_MN_1M) 
  /m2_pc_HHExpNFPhone_Purch_MN_1M=MEDIAN(pc_HHExpNFPhone_Purch_MN_1M) 
  /m2_pc_HHExpNFPhone_GiftAid_MN_1M=MEDIAN(pc_HHExpNFPhone_GiftAid_MN_1M) 
  /m2_pc_HHExpNFRecr_Purch_MN_1M=MEDIAN(pc_HHExpNFRecr_Purch_MN_1M) 
  /m2_pc_HHExpNFRecr_GiftAid_MN_1M=MEDIAN(pc_HHExpNFRecr_GiftAid_MN_1M) 
  /m2_pc_HHExpNFAlcTobac_Purch_MN_1M=MEDIAN(pc_HHExpNFAlcTobac_Purch_MN_1M) 
  /m2_pc_HHExpNFAlcTobac_GiftAid_MN_1M=MEDIAN(pc_HHExpNFAlcTobac_GiftAid_MN_1M) 
  /m2_pc_HHExpNFMedServ_Purch_MN_6M=MEDIAN(pc_HHExpNFMedServ_Purch_MN_6M) 
  /m2_pc_HHExpNFMedServ_GiftAid_MN_6M=MEDIAN(pc_HHExpNFMedServ_GiftAid_MN_6M) 
  /m2_pc_HHExpNFMedGood_Purch_MN_6M=MEDIAN(pc_HHExpNFMedGood_Purch_MN_6M) 
  /m2_pc_HHExpNFMedGood_GiftAid_MN_6M=MEDIAN(pc_HHExpNFMedGood_GiftAid_MN_6M) 
  /m2_pc_HHExpNFCloth_Purch_MN_6M=MEDIAN(pc_HHExpNFCloth_Purch_MN_6M) 
  /m2_pc_HHExpNFCloth_GiftAid_MN_6M=MEDIAN(pc_HHExpNFCloth_GiftAid_MN_6M) 
  /m2_pc_HHExpNFEduFee_Purch_MN_6M=MEDIAN(pc_HHExpNFEduFee_Purch_MN_6M) 
  /m2_pc_HHExpNFEduFee_GiftAid_MN_6M=MEDIAN(pc_HHExpNFEduFee_GiftAid_MN_6M) 
  /m2_pc_HHExpNFEduGood_Purch_MN_6M=MEDIAN(pc_HHExpNFEduGood_Purch_MN_6M) 
  /m2_pc_HHExpNFEduGood_GiftAid_MN_6M=MEDIAN(pc_HHExpNFEduGood_GiftAid_MN_6M) 
  /m2_pc_HHExpNFRent_Purch_MN_6M=MEDIAN(pc_HHExpNFRent_Purch_MN_6M) 
  /m2_pc_HHExpNFRent_GiftAid_MN_6M=MEDIAN(pc_HHExpNFRent_GiftAid_MN_6M) 
  /m2_pc_HHExpNFHHSoft_Purch_MN_6M=MEDIAN(pc_HHExpNFHHSoft_Purch_MN_6M) 
  /m2_pc_HHExpNFHHSoft_GiftAid_MN_6M=MEDIAN(pc_HHExpNFHHSoft_GiftAid_MN_6M) 
  /m2_pc_HHExpNFHHMaint_Purch_MN_6M=MEDIAN(pc_HHExpNFHHMaint_Purch_MN_6M) 
  /m2_pc_HHExpNFHHMaint_GiftAid_MN_6M=MEDIAN(pc_HHExpNFHHMaint_GiftAid_MN_6M)
  /n2_pc_HHExpFCer_Purch_MN_7D=N(pc_HHExpFCer_Purch_MN_7D) 
  /n2_pc_HHExpFCer_GiftAid_MN_7D=N(pc_HHExpFCer_GiftAid_MN_7D) 
  /n2_pc_HHExpFCer_Own_MN_7D=N(pc_HHExpFCer_Own_MN_7D) 
  /n2_pc_HHExpFTub_Purch_MN_7D=N(pc_HHExpFTub_Purch_MN_7D) 
  /n2_pc_HHExpFTub_GiftAid_MN_7D=N(pc_HHExpFTub_GiftAid_MN_7D) 
  /n2_pc_HHExpFTub_Own_MN_7D=N(pc_HHExpFTub_Own_MN_7D) 
  /n2_pc_HHExpFPuls_Purch_MN_7D=N(pc_HHExpFPuls_Purch_MN_7D) 
  /n2_pc_HHExpFPuls_GiftAid_MN_7D=N(pc_HHExpFPuls_GiftAid_MN_7D) 
  /n2_pc_HHExpFPuls_Own_MN_7D=N(pc_HHExpFPuls_Own_MN_7D) 
  /n2_pc_HHExpFVeg_Purch_MN_7D=N(pc_HHExpFVeg_Purch_MN_7D) 
  /n2_pc_HHExpFVeg_GiftAid_MN_7D=N(pc_HHExpFVeg_GiftAid_MN_7D) 
  /n2_pc_HHExpFVeg_Own_MN_7D=N(pc_HHExpFVeg_Own_MN_7D) 
  /n2_pc_HHExpFFrt_Purch_MN_7D=N(pc_HHExpFFrt_Purch_MN_7D) 
  /n2_pc_HHExpFFrt_GiftAid_MN_7D=N(pc_HHExpFFrt_GiftAid_MN_7D) 
  /n2_pc_HHExpFFrt_Own_MN_7D=N(pc_HHExpFFrt_Own_MN_7D) 
  /n2_pc_HHExpFAnimMeat_Purch_MN_7D=N(pc_HHExpFAnimMeat_Purch_MN_7D) 
  /n2_pc_HHExpFAnimMeat_GiftAid_MN_7D=N(pc_HHExpFAnimMeat_GiftAid_MN_7D) 
  /n2_pc_HHExpFAnimMeat_Own_MN_7D=N(pc_HHExpFAnimMeat_Own_MN_7D) 
  /n2_pc_HHExpFAnimFish_Purch_MN_7D=N(pc_HHExpFAnimFish_Purch_MN_7D) 
  /n2_pc_HHExpFAnimFish_GiftAid_MN_7D=N(pc_HHExpFAnimFish_GiftAid_MN_7D) 
  /n2_pc_HHExpFAnimFish_Own_MN_7D=N(pc_HHExpFAnimFish_Own_MN_7D) 
  /n2_pc_HHExpFFats_Purch_MN_7D=N(pc_HHExpFFats_Purch_MN_7D) 
  /n2_pc_HHExpFFats_GiftAid_MN_7D=N(pc_HHExpFFats_GiftAid_MN_7D) 
  /n2_pc_HHExpFFats_Own_MN_7D=N(pc_HHExpFFats_Own_MN_7D) 
  /n2_pc_HHExpFDairy_Purch_MN_7D=N(pc_HHExpFDairy_Purch_MN_7D) 
  /n2_pc_HHExpFDairy_GiftAid_MN_7D=N(pc_HHExpFDairy_GiftAid_MN_7D) 
  /n2_pc_HHExpFDairy_Own_MN_7D=N(pc_HHExpFDairy_Own_MN_7D) 
  /n2_pc_HHExpFEgg_Purch_MN_7D=N(pc_HHExpFEgg_Purch_MN_7D) 
  /n2_pc_HHExpFEgg_GiftAid_MN_7D=N(pc_HHExpFEgg_GiftAid_MN_7D) 
  /n2_pc_HHExpFEgg_Own_MN_7D=N(pc_HHExpFEgg_Own_MN_7D) 
  /n2_pc_HHExpFSgr_Purch_MN_7D=N(pc_HHExpFSgr_Purch_MN_7D) 
  /n2_pc_HHExpFSgr_GiftAid_MN_7D=N(pc_HHExpFSgr_GiftAid_MN_7D) 
  /n2_pc_HHExpFSgr_Own_MN_7D=N(pc_HHExpFSgr_Own_MN_7D) 
  /n2_pc_HHExpFCond_Purch_MN_7D=N(pc_HHExpFCond_Purch_MN_7D) 
  /n2_pc_HHExpFCond_GiftAid_MN_7D=N(pc_HHExpFCond_GiftAid_MN_7D) 
  /n2_pc_HHExpFCond_Own_MN_7D=N(pc_HHExpFCond_Own_MN_7D) 
  /n2_pc_HHExpFBev_Purch_MN_7D=N(pc_HHExpFBev_Purch_MN_7D) 
  /n2_pc_HHExpFBev_GiftAid_MN_7D=N(pc_HHExpFBev_GiftAid_MN_7D) 
  /n2_pc_HHExpFBev_Own_MN_7D=N(pc_HHExpFBev_Own_MN_7D) 
  /n2_pc_HHExpFOut_Purch_MN_7D=N(pc_HHExpFOut_Purch_MN_7D) 
  /n2_pc_HHExpFOut_GiftAid_MN_7D=N(pc_HHExpFOut_GiftAid_MN_7D) 
  /n2_pc_HHExpFOut_Own_MN_7D=N(pc_HHExpFOut_Own_MN_7D) 
  /n2_pc_HHExpNFHyg_Purch_MN_1M=N(pc_HHExpNFHyg_Purch_MN_1M) 
  /n2_pc_HHExpNFHyg_GiftAid_MN_1M=N(pc_HHExpNFHyg_GiftAid_MN_1M) 
  /n2_pc_HHExpNFTransp_Purch_MN_1M=N(pc_HHExpNFTransp_Purch_MN_1M) 
  /n2_pc_HHExpNFTransp_GiftAid_MN_1M=N(pc_HHExpNFTransp_GiftAid_MN_1M) 
  /n2_pc_HHExpNFFuel_Purch_MN_1M=N(pc_HHExpNFFuel_Purch_MN_1M) 
  /n2_pc_HHExpNFFuel_GiftAid_MN_1M=N(pc_HHExpNFFuel_GiftAid_MN_1M) 
  /n2_pc_HHExpNFWat_Purch_MN_1M=N(pc_HHExpNFWat_Purch_MN_1M) 
  /n2_pc_HHExpNFWat_GiftAid_MN_1M=N(pc_HHExpNFWat_GiftAid_MN_1M) 
  /n2_pc_HHExpNFElec_Purch_MN_1M=N(pc_HHExpNFElec_Purch_MN_1M) 
  /n2_pc_HHExpNFElec_GiftAid_MN_1M=N(pc_HHExpNFElec_GiftAid_MN_1M) 
  /n2_pc_HHExpNFEnerg_Purch_MN_1M=N(pc_HHExpNFEnerg_Purch_MN_1M) 
  /n2_pc_HHExpNFEnerg_GiftAid_MN_1M=N(pc_HHExpNFEnerg_GiftAid_MN_1M) 
  /n2_pc_HHExpNFDwelSer_Purch_MN_1M=N(pc_HHExpNFDwelSer_Purch_MN_1M) 
  /n2_pc_HHExpNFDwelSer_GiftAid_MN_1M=N(pc_HHExpNFDwelSer_GiftAid_MN_1M) 
  /n2_pc_HHExpNFPhone_Purch_MN_1M=N(pc_HHExpNFPhone_Purch_MN_1M) 
  /n2_pc_HHExpNFPhone_GiftAid_MN_1M=N(pc_HHExpNFPhone_GiftAid_MN_1M) 
  /n2_pc_HHExpNFRecr_Purch_MN_1M=N(pc_HHExpNFRecr_Purch_MN_1M) 
  /n2_pc_HHExpNFRecr_GiftAid_MN_1M=N(pc_HHExpNFRecr_GiftAid_MN_1M) 
  /n2_pc_HHExpNFAlcTobac_Purch_MN_1M=N(pc_HHExpNFAlcTobac_Purch_MN_1M) 
  /n2_pc_HHExpNFAlcTobac_GiftAid_MN_1M=N(pc_HHExpNFAlcTobac_GiftAid_MN_1M) 
  /n2_pc_HHExpNFMedServ_Purch_MN_6M=N(pc_HHExpNFMedServ_Purch_MN_6M) 
  /n2_pc_HHExpNFMedServ_GiftAid_MN_6M=N(pc_HHExpNFMedServ_GiftAid_MN_6M) 
  /n2_pc_HHExpNFMedGood_Purch_MN_6M=N(pc_HHExpNFMedGood_Purch_MN_6M) 
  /n2_pc_HHExpNFMedGood_GiftAid_MN_6M=N(pc_HHExpNFMedGood_GiftAid_MN_6M) 
  /n2_pc_HHExpNFCloth_Purch_MN_6M=N(pc_HHExpNFCloth_Purch_MN_6M) 
  /n2_pc_HHExpNFCloth_GiftAid_MN_6M=N(pc_HHExpNFCloth_GiftAid_MN_6M) 
  /n2_pc_HHExpNFEduFee_Purch_MN_6M=N(pc_HHExpNFEduFee_Purch_MN_6M) 
  /n2_pc_HHExpNFEduFee_GiftAid_MN_6M=N(pc_HHExpNFEduFee_GiftAid_MN_6M) 
  /n2_pc_HHExpNFEduGood_Purch_MN_6M=N(pc_HHExpNFEduGood_Purch_MN_6M) 
  /n2_pc_HHExpNFEduGood_GiftAid_MN_6M=N(pc_HHExpNFEduGood_GiftAid_MN_6M) 
  /n2_pc_HHExpNFRent_Purch_MN_6M=N(pc_HHExpNFRent_Purch_MN_6M) 
  /n2_pc_HHExpNFRent_GiftAid_MN_6M=N(pc_HHExpNFRent_GiftAid_MN_6M) 
  /n2_pc_HHExpNFHHSoft_Purch_MN_6M=N(pc_HHExpNFHHSoft_Purch_MN_6M) 
  /n2_pc_HHExpNFHHSoft_GiftAid_MN_6M=N(pc_HHExpNFHHSoft_GiftAid_MN_6M) 
  /n2_pc_HHExpNFHHMaint_Purch_MN_6M=N(pc_HHExpNFHHMaint_Purch_MN_6M) 
  /n2_pc_HHExpNFHHMaint_GiftAid_MN_6M=N(pc_HHExpNFHHMaint_GiftAid_MN_6M).

* Then for ADMIN3 level.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=ADMIN3Name 
    /m3_pc_HHExpFCer_Purch_MN_7D=MEDIAN(pc_HHExpFCer_Purch_MN_7D) 
  /m3_pc_HHExpFCer_GiftAid_MN_7D=MEDIAN(pc_HHExpFCer_GiftAid_MN_7D) 
  /m3_pc_HHExpFCer_Own_MN_7D=MEDIAN(pc_HHExpFCer_Own_MN_7D) 
  /m3_pc_HHExpFTub_Purch_MN_7D=MEDIAN(pc_HHExpFTub_Purch_MN_7D) 
  /m3_pc_HHExpFTub_GiftAid_MN_7D=MEDIAN(pc_HHExpFTub_GiftAid_MN_7D) 
  /m3_pc_HHExpFTub_Own_MN_7D=MEDIAN(pc_HHExpFTub_Own_MN_7D) 
  /m3_pc_HHExpFPuls_Purch_MN_7D=MEDIAN(pc_HHExpFPuls_Purch_MN_7D) 
  /m3_pc_HHExpFPuls_GiftAid_MN_7D=MEDIAN(pc_HHExpFPuls_GiftAid_MN_7D) 
  /m3_pc_HHExpFPuls_Own_MN_7D=MEDIAN(pc_HHExpFPuls_Own_MN_7D) 
  /m3_pc_HHExpFVeg_Purch_MN_7D=MEDIAN(pc_HHExpFVeg_Purch_MN_7D) 
  /m3_pc_HHExpFVeg_GiftAid_MN_7D=MEDIAN(pc_HHExpFVeg_GiftAid_MN_7D) 
  /m3_pc_HHExpFVeg_Own_MN_7D=MEDIAN(pc_HHExpFVeg_Own_MN_7D) 
  /m3_pc_HHExpFFrt_Purch_MN_7D=MEDIAN(pc_HHExpFFrt_Purch_MN_7D) 
  /m3_pc_HHExpFFrt_GiftAid_MN_7D=MEDIAN(pc_HHExpFFrt_GiftAid_MN_7D) 
  /m3_pc_HHExpFFrt_Own_MN_7D=MEDIAN(pc_HHExpFFrt_Own_MN_7D) 
  /m3_pc_HHExpFAnimMeat_Purch_MN_7D=MEDIAN(pc_HHExpFAnimMeat_Purch_MN_7D) 
  /m3_pc_HHExpFAnimMeat_GiftAid_MN_7D=MEDIAN(pc_HHExpFAnimMeat_GiftAid_MN_7D) 
  /m3_pc_HHExpFAnimMeat_Own_MN_7D=MEDIAN(pc_HHExpFAnimMeat_Own_MN_7D) 
  /m3_pc_HHExpFAnimFish_Purch_MN_7D=MEDIAN(pc_HHExpFAnimFish_Purch_MN_7D) 
  /m3_pc_HHExpFAnimFish_GiftAid_MN_7D=MEDIAN(pc_HHExpFAnimFish_GiftAid_MN_7D) 
  /m3_pc_HHExpFAnimFish_Own_MN_7D=MEDIAN(pc_HHExpFAnimFish_Own_MN_7D) 
  /m3_pc_HHExpFFats_Purch_MN_7D=MEDIAN(pc_HHExpFFats_Purch_MN_7D) 
  /m3_pc_HHExpFFats_GiftAid_MN_7D=MEDIAN(pc_HHExpFFats_GiftAid_MN_7D) 
  /m3_pc_HHExpFFats_Own_MN_7D=MEDIAN(pc_HHExpFFats_Own_MN_7D) 
  /m3_pc_HHExpFDairy_Purch_MN_7D=MEDIAN(pc_HHExpFDairy_Purch_MN_7D) 
  /m3_pc_HHExpFDairy_GiftAid_MN_7D=MEDIAN(pc_HHExpFDairy_GiftAid_MN_7D) 
  /m3_pc_HHExpFDairy_Own_MN_7D=MEDIAN(pc_HHExpFDairy_Own_MN_7D) 
  /m3_pc_HHExpFEgg_Purch_MN_7D=MEDIAN(pc_HHExpFEgg_Purch_MN_7D) 
  /m3_pc_HHExpFEgg_GiftAid_MN_7D=MEDIAN(pc_HHExpFEgg_GiftAid_MN_7D) 
  /m3_pc_HHExpFEgg_Own_MN_7D=MEDIAN(pc_HHExpFEgg_Own_MN_7D) 
  /m3_pc_HHExpFSgr_Purch_MN_7D=MEDIAN(pc_HHExpFSgr_Purch_MN_7D) 
  /m3_pc_HHExpFSgr_GiftAid_MN_7D=MEDIAN(pc_HHExpFSgr_GiftAid_MN_7D) 
  /m3_pc_HHExpFSgr_Own_MN_7D=MEDIAN(pc_HHExpFSgr_Own_MN_7D) 
  /m3_pc_HHExpFCond_Purch_MN_7D=MEDIAN(pc_HHExpFCond_Purch_MN_7D) 
  /m3_pc_HHExpFCond_GiftAid_MN_7D=MEDIAN(pc_HHExpFCond_GiftAid_MN_7D) 
  /m3_pc_HHExpFCond_Own_MN_7D=MEDIAN(pc_HHExpFCond_Own_MN_7D) 
  /m3_pc_HHExpFBev_Purch_MN_7D=MEDIAN(pc_HHExpFBev_Purch_MN_7D) 
  /m3_pc_HHExpFBev_GiftAid_MN_7D=MEDIAN(pc_HHExpFBev_GiftAid_MN_7D) 
  /m3_pc_HHExpFBev_Own_MN_7D=MEDIAN(pc_HHExpFBev_Own_MN_7D) 
  /m3_pc_HHExpFOut_Purch_MN_7D=MEDIAN(pc_HHExpFOut_Purch_MN_7D) 
  /m3_pc_HHExpFOut_GiftAid_MN_7D=MEDIAN(pc_HHExpFOut_GiftAid_MN_7D) 
  /m3_pc_HHExpFOut_Own_MN_7D=MEDIAN(pc_HHExpFOut_Own_MN_7D) 
  /m3_pc_HHExpNFHyg_Purch_MN_1M=MEDIAN(pc_HHExpNFHyg_Purch_MN_1M) 
  /m3_pc_HHExpNFHyg_GiftAid_MN_1M=MEDIAN(pc_HHExpNFHyg_GiftAid_MN_1M) 
  /m3_pc_HHExpNFTransp_Purch_MN_1M=MEDIAN(pc_HHExpNFTransp_Purch_MN_1M) 
  /m3_pc_HHExpNFTransp_GiftAid_MN_1M=MEDIAN(pc_HHExpNFTransp_GiftAid_MN_1M) 
  /m3_pc_HHExpNFFuel_Purch_MN_1M=MEDIAN(pc_HHExpNFFuel_Purch_MN_1M) 
  /m3_pc_HHExpNFFuel_GiftAid_MN_1M=MEDIAN(pc_HHExpNFFuel_GiftAid_MN_1M) 
  /m3_pc_HHExpNFWat_Purch_MN_1M=MEDIAN(pc_HHExpNFWat_Purch_MN_1M) 
  /m3_pc_HHExpNFWat_GiftAid_MN_1M=MEDIAN(pc_HHExpNFWat_GiftAid_MN_1M) 
  /m3_pc_HHExpNFElec_Purch_MN_1M=MEDIAN(pc_HHExpNFElec_Purch_MN_1M) 
  /m3_pc_HHExpNFElec_GiftAid_MN_1M=MEDIAN(pc_HHExpNFElec_GiftAid_MN_1M) 
  /m3_pc_HHExpNFEnerg_Purch_MN_1M=MEDIAN(pc_HHExpNFEnerg_Purch_MN_1M) 
  /m3_pc_HHExpNFEnerg_GiftAid_MN_1M=MEDIAN(pc_HHExpNFEnerg_GiftAid_MN_1M) 
  /m3_pc_HHExpNFDwelSer_Purch_MN_1M=MEDIAN(pc_HHExpNFDwelSer_Purch_MN_1M) 
  /m3_pc_HHExpNFDwelSer_GiftAid_MN_1M=MEDIAN(pc_HHExpNFDwelSer_GiftAid_MN_1M) 
  /m3_pc_HHExpNFPhone_Purch_MN_1M=MEDIAN(pc_HHExpNFPhone_Purch_MN_1M) 
  /m3_pc_HHExpNFPhone_GiftAid_MN_1M=MEDIAN(pc_HHExpNFPhone_GiftAid_MN_1M) 
  /m3_pc_HHExpNFRecr_Purch_MN_1M=MEDIAN(pc_HHExpNFRecr_Purch_MN_1M) 
  /m3_pc_HHExpNFRecr_GiftAid_MN_1M=MEDIAN(pc_HHExpNFRecr_GiftAid_MN_1M) 
  /m3_pc_HHExpNFAlcTobac_Purch_MN_1M=MEDIAN(pc_HHExpNFAlcTobac_Purch_MN_1M) 
  /m3_pc_HHExpNFAlcTobac_GiftAid_MN_1M=MEDIAN(pc_HHExpNFAlcTobac_GiftAid_MN_1M) 
  /m3_pc_HHExpNFMedServ_Purch_MN_6M=MEDIAN(pc_HHExpNFMedServ_Purch_MN_6M) 
  /m3_pc_HHExpNFMedServ_GiftAid_MN_6M=MEDIAN(pc_HHExpNFMedServ_GiftAid_MN_6M) 
  /m3_pc_HHExpNFMedGood_Purch_MN_6M=MEDIAN(pc_HHExpNFMedGood_Purch_MN_6M) 
  /m3_pc_HHExpNFMedGood_GiftAid_MN_6M=MEDIAN(pc_HHExpNFMedGood_GiftAid_MN_6M) 
  /m3_pc_HHExpNFCloth_Purch_MN_6M=MEDIAN(pc_HHExpNFCloth_Purch_MN_6M) 
  /m3_pc_HHExpNFCloth_GiftAid_MN_6M=MEDIAN(pc_HHExpNFCloth_GiftAid_MN_6M) 
  /m3_pc_HHExpNFEduFee_Purch_MN_6M=MEDIAN(pc_HHExpNFEduFee_Purch_MN_6M) 
  /m3_pc_HHExpNFEduFee_GiftAid_MN_6M=MEDIAN(pc_HHExpNFEduFee_GiftAid_MN_6M) 
  /m3_pc_HHExpNFEduGood_Purch_MN_6M=MEDIAN(pc_HHExpNFEduGood_Purch_MN_6M) 
  /m3_pc_HHExpNFEduGood_GiftAid_MN_6M=MEDIAN(pc_HHExpNFEduGood_GiftAid_MN_6M) 
  /m3_pc_HHExpNFRent_Purch_MN_6M=MEDIAN(pc_HHExpNFRent_Purch_MN_6M) 
  /m3_pc_HHExpNFRent_GiftAid_MN_6M=MEDIAN(pc_HHExpNFRent_GiftAid_MN_6M) 
  /m3_pc_HHExpNFHHSoft_Purch_MN_6M=MEDIAN(pc_HHExpNFHHSoft_Purch_MN_6M) 
  /m3_pc_HHExpNFHHSoft_GiftAid_MN_6M=MEDIAN(pc_HHExpNFHHSoft_GiftAid_MN_6M) 
  /m3_pc_HHExpNFHHMaint_Purch_MN_6M=MEDIAN(pc_HHExpNFHHMaint_Purch_MN_6M) 
  /m3_pc_HHExpNFHHMaint_GiftAid_MN_6M=MEDIAN(pc_HHExpNFHHMaint_GiftAid_MN_6M)
    /n3_pc_HHExpFCer_Purch_MN_7D=N(pc_HHExpFCer_Purch_MN_7D) 
  /n3_pc_HHExpFCer_GiftAid_MN_7D=N(pc_HHExpFCer_GiftAid_MN_7D) 
  /n3_pc_HHExpFCer_Own_MN_7D=N(pc_HHExpFCer_Own_MN_7D) 
  /n3_pc_HHExpFTub_Purch_MN_7D=N(pc_HHExpFTub_Purch_MN_7D) 
  /n3_pc_HHExpFTub_GiftAid_MN_7D=N(pc_HHExpFTub_GiftAid_MN_7D) 
  /n3_pc_HHExpFTub_Own_MN_7D=N(pc_HHExpFTub_Own_MN_7D) 
  /n3_pc_HHExpFPuls_Purch_MN_7D=N(pc_HHExpFPuls_Purch_MN_7D) 
  /n3_pc_HHExpFPuls_GiftAid_MN_7D=N(pc_HHExpFPuls_GiftAid_MN_7D) 
  /n3_pc_HHExpFPuls_Own_MN_7D=N(pc_HHExpFPuls_Own_MN_7D) 
  /n3_pc_HHExpFVeg_Purch_MN_7D=N(pc_HHExpFVeg_Purch_MN_7D) 
  /n3_pc_HHExpFVeg_GiftAid_MN_7D=N(pc_HHExpFVeg_GiftAid_MN_7D) 
  /n3_pc_HHExpFVeg_Own_MN_7D=N(pc_HHExpFVeg_Own_MN_7D) 
  /n3_pc_HHExpFFrt_Purch_MN_7D=N(pc_HHExpFFrt_Purch_MN_7D) 
  /n3_pc_HHExpFFrt_GiftAid_MN_7D=N(pc_HHExpFFrt_GiftAid_MN_7D) 
  /n3_pc_HHExpFFrt_Own_MN_7D=N(pc_HHExpFFrt_Own_MN_7D) 
  /n3_pc_HHExpFAnimMeat_Purch_MN_7D=N(pc_HHExpFAnimMeat_Purch_MN_7D) 
  /n3_pc_HHExpFAnimMeat_GiftAid_MN_7D=N(pc_HHExpFAnimMeat_GiftAid_MN_7D) 
  /n3_pc_HHExpFAnimMeat_Own_MN_7D=N(pc_HHExpFAnimMeat_Own_MN_7D) 
  /n3_pc_HHExpFAnimFish_Purch_MN_7D=N(pc_HHExpFAnimFish_Purch_MN_7D) 
  /n3_pc_HHExpFAnimFish_GiftAid_MN_7D=N(pc_HHExpFAnimFish_GiftAid_MN_7D) 
  /n3_pc_HHExpFAnimFish_Own_MN_7D=N(pc_HHExpFAnimFish_Own_MN_7D) 
  /n3_pc_HHExpFFats_Purch_MN_7D=N(pc_HHExpFFats_Purch_MN_7D) 
  /n3_pc_HHExpFFats_GiftAid_MN_7D=N(pc_HHExpFFats_GiftAid_MN_7D) 
  /n3_pc_HHExpFFats_Own_MN_7D=N(pc_HHExpFFats_Own_MN_7D) 
  /n3_pc_HHExpFDairy_Purch_MN_7D=N(pc_HHExpFDairy_Purch_MN_7D) 
  /n3_pc_HHExpFDairy_GiftAid_MN_7D=N(pc_HHExpFDairy_GiftAid_MN_7D) 
  /n3_pc_HHExpFDairy_Own_MN_7D=N(pc_HHExpFDairy_Own_MN_7D) 
  /n3_pc_HHExpFEgg_Purch_MN_7D=N(pc_HHExpFEgg_Purch_MN_7D) 
  /n3_pc_HHExpFEgg_GiftAid_MN_7D=N(pc_HHExpFEgg_GiftAid_MN_7D) 
  /n3_pc_HHExpFEgg_Own_MN_7D=N(pc_HHExpFEgg_Own_MN_7D) 
  /n3_pc_HHExpFSgr_Purch_MN_7D=N(pc_HHExpFSgr_Purch_MN_7D) 
  /n3_pc_HHExpFSgr_GiftAid_MN_7D=N(pc_HHExpFSgr_GiftAid_MN_7D) 
  /n3_pc_HHExpFSgr_Own_MN_7D=N(pc_HHExpFSgr_Own_MN_7D) 
  /n3_pc_HHExpFCond_Purch_MN_7D=N(pc_HHExpFCond_Purch_MN_7D) 
  /n3_pc_HHExpFCond_GiftAid_MN_7D=N(pc_HHExpFCond_GiftAid_MN_7D) 
  /n3_pc_HHExpFCond_Own_MN_7D=N(pc_HHExpFCond_Own_MN_7D) 
  /n3_pc_HHExpFBev_Purch_MN_7D=N(pc_HHExpFBev_Purch_MN_7D) 
  /n3_pc_HHExpFBev_GiftAid_MN_7D=N(pc_HHExpFBev_GiftAid_MN_7D) 
  /n3_pc_HHExpFBev_Own_MN_7D=N(pc_HHExpFBev_Own_MN_7D) 
  /n3_pc_HHExpFOut_Purch_MN_7D=N(pc_HHExpFOut_Purch_MN_7D) 
  /n3_pc_HHExpFOut_GiftAid_MN_7D=N(pc_HHExpFOut_GiftAid_MN_7D) 
  /n3_pc_HHExpFOut_Own_MN_7D=N(pc_HHExpFOut_Own_MN_7D) 
  /n3_pc_HHExpNFHyg_Purch_MN_1M=N(pc_HHExpNFHyg_Purch_MN_1M) 
  /n3_pc_HHExpNFHyg_GiftAid_MN_1M=N(pc_HHExpNFHyg_GiftAid_MN_1M) 
  /n3_pc_HHExpNFTransp_Purch_MN_1M=N(pc_HHExpNFTransp_Purch_MN_1M) 
  /n3_pc_HHExpNFTransp_GiftAid_MN_1M=N(pc_HHExpNFTransp_GiftAid_MN_1M) 
  /n3_pc_HHExpNFFuel_Purch_MN_1M=N(pc_HHExpNFFuel_Purch_MN_1M) 
  /n3_pc_HHExpNFFuel_GiftAid_MN_1M=N(pc_HHExpNFFuel_GiftAid_MN_1M) 
  /n3_pc_HHExpNFWat_Purch_MN_1M=N(pc_HHExpNFWat_Purch_MN_1M) 
  /n3_pc_HHExpNFWat_GiftAid_MN_1M=N(pc_HHExpNFWat_GiftAid_MN_1M) 
  /n3_pc_HHExpNFElec_Purch_MN_1M=N(pc_HHExpNFElec_Purch_MN_1M) 
  /n3_pc_HHExpNFElec_GiftAid_MN_1M=N(pc_HHExpNFElec_GiftAid_MN_1M) 
  /n3_pc_HHExpNFEnerg_Purch_MN_1M=N(pc_HHExpNFEnerg_Purch_MN_1M) 
  /n3_pc_HHExpNFEnerg_GiftAid_MN_1M=N(pc_HHExpNFEnerg_GiftAid_MN_1M) 
  /n3_pc_HHExpNFDwelSer_Purch_MN_1M=N(pc_HHExpNFDwelSer_Purch_MN_1M) 
  /n3_pc_HHExpNFDwelSer_GiftAid_MN_1M=N(pc_HHExpNFDwelSer_GiftAid_MN_1M) 
  /n3_pc_HHExpNFPhone_Purch_MN_1M=N(pc_HHExpNFPhone_Purch_MN_1M) 
  /n3_pc_HHExpNFPhone_GiftAid_MN_1M=N(pc_HHExpNFPhone_GiftAid_MN_1M) 
  /n3_pc_HHExpNFRecr_Purch_MN_1M=N(pc_HHExpNFRecr_Purch_MN_1M) 
  /n3_pc_HHExpNFRecr_GiftAid_MN_1M=N(pc_HHExpNFRecr_GiftAid_MN_1M) 
  /n3_pc_HHExpNFAlcTobac_Purch_MN_1M=N(pc_HHExpNFAlcTobac_Purch_MN_1M) 
  /n3_pc_HHExpNFAlcTobac_GiftAid_MN_1M=N(pc_HHExpNFAlcTobac_GiftAid_MN_1M) 
  /n3_pc_HHExpNFMedServ_Purch_MN_6M=N(pc_HHExpNFMedServ_Purch_MN_6M) 
  /n3_pc_HHExpNFMedServ_GiftAid_MN_6M=N(pc_HHExpNFMedServ_GiftAid_MN_6M) 
  /n3_pc_HHExpNFMedGood_Purch_MN_6M=N(pc_HHExpNFMedGood_Purch_MN_6M) 
  /n3_pc_HHExpNFMedGood_GiftAid_MN_6M=N(pc_HHExpNFMedGood_GiftAid_MN_6M) 
  /n3_pc_HHExpNFCloth_Purch_MN_6M=N(pc_HHExpNFCloth_Purch_MN_6M) 
  /n3_pc_HHExpNFCloth_GiftAid_MN_6M=N(pc_HHExpNFCloth_GiftAid_MN_6M) 
  /n3_pc_HHExpNFEduFee_Purch_MN_6M=N(pc_HHExpNFEduFee_Purch_MN_6M) 
  /n3_pc_HHExpNFEduFee_GiftAid_MN_6M=N(pc_HHExpNFEduFee_GiftAid_MN_6M) 
  /n3_pc_HHExpNFEduGood_Purch_MN_6M=N(pc_HHExpNFEduGood_Purch_MN_6M) 
  /n3_pc_HHExpNFEduGood_GiftAid_MN_6M=N(pc_HHExpNFEduGood_GiftAid_MN_6M) 
  /n3_pc_HHExpNFRent_Purch_MN_6M=N(pc_HHExpNFRent_Purch_MN_6M) 
  /n3_pc_HHExpNFRent_GiftAid_MN_6M=N(pc_HHExpNFRent_GiftAid_MN_6M) 
  /n3_pc_HHExpNFHHSoft_Purch_MN_6M=N(pc_HHExpNFHHSoft_Purch_MN_6M) 
  /n3_pc_HHExpNFHHSoft_GiftAid_MN_6M=N(pc_HHExpNFHHSoft_GiftAid_MN_6M) 
  /n3_pc_HHExpNFHHMaint_Purch_MN_6M=N(pc_HHExpNFHHMaint_Purch_MN_6M) 
  /n3_pc_HHExpNFHHMaint_GiftAid_MN_6M=N(pc_HHExpNFHHMaint_GiftAid_MN_6M).

* Then for ADMIN4 level.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=ADMIN4Name 
  /m4_pc_HHExpFCer_Purch_MN_7D=MEDIAN(pc_HHExpFCer_Purch_MN_7D) 
  /m4_pc_HHExpFCer_GiftAid_MN_7D=MEDIAN(pc_HHExpFCer_GiftAid_MN_7D) 
  /m4_pc_HHExpFCer_Own_MN_7D=MEDIAN(pc_HHExpFCer_Own_MN_7D) 
  /m4_pc_HHExpFTub_Purch_MN_7D=MEDIAN(pc_HHExpFTub_Purch_MN_7D) 
  /m4_pc_HHExpFTub_GiftAid_MN_7D=MEDIAN(pc_HHExpFTub_GiftAid_MN_7D) 
  /m4_pc_HHExpFTub_Own_MN_7D=MEDIAN(pc_HHExpFTub_Own_MN_7D) 
  /m4_pc_HHExpFPuls_Purch_MN_7D=MEDIAN(pc_HHExpFPuls_Purch_MN_7D) 
  /m4_pc_HHExpFPuls_GiftAid_MN_7D=MEDIAN(pc_HHExpFPuls_GiftAid_MN_7D) 
  /m4_pc_HHExpFPuls_Own_MN_7D=MEDIAN(pc_HHExpFPuls_Own_MN_7D) 
  /m4_pc_HHExpFVeg_Purch_MN_7D=MEDIAN(pc_HHExpFVeg_Purch_MN_7D) 
  /m4_pc_HHExpFVeg_GiftAid_MN_7D=MEDIAN(pc_HHExpFVeg_GiftAid_MN_7D) 
  /m4_pc_HHExpFVeg_Own_MN_7D=MEDIAN(pc_HHExpFVeg_Own_MN_7D) 
  /m4_pc_HHExpFFrt_Purch_MN_7D=MEDIAN(pc_HHExpFFrt_Purch_MN_7D) 
  /m4_pc_HHExpFFrt_GiftAid_MN_7D=MEDIAN(pc_HHExpFFrt_GiftAid_MN_7D) 
  /m4_pc_HHExpFFrt_Own_MN_7D=MEDIAN(pc_HHExpFFrt_Own_MN_7D) 
  /m4_pc_HHExpFAnimMeat_Purch_MN_7D=MEDIAN(pc_HHExpFAnimMeat_Purch_MN_7D) 
  /m4_pc_HHExpFAnimMeat_GiftAid_MN_7D=MEDIAN(pc_HHExpFAnimMeat_GiftAid_MN_7D) 
  /m4_pc_HHExpFAnimMeat_Own_MN_7D=MEDIAN(pc_HHExpFAnimMeat_Own_MN_7D) 
  /m4_pc_HHExpFAnimFish_Purch_MN_7D=MEDIAN(pc_HHExpFAnimFish_Purch_MN_7D) 
  /m4_pc_HHExpFAnimFish_GiftAid_MN_7D=MEDIAN(pc_HHExpFAnimFish_GiftAid_MN_7D) 
  /m4_pc_HHExpFAnimFish_Own_MN_7D=MEDIAN(pc_HHExpFAnimFish_Own_MN_7D) 
  /m4_pc_HHExpFFats_Purch_MN_7D=MEDIAN(pc_HHExpFFats_Purch_MN_7D) 
  /m4_pc_HHExpFFats_GiftAid_MN_7D=MEDIAN(pc_HHExpFFats_GiftAid_MN_7D) 
  /m4_pc_HHExpFFats_Own_MN_7D=MEDIAN(pc_HHExpFFats_Own_MN_7D) 
  /m4_pc_HHExpFDairy_Purch_MN_7D=MEDIAN(pc_HHExpFDairy_Purch_MN_7D) 
  /m4_pc_HHExpFDairy_GiftAid_MN_7D=MEDIAN(pc_HHExpFDairy_GiftAid_MN_7D) 
  /m4_pc_HHExpFDairy_Own_MN_7D=MEDIAN(pc_HHExpFDairy_Own_MN_7D) 
  /m4_pc_HHExpFEgg_Purch_MN_7D=MEDIAN(pc_HHExpFEgg_Purch_MN_7D) 
  /m4_pc_HHExpFEgg_GiftAid_MN_7D=MEDIAN(pc_HHExpFEgg_GiftAid_MN_7D) 
  /m4_pc_HHExpFEgg_Own_MN_7D=MEDIAN(pc_HHExpFEgg_Own_MN_7D) 
  /m4_pc_HHExpFSgr_Purch_MN_7D=MEDIAN(pc_HHExpFSgr_Purch_MN_7D) 
  /m4_pc_HHExpFSgr_GiftAid_MN_7D=MEDIAN(pc_HHExpFSgr_GiftAid_MN_7D) 
  /m4_pc_HHExpFSgr_Own_MN_7D=MEDIAN(pc_HHExpFSgr_Own_MN_7D) 
  /m4_pc_HHExpFCond_Purch_MN_7D=MEDIAN(pc_HHExpFCond_Purch_MN_7D) 
  /m4_pc_HHExpFCond_GiftAid_MN_7D=MEDIAN(pc_HHExpFCond_GiftAid_MN_7D) 
  /m4_pc_HHExpFCond_Own_MN_7D=MEDIAN(pc_HHExpFCond_Own_MN_7D) 
  /m4_pc_HHExpFBev_Purch_MN_7D=MEDIAN(pc_HHExpFBev_Purch_MN_7D) 
  /m4_pc_HHExpFBev_GiftAid_MN_7D=MEDIAN(pc_HHExpFBev_GiftAid_MN_7D) 
  /m4_pc_HHExpFBev_Own_MN_7D=MEDIAN(pc_HHExpFBev_Own_MN_7D) 
  /m4_pc_HHExpFOut_Purch_MN_7D=MEDIAN(pc_HHExpFOut_Purch_MN_7D) 
  /m4_pc_HHExpFOut_GiftAid_MN_7D=MEDIAN(pc_HHExpFOut_GiftAid_MN_7D) 
  /m4_pc_HHExpFOut_Own_MN_7D=MEDIAN(pc_HHExpFOut_Own_MN_7D) 
  /m4_pc_HHExpNFHyg_Purch_MN_1M=MEDIAN(pc_HHExpNFHyg_Purch_MN_1M) 
  /m4_pc_HHExpNFHyg_GiftAid_MN_1M=MEDIAN(pc_HHExpNFHyg_GiftAid_MN_1M) 
  /m4_pc_HHExpNFTransp_Purch_MN_1M=MEDIAN(pc_HHExpNFTransp_Purch_MN_1M) 
  /m4_pc_HHExpNFTransp_GiftAid_MN_1M=MEDIAN(pc_HHExpNFTransp_GiftAid_MN_1M) 
  /m4_pc_HHExpNFFuel_Purch_MN_1M=MEDIAN(pc_HHExpNFFuel_Purch_MN_1M) 
  /m4_pc_HHExpNFFuel_GiftAid_MN_1M=MEDIAN(pc_HHExpNFFuel_GiftAid_MN_1M) 
  /m4_pc_HHExpNFWat_Purch_MN_1M=MEDIAN(pc_HHExpNFWat_Purch_MN_1M) 
  /m4_pc_HHExpNFWat_GiftAid_MN_1M=MEDIAN(pc_HHExpNFWat_GiftAid_MN_1M) 
  /m4_pc_HHExpNFElec_Purch_MN_1M=MEDIAN(pc_HHExpNFElec_Purch_MN_1M) 
  /m4_pc_HHExpNFElec_GiftAid_MN_1M=MEDIAN(pc_HHExpNFElec_GiftAid_MN_1M) 
  /m4_pc_HHExpNFEnerg_Purch_MN_1M=MEDIAN(pc_HHExpNFEnerg_Purch_MN_1M) 
  /m4_pc_HHExpNFEnerg_GiftAid_MN_1M=MEDIAN(pc_HHExpNFEnerg_GiftAid_MN_1M) 
  /m4_pc_HHExpNFDwelSer_Purch_MN_1M=MEDIAN(pc_HHExpNFDwelSer_Purch_MN_1M) 
  /m4_pc_HHExpNFDwelSer_GiftAid_MN_1M=MEDIAN(pc_HHExpNFDwelSer_GiftAid_MN_1M) 
  /m4_pc_HHExpNFPhone_Purch_MN_1M=MEDIAN(pc_HHExpNFPhone_Purch_MN_1M) 
  /m4_pc_HHExpNFPhone_GiftAid_MN_1M=MEDIAN(pc_HHExpNFPhone_GiftAid_MN_1M) 
  /m4_pc_HHExpNFRecr_Purch_MN_1M=MEDIAN(pc_HHExpNFRecr_Purch_MN_1M) 
  /m4_pc_HHExpNFRecr_GiftAid_MN_1M=MEDIAN(pc_HHExpNFRecr_GiftAid_MN_1M) 
  /m4_pc_HHExpNFAlcTobac_Purch_MN_1M=MEDIAN(pc_HHExpNFAlcTobac_Purch_MN_1M) 
  /m4_pc_HHExpNFAlcTobac_GiftAid_MN_1M=MEDIAN(pc_HHExpNFAlcTobac_GiftAid_MN_1M) 
  /m4_pc_HHExpNFMedServ_Purch_MN_6M=MEDIAN(pc_HHExpNFMedServ_Purch_MN_6M) 
  /m4_pc_HHExpNFMedServ_GiftAid_MN_6M=MEDIAN(pc_HHExpNFMedServ_GiftAid_MN_6M) 
  /m4_pc_HHExpNFMedGood_Purch_MN_6M=MEDIAN(pc_HHExpNFMedGood_Purch_MN_6M) 
  /m4_pc_HHExpNFMedGood_GiftAid_MN_6M=MEDIAN(pc_HHExpNFMedGood_GiftAid_MN_6M) 
  /m4_pc_HHExpNFCloth_Purch_MN_6M=MEDIAN(pc_HHExpNFCloth_Purch_MN_6M) 
  /m4_pc_HHExpNFCloth_GiftAid_MN_6M=MEDIAN(pc_HHExpNFCloth_GiftAid_MN_6M) 
  /m4_pc_HHExpNFEduFee_Purch_MN_6M=MEDIAN(pc_HHExpNFEduFee_Purch_MN_6M) 
  /m4_pc_HHExpNFEduFee_GiftAid_MN_6M=MEDIAN(pc_HHExpNFEduFee_GiftAid_MN_6M) 
  /m4_pc_HHExpNFEduGood_Purch_MN_6M=MEDIAN(pc_HHExpNFEduGood_Purch_MN_6M) 
  /m4_pc_HHExpNFEduGood_GiftAid_MN_6M=MEDIAN(pc_HHExpNFEduGood_GiftAid_MN_6M) 
  /m4_pc_HHExpNFRent_Purch_MN_6M=MEDIAN(pc_HHExpNFRent_Purch_MN_6M) 
  /m4_pc_HHExpNFRent_GiftAid_MN_6M=MEDIAN(pc_HHExpNFRent_GiftAid_MN_6M) 
  /m4_pc_HHExpNFHHSoft_Purch_MN_6M=MEDIAN(pc_HHExpNFHHSoft_Purch_MN_6M) 
  /m4_pc_HHExpNFHHSoft_GiftAid_MN_6M=MEDIAN(pc_HHExpNFHHSoft_GiftAid_MN_6M) 
  /m4_pc_HHExpNFHHMaint_Purch_MN_6M=MEDIAN(pc_HHExpNFHHMaint_Purch_MN_6M) 
  /m4_pc_HHExpNFHHMaint_GiftAid_MN_6M=MEDIAN(pc_HHExpNFHHMaint_GiftAid_MN_6M)
  /n4_pc_HHExpFCer_Purch_MN_7D=N(pc_HHExpFCer_Purch_MN_7D) 
  /n4_pc_HHExpFCer_GiftAid_MN_7D=N(pc_HHExpFCer_GiftAid_MN_7D) 
  /n4_pc_HHExpFCer_Own_MN_7D=N(pc_HHExpFCer_Own_MN_7D) 
  /n4_pc_HHExpFTub_Purch_MN_7D=N(pc_HHExpFTub_Purch_MN_7D) 
  /n4_pc_HHExpFTub_GiftAid_MN_7D=N(pc_HHExpFTub_GiftAid_MN_7D) 
  /n4_pc_HHExpFTub_Own_MN_7D=N(pc_HHExpFTub_Own_MN_7D) 
  /n4_pc_HHExpFPuls_Purch_MN_7D=N(pc_HHExpFPuls_Purch_MN_7D) 
  /n4_pc_HHExpFPuls_GiftAid_MN_7D=N(pc_HHExpFPuls_GiftAid_MN_7D) 
  /n4_pc_HHExpFPuls_Own_MN_7D=N(pc_HHExpFPuls_Own_MN_7D) 
  /n4_pc_HHExpFVeg_Purch_MN_7D=N(pc_HHExpFVeg_Purch_MN_7D) 
  /n4_pc_HHExpFVeg_GiftAid_MN_7D=N(pc_HHExpFVeg_GiftAid_MN_7D) 
  /n4_pc_HHExpFVeg_Own_MN_7D=N(pc_HHExpFVeg_Own_MN_7D) 
  /n4_pc_HHExpFFrt_Purch_MN_7D=N(pc_HHExpFFrt_Purch_MN_7D) 
  /n4_pc_HHExpFFrt_GiftAid_MN_7D=N(pc_HHExpFFrt_GiftAid_MN_7D) 
  /n4_pc_HHExpFFrt_Own_MN_7D=N(pc_HHExpFFrt_Own_MN_7D) 
  /n4_pc_HHExpFAnimMeat_Purch_MN_7D=N(pc_HHExpFAnimMeat_Purch_MN_7D) 
  /n4_pc_HHExpFAnimMeat_GiftAid_MN_7D=N(pc_HHExpFAnimMeat_GiftAid_MN_7D) 
  /n4_pc_HHExpFAnimMeat_Own_MN_7D=N(pc_HHExpFAnimMeat_Own_MN_7D) 
  /n4_pc_HHExpFAnimFish_Purch_MN_7D=N(pc_HHExpFAnimFish_Purch_MN_7D) 
  /n4_pc_HHExpFAnimFish_GiftAid_MN_7D=N(pc_HHExpFAnimFish_GiftAid_MN_7D) 
  /n4_pc_HHExpFAnimFish_Own_MN_7D=N(pc_HHExpFAnimFish_Own_MN_7D) 
  /n4_pc_HHExpFFats_Purch_MN_7D=N(pc_HHExpFFats_Purch_MN_7D) 
  /n4_pc_HHExpFFats_GiftAid_MN_7D=N(pc_HHExpFFats_GiftAid_MN_7D) 
  /n4_pc_HHExpFFats_Own_MN_7D=N(pc_HHExpFFats_Own_MN_7D) 
  /n4_pc_HHExpFDairy_Purch_MN_7D=N(pc_HHExpFDairy_Purch_MN_7D) 
  /n4_pc_HHExpFDairy_GiftAid_MN_7D=N(pc_HHExpFDairy_GiftAid_MN_7D) 
  /n4_pc_HHExpFDairy_Own_MN_7D=N(pc_HHExpFDairy_Own_MN_7D) 
  /n4_pc_HHExpFEgg_Purch_MN_7D=N(pc_HHExpFEgg_Purch_MN_7D) 
  /n4_pc_HHExpFEgg_GiftAid_MN_7D=N(pc_HHExpFEgg_GiftAid_MN_7D) 
  /n4_pc_HHExpFEgg_Own_MN_7D=N(pc_HHExpFEgg_Own_MN_7D) 
  /n4_pc_HHExpFSgr_Purch_MN_7D=N(pc_HHExpFSgr_Purch_MN_7D) 
  /n4_pc_HHExpFSgr_GiftAid_MN_7D=N(pc_HHExpFSgr_GiftAid_MN_7D) 
  /n4_pc_HHExpFSgr_Own_MN_7D=N(pc_HHExpFSgr_Own_MN_7D) 
  /n4_pc_HHExpFCond_Purch_MN_7D=N(pc_HHExpFCond_Purch_MN_7D) 
  /n4_pc_HHExpFCond_GiftAid_MN_7D=N(pc_HHExpFCond_GiftAid_MN_7D) 
  /n4_pc_HHExpFCond_Own_MN_7D=N(pc_HHExpFCond_Own_MN_7D) 
  /n4_pc_HHExpFBev_Purch_MN_7D=N(pc_HHExpFBev_Purch_MN_7D) 
  /n4_pc_HHExpFBev_GiftAid_MN_7D=N(pc_HHExpFBev_GiftAid_MN_7D) 
  /n4_pc_HHExpFBev_Own_MN_7D=N(pc_HHExpFBev_Own_MN_7D) 
  /n4_pc_HHExpFOut_Purch_MN_7D=N(pc_HHExpFOut_Purch_MN_7D) 
  /n4_pc_HHExpFOut_GiftAid_MN_7D=N(pc_HHExpFOut_GiftAid_MN_7D) 
  /n4_pc_HHExpFOut_Own_MN_7D=N(pc_HHExpFOut_Own_MN_7D) 
  /n4_pc_HHExpNFHyg_Purch_MN_1M=N(pc_HHExpNFHyg_Purch_MN_1M) 
  /n4_pc_HHExpNFHyg_GiftAid_MN_1M=N(pc_HHExpNFHyg_GiftAid_MN_1M) 
  /n4_pc_HHExpNFTransp_Purch_MN_1M=N(pc_HHExpNFTransp_Purch_MN_1M) 
  /n4_pc_HHExpNFTransp_GiftAid_MN_1M=N(pc_HHExpNFTransp_GiftAid_MN_1M) 
  /n4_pc_HHExpNFFuel_Purch_MN_1M=N(pc_HHExpNFFuel_Purch_MN_1M) 
  /n4_pc_HHExpNFFuel_GiftAid_MN_1M=N(pc_HHExpNFFuel_GiftAid_MN_1M) 
  /n4_pc_HHExpNFWat_Purch_MN_1M=N(pc_HHExpNFWat_Purch_MN_1M) 
  /n4_pc_HHExpNFWat_GiftAid_MN_1M=N(pc_HHExpNFWat_GiftAid_MN_1M) 
  /n4_pc_HHExpNFElec_Purch_MN_1M=N(pc_HHExpNFElec_Purch_MN_1M) 
  /n4_pc_HHExpNFElec_GiftAid_MN_1M=N(pc_HHExpNFElec_GiftAid_MN_1M) 
  /n4_pc_HHExpNFEnerg_Purch_MN_1M=N(pc_HHExpNFEnerg_Purch_MN_1M) 
  /n4_pc_HHExpNFEnerg_GiftAid_MN_1M=N(pc_HHExpNFEnerg_GiftAid_MN_1M) 
  /n4_pc_HHExpNFDwelSer_Purch_MN_1M=N(pc_HHExpNFDwelSer_Purch_MN_1M) 
  /n4_pc_HHExpNFDwelSer_GiftAid_MN_1M=N(pc_HHExpNFDwelSer_GiftAid_MN_1M) 
  /n4_pc_HHExpNFPhone_Purch_MN_1M=N(pc_HHExpNFPhone_Purch_MN_1M) 
  /n4_pc_HHExpNFPhone_GiftAid_MN_1M=N(pc_HHExpNFPhone_GiftAid_MN_1M) 
  /n4_pc_HHExpNFRecr_Purch_MN_1M=N(pc_HHExpNFRecr_Purch_MN_1M) 
  /n4_pc_HHExpNFRecr_GiftAid_MN_1M=N(pc_HHExpNFRecr_GiftAid_MN_1M) 
  /n4_pc_HHExpNFAlcTobac_Purch_MN_1M=N(pc_HHExpNFAlcTobac_Purch_MN_1M) 
  /n4_pc_HHExpNFAlcTobac_GiftAid_MN_1M=N(pc_HHExpNFAlcTobac_GiftAid_MN_1M) 
  /n4_pc_HHExpNFMedServ_Purch_MN_6M=N(pc_HHExpNFMedServ_Purch_MN_6M) 
  /n4_pc_HHExpNFMedServ_GiftAid_MN_6M=N(pc_HHExpNFMedServ_GiftAid_MN_6M) 
  /n4_pc_HHExpNFMedGood_Purch_MN_6M=N(pc_HHExpNFMedGood_Purch_MN_6M) 
  /n4_pc_HHExpNFMedGood_GiftAid_MN_6M=N(pc_HHExpNFMedGood_GiftAid_MN_6M) 
  /n4_pc_HHExpNFCloth_Purch_MN_6M=N(pc_HHExpNFCloth_Purch_MN_6M) 
  /n4_pc_HHExpNFCloth_GiftAid_MN_6M=N(pc_HHExpNFCloth_GiftAid_MN_6M) 
  /n4_pc_HHExpNFEduFee_Purch_MN_6M=N(pc_HHExpNFEduFee_Purch_MN_6M) 
  /n4_pc_HHExpNFEduFee_GiftAid_MN_6M=N(pc_HHExpNFEduFee_GiftAid_MN_6M) 
  /n4_pc_HHExpNFEduGood_Purch_MN_6M=N(pc_HHExpNFEduGood_Purch_MN_6M) 
  /n4_pc_HHExpNFEduGood_GiftAid_MN_6M=N(pc_HHExpNFEduGood_GiftAid_MN_6M) 
  /n4_pc_HHExpNFRent_Purch_MN_6M=N(pc_HHExpNFRent_Purch_MN_6M) 
  /n4_pc_HHExpNFRent_GiftAid_MN_6M=N(pc_HHExpNFRent_GiftAid_MN_6M) 
  /n4_pc_HHExpNFHHSoft_Purch_MN_6M=N(pc_HHExpNFHHSoft_Purch_MN_6M) 
  /n4_pc_HHExpNFHHSoft_GiftAid_MN_6M=N(pc_HHExpNFHHSoft_GiftAid_MN_6M) 
  /n4_pc_HHExpNFHHMaint_Purch_MN_6M=N(pc_HHExpNFHHMaint_Purch_MN_6M) 
  /n4_pc_HHExpNFHHMaint_GiftAid_MN_6M=N(pc_HHExpNFHHMaint_GiftAid_MN_6M).

* B. Replace outliers with median by admin levels.
DO REPEAT X = o_HHExpFCer_Purch_MN_7D TO o_HHExpNFHHMaint_GiftAid_MN_6M /
          Y = pc_HHExpFCer_Purch_MN_7D TO pc_HHExpNFHHMaint_GiftAid_MN_6M /
          M1 = m1_pc_HHExpFCer_Purch_MN_7D TO m1_pc_HHExpNFHHMaint_GiftAid_MN_6M /
          M2 = m2_pc_HHExpFCer_Purch_MN_7D TO m2_pc_HHExpNFHHMaint_GiftAid_MN_6M /
          M3 = m3_pc_HHExpFCer_Purch_MN_7D TO m3_pc_HHExpNFHHMaint_GiftAid_MN_6M /
          M4 = m4_pc_HHExpFCer_Purch_MN_7D TO m4_pc_HHExpNFHHMaint_GiftAid_MN_6M /
          N1 = n1_pc_HHExpFCer_Purch_MN_7D TO n1_pc_HHExpNFHHMaint_GiftAid_MN_6M /
          N2 = n2_pc_HHExpFCer_Purch_MN_7D TO n2_pc_HHExpNFHHMaint_GiftAid_MN_6M /
          N3 = n3_pc_HHExpFCer_Purch_MN_7D TO n3_pc_HHExpNFHHMaint_GiftAid_MN_6M /
          N4 = n4_pc_HHExpFCer_Purch_MN_7D TO n4_pc_HHExpNFHHMaint_GiftAid_MN_6M.

  * National level (ADMIN0).
  IF (X = 1 OR X = 2) Y = M1.

  * Admin level 1: Replace if more than 150 valid observations.
  IF (X = 1 OR X = 2) AND (N1 > 150) Y = M1.

  * Admin level 2: Replace if more than 50 valid observations.
  IF (X = 1 OR X = 2) AND (N2 > 50) Y = M2.

  * Admin level 3: Replace if more than 15 valid observations.
  IF (X = 1 OR X = 2) AND (N3 > 15) Y = M3.

  * Admin level 4: Replace if more than 5 valid observations.
  IF (X = 1 OR X = 2) AND (N4 > 5) Y = M4.

END REPEAT.
EXECUTE.

* Drop the temporary median and count variables if they are not needed.
DELETE VARIABLES n1_pc_HHExpFCer_Purch_MN_7D TO n4_pc_HHExpNFHHMaint_GiftAid_MN_6M
                 m1_pc_HHExpFCer_Purch_MN_7D TO m4_pc_HHExpNFHHMaint_GiftAid_MN_6M.
EXECUTE.

*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*
*  Stage 2: cleaning food and NF aggregates
*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*

*------------------------------------------------------------------------------*
*  Step 2.1: Compute aggregates
*------------------------------------------------------------------------------*.
* Note: aggergates computed in pc monthly terms, based on vars cleaned in previous stage.

*** Food aggregate.
COMPUTE pc_HHExpF_1M  = SUM(pc_HHExpFCer_Purch_MN_7D TO pc_HHExpFOut_Own_MN_7D).
IF SYSMIS(pc_HHExpF_1M) pc_HHExpF_1M=0.
EXECUTE.
    
COMPUTE pc_HHExpF_1M  = pc_HHExpF_1M*30/7 /* convert monthly only if recall period is 7D.
EXECUTE.

*** NF aggregate. 
COMPUTE temp_HHExpNF_30D = SUM(pc_HHExpNFHyg_Purch_MN_1M TO pc_HHExpNFAlcTobac_GiftAid_MN_1M) /* 1M recall.
COMPUTE temp_HHExpNF_6M  = SUM(pc_HHExpNFMedServ_Purch_MN_6M TO pc_HHExpNFHHMaint_GiftAid_MN_6M) /* 6M recall.
COMPUTE temp_HHExpNF_6M = temp_HHExpNF_6M/6 /* convert to monthly exp with 6M recall.
COMPUTE pc_HHExpNF_1M = SUM(temp_HHExpNF_30D, temp_HHExpNF_6M) /* total NF.
IF SYSMIS(pc_HHExpNF_1M) pc_HHExpNF_1M=0.
EXECUTE.

 SPSSINC SELECT VARIABLES MACRONAME="!trash" 
    /PROPERTIES  PATTERN = "(temp_)"  /* drop uneccessary vars.
DELETE VARIABLES !trash.

*------------------------------------------------------------------------------*
*  Step 2.2: Clean aggregates
*------------------------------------------------------------------------------*.

**** A. Identify observations with either zero total food or non-food consumption expenditures.

 *creating outlier tag var.
IF NOT(SYSMIS(pc_HHExpF_1M))  o_HHExpF_1M = 0. 
IF NOT(SYSMIS(pc_HHExpNF_1M))  o_HHExpNF_1M = 0.
EXE.
 
* identify obs as bottom outlier if the aggregate is zero.
IF (pc_HHExpF_1M=0)  o_HHExpF_1M = 1. 
IF (pc_HHExpNF_1M=0)  o_HHExpNF_1M = 1. 
EXE.
	
**** B. Identify outliers

*** Transform all variables to approximate normality using inverse hyperbolic sine transformation.
COMPUTE tpcHHExpF_1M =LN(pc_HHExpF_1M+ sqrt(pc_HHExpF_1M**2+1)).
COMPUTE tpcHHExpNF_1M =LN(pc_HHExpNF_1M+ sqrt(pc_HHExpNF_1M**2+1)).
EXE.

*** Standardize the transformed variable using median and minimum absolute deviation (MAD).
    
** Calculate the median of each variable.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=
  /tpcHHExpF_1M_median=MEDIAN(tpcHHExpF_1M) 
  /tpcHHExpNF_1M_median=MEDIAN(tpcHHExpNF_1M). 
EXE.

* Absolute value of diff between var and median for each observations.
COMPUTE dHHExpF_1M = ABS(tpcHHExpF_1M - tpcHHExpF_1M_median).
COMPUTE dHHExpNF_1M = ABS(tpcHHExpNF_1M - tpcHHExpNF_1M_median).
EXE.

* Compute median of these difference for each variable.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=
  /dHHExpF_1M_median=MEDIAN(dHHExpF_1M) 
  /dHHExpNF_1M_median=MEDIAN(dHHExpNF_1M).

* Compute MAD for each variable.
COMPUTE MADHHExpF_1M = 1.4826*dHHExpF_1M_median.
COMPUTE MADHHExpNF_1M = 1.4826*dHHExpNF_1M_median.
EXECUTE.

* Standardize.
COMPUTE zHHExpF_1M = (tpcHHExpF_1M - tpcHHExpF_1M_median)/MADHHExpF_1M.
COMPUTE zHHExpNF_1M = (tpcHHExpNF_1M - tpcHHExpNF_1M_median)/MADHHExpNF_1M.
EXE.

* drop temporary variables.
    SPSSINC SELECT VARIABLES MACRONAME="!trash" 
     /PROPERTIES  PATTERN = "(tpc|_median|dHHExp|MAD)" .
DELETE VARIABLES !trash.

*** Identify outliers (3 MADs from the median).
IF  (NOT(SYSMIS(pc_HHExpF_1M))) o_HHExpF_1M=0.
IF  (NOT(SYSMIS(pc_HHExpNF_1M))) o_HHExpNF_1M=0.
EXE.

DO REPEAT X =o_HHExpF_1M TO o_HHExpNF_1M / Y =zHHExpF_1M TO zHHExpNF_1M.
IF  (NOT(SYSMIS(Y)) AND Y>3) X=2 /* top outliers.
IF  (NOT(SYSMIS(Y)) AND Y<-3) X=1  /* bottom outliers.
END REPEAT PRINT.
EXECUTE.

* drop temporary variables.
    SPSSINC SELECT VARIABLES MACRONAME="!trash" 
     /PROPERTIES  PATTERN = "(zHHExp)" .
DELETE VARIABLES !trash.
EXECUTE.

* label outlier variables.
    SPSSINC SELECT VARIABLES MACRONAME="!list" 
     /PROPERTIES  PATTERN = "(o_HHExp)" .
VALUE LABELS
!list
0 'no out'
1 'bottom out'
2 'top out'.
EXECUTE.

* B. Treat outliers (median imputation by admin levels).

* Step 1: Set outliers to missing in the pc_ variables based on the corresponding o_ variables.
DO REPEAT X = o_HHExpF_1M TO o_HHExpNF_1M /
          Y = pc_HHExpF_1M TO pc_HHExpNF_1M.
  IF (X = 1 OR X = 2) Y = $sysmis.
END REPEAT.
EXECUTE.

* Step 2: Compute median for each admin level (ADMIN1, ADMIN2, etc.).
* First for ADMIN1 level.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=ADMIN1Name 
  /m1_pc_HHExpF_1M=MEDIAN(pc_HHExpF_1M) 
  /m1_pc_HHExpNF_1M=MEDIAN(pc_HHExpNF_1M) 
  /n1_pc_HHExpF_1M=N(pc_HHExpF_1M) 
  /n1_pc_HHExpNF_1M=N(pc_HHExpNF_1M) 
  
* for ADMIN2 level.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=ADMIN2Name 
  /m2_pc_HHExpF_1M=MEDIAN(pc_HHExpF_1M) 
  /m2_pc_HHExpNF_1M=MEDIAN(pc_HHExpNF_1M) 
  /n2_pc_HHExpF_1M=N(pc_HHExpF_1M) 
  /n2_pc_HHExpNF_1M=N(pc_HHExpNF_1M) 
  
* for ADMIN3 level.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=ADMIN3Name 
  /m3_pc_HHExpF_1M=MEDIAN(pc_HHExpF_1M) 
  /m3_pc_HHExpNF_1M=MEDIAN(pc_HHExpNF_1M) 
  /n3_pc_HHExpF_1M=N(pc_HHExpF_1M) 
  /n3_pc_HHExpNF_1M=N(pc_HHExpNF_1M) 
  
* for ADMIN4 level.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=ADMIN4Name 
  /m4_pc_HHExpF_1M=MEDIAN(pc_HHExpF_1M) 
  /m4_pc_HHExpNF_1M=MEDIAN(pc_HHExpNF_1M) 
  /n4_pc_HHExpF_1M=N(pc_HHExpF_1M) 
  /n4_pc_HHExpNF_1M=N(pc_HHExpNF_1M) 

* B. Replace outliers with median by admin levels.
DO REPEAT X = o_HHExpF_1M TO o_HHExpNF_1M /
          Y = pc_HHExpF_1M TO pc_HHExpNF_1M /
          M1 = m1_pc_HHExpF_1M TO m1_pc_HHExpNF_1M /
          M2 = m2_pc_HHExpF_1M TO m2_pc_HHExpNF_1M /
          M3 = m3_pc_HHExpF_1M TO m3_pc_HHExpNF_1M /
          M4 = m4_pc_HHExpF_1M TO m4_pc_HHExpNF_1M /
          N1 = n1_pc_HHExpF_1M TO n1_pc_HHExpNF_1M /
          N2 = n2_pc_HHExpF_1M TO n2_pc_HHExpNF_1M /
          N3 = n3_pc_HHExpF_1M TO n3_pc_HHExpNF_1M /
          N4 = n4_pc_HHExpF_1M TO n4_pc_HHExpNF_1M.

  * National level (ADMIN0).
  IF (X = 1 OR X = 2) Y = M1.

  * Admin level 1: Replace if more than 150 valid observations.
  IF (X = 1 OR X = 2) AND (N1 > 150) Y = M1.

  * Admin level 2: Replace if more than 50 valid observations.
  IF (X = 1 OR X = 2) AND (N2 > 50) Y = M2.

  * Admin level 3: Replace if more than 15 valid observations.
  IF (X = 1 OR X = 2) AND (N3 > 15) Y = M3.

  * Admin level 4: Replace if more than 5 valid observations.
  IF (X = 1 OR X = 2) AND (N4 > 5) Y = M4.

END REPEAT.
EXECUTE.

* Drop the temporary median and count variables if they are not needed.
DELETE VARIABLES n1_pc_HHExpF_1M TO n4_pc_HHExpNF_1M
                 m1_pc_HHExpF_1M TO m4_pc_HHExpNF_1M.
EXECUTE.

* Reconcile Single Expenditure Variables with Modified Aggregates.

* Step 1: Calculate total food expenditure (temp_F).
COMPUTE temp_F = SUM(pc_HHExpFCer_Purch_MN_7D TO pc_HHExpFOut_Own_MN_7D).
EXECUTE.

* Step 2: Compute shares for observations where food aggregates are not outliers.
DO REPEAT X=pc_HHExpFCer_Purch_MN_7D pc_HHExpFCer_GiftAid_MN_7D pc_HHExpFCer_Own_MN_7D
    pc_HHExpFTub_Purch_MN_7D pc_HHExpFTub_GiftAid_MN_7D pc_HHExpFTub_Own_MN_7D
    pc_HHExpFPuls_Purch_MN_7D pc_HHExpFPuls_GiftAid_MN_7D pc_HHExpFPuls_Own_MN_7D
    pc_HHExpFVeg_Purch_MN_7D pc_HHExpFVeg_GiftAid_MN_7D pc_HHExpFVeg_Own_MN_7D
    pc_HHExpFFrt_Purch_MN_7D pc_HHExpFFrt_GiftAid_MN_7D pc_HHExpFFrt_Own_MN_7D
    pc_HHExpFAnimMeat_Purch_MN_7D pc_HHExpFAnimMeat_GiftAid_MN_7D pc_HHExpFAnimMeat_Own_MN_7D
    pc_HHExpFAnimFish_Purch_MN_7D pc_HHExpFAnimFish_GiftAid_MN_7D pc_HHExpFAnimFish_Own_MN_7D
    pc_HHExpFFats_Purch_MN_7D pc_HHExpFFats_GiftAid_MN_7D pc_HHExpFFats_Own_MN_7D
    pc_HHExpFDairy_Purch_MN_7D pc_HHExpFDairy_GiftAid_MN_7D pc_HHExpFDairy_Own_MN_7D
    pc_HHExpFEgg_Purch_MN_7D pc_HHExpFEgg_GiftAid_MN_7D pc_HHExpFEgg_Own_MN_7D
    pc_HHExpFSgr_Purch_MN_7D pc_HHExpFSgr_GiftAid_MN_7D pc_HHExpFSgr_Own_MN_7D
    pc_HHExpFCond_Purch_MN_7D pc_HHExpFCond_GiftAid_MN_7D pc_HHExpFCond_Own_MN_7D
    pc_HHExpFBev_Purch_MN_7D pc_HHExpFBev_GiftAid_MN_7D pc_HHExpFBev_Own_MN_7D
    pc_HHExpFOut_Purch_MN_7D pc_HHExpFOut_GiftAid_MN_7D pc_HHExpFOut_Own_MN_7D
  /
    Y=sHHExpFCer_Purch_MN_7D sHHExpFCer_GiftAid_MN_7D sHHExpFCer_Own_MN_7D
    sHHExpFTub_Purch_MN_7D sHHExpFTub_GiftAid_MN_7D sHHExpFTub_Own_MN_7D
    sHHExpFPuls_Purch_MN_7D sHHExpFPuls_GiftAid_MN_7D sHHExpFPuls_Own_MN_7D
    sHHExpFVeg_Purch_MN_7D sHHExpFVeg_GiftAid_MN_7D sHHExpFVeg_Own_MN_7D
    sHHExpFFrt_Purch_MN_7D sHHExpFFrt_GiftAid_MN_7D sHHExpFFrt_Own_MN_7D
    sHHExpFAnimMeat_Purch_MN_7D sHHExpFAnimMeat_GiftAid_MN_7D sHHExpFAnimMeat_Own_MN_7D
    sHHExpFAnimFish_Purch_MN_7D sHHExpFAnimFish_GiftAid_MN_7D sHHExpFAnimFish_Own_MN_7D
    sHHExpFFats_Purch_MN_7D sHHExpFFats_GiftAid_MN_7D sHHExpFFats_Own_MN_7D
    sHHExpFDairy_Purch_MN_7D sHHExpFDairy_GiftAid_MN_7D sHHExpFDairy_Own_MN_7D
    sHHExpFEgg_Purch_MN_7D sHHExpFEgg_GiftAid_MN_7D sHHExpFEgg_Own_MN_7D
    sHHExpFSgr_Purch_MN_7D sHHExpFSgr_GiftAid_MN_7D sHHExpFSgr_Own_MN_7D
    sHHExpFCond_Purch_MN_7D sHHExpFCond_GiftAid_MN_7D sHHExpFCond_Own_MN_7D
    sHHExpFBev_Purch_MN_7D sHHExpFBev_GiftAid_MN_7D sHHExpFBev_Own_MN_7D
    sHHExpFOut_Purch_MN_7D sHHExpFOut_GiftAid_MN_7D sHHExpFOut_Own_MN_7D.

  COMPUTE Y = X/temp_F.

END REPEAT.
EXECUTE.

COMPUTE F_OutlierFlag = 0.
IF (o_HHExpF_1M = 1 OR o_HHExpF_1M = 2) F_OutlierFlag = 1.
EXECUTE.

* Fill missing values with 0 for non-outliers and missing for outliers for F expenditure shares.
DO REPEAT X = sHHExpFCer_Purch_MN_7D sHHExpFCer_GiftAid_MN_7D sHHExpFCer_Own_MN_7D
             sHHExpFTub_Purch_MN_7D sHHExpFTub_GiftAid_MN_7D sHHExpFTub_Own_MN_7D
             sHHExpFPuls_Purch_MN_7D sHHExpFPuls_GiftAid_MN_7D sHHExpFPuls_Own_MN_7D
             sHHExpFVeg_Purch_MN_7D sHHExpFVeg_GiftAid_MN_7D sHHExpFVeg_Own_MN_7D
             sHHExpFFrt_Purch_MN_7D sHHExpFFrt_GiftAid_MN_7D sHHExpFFrt_Own_MN_7D
             sHHExpFAnimMeat_Purch_MN_7D sHHExpFAnimMeat_GiftAid_MN_7D sHHExpFAnimMeat_Own_MN_7D
             sHHExpFAnimFish_Purch_MN_7D sHHExpFAnimFish_GiftAid_MN_7D sHHExpFAnimFish_Own_MN_7D
             sHHExpFFats_Purch_MN_7D sHHExpFFats_GiftAid_MN_7D sHHExpFFats_Own_MN_7D
             sHHExpFDairy_Purch_MN_7D sHHExpFDairy_GiftAid_MN_7D sHHExpFDairy_Own_MN_7D
             sHHExpFEgg_Purch_MN_7D sHHExpFEgg_GiftAid_MN_7D sHHExpFEgg_Own_MN_7D
             sHHExpFSgr_Purch_MN_7D sHHExpFSgr_GiftAid_MN_7D sHHExpFSgr_Own_MN_7D
             sHHExpFCond_Purch_MN_7D sHHExpFCond_GiftAid_MN_7D sHHExpFCond_Own_MN_7D
             sHHExpFBev_Purch_MN_7D sHHExpFBev_GiftAid_MN_7D sHHExpFBev_Own_MN_7D
             sHHExpFOut_Purch_MN_7D sHHExpFOut_GiftAid_MN_7D sHHExpFOut_Own_MN_7D.

    * Replace missing values with 0 if OutlierFlag is 0 (not an outlier).
    IF (F_OutlierFlag = 0 AND MISSING(X)) X = 0.
    
    * Keep missing values if the observation is an outlier.
    IF (F_OutlierFlag = 1) X = $SYSMIS.

END REPEAT.
EXECUTE.

* Calculate the mean share across all obs excluding outliers.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=
  /sHHExpFCer_Purch_MN_7D_mean=MEAN(sHHExpFCer_Purch_MN_7D) 
  /sHHExpFCer_GiftAid_MN_7D_mean=MEAN(sHHExpFCer_GiftAid_MN_7D) 
  /sHHExpFCer_Own_MN_7D_mean=MEAN(sHHExpFCer_Own_MN_7D) 
  /sHHExpFTub_Purch_MN_7D_mean=MEAN(sHHExpFTub_Purch_MN_7D) 
  /sHHExpFTub_GiftAid_MN_7D_mean=MEAN(sHHExpFTub_GiftAid_MN_7D) 
  /sHHExpFTub_Own_MN_7D_mean=MEAN(sHHExpFTub_Own_MN_7D) 
  /sHHExpFPuls_Purch_MN_7D_mean=MEAN(sHHExpFPuls_Purch_MN_7D) 
  /sHHExpFPuls_GiftAid_MN_7D_mean=MEAN(sHHExpFPuls_GiftAid_MN_7D) 
  /sHHExpFPuls_Own_MN_7D_mean=MEAN(sHHExpFPuls_Own_MN_7D) 
  /sHHExpFVeg_Purch_MN_7D_mean=MEAN(sHHExpFVeg_Purch_MN_7D) 
  /sHHExpFVeg_GiftAid_MN_7D_mean=MEAN(sHHExpFVeg_GiftAid_MN_7D) 
  /sHHExpFVeg_Own_MN_7D_mean=MEAN(sHHExpFVeg_Own_MN_7D) 
  /sHHExpFFrt_Purch_MN_7D_mean=MEAN(sHHExpFFrt_Purch_MN_7D) 
  /sHHExpFFrt_GiftAid_MN_7D_mean=MEAN(sHHExpFFrt_GiftAid_MN_7D) 
  /sHHExpFFrt_Own_MN_7D_mean=MEAN(sHHExpFFrt_Own_MN_7D) 
  /sHHExpFAnimMeat_Purch_MN_7D_mean=MEAN(sHHExpFAnimMeat_Purch_MN_7D) 
  /sHHExpFAnimMeat_GiftAid_MN_7D_mean=MEAN(sHHExpFAnimMeat_GiftAid_MN_7D) 
  /sHHExpFAnimMeat_Own_MN_7D_mean=MEAN(sHHExpFAnimMeat_Own_MN_7D) 
  /sHHExpFAnimFish_Purch_MN_7D_mean=MEAN(sHHExpFAnimFish_Purch_MN_7D) 
  /sHHExpFAnimFish_GiftAid_MN_7D_mean=MEAN(sHHExpFAnimFish_GiftAid_MN_7D) 
  /sHHExpFAnimFish_Own_MN_7D_mean=MEAN(sHHExpFAnimFish_Own_MN_7D) 
  /sHHExpFFats_Purch_MN_7D_mean=MEAN(sHHExpFFats_Purch_MN_7D) 
  /sHHExpFFats_GiftAid_MN_7D_mean=MEAN(sHHExpFFats_GiftAid_MN_7D) 
  /sHHExpFFats_Own_MN_7D_mean=MEAN(sHHExpFFats_Own_MN_7D) 
  /sHHExpFDairy_Purch_MN_7D_mean=MEAN(sHHExpFDairy_Purch_MN_7D) 
  /sHHExpFDairy_GiftAid_MN_7D_mean=MEAN(sHHExpFDairy_GiftAid_MN_7D) 
  /sHHExpFDairy_Own_MN_7D_mean=MEAN(sHHExpFDairy_Own_MN_7D) 
  /sHHExpFEgg_Purch_MN_7D_mean=MEAN(sHHExpFEgg_Purch_MN_7D) 
  /sHHExpFEgg_GiftAid_MN_7D_mean=MEAN(sHHExpFEgg_GiftAid_MN_7D) 
  /sHHExpFEgg_Own_MN_7D_mean=MEAN(sHHExpFEgg_Own_MN_7D) 
  /sHHExpFSgr_Purch_MN_7D_mean=MEAN(sHHExpFSgr_Purch_MN_7D) 
  /sHHExpFSgr_GiftAid_MN_7D_mean=MEAN(sHHExpFSgr_GiftAid_MN_7D) 
  /sHHExpFSgr_Own_MN_7D_mean=MEAN(sHHExpFSgr_Own_MN_7D) 
  /sHHExpFCond_Purch_MN_7D_mean=MEAN(sHHExpFCond_Purch_MN_7D) 
  /sHHExpFCond_GiftAid_MN_7D_mean=MEAN(sHHExpFCond_GiftAid_MN_7D) 
  /sHHExpFCond_Own_MN_7D_mean=MEAN(sHHExpFCond_Own_MN_7D) 
  /sHHExpFBev_Purch_MN_7D_mean=MEAN(sHHExpFBev_Purch_MN_7D) 
  /sHHExpFBev_GiftAid_MN_7D_mean=MEAN(sHHExpFBev_GiftAid_MN_7D) 
  /sHHExpFBev_Own_MN_7D_mean=MEAN(sHHExpFBev_Own_MN_7D) 
  /sHHExpFOut_Purch_MN_7D_mean=MEAN(sHHExpFOut_Purch_MN_7D) 
  /sHHExpFOut_GiftAid_MN_7D_mean=MEAN(sHHExpFOut_GiftAid_MN_7D) 
  /sHHExpFOut_Own_MN_7D_mean=MEAN(sHHExpFOut_Own_MN_7D).

EXECUTE.

* Replace outliers with mean shares.
DO REPEAT X = pc_HHExpFCer_Purch_MN_7D pc_HHExpFCer_GiftAid_MN_7D pc_HHExpFCer_Own_MN_7D
                pc_HHExpFTub_Purch_MN_7D pc_HHExpFTub_GiftAid_MN_7D pc_HHExpFTub_Own_MN_7D
                pc_HHExpFPuls_Purch_MN_7D pc_HHExpFPuls_GiftAid_MN_7D pc_HHExpFPuls_Own_MN_7D
                pc_HHExpFVeg_Purch_MN_7D pc_HHExpFVeg_GiftAid_MN_7D pc_HHExpFVeg_Own_MN_7D
                pc_HHExpFFrt_Purch_MN_7D pc_HHExpFFrt_GiftAid_MN_7D pc_HHExpFFrt_Own_MN_7D
                pc_HHExpFAnimMeat_Purch_MN_7D pc_HHExpFAnimMeat_GiftAid_MN_7D pc_HHExpFAnimMeat_Own_MN_7D
                pc_HHExpFAnimFish_Purch_MN_7D pc_HHExpFAnimFish_GiftAid_MN_7D pc_HHExpFAnimFish_Own_MN_7D
                pc_HHExpFFats_Purch_MN_7D pc_HHExpFFats_GiftAid_MN_7D pc_HHExpFFats_Own_MN_7D
                pc_HHExpFDairy_Purch_MN_7D pc_HHExpFDairy_GiftAid_MN_7D pc_HHExpFDairy_Own_MN_7D
                pc_HHExpFEgg_Purch_MN_7D pc_HHExpFEgg_GiftAid_MN_7D pc_HHExpFEgg_Own_MN_7D
                pc_HHExpFSgr_Purch_MN_7D pc_HHExpFSgr_GiftAid_MN_7D pc_HHExpFSgr_Own_MN_7D
                pc_HHExpFCond_Purch_MN_7D pc_HHExpFCond_GiftAid_MN_7D pc_HHExpFCond_Own_MN_7D
                pc_HHExpFBev_Purch_MN_7D pc_HHExpFBev_GiftAid_MN_7D pc_HHExpFBev_Own_MN_7D
                pc_HHExpFOut_Purch_MN_7D pc_HHExpFOut_GiftAid_MN_7D pc_HHExpFOut_Own_MN_7D
    /
    Y = sHHExpFCer_Purch_MN_7D_mean sHHExpFCer_GiftAid_MN_7D_mean sHHExpFCer_Own_MN_7D_mean
        sHHExpFTub_Purch_MN_7D_mean sHHExpFTub_GiftAid_MN_7D_mean sHHExpFTub_Own_MN_7D_mean
        sHHExpFPuls_Purch_MN_7D_mean sHHExpFPuls_GiftAid_MN_7D_mean sHHExpFPuls_Own_MN_7D_mean
        sHHExpFVeg_Purch_MN_7D_mean sHHExpFVeg_GiftAid_MN_7D_mean sHHExpFVeg_Own_MN_7D_mean
        sHHExpFFrt_Purch_MN_7D_mean sHHExpFFrt_GiftAid_MN_7D_mean sHHExpFFrt_Own_MN_7D_mean
        sHHExpFAnimMeat_Purch_MN_7D_mean sHHExpFAnimMeat_GiftAid_MN_7D_mean sHHExpFAnimMeat_Own_MN_7D_mean
        sHHExpFAnimFish_Purch_MN_7D_mean sHHExpFAnimFish_GiftAid_MN_7D_mean sHHExpFAnimFish_Own_MN_7D_mean
        sHHExpFFats_Purch_MN_7D_mean sHHExpFFats_GiftAid_MN_7D_mean sHHExpFFats_Own_MN_7D_mean
        sHHExpFDairy_Purch_MN_7D_mean sHHExpFDairy_GiftAid_MN_7D_mean sHHExpFDairy_Own_MN_7D_mean
        sHHExpFEgg_Purch_MN_7D_mean sHHExpFEgg_GiftAid_MN_7D_mean sHHExpFEgg_Own_MN_7D_mean
        sHHExpFSgr_Purch_MN_7D_mean sHHExpFSgr_GiftAid_MN_7D_mean sHHExpFSgr_Own_MN_7D_mean
        sHHExpFCond_Purch_MN_7D_mean sHHExpFCond_GiftAid_MN_7D_mean sHHExpFCond_Own_MN_7D_mean
        sHHExpFBev_Purch_MN_7D_mean sHHExpFBev_GiftAid_MN_7D_mean sHHExpFBev_Own_MN_7D_mean
        sHHExpFOut_Purch_MN_7D_mean sHHExpFOut_GiftAid_MN_7D_mean sHHExpFOut_Own_MN_7D_mean.

    IF (F_OutlierFlag = 1) X = pc_HHExpF_1M * Y.

END REPEAT.
EXECUTE.

*** Estimate average consumption share of each NF variable.
* Temporarily express the NF vars with 6-month recall in monthly terms.
DO REPEAT X = pc_HHExpNFMedServ_Purch_MN_6M TO pc_HHExpNFHHMaint_GiftAid_MN_6M.    
    COMPUTE X = X / 6.
END REPEAT.
EXECUTE.

* Calculate total non food expenditure (temp_NF).
COMPUTE temp_NF = SUM(pc_HHExpNFHyg_Purch_MN_1M TO pc_HHExpNFHHMaint_GiftAid_MN_6M).
EXECUTE.

* Compute shares for non-food variables, only for observations where non-food aggregates are not outliers.
DO REPEAT X = pc_HHExpNFHyg_Purch_MN_1M pc_HHExpNFHyg_GiftAid_MN_1M pc_HHExpNFTransp_Purch_MN_1M 
                pc_HHExpNFTransp_GiftAid_MN_1M pc_HHExpNFFuel_Purch_MN_1M pc_HHExpNFFuel_GiftAid_MN_1M
                pc_HHExpNFWat_Purch_MN_1M pc_HHExpNFWat_GiftAid_MN_1M pc_HHExpNFElec_Purch_MN_1M
                pc_HHExpNFElec_GiftAid_MN_1M pc_HHExpNFEnerg_Purch_MN_1M pc_HHExpNFEnerg_GiftAid_MN_1M
                pc_HHExpNFDwelSer_Purch_MN_1M pc_HHExpNFDwelSer_GiftAid_MN_1M pc_HHExpNFPhone_Purch_MN_1M
                pc_HHExpNFPhone_GiftAid_MN_1M pc_HHExpNFRecr_Purch_MN_1M pc_HHExpNFRecr_GiftAid_MN_1M
                pc_HHExpNFAlcTobac_Purch_MN_1M pc_HHExpNFAlcTobac_GiftAid_MN_1M pc_HHExpNFMedServ_Purch_MN_6M
                pc_HHExpNFMedServ_GiftAid_MN_6M pc_HHExpNFMedGood_Purch_MN_6M pc_HHExpNFMedGood_GiftAid_MN_6M
                pc_HHExpNFCloth_Purch_MN_6M pc_HHExpNFCloth_GiftAid_MN_6M pc_HHExpNFEduFee_Purch_MN_6M
                pc_HHExpNFEduFee_GiftAid_MN_6M pc_HHExpNFEduGood_Purch_MN_6M pc_HHExpNFEduGood_GiftAid_MN_6M
                pc_HHExpNFRent_Purch_MN_6M pc_HHExpNFRent_GiftAid_MN_6M pc_HHExpNFHHSoft_Purch_MN_6M
                pc_HHExpNFHHSoft_GiftAid_MN_6M pc_HHExpNFHHMaint_Purch_MN_6M pc_HHExpNFHHMaint_GiftAid_MN_6M
  /
        Y = sHHExpNFHyg_Purch_MN_1M sHHExpNFHyg_GiftAid_MN_1M sHHExpNFTransp_Purch_MN_1M
            sHHExpNFTransp_GiftAid_MN_1M sHHExpNFFuel_Purch_MN_1M sHHExpNFFuel_GiftAid_MN_1M
            sHHExpNFWat_Purch_MN_1M sHHExpNFWat_GiftAid_MN_1M sHHExpNFElec_Purch_MN_1M
            sHHExpNFElec_GiftAid_MN_1M sHHExpNFEnerg_Purch_MN_1M sHHExpNFEnerg_GiftAid_MN_1M
            sHHExpNFDwelSer_Purch_MN_1M sHHExpNFDwelSer_GiftAid_MN_1M sHHExpNFPhone_Purch_MN_1M
            sHHExpNFPhone_GiftAid_MN_1M sHHExpNFRecr_Purch_MN_1M sHHExpNFRecr_GiftAid_MN_1M
            sHHExpNFAlcTobac_Purch_MN_1M sHHExpNFAlcTobac_GiftAid_MN_1M sHHExpNFMedServ_Purch_MN_6M
            sHHExpNFMedServ_GiftAid_MN_6M sHHExpNFMedGood_Purch_MN_6M sHHExpNFMedGood_GiftAid_MN_6M
            sHHExpNFCloth_Purch_MN_6M sHHExpNFCloth_GiftAid_MN_6M sHHExpNFEduFee_Purch_MN_6M
            sHHExpNFEduFee_GiftAid_MN_6M sHHExpNFEduGood_Purch_MN_6M sHHExpNFEduGood_GiftAid_MN_6M
            sHHExpNFRent_Purch_MN_6M sHHExpNFRent_GiftAid_MN_6M sHHExpNFHHSoft_Purch_MN_6M
            sHHExpNFHHSoft_GiftAid_MN_6M sHHExpNFHHMaint_Purch_MN_6M sHHExpNFHHMaint_GiftAid_MN_6M.
  COMPUTE Y = X / Temp_NF.
END REPEAT.
EXECUTE.

COMPUTE NF_OutlierFlag = 0.
IF (o_HHExpNF_1M = 1 OR o_HHExpNF_1M = 2) NF_OutlierFlag = 1.
EXECUTE.

* Fill missing values with 0 for non-outliers and missing for outliers for NF expenditure shares..
DO REPEAT X = sHHExpNFHyg_Purch_MN_1M sHHExpNFHyg_GiftAid_MN_1M sHHExpNFTransp_Purch_MN_1M 
                sHHExpNFTransp_GiftAid_MN_1M sHHExpNFFuel_Purch_MN_1M sHHExpNFFuel_GiftAid_MN_1M
                sHHExpNFWat_Purch_MN_1M sHHExpNFWat_GiftAid_MN_1M sHHExpNFElec_Purch_MN_1M
                sHHExpNFElec_GiftAid_MN_1M sHHExpNFEnerg_Purch_MN_1M sHHExpNFEnerg_GiftAid_MN_1M
                sHHExpNFDwelSer_Purch_MN_1M sHHExpNFDwelSer_GiftAid_MN_1M sHHExpNFPhone_Purch_MN_1M
                sHHExpNFPhone_GiftAid_MN_1M sHHExpNFRecr_Purch_MN_1M sHHExpNFRecr_GiftAid_MN_1M
                sHHExpNFAlcTobac_Purch_MN_1M sHHExpNFAlcTobac_GiftAid_MN_1M sHHExpNFMedServ_Purch_MN_6M
                sHHExpNFMedServ_GiftAid_MN_6M sHHExpNFMedGood_Purch_MN_6M sHHExpNFMedGood_GiftAid_MN_6M
                sHHExpNFCloth_Purch_MN_6M sHHExpNFCloth_GiftAid_MN_6M sHHExpNFEduFee_Purch_MN_6M
                sHHExpNFEduFee_GiftAid_MN_6M sHHExpNFEduGood_Purch_MN_6M sHHExpNFEduGood_GiftAid_MN_6M
                sHHExpNFRent_Purch_MN_6M sHHExpNFRent_GiftAid_MN_6M sHHExpNFHHSoft_Purch_MN_6M
                sHHExpNFHHSoft_GiftAid_MN_6M sHHExpNFHHMaint_Purch_MN_6M sHHExpNFHHMaint_GiftAid_MN_6M.

    * Replace missing values with 0 if OutlierFlag is 0 (not an outlier).
    IF (NF_OutlierFlag = 0 AND MISSING(X)) X = 0.
    
    * Keep missing values if the observation is an outlier.
    IF (NF_OutlierFlag = 1) X = $SYSMIS.

END REPEAT.
EXECUTE.

* Calculate mean shares based on the non-outlier rows.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=
  /sHHExpNFHyg_Purch_MN_1M_mean=MEAN(sHHExpNFHyg_Purch_MN_1M) 
  /sHHExpNFHyg_GiftAid_MN_1M_mean=MEAN(sHHExpNFHyg_GiftAid_MN_1M) 
  /sHHExpNFTransp_Purch_MN_1M_mean=MEAN(sHHExpNFTransp_Purch_MN_1M) 
  /sHHExpNFTransp_GiftAid_MN_1M_mean=MEAN(sHHExpNFTransp_GiftAid_MN_1M) 
  /sHHExpNFFuel_Purch_MN_1M_mean=MEAN(sHHExpNFFuel_Purch_MN_1M) 
  /sHHExpNFFuel_GiftAid_MN_1M_mean=MEAN(sHHExpNFFuel_GiftAid_MN_1M) 
  /sHHExpNFWat_Purch_MN_1M_mean=MEAN(sHHExpNFWat_Purch_MN_1M) 
  /sHHExpNFWat_GiftAid_MN_1M_mean=MEAN(sHHExpNFWat_GiftAid_MN_1M) 
  /sHHExpNFElec_Purch_MN_1M_mean=MEAN(sHHExpNFElec_Purch_MN_1M) 
  /sHHExpNFElec_GiftAid_MN_1M_mean=MEAN(sHHExpNFElec_GiftAid_MN_1M) 
  /sHHExpNFEnerg_Purch_MN_1M_mean=MEAN(sHHExpNFEnerg_Purch_MN_1M) 
  /sHHExpNFEnerg_GiftAid_MN_1M_mean=MEAN(sHHExpNFEnerg_GiftAid_MN_1M) 
  /sHHExpNFDwelSer_Purch_MN_1M_mean=MEAN(sHHExpNFDwelSer_Purch_MN_1M) 
  /sHHExpNFDwelSer_GiftAid_MN_1M_mean=MEAN(sHHExpNFDwelSer_GiftAid_MN_1M) 
  /sHHExpNFPhone_Purch_MN_1M_mean=MEAN(sHHExpNFPhone_Purch_MN_1M) 
  /sHHExpNFPhone_GiftAid_MN_1M_mean=MEAN(sHHExpNFPhone_GiftAid_MN_1M) 
  /sHHExpNFRecr_Purch_MN_1M_mean=MEAN(sHHExpNFRecr_Purch_MN_1M) 
  /sHHExpNFRecr_GiftAid_MN_1M_mean=MEAN(sHHExpNFRecr_GiftAid_MN_1M) 
  /sHHExpNFAlcTobac_Purch_MN_1M_mean=MEAN(sHHExpNFAlcTobac_Purch_MN_1M) 
  /sHHExpNFAlcTobac_GiftAid_MN_1M_mean=MEAN(sHHExpNFAlcTobac_GiftAid_MN_1M) 
  /sHHExpNFMedServ_Purch_MN_6M_mean=MEAN(sHHExpNFMedServ_Purch_MN_6M) 
  /sHHExpNFMedServ_GiftAid_MN_6M_mean=MEAN(sHHExpNFMedServ_GiftAid_MN_6M) 
  /sHHExpNFMedGood_Purch_MN_6M_mean=MEAN(sHHExpNFMedGood_Purch_MN_6M) 
  /sHHExpNFMedGood_GiftAid_MN_6M_mean=MEAN(sHHExpNFMedGood_GiftAid_MN_6M) 
  /sHHExpNFCloth_Purch_MN_6M_mean=MEAN(sHHExpNFCloth_Purch_MN_6M) 
  /sHHExpNFCloth_GiftAid_MN_6M_mean=MEAN(sHHExpNFCloth_GiftAid_MN_6M) 
  /sHHExpNFEduFee_Purch_MN_6M_mean=MEAN(sHHExpNFEduFee_Purch_MN_6M) 
  /sHHExpNFEduFee_GiftAid_MN_6M_mean=MEAN(sHHExpNFEduFee_GiftAid_MN_6M) 
  /sHHExpNFEduGood_Purch_MN_6M_mean=MEAN(sHHExpNFEduGood_Purch_MN_6M) 
  /sHHExpNFEduGood_GiftAid_MN_6M_mean=MEAN(sHHExpNFEduGood_GiftAid_MN_6M) 
  /sHHExpNFRent_Purch_MN_6M_mean=MEAN(sHHExpNFRent_Purch_MN_6M) 
  /sHHExpNFRent_GiftAid_MN_6M_mean=MEAN(sHHExpNFRent_GiftAid_MN_6M) 
  /sHHExpNFHHSoft_Purch_MN_6M_mean=MEAN(sHHExpNFHHSoft_Purch_MN_6M) 
  /sHHExpNFHHSoft_GiftAid_MN_6M_mean=MEAN(sHHExpNFHHSoft_GiftAid_MN_6M) 
  /sHHExpNFHHMaint_Purch_MN_6M_mean=MEAN(sHHExpNFHHMaint_Purch_MN_6M) 
  /sHHExpNFHHMaint_GiftAid_MN_6M_mean=MEAN(sHHExpNFHHMaint_GiftAid_MN_6M)

EXECUTE.

* Replace outliers with mean shares.
DO REPEAT X = pc_HHExpNFHyg_Purch_MN_1M pc_HHExpNFHyg_GiftAid_MN_1M
    pc_HHExpNFTransp_Purch_MN_1M pc_HHExpNFTransp_GiftAid_MN_1M
    pc_HHExpNFFuel_Purch_MN_1M pc_HHExpNFFuel_GiftAid_MN_1M
    pc_HHExpNFWat_Purch_MN_1M pc_HHExpNFWat_GiftAid_MN_1M
    pc_HHExpNFElec_Purch_MN_1M pc_HHExpNFElec_GiftAid_MN_1M
    pc_HHExpNFEnerg_Purch_MN_1M pc_HHExpNFEnerg_GiftAid_MN_1M
    pc_HHExpNFDwelSer_Purch_MN_1M pc_HHExpNFDwelSer_GiftAid_MN_1M
    pc_HHExpNFPhone_Purch_MN_1M pc_HHExpNFPhone_GiftAid_MN_1M
    pc_HHExpNFRecr_Purch_MN_1M pc_HHExpNFRecr_GiftAid_MN_1M
    pc_HHExpNFAlcTobac_Purch_MN_1M pc_HHExpNFAlcTobac_GiftAid_MN_1M
    pc_HHExpNFMedServ_Purch_MN_6M pc_HHExpNFMedServ_GiftAid_MN_6M
    pc_HHExpNFMedGood_Purch_MN_6M pc_HHExpNFMedGood_GiftAid_MN_6M
    pc_HHExpNFCloth_Purch_MN_6M pc_HHExpNFCloth_GiftAid_MN_6M
    pc_HHExpNFEduFee_Purch_MN_6M pc_HHExpNFEduFee_GiftAid_MN_6M
    pc_HHExpNFEduGood_Purch_MN_6M pc_HHExpNFEduGood_GiftAid_MN_6M
    pc_HHExpNFRent_Purch_MN_6M pc_HHExpNFRent_GiftAid_MN_6M
    pc_HHExpNFHHSoft_Purch_MN_6M pc_HHExpNFHHSoft_GiftAid_MN_6M
    pc_HHExpNFHHMaint_Purch_MN_6M pc_HHExpNFHHMaint_GiftAid_MN_6M
    /
    Y = sHHExpNFHyg_Purch_MN_1M_mean sHHExpNFHyg_GiftAid_MN_1M_mean
    sHHExpNFTransp_Purch_MN_1M_mean sHHExpNFTransp_GiftAid_MN_1M_mean
    sHHExpNFFuel_Purch_MN_1M_mean sHHExpNFFuel_GiftAid_MN_1M_mean
    sHHExpNFWat_Purch_MN_1M_mean sHHExpNFWat_GiftAid_MN_1M_mean
    sHHExpNFElec_Purch_MN_1M_mean sHHExpNFElec_GiftAid_MN_1M_mean
    sHHExpNFEnerg_Purch_MN_1M_mean sHHExpNFEnerg_GiftAid_MN_1M_mean
    sHHExpNFDwelSer_Purch_MN_1M_mean sHHExpNFDwelSer_GiftAid_MN_1M_mean
    sHHExpNFPhone_Purch_MN_1M_mean sHHExpNFPhone_GiftAid_MN_1M_mean
    sHHExpNFRecr_Purch_MN_1M_mean sHHExpNFRecr_GiftAid_MN_1M_mean
    sHHExpNFAlcTobac_Purch_MN_1M_mean sHHExpNFAlcTobac_GiftAid_MN_1M_mean
    sHHExpNFMedServ_Purch_MN_6M_mean sHHExpNFMedServ_GiftAid_MN_6M_mean
    sHHExpNFMedGood_Purch_MN_6M_mean sHHExpNFMedGood_GiftAid_MN_6M_mean
    sHHExpNFCloth_Purch_MN_6M_mean sHHExpNFCloth_GiftAid_MN_6M_mean
    sHHExpNFEduFee_Purch_MN_6M_mean sHHExpNFEduFee_GiftAid_MN_6M_mean
    sHHExpNFEduGood_Purch_MN_6M_mean sHHExpNFEduGood_GiftAid_MN_6M_mean
    sHHExpNFRent_Purch_MN_6M_mean sHHExpNFRent_GiftAid_MN_6M_mean
    sHHExpNFHHSoft_Purch_MN_6M_mean sHHExpNFHHSoft_GiftAid_MN_6M_mean
    sHHExpNFHHMaint_Purch_MN_6M_mean sHHExpNFHHMaint_GiftAid_MN_6M_mean.

    IF (NF_OutlierFlag = 1) X = pc_HHExpNF_1M * Y.

END REPEAT.
EXECUTE.

* re-express exp vars with 6M recall into 6M period.
DO REPEAT X = pc_HHExpNFMedServ_Purch_MN_6M pc_HHExpNFMedServ_GiftAid_MN_6M
    pc_HHExpNFMedGood_Purch_MN_6M pc_HHExpNFMedGood_GiftAid_MN_6M
    pc_HHExpNFCloth_Purch_MN_6M pc_HHExpNFCloth_GiftAid_MN_6M
    pc_HHExpNFEduFee_Purch_MN_6M pc_HHExpNFEduFee_GiftAid_MN_6M
    pc_HHExpNFEduGood_Purch_MN_6M pc_HHExpNFEduGood_GiftAid_MN_6M
    pc_HHExpNFRent_Purch_MN_6M pc_HHExpNFRent_GiftAid_MN_6M
    pc_HHExpNFHHSoft_Purch_MN_6M pc_HHExpNFHHSoft_GiftAid_MN_6M
    pc_HHExpNFHHMaint_Purch_MN_6M pc_HHExpNFHHMaint_GiftAid_MN_6M.

    COMPUTE X = X * 6.

END REPEAT.
EXECUTE.

* Re-transform single exp variables from per capita to household.
DO REPEAT X =  HHExpFCer_Purch_MN_7D TO HHExpNFHHMaint_GiftAid_MN_6M / Y = pc_HHExpFCer_Purch_MN_7D TO pc_HHExpNFHHMaint_GiftAid_MN_6M.
COMPUTE X = Y*HHSize.
END REPEAT.
EXECUTE.

* Drop temporary columns.
DELETE VARIABLES pc_HHExpFCer_Purch_MN_7D TO pc_HHExpNFHHMaint_GiftAid_MN_6M.
DELETE VARIABLES o_HHExpFCer_Purch_MN_7D TO o_HHExpNFHHMaint_GiftAid_MN_6M.
DELETE VARIABLES sHHExpFCer_Purch_MN_7D TO sHHExpFOut_Own_MN_7D.
DELETE VARIABLES sHHExpFCer_Purch_MN_7D_mean TO sHHExpFOut_Own_MN_7D_mean.
DELETE VARIABLES sHHExpNFHyg_Purch_MN_1M TO sHHExpNFHHMaint_GiftAid_MN_6M.
DELETE VARIABLES sHHExpNFHyg_Purch_MN_1M_mean TO sHHExpNFHHMaint_GiftAid_MN_6M_mean.
DELETE VARIABLES pc_HHExpF_1M pc_HHExpNF_1M o_HHExpF_1M o_HHExpNF_1M temp_F temp_NF F_OutlierFlag NF_OutlierFlag.   

