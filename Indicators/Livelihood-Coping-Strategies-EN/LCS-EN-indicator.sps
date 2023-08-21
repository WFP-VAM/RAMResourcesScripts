* Encoding: UTF-8.
********************************************************************************
 * SPSS Syntax for the Livelihood Coping Strategy for Food Security (LCS-EN) indicator
 *******************************************************************************
						   
* Important note: this syntax file is only an example. When calculating the indicator, you will need to include the 10 strategies (4 stress, 3 crisis, 3 emergency) that were selected for your specific case.

* Please find more guidance on the indicator at the LCS-EN VAM Resource Center page: https://resources.vam.wfp.org/data-analysis/quantitative/essential-needs/livelihood-coping-strategies-essential-needs

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* VALUE LABELS
*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

VALUE LABELS
     LcsEN_stress_DomAsset 
     LcsEN_stress_Utilities 
     LcsEN_stress_Saving 
     LcsEN_stress_BorrowCash 
     LcsEN_crisis_ProdAssets 
     LcsEN_crisis_Health 
     LcsEN_crisis_OutSchool 
     LcsEN_em_ResAsset 
     LcsEN_em_Begged 
     LcsEN_em_IllegalAct 
    10 'No, because we did not need to' 
    20 'No, because we already sold those assets or have engaged in this activity within the last 12 months and cannot continue to' 
    30 'Yes' 
    9999 'Not applicable (do not have children/these assets)'.
	
	
*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* TREATMENT OF MISSING VALUES

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 	
* The LCS-EN standard module does not allow for skipping questions, so there should not be missing values. Check that indeed this is the case.
FREQUENCIES LcsEN_stress_DomAsset LcsEN_stress_Utilities LcsEN_stress_Saving LcsEN_stress_BorrowCash LcsEN_crisis_ProdAssets LcsEN_crisis_Health LcsEN_crisis_OutSchool LcsEN_em_ResAsset LcsEN_em_Begged LcsEN_em_IllegalAct.
	
* If there are no missings, you can just go ahead. If there are missing values, then you will need to understand why and, based on that, treat these missing values.

            * POTENTIAL REASON 1: Although not recommended, customized modules might include skip patterns to avoid asking about strategies that are not relevant for the household. 
                                                                               *For example, a skip pattern might be introduced so that a question on withdrawing children from school is not asked to households with no children. 
                                                                                *In these cases, it is important to recode missing values to 9999 'Not applicable (don't have children/these assets)'. 
            
            * POTENTIAL REASON 2: Although in the standard module questions should be mandatory, customized modules might allow to skip questions (for example because the respondent refuse to answer). 
                                                                                *In these cases, missing values should be left as such.

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* STRESS STRATEGIES

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* reminder: this is just an example of four stress strategies. You will need to replace with the four strategies selected for your specific case

*Variable labels: 

VARIABLE LABELS
 LcsEN_stress_DomAsset "Sold household assets/goods (radio, furniture, refrigerator, relevision, jewellery, etc.)" 
 LcsEN_stress_Utilities "Reduced or ceased payments on essential utilities and bills " 
 LcsEN_stress_Saving "Spent saving" 
 LcsEN_stress_BorrowCash "Borrowed cash" .


*% of household who adopted one or more stress coping strategies 

DO IF LcsEN_stress_DomAsset=20 | LcsEN_stress_DomAsset=30 | LcsEN_stress_Utilities=20 | LcsEN_stress_Utilities=30 | LcsEN_stress_Saving=20 | LcsEN_stress_Saving=30 | LcsEN_stress_BorrowCash=20 | LcsEN_stress_BorrowCash=30. 
COMPUTE stress_coping_EN=1.
ELSE. 
COMPUTE stress_coping_EN = 0. 
 END IF.

VARIABLE LABELS stress_coping_EN "Did the HH engage in stress coping strategies?" .

 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* CRISIS STRATEGIES

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* reminder: this is just an example of three crisis strategies. You will need to replace with the three strategies selected for your specific case

*Variables lables: 

Variable labels 
LcsEN_crisis_ProdAssets "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.) "
LcsEN_crisis_Health "Reduced expenses on health (including drugs)"
LcsEN_crisis_OutSchool  "Withdrew children from school".


*% of household who adopted one or more crisis coping strategies 

DO IF LcsEN_crisis_ProdAssets = 20 | LcsEN_crisis_ProdAssets = 30 | LcsEN_crisis_Health  = 20 | LcsEN_crisis_Health  = 30 | LcsEN_crisis_OutSchool =20 | LcsEN_crisis_OutSchool =30.

COMPUTE crisis_coping_EN =1. 
ELSE. 
COMPUTE crisis_coping_EN =0.  
END IF. 

EXECUTE. 

VARIABLE LABELS crisis_coping_EN "Did the HH engage in crisis coping strategies?" .


*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* EMERGENCY STRATEGIES:

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* reminder: this is just an example of three emergency strategies. You will need to replace with the three strategies selected for your specific case

*Variables lables: 

VARIABLE LABELS
 LcsEN_em_ResAsset "Mortaged/Sold house or land" 
 LcsEN_em_Begged "Begged and/or scavenged (asked strangers for money/food/other goods)" 
 LcsEN_em_IllegalAct "Had to engage in illegal income activities (theft, prostitution)" .

*% of household who adopted one or more emergency coping strategies 

DO IF LcsEN_em_ResAsset = 20 | LcsEN_em_ResAsset = 30 | LcsEN_em_Begged  = 20 | LcsEN_em_Begged  = 30 | LcsEN_em_IllegalAct =20 | LcsEN_em_IllegalAct =30.

