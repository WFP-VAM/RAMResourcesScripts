*Households are classified according to the nature of their coping strategies, which are grouped into three categories based on the severity of their implications 

 

*Values labels: 

lab def LcsEN_label 1"No, because I did not need to" 2"No, because I already sold those assets or have engaged in this activity within the last 12 months and cannot continue to do it" 3"Yes" 4"Not applicable (don't have children/these assets)" 

 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

*1. STRESS STRATEGIES: sold household assets, purchased on credit, spent savings, borrowed money 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

*Variable labels: 

lab var LcsEN_stress_DomAsset "Sold household assets/goods (radio, furniture, refrigerator, relevision, jewellery, etc.)" 

lab var LcsEN_stress_CrdtFood "Purchase foos or other essential items on credit" 

lab var LcsEN_stress_Saving "Spent saving" 

lab var LcsEN_stress_BorrowCash "Borrow cash" 

 

foreach var of varlist LcsEN_stress_DomAsset LcsEN_stress_CrdtFood LcsEN_stress_Saving LcsEN_stress_BorrowCash { 

lab val `var' LcsEN_label 

} 

 

 

*% of household who adopted one or more stress coping strategies 

gen byte stress_coping_EN=(LcsEN_stress_DomAsset==2 | LcsEN_stress_DomAsset==3) | (LcsEN_stress_CrdtFood==2 | LcsEN_stress_CrdtFood==3) | (LcsEN_stress_Saving==2 | LcsEN_stress_Saving==3) | (LcsEN_stress_BorrowCash==2 | LcsEN_stress_BorrowCash==3) 

 

lab var stress_coping_EN "Did the HH engage in stress coping strategies?" 

 

 

 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

*2. CRISIS STRATEGIES: sold productive assets, reduced expenses for health/education, withdrew children from school 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

*Variables lables: 

lab var LcsEN_crisis_ProdAssets "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)" 

lab var LcsEN_crisis_HealthEdu "Reduced expenses on health (inclusing drugs) or education" 

lab var LcsEN_crisis_OutSchool "Withdrew children from school" 

 

foreach var of varlist LcsEN_crisis_ProdAssets LcsEN_crisis_HealthEdu LcsEN_crisis_OutSchool { 

lab val `var' LcsEN_label 

} 

 

 

*% of household who adopted one or more crisis coping strategies 

gen byte crisis_coping_EN=(LcsEN_crisis_ProdAssets==2 | LcsEN_crisis_ProdAssets==3) | (LcsEN_crisis_HealthEdu==2 | LcsEN_crisis_HealthEdu==3) | (LcsEN_crisis_OutSchool==2 | LcsEN_crisis_OutSchool==3) 

 

lab var crisis_coping_EN "Did HH engage in crisis coping strategies?" 


 

 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

*3. EMERGENCY STRATEGIES: sold house/land, begged, engaged in illegal income activities 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

*Variables lables: 

lab var LcsEN_em_ResAsset "Mortaged/Sold house or land" 

lab var LcsEN_em_Begged "Begged and/or scavenged (asked strangers for money/food)" 

lab var LcsEN_em_IllegalAct "Had to engage in illegal income activities (theft, prostitution)" 

 

foreach var of varlist LcsEN_em_ResAsset LcsEN_em_Begged LcsEN_em_IllegalAct { 

lab val `var' LcsEN_label 

} 

 

*% of household who adopted one or more emergency coping strategies 

gen byte emergency_coping_EN=(LcsEN_em_ResAsset==2 | LcsEN_em_ResAsset==3) | (LcsEN_em_Begged==2 | LcsEN_em_Begged==3) | (LcsEN_em_IllegalAct==2 | LcsEN_em_IllegalAct==3) 

 

lab var emergency_coping_EN "Did the HH engage in emergency coping strategies?" 

 

 

 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

*COPING BEHAVIOR 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

 

gen Max_coping_behaviorEN=1 

replace Max_coping_behaviorEN=2 if stress_coping_EN==1 

replace Max_coping_behaviorEN=3 if crisis_coping_EN==1 

replace Max_coping_behaviorEN=4 if emergency_coping_EN==1 

 

lab var Max_coping_behaviorEN "Summary of asset depletion" 

lab def Max_coping_behaviorEN_label 1"HH not adopting coping strategies" 2"Stress coping strategies" 3"Crisis coping strategies" 4"Emergency coping strategies" 

lab val Max_coping_behaviorEN Max_coping_behaviorEN_label 

  

 

 

*Calculate LCS-FS indicator using the LCS-EN module to be able to calculate CARI 

 

*Values labels: 

lab def EnAccessRsn_label 1"To buy food" 2"To pay for rent" 3"To pay school, education costs" 4"To cover health expenses" 5"To buy essential non-food items (clothes, small furniture)" 6"To access water or sanitation facilities" 7"To access essential dwelling services (electricity, energy, waste disposal...)" 8"To pay for existing debts" 999"Other, specify" 

 

lab val EnAccessRsn EnAccessRsn_label 

 

 

*tabulate results  

tabstat LhCSIEnAccess1 LhCSIEnAccess2 LhCSIEnAccess3 LhCSIEnAccess4 LhCSIEnAccess5 LhCSIEnAccess6 LhCSIEnAccess7 LhCSIEnAccess8 LhCSIEnAccess999,statistics(mean) columns(statistics) 

 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

* Calculating LCS-FS using the LCS-EN module*************************************----------------------------------------------------------------------------------------------------------------------------------------------------------------* 

 

 

***Important note: If `to buy food' is not among the reasons selected for applying livelihood coping strategies then these case/households should be considered under `not coping' when computing CARI 

*If the design of this question provides responses in a single cell then the analyst should manually split the responses in excel prior to running this syntax 

 

 

replace Max_coping_behaviorEN=1 if LhCSIEnAccess1==0 

 

*rename variable in order to continue with CARI syntax 

rename Max_coping_behaviorEN Max_coping_behavior 
