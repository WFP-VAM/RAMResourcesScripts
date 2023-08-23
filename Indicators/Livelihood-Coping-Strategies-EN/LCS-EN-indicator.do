********************************************************************************
 * STATA Syntax for the Livelihood Coping Strategy for Essential Needs (LCS-EN) indicator
 *******************************************************************************
						   
* Important note: this syntax file is only an example. When calculating the indicator, you will need to include the 10 strategies (4 stress, 3 crisis, 3 emergency) that were selected for your specific case.

* Please find more guidance on the indicator at the LCS-EN VAM Resource Center page: https://resources.vam.wfp.org/data-analysis/quantitative/essential-needs/livelihood-coping-strategies-essential-needs

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* VALUE LABELS
*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

lab def LcsEN_label ///
	10 "No, because we did not need to" ///
	20 "No, because we already sold those assets or have engaged in this activity within the last 12 months and cannot continue to" ///
	30 "Yes" ///
	9999 "Not applicable (don't have children/these assets)" 
	
	
*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* TREATMENT OF MISSING VALUES
*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 	
* The LCS-EN standard module does not allow for skipping questions, so there should not be missing values. Check that indeed this is the case.
foreach var of varlist LcsEN_stress_DomAsset LcsEN_stress_Utilities LcsEN_stress_Saving LcsEN_stress_BorrowCash LcsEN_crisis_ProdAssets LcsEN_crisis_Health LcsEN_crisis_OutSchool LcsEN_em_ResAsset LcsEN_em_Begged LcsEN_em_IllegalAct {
tab `var' , missing	
}

* If there are no missings, you can just go ahead. If there are missing values, then you will need to understand why and, based on that, treat these missing values.

	* POTENTIAL REASON 1: Although not recommended, customized modules might include skip patterns to avoid asking about strategies that are not relevant for the household. For example, a skip pattern might be introduced so that a question on withdrawing children from school is not asked to households with no children. In these cases, it is important to recode missing values to 9999 "Not applicable (don't have children/these assets)". 
	
	* POTENTIAL REASON 2: Although in the standard module questions should be mandatory, customized modules might allow to skip questions (for example because the respondent refuse to answer). In these cases, missing values should be left as such.

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* STRESS STRATEGIES

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* reminder: this is just an example of four stress strategies. You will need to replace with the four strategies selected for your specific case

*Variable labels: 

lab var LcsEN_stress_DomAsset "Sold household assets/goods (radio, furniture, refrigerator, relevision, jewellery, etc.)" 

lab var LcsEN_stress_Utilities "Reduced or ceased payments on essential utilities and bills " 

lab var LcsEN_stress_Saving "Spent saving" 

lab var LcsEN_stress_BorrowCash "Borrowed cash" 


foreach var of varlist LcsEN_stress_DomAsset LcsEN_stress_Utilities LcsEN_stress_Saving LcsEN_stress_BorrowCash { 

lab val `var' LcsEN_label 
} 

 
*% of household who adopted one or more stress coping strategies 

gen stress_coping_EN=(LcsEN_stress_DomAsset==20 | LcsEN_stress_DomAsset==30) | (LcsEN_stress_Utilities==20 | LcsEN_stress_Utilities==30) | (LcsEN_stress_Saving==20 | LcsEN_stress_Saving==30) | (LcsEN_stress_BorrowCash==20 | LcsEN_stress_BorrowCash==30) 

 
lab var stress_coping_EN "Did the HH engage in stress coping strategies?" 

 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* CRISIS STRATEGIES

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* reminder: this is just an example of three crisis strategies. You will need to replace with the three strategies selected for your specific case

*Variables lables: 

lab var LcsEN_crisis_ProdAssets "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)" 

lab var LcsEN_crisis_Health "Reduced expenses on health (including medicines)" 

lab var LcsEN_crisis_OutSchool "Withdrew children from school" 

 
foreach var of varlist LcsEN_crisis_ProdAssets LcsEN_crisis_Health LcsEN_crisis_OutSchool { 

lab val `var' LcsEN_label 

} 


*% of household who adopted one or more crisis coping strategies 

gen crisis_coping_EN=(LcsEN_crisis_ProdAssets==20 | LcsEN_crisis_ProdAssets==30) | (LcsEN_crisis_Health==20 | LcsEN_crisis_Health==30) | (LcsEN_crisis_OutSchool==20 | LcsEN_crisis_OutSchool==30) 


lab var crisis_coping_EN "Did HH engage in crisis coping strategies?" 


*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* EMERGENCY STRATEGIES:

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* reminder: this is just an example of three emergency strategies. You will need to replace with the three strategies selected for your specific case

*Variables lables: 

lab var LcsEN_em_ResAsset "Mortaged/Sold house or land" 

lab var LcsEN_em_Begged "Begged and/or scavenged (asked strangers for money/food/other goods)" 

lab var LcsEN_em_IllegalAct "Had to engage in illegal income activities (theft, prostitution)" 


foreach var of varlist LcsEN_em_ResAsset LcsEN_em_Begged LcsEN_em_IllegalAct { 

lab val `var' LcsEN_label 

} 


*% of household who adopted one or more emergency coping strategies 