COMPUTE emergency_coping_EN =1. 
ELSE. 
COMPUTE emergency_coping_EN =0.  
END IF. 

VARIABLE LABELS emergency_coping_EN  'Did the HH engage in emergency coping strategies?'.

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* COPING behaviour 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*

* this variable counts the strategies with valid (i.e. non missing) values - normally it should be equal to 10 for all respondents.
COMPUTE temp_nonmiss_number=NVALID(LcsEN_stress_DomAsset, LcsEN_stress_Utilities , LcsEN_stress_Saving , LcsEN_stress_BorrowCash , LcsEN_crisis_ProdAssets , +
                      LcsEN_crisis_Health , LcsEN_crisis_OutSchool , LcsEN_em_ResAsset , LcsEN_em_Begged , LcsEN_em_IllegalAct).
EXECUTE.
VARIABLE LABELS temp_nonmiss_number  "Number of strategies with non missing values".

 IF  (temp_nonmiss_number>0) Max_coping_behaviourEN=1.
* the Max_coping_behaviourEN variable will be missing for an observation if answers to strategies are all missing.
IF (stress_coping_EN=1) Max_coping_behaviourEN=2.
IF (crisis_coping_EN=1) Max_coping_behaviourEN=3.
IF  (emergency_coping_EN=1) Max_coping_behaviourEN=4.
 EXECUTE.

VALUE LABELS Max_coping_behaviourEN 1 'HH not adopting coping strategies' 2 'Stress coping strategies ' 3 'Crisis coping strategies ' 4 'Emergencies coping strategies'.
VARIABLE LABELS Max_coping_behaviourEN "Summary of asset depletion".


DELETE VARIABLES temp_nonmiss_number.
EXECUTE.

* tabulate results.
FREQUENCIES Max_coping_behaviourEN.


*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* ANALYSE THE REAONS WHY STRATEGIES ARE ADOPTED

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
* The final question included in the LCS-EN module asks the main reasons why coping strategies were adopted (LhCSIEnAccess). 
*Depending on the format you download the data sets and the import options you select the format of the variable could be different. 
 *In general, it is recommend downloading with the multiple response split into seperate columns (i.e. variables) with 1/0. 
 *The rest of the syntax assumes that the variable LhCSIEnAccess was exported in this way.

* In SPSS it is assumed that varibales are named using a dot before the suffix indicating the answer opption (i.e. LhCSIEnAccess.1, LhCSIEnAccess.2...). 
* This is way that variables are automatically named when a dataset is exported to SPSS (SAV) format  (i.e. LhCSIEnAccess.1, LhCSIEnAccess.2...) 

* Rename variables to remove the dot.
RENAME VARIABLES (LhCSIEnAccess.1 LhCSIEnAccess.2 LhCSIEnAccess.3 LhCSIEnAccess.4 LhCSIEnAccess.5 LhCSIEnAccess.6 LhCSIEnAccess.7 LhCSIEnAccess.8 LhCSIEnAccess.999 = 
                                         LhCSIEnAccess1 LhCSIEnAccess2 LhCSIEnAccess3 LhCSIEnAccess4 LhCSIEnAccess5 LhCSIEnAccess6 LhCSIEnAccess7 LhCSIEnAccess8 LhCSIEnAccess999).
EXECUTE.

VARIABLE LABELS
 LhCSIEnAccess1 "Adopted strategies to buy food" 
 LhCSIEnAccess2 "Adopted strategies to pay for rent" 
 LhCSIEnAccess3 "Adopted strategies to pay school, education costs" 
 LhCSIEnAccess4 "Adopted strategies to cover health expenses" 
 LhCSIEnAccess5 "Adopted strategies to buy essential non-food items (clothes, small furniture)" 
 LhCSIEnAccess6 "Adopted strategies to access water or sanitation facilities" 
 LhCSIEnAccess7 "Adopted strategies to access essential dwelling services (electricity, energy, waste disposal...)" 
 LhCSIEnAccess8 "Adopted strategies to pay for existing debts" 
 LhCSIEnAccess999 "Adopted strategies for other reasons" .

*tabulate results . 
DESCRIPTIVES VARIABLES=LhCSIEnAccess1 LhCSIEnAccess2 LhCSIEnAccess3 LhCSIEnAccess4 LhCSIEnAccess5 
    LhCSIEnAccess6 LhCSIEnAccess7 LhCSIEnAccess8 LhCSIEnAccess999
  /STATISTICS=MEAN.



*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* CALCULATING LCS-FS USING THE LCS-EN MODULE

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
* To estimate food insecurity using CARI, the LCS-FS indicator should be used. 
* In this case the LCS-EN inidicator can be converted to the LCS-FS using the final question included in the LCS-EN module asking the main reasons why coping strategies were adopted (LhCSIEnAccess). 
* If "to buy food" is not among the reasons selected for applying livelihood coping strategies then these cases/households should be considered under "not coping" when computing CARI 



IF (NOT SYSMIS(Max_coping_behaviourEN)) Max_coping_behaviourFS = Max_coping_behaviourEN.
EXECUTE.

IF (LhCSIEnAccess1=0 & NOT SYSMIS(Max_coping_behaviourFS)) Max_coping_behaviourFS=1. 
EXECUTE.

VARIABLE LABELS Max_coping_behaviourFS "Summary of asset depletion (converted from EN to FS)". 


