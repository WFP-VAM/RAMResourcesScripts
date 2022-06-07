
SPSS Syntax to compute LCS essential needs (LCS_EN)  

Please refer to Github  for additonal scripts in R and STATA data analysis tools

***Livelihood Coping ***

***define value labels 



Value labels 
LcsEN_stress_DomAsset
LcsEN_stress_CrdtFood
LcsEN_stress_Saving
LcsEN_stress_BorrowCash
LcsEN_crisis_ProdAsset
LcsEN_crisis_HealthEdu
LcsEN_crisis_OutSchool
LcsEN_em_IllegalAct
LcsEN_em_Begged
LcsEN_em_ResAsset
10 ‘No, because I did not need to’
20 ‘No because I already sold those assets or have engaged in this activity within the last 12 months and cannot continue to do it’
30 ‘Yes’
9999 ‘Not applicable (don’t have children/ these assets)’.

***stress strategies*** (must have 4 stress strategies to calculate LCS-EN, if you have more then use the most frequently applied strategies)

Variable labels 
LcsEN_stress_DomAsset	‘Sold household assets/goods (radio, furniture, refrigerator, television, jewellery etc.)’
LcsEN_stress_CrdtFood	‘Purchased food or other essential items on credit’
LcsEN_stress_Saving	‘Spent savings’
LcsEN_stress_BorrowCash	‘Borrowed money’.

Do if (LcsEN_stress_DomAsset = 20) | (LcsEN_stress_DomAsset = 30) | (LcsEN_stress_CrdtFood = 20) | (LcsEN_stress_CrdtFood = 30) | (LcsEN_stress_Saving =20) | (LcsEN_stress_Saving =30) | (LcsEN_stress_BorrowCash  =20) | (LcsEN_stress_BorrowCash=30).

Compute stress_coping_EN =1.
Else.
Compute stress_coping_EN =0.
End if.
EXECUTE.

  ***crisis strategies***(must have 3 crisis strategies to calculate LCS-EN, if you have more then use the most frequently applied strategies)

Variable labels 
LcsEN_crisis_ProdAsset	‘Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)’
LcsEN_crisis_HealthEdu	‘Reduced expenses on health (including drugs) or education’
LcsEN_crisis_OutSchool	‘Withdrew children from school.’

Do if (LcsEN_crisis_ProdAsset = 20) | (LcsEN_crisis_ProdAsset =30) | (LcsEN_crisis_HealthEdu =20) | (LcsEN_crisis_HealthEdu=30) | (LcsEN_crisis_OutSchool =20) | (LcsEN_crisis_OutSchool =30).

Compute crisis_coping_EN =1.
Else.
Compute crisis_coping_EN =0. 
End if.
EXECUTE.

***emergency strategies ***(must have 3 emergency strategies to calculate LCS, if you have more then use the most frequently applied strategies)

Variable labels 
LcsEN_em_ResAsset	‘Mortgaged/Sold house or land’
LcsEN_em_Begged	‘Begged and/or scavenged (asked strangers for money/food)’
LcsEN_em_IllegalAct	‘Had to engage in illegal income activities (theft, prostitution)’.

Do if (LcsEN_em_ResAsset = 20) | (LcsEN_em_ResAsset = 30) | (LcsEN_em_Begged = 20) | (LcsEN_em_Begged =30) | (LcsEN_em_IllegalAct = 20) | (LcsEN_em_IllegalAct = 30).

Compute emergency_coping_EN =1.
Else.
Compute emergency_coping_EN = 0.
End if.
EXECUTE.

*** label new variable

variable labels stress_coping_EN 'Did the HH engage in stress coping strategies?'.
variable labels crisis_coping_EN 'Did the HH engage in crisis coping strategies?'.
variable labels emergency_coping_EN  'Did the HH engage in emergency coping strategies?'.

*** recode variables to compute one variable with coping behavior 

recode  stress_coping_EN (0=0) (1=2).
recode  crisis_coping_EN (0=0) (1=3).
recode  emergency_coping_EN (0=0) (1=4).

COMPUTE Max_coping_behaviourEN=MAX(stress_coping_EN,  crisis_coping_EN,  emergency_coping_EN).
RECODE Max_coping_behaviour (0=1).

Value labels Max_coping_behaviourEN 1 'HH not adopting coping strategies' 2 'Stress coping strategies ' 3 'Crisis coping strategies ' 4 'Emergencies coping strategies'.

Variable Labels Max_coping_behaviourEN 'Summary of asset depletion'.
EXECUTE.

Frequencies Max_coping_behaviourEN.

***calculate LCS-FS indicator using the LCS-EN module to be able to calculate CARI 

***define value labels 

Value labels EnAccessRsn
1 ‘To buy food’
2 ‘To pay for rent’
3 ‘To pay school, education costs’
4 ‘To cover health expenses‘
5 ‘To buy essential non-food items (clothes, small furniture...)’
6 ‘To access water or sanitation facilities’
7 ‘To access essential dwelling services (electricity, energy, waste disposal…)’
8 ‘To pay for existing debts’
999 ‘Other, specify’.

*Create a multi-response dataset for reasons selected for applying livelihood coping strategies

MRSETS
  /MDGROUP NAME=$ReasonsforCoping CATEGORYLABELS=VARLABELS VARIABLES= LhCSIEnAccess/1 LhCSIEnAccess/2 LhCSIEnAccess/3 LhCSIEnAccess/4 LhCSIEnAccess/5 LhCSIEnAccess/6 LhCSIEnAccess/7 LhCSIEnAccess/8 LhCSIEnAccess/999 
VALUE=1
 /DISPLAY NAME=[$ReasonsforCoping].

*Customs table to check frequencies for each reason by column percentages and table column percentages

CTABLES
  /VLABELS VARIABLES=$ReasonsforCoping DISPLAY=LABEL
  /TABLE $ReasonsforCoping [COLPCT.RESPONSES.COUNT PCT40.1, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=$ReasonsforCoping  EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

***********************************Calculating LCS-FS using the LCS-EN module************************************

***Important note: If ‘to buy food’ is not among the reasons selected for applying livelihood coping strategies then these case/households should be considered under ‘not coping’ when computing CARI. 

/*If the design of this question provides responses in a single cell then the analyst should manually split the responses in excel prior to running this syntax


***define value labels 
Value labels EnAccessRsn
LhCSIEnAccess/1 = To buy food

If (LhCSIEnAccess/1=0) Max_coping_behaviourEN =1. 
*rename variable in order to continue with the CARI syntax. 

Rename variable (Max_coping_behaviourEN=Max_coping_behaviour). 
Frequencies Max_coping_behaviour. 