gen emergency_coping_EN=(LcsEN_em_ResAsset==20 | LcsEN_em_ResAsset==30) | (LcsEN_em_Begged==20 | LcsEN_em_Begged==30) | (LcsEN_em_IllegalAct==20 | LcsEN_em_IllegalAct==30) 

 lab var emergency_coping_EN "Did the HH engage in emergency coping strategies?" 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* COPING BEHAVIOR 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*

egen temp_nonmiss_number = rownonmiss(LcsEN_stress_DomAsset LcsEN_stress_Utilities LcsEN_stress_Saving LcsEN_stress_BorrowCash LcsEN_crisis_ProdAssets LcsEN_crisis_Health LcsEN_crisis_OutSchool LcsEN_em_ResAsset LcsEN_em_Begged LcsEN_em_IllegalAct)  //this variable counts the strategies with valid (i.e. non missing) values - normally it should be equal to 10 for all respondents
label var temp_nonmiss_number "Number of strategies with non missing values"
 
gen 	Max_coping_behaviourEN=1 if temp_nonmiss_number>0 // the Max_coping_behaviourEN variable will be missing for an observation if answers to strategies are all missing

replace Max_coping_behaviourEN=2 if stress_coping_EN==1 

replace Max_coping_behaviourEN=3 if crisis_coping_EN==1 

replace Max_coping_behaviourEN=4 if emergency_coping_EN==1 

 
lab var Max_coping_behaviourEN "Summary of asset depletion" 

lab def Max_coping_behaviourEN_label 1"HH not adopting coping strategies" 2"Stress coping strategies" 3"Crisis coping strategies" 4"Emergency coping strategies" 

lab val Max_coping_behaviourEN Max_coping_behaviourEN_label 

drop temp_nonmiss_number

* tabulate results
tab Max_coping_behaviourEN, missing

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* ANALYSE THE REAONS WHY STRATEGIES ARE ADOPTED

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
* The final question included in the LCS-EN module asks the main reasons why coping strategies were adopted (LhCSIEnAccess). Depending on the format you download the data sets and the import options you select the format of the variable could be different - in general, it is recommend downloading with the multiple response split into seperate columns (i.e. variables) with 1/0. The rest of the syntax assumes that the variable LhCSIEnAccess was exported in this way.

* In Stata it is assumed that varibales are named using an underscore before the suffix indicating the answer opption (i.e. LhCSIEnAccess_1, LhCSIEnAccess_2...). This is way that variables are automatically named when a dataset is saved from SPSS to Stata (DTA). In SPSS (SAV) a dot is used instead of the underscore (i.e. LhCSIEnAccess.1, LhCSIEnAccess.2...) 

* Rename variables to remove the underscore
foreach i in 1 2 3 4 5 6 7 8 999 {					   
capture confirm variable LhCSIEnAccess_`i' // check if actually the variables are named with underscore. Otherwise make sure to rename manually.
if !_rc { 
		rename LhCSIEnAccess_`i'  LhCSIEnAccess`i'
		}
		   else { 
			capture confirm variable LhCSIEnAccess`i' // check if variable already has correct name
			if !_rc { 
				   di "LhCSIEnAccess`i' already named correctly"
				   }
				   else {
				   di "LhCSIEnAccess `i' nned to be renamed manually or does not exist"
				   }
				  }
}

* Label variables
label var LhCSIEnAccess1 "Adopted strategies to buy food" 
label var LhCSIEnAccess2 "Adopted strategies to pay for rent" 
label var LhCSIEnAccess3 "Adopted strategies to pay school, education costs" 
label var LhCSIEnAccess4 "Adopted strategies to cover health expenses" 
label var LhCSIEnAccess5 "Adopted strategies to buy essential non-food items (clothes, small furniture)" 
label var LhCSIEnAccess6 "Adopted strategies to access water or sanitation facilities" 
label var LhCSIEnAccess7 "Adopted strategies to access essential dwelling services (electricity, energy, waste disposal...)" 
label var LhCSIEnAccess8 "Adopted strategies to pay for existing debts" 
label var LhCSIEnAccess999 "Adopted strategies for other reasons" 

*tabulate results  

tabstat LhCSIEnAccess1 LhCSIEnAccess2 LhCSIEnAccess3 LhCSIEnAccess4 LhCSIEnAccess5 LhCSIEnAccess6 LhCSIEnAccess7 LhCSIEnAccess8 LhCSIEnAccess999,statistics(mean) columns(statistics) 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* CALCULATING LCS-FS USING THE LCS-EN MODULE

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
* To estimate food insecurity using CARI, the LCS-FS indicator should be used. In this case the LCS-EN inidicator can be converted to the LCS-FS using the final question included in the LCS-EN module asking the main reasons why coping strategies were adopted (LhCSIEnAccess). If "to buy food" is not among the reasons selected for applying livelihood coping strategies then these cases/households should be considered under "not coping" when computing CARI 


gen Max_coping_behaviourFS = Max_coping_behaviourEN if Max_coping_behaviourEN!=. // generate variable in order to continue with CARI syntax 

replace Max_coping_behaviourFS=1 if LhCSIEnAccess1==0 & Max_coping_behaviourFS!=.
label var Max_coping_behaviourFS "Summary of asset depletion (converted from EN to FS)" 

* tabulate results
tab Max_coping_behaviourFS, missing
