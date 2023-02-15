* Encoding: UTF-8.

SPSS Syntax to compute LCS Food Security (LCS_FS)  

Please refer to Github  for additonal scripts in R and STATA data analysis tools

***Livelihood Coping ***

***define value labels 

Value labels 
Lcs_stress_DomAsset
Lcs_stress_Saving
Lcs_stress_EatOut
Lcs_stress_CrdtFood
Lcs_crisis_ProdAssets
Lcs_crisis_HealthEdu
Lcs_crisis_OutSchool
Lcs_em_ResAsset
Lcs_em_Begged
Lcs_em_IllegalAct
10 'No, because I did not need to'
20 'No, because I already sold those assets or have engaged in this activity (12 months) and cannot continue to do it'
30 'Yes'
9999 'Not applicable (don’t have children/ these assets)'.

***stress strategies*** (must have 4 stress strategies to calculate LCS-EN, if you have more then use the most frequently applied strategies)

Variable labels 
Lcs_stress_DomAsset "Sold household assets/goods (radio, furniture, refrigerator, television, jewellery etc.) due to lack of food"
Lcs_stress_Saving  "Spent savings due to lack of food"
Lcs_stress_EatOut "Sent household members to eat elsewhere/live with family or friends due to lack of food"
Lcs_stress_CrdtFood  "Purchased food/non-food on credit (incur debts) due to lack of food"
Lcs_crisis_ProdAssets  "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)  due to lack of food"
Lcs_crisis_HealthEdu "Reduced expenses on health (including drugs) or education due to lack of food"
Lcs_crisis_OutSchool  "Withdrew children from school due to lack of food"
Lcs_em_ResAsset "Mortgaged/Sold house or land due to lack of food"
Lcs_em_Begged "Begged and/or scavenged (asked strangers for money/food) due to lack of food"
Lcs_em_IllegalAct "Engaged in illegal income activities (theft, prostitution) due to lack of food".
 
Compute stress_coping_FS  = 0.
if Lcs_stress_DomAsset = 20 | Lcs_stress_DomAsset = 30 | Lcs_stress_Saving  = 20 | Lcs_stress_Saving  = 30 | Lcs_stress_EatOut =20 | Lcs_stress_EatOut =30 |  Lcs_stress_CrdtFood  =20 | Lcs_stress_CrdtFood=30 stress_coping_FS  = 1.

  ***crisis strategies***(must have 3 crisis strategies to calculate LCS-EN, if you have more then use the most frequently applied strategies)

Variable labels 
Lcs_crisis_ProdAssets "Sold productive assets or means of transport (sewing machine, wheelbarrow, bicycle, car, etc.)  due to lack of food"
Lcs_crisis_HealthEdu "Reduced expenses on health (including drugs) or education due to lack of food"
Lcs_crisis_OutSchool  "Withdrew children from school due to lack of food"

Compute crisis_coping_FS  = 0.
if Lcs_crisis_ProdAssets = 20 | Lcs_crisis_ProdAssets = 30 | Lcs_crisis_HealthEdu  = 20 | Lcs_crisis_HealthEdu  = 30 | Lcs_crisis_OutSchool =20 | Lcs_crisis_OutSchool =30 crisis_coping_FS  = 1.

***emergency strategies ***(must have 3 emergency strategies to calculate LCS, if you have more then use the most frequently applied strategies)

Variable labels 
Lcs_em_ResAsset "Mortgaged/Sold house or land due to lack of food"
Lcs_em_Begged "Begged and/or scavenged (asked strangers for money/food) due to lack of food"
Lcs_em_IllegalAct "Engaged in illegal income activities (theft, prostitution) due to lack of food"


Compute emergency_coping_FS  = 0.
if Lcs_em_ResAsset = 20 | Lcs_em_ResAsset = 30 | Lcs_em_Begged  = 20 | Lcs_em_Begged  = 30 | Lcs_em_IllegalAct =20 | Lcs_em_IllegalAct =30 emergency_coping_FS  = 1.


*** label new variable

variable labels stress_coping_FS 'Did the HH engage in stress coping strategies?'.
variable labels crisis_coping_FS 'Did the HH engage in crisis coping strategies?'.
variable labels emergency_coping_FS  'Did the HH engage in emergency coping strategies?'.

*** recode variables to compute one variable with coping behavior 

recode  stress_coping_FS (0=0) (1=2).
recode  crisis_coping_FS (0=0) (1=3).
recode  emergency_coping_FS (0=0) (1=4).

COMPUTE Max_coping_behaviourFS=MAX(stress_coping_FS,  crisis_coping_FS,  emergency_coping_FS).
RECODE Max_coping_behaviourFS (0=1).

Value labels Max_coping_behaviourFS 1 'HH not adopting coping strategies' 2 'Stress coping strategies ' 3 'Crisis coping strategies ' 4 'Emergencies coping strategies'.

Variable Labels Max_coping_behaviourFS 'Summary of asset depletion'.
EXECUTE.

Frequencies Max_coping_behaviourFS.

