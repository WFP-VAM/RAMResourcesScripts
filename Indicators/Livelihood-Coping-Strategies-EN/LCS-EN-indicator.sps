* Encoding: UTF-8.

**SPSS Syntax to compute LCS essential needs (LCS_EN)  

***Please refer to Github  for additonal scripts in R and STATA data analysis tools

***Livelihood Coping ***

***define value labels 



Value labels 
LcsEN_stress_DomAsset
LcsEN_stress_CrdtFood
LcsEN_stress_Saving
LcsEN_stress_BorrowCash
LcsEN_crisis_ProdAssets
LcsEN_crisis_Health
LcsEN_crisis_OutSchool
LcsEN_em_IllegalAct
LcsEN_em_Begged
LcsEN_em_ResAsset
10 'No, because I did not need to'
20 'No, because I already sold those assets or have engaged in this activity (12 months) and cannot continue to do it'
30 'Yes'
9999 'Not applicable (don’t have access to this strategy)'.

***stress strategies*** (must have 4 stress strategies to calculate LCS-EN, if you have more then use the most frequently applied strategies)

Variable labels 
LcsEN_stress_DomAsset "Sold household assets/goods (radio, furniture, television, jewellery etc.) to meet essential needs"
LcsEN_stress_CrdtFood	"Purchased food or other essential items on credit"
LcsEN_stress_Saving	"Spent savings to meet essential needs"
LcsEN_stress_BorrowCash "Borrowed money to meet essential needs".

Do if (LcsEN_stress_DomAsset = 20) | (LcsEN_stress_DomAsset = 30) | (LcsEN_stress_CrdtFood = 20) | (LcsEN_stress_CrdtFood = 30) | (LcsEN_stress_Saving =20) | (LcsEN_stress_Saving =30) | (LcsEN_stress_BorrowCash  =20) | (LcsEN_stress_BorrowCash=30).

Compute stress_coping_EN =1.
Else.
Compute stress_coping_EN =0.
End if.
EXECUTE.

  ***crisis strategies***(must have 3 crisis strategies to calculate LCS-EN, if you have more then use the most frequently applied strategies)

Variable labels 
LcsEN_crisis_ProdAssets "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.) to meet essential needs"
LcsEN_crisis_Health "Reduced expenses on health (including drugs) to meet other essential needs"
LcsEN_crisis_OutSchool	"Withdrew children from school to meet essential needs".

Do if (LcsEN_crisis_ProdAssets = 20) | (LcsEN_crisis_ProdAssets =30) | (LcsEN_crisis_Health =20) | (LcsEN_crisis_Health =30) | (LcsEN_crisis_OutSchool =20) | (LcsEN_crisis_OutSchool =30).

Compute crisis_coping_EN =1.
Else.
Compute crisis_coping_EN =0. 
End if.
EXECUTE.

***emergency strategies ***(must have 3 emergency strategies to calculate LCS, if you have more then use the most frequently applied strategies)

Variable labels 
LcsEN_em_ResAsset	"Mortgaged/Sold ?house that the household was permanently living in or sold land to meet essential needs"
LcsEN_em_Begged	"Begged and/or scavenged (asked strangers for money/food) to meet essential needs"
LcsEN_em_IllegalAct	"Engaged in socially degrading, high risk, or exploitive jobs, or life-threatening income activities (e.g., smuggling, theft, join armed groups, prostitution) to meet essential needs".

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
RECODE Max_coping_behaviourEN (0=1).

Value labels Max_coping_behaviourEN 1 'HH not adopting coping strategies' 2 'Stress coping strategies ' 3 'Crisis coping strategies ' 4 'Emergencies coping strategies'.

Variable Labels Max_coping_behaviourEN 'Summary of asset depletion'.
EXECUTE.

Frequencies Max_coping_behaviourEN.

***calculate LCS-FS indicator using the LCS-EN module to be able to calculate CARI 
    
**depending on the format you download the data sets and the import options you select the format of the variable could be different - in general, recommend downloading with the multiple response split into seperate columns with 1/0 

***define value labels

Variable labels
LhCSIEnAccess1 "To buy food"
LhCSIEnAccess2 "To pay for rent or access adequate shelter"
LhCSIEnAccess3 "To pay for school fees and other education costs"
LhCSIEnAccess4 "To cover health expenses"
LhCSIEnAccess5 "To buy essential non-food items (clothes, small furniture...)"
LhCSIEnAccess6 "To access water or sanitation facilities"
LhCSIEnAccess7 "To access essential dwelling services (electricity, energy, waste disposal…)"
LhCSIEnAccess8 "To pay for existing debts"
LhCSIEnAccess999 "Other".

*Create a multi-response dataset for reasons selected for applying livelihood coping strategies


MULT RESPONSE GROUPS=$ReasonsforCoping 'Reasons for Coping' (lhcsienaccess1 lhcsienaccess2 lhcsienaccess3 lhcsienaccess4 
    lhcsienaccess5 lhcsienaccess6 lhcsienaccess7 lhcsienaccess8 lhcsienaccess999 (1))
  /FREQUENCIES=$ReasonsforCoping.

*Customs table to check frequencies for each reason by column percentages and table column percentages

CTABLES
  /VLABELS VARIABLES=$ReasonsforCoping DISPLAY=LABEL
  /TABLE $ReasonsforCoping [COLPCT.RESPONSES.COUNT PCT40.1, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=$ReasonsforCoping  EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

***********************************Calculating LCS-FS using the LCS-EN module************************************

***Important note: If "To buy food" is not among the reasons selected for applying livelihood coping strategies then these case/households should be considered under  'HH not adopting coping strategies' when computing CARI. 

/*If the design of this question provides responses in a single cell then the analyst should manually split the responses in excel prior to running this syntax


***define value labels 


If (LhCSIEnAccess1=0) Max_coping_behaviourEN =1. 
*rename variable in order to continue with the CARI syntax. 

Rename variable (Max_coping_behaviourEN=Max_coping_behaviour). 
Frequencies Max_coping_behaviour. 




