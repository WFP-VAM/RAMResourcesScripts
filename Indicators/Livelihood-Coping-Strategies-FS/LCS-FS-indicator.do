********************************************************************************
 * STATA Syntax for the Livelihood Coping Strategy for Food Security (LCS-FS) indicator
 *******************************************************************************
						   
* Important note: this syntax file is only an example. When calculating the indicator, you will need to include the 10 strategies (4 stress, 3 crisis, 3 emergency) that were selected for your specific case.

* Please find more guidance on the indicator at the LCS-FS VAM Resource Center page: https://resources.vam.wfp.org/data-analysis/quantitative/food-security/livelihood-coping-strategies-food-security

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* VALUE LABELS
*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

lab def Lcs_label ///
	10 "No, because we did not need to" ///
	20 "No, because we already sold those assets or have engaged in this activity within the last 12 months and cannot continue to" ///
	30 "Yes" ///
	9999 "Not applicable (don't have children/these assets)" 
	
	
*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* TREATMENT OF MISSING VALUES
*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 	
* The LCS-FS standard module does not allow for skipping questions, so there should not be missing values. Check that indeed this is the case.
foreach var of varlist Lcs_stress_DomAsset Lcs_stress_Utilities Lcs_stress_Saving Lcs_stress_BorrowCash Lcs_crisis_ProdAssets Lcs_crisis_Health Lcs_crisis_OutSchool Lcs_em_ResAsset Lcs_em_Begged Lcs_em_IllegalAct {
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

lab var Lcs_stress_DomAsset "Sold household assets/goods (radio, furniture, refrigerator, relevision, jewellery, etc.)" 

lab var Lcs_stress_Utilities "Reduced or ceased payments on essential utilities and bills " 

lab var Lcs_stress_Saving "Spent saving" 

lab var Lcs_stress_BorrowCash "Borrowed cash" 


foreach var of varlist Lcs_stress_DomAsset Lcs_stress_Utilities Lcs_stress_Saving Lcs_stress_BorrowCash { 

lab val `var' Lcs_label 
} 

 
*% of household who adopted one or more stress coping strategies 

gen stress_coping_FS=(Lcs_stress_DomAsset==20 | Lcs_stress_DomAsset==30) | (Lcs_stress_Utilities==20 | Lcs_stress_Utilities==30) | (Lcs_stress_Saving==20 | Lcs_stress_Saving==30) | (Lcs_stress_BorrowCash==20 | Lcs_stress_BorrowCash==30) 

 
lab var stress_coping_FS "Did the HH engage in stress coping strategies?" 

 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* CRISIS STRATEGIES

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* reminder: this is just an example of three crisis strategies. You will need to replace with the three strategies selected for your specific case

*Variables lables: 

lab var Lcs_crisis_ProdAssets "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)" 

lab var Lcs_crisis_Health "Reduced expenses on health (including medicines)" 

lab var Lcs_crisis_OutSchool "Withdrew children from school" 

 
foreach var of varlist Lcs_crisis_ProdAssets Lcs_crisis_Health Lcs_crisis_OutSchool { 

lab val `var' Lcs_label 

} 


*% of household who adopted one or more crisis coping strategies 

gen crisis_coping_FS=(Lcs_crisis_ProdAssets==20 | Lcs_crisis_ProdAssets==30) | (Lcs_crisis_Health==20 | Lcs_crisis_Health==30) | (Lcs_crisis_OutSchool==20 | Lcs_crisis_OutSchool==30) 


lab var crisis_coping_FS "Did HH engage in crisis coping strategies?" 


*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* EMERGENCY STRATEGIES:

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 
* reminder: this is just an example of three emergency strategies. You will need to replace with the three strategies selected for your specific case

*Variables lables: 

lab var Lcs_em_ResAsset "Mortaged/Sold house or land" 

lab var Lcs_em_Begged "Begged and/or scavenged (asked strangers for money/food/other goods)" 

lab var Lcs_em_IllegalAct "Had to engage in illegal income activities (theft, prostitution)" 


foreach var of varlist Lcs_em_ResAsset Lcs_em_Begged Lcs_em_IllegalAct { 

lab val `var' Lcs_label 

} 


*% of household who adopted one or more emergency coping strategies 

gen emergency_coping_FS=(Lcs_em_ResAsset==20 | Lcs_em_ResAsset==30) | (Lcs_em_Begged==20 | Lcs_em_Begged==30) | (Lcs_em_IllegalAct==20 | Lcs_em_IllegalAct==30) 

 lab var emergency_coping_FS "Did the HH engage in emergency coping strategies?" 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* COPING BEHAVIOR 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*

egen temp_nonmiss_number = rownonmiss(Lcs_stress_DomAsset Lcs_stress_Utilities Lcs_stress_Saving Lcs_stress_BorrowCash Lcs_crisis_ProdAssets Lcs_crisis_Health Lcs_crisis_OutSchool Lcs_em_ResAsset Lcs_em_Begged Lcs_em_IllegalAct)  //this variable counts the strategies with valid (i.e. non missing) values - normally it should be equal to 10 for all respondents
label var temp_nonmiss_number "Number of strategies with non missing values"
 
gen 	Max_coping_behaviourFS=1 if temp_nonmiss_number>0 // the Max_coping_behaviourFS variable will be missing for an observation if answers to strategies are all missing

replace Max_coping_behaviourFS=2 if stress_coping_FS==1 

replace Max_coping_behaviourFS=3 if crisis_coping_FS==1 

replace Max_coping_behaviourFS=4 if emergency_coping_FS==1 

 
lab var Max_coping_behaviourFS "Summary of asset depletion" 

lab def Max_coping_behaviourFS_label 1"HH not adopting coping strategies" 2"Stress coping strategies" 3"Crisis coping strategies" 4"Emergency coping strategies" 

lab val Max_coping_behaviourFS Max_coping_behaviourFS_label 

drop temp_nonmiss_number

* tabulate results
tab Max_coping_behaviourFS, missing

