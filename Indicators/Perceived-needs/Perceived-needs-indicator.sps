********************************************************************************
*                         WFP Standardized Scripts                             *
*                   Perceived Needs Indicators Calculation                     *
********************************************************************************

* NOTE: this syntax file assumes the use of all the questions included in the standard module.
* If any question is dropped, the corresponding variable names should be deleted from the syntax file.
* The sample data on which this syntax file is based can be found here:
* https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Static
* For more information on the Perceived Needs Indicators (including module), see the VAM Resource Center:
* https://resources.vam.wfp.org/data-analysis/quantitative/essential-needs/perceived-needs-indicators

*-------------------------------------------------------------------------------*
* Open dataset
*-------------------------------------------------------------------------------*

* Import sample dataset (Import Data/CSV data) and go with default import options

*-------------------------------------------------------------------------------*
* Labels
*-------------------------------------------------------------------------------*

* Variable labels.
VARIABLE LABELS
  HHPercNeedWater      'Not enough water that is safe for drinking or cooking' 
  HHPercNeedFood       'Not enough food, or good enough food, or not able to cook food' 
  HHPercNeedHousing    'No suitable place to live in'
  HHPercNeedToilet     'No easy and safe access to a clean toilet' 
  HHPercNeedHygiene    'Not enough soap, sanitary materials, water or a suitable place to wash'
  HHPercNeedClothTex   'Not enough or good enough, clothes, shoes, bedding or blankets'
  HHPercNeedLivelihood 'Not enough income, money or resources to live' 
  HHPercNeedDisabIll   'Serious problem with physical health'
  HHPercNeedHealth     'Not able to get adequate health care (including during pregnancy or childbirth - for women)'
  HHPercNeedSafety     'Not safe or protected where you live now'
  HHPercNeedEducation  'Children not in school, or not getting a good enough education'
  HHPercNeedCaregive   'Difficult to care for family members who live with you'
  HHPercNeedInfo       'Not have enough information (including on situation at home - for displaced)' 
  HHPercNeedAsstInfo   'Inadequate aid'
  CMPercNeedJustice    'Inadequate system for law and justice in community'
  CMPercNeedGBViolence 'Physical or sexual violence towards women in community' 
  CMPercNeedSubstAbuse 'People drink a lot of alcohol or use harmful drugs in community' 
  CMPercNeedMentalCare 'Mental illness in community'
  CMPercNeedCaregiving 'Not enough care for people who are on their own in community'. 
EXECUTE.

* Value labels for indicators.
VALUE LABELS
  HHPercNeedWater 
  HHPercNeedFood
  HHPercNeedHousing
  HHPercNeedToilet
  HHPercNeedHygiene
  HHPercNeedClothTex
  HHPercNeedLivelihood
  HHPercNeedDisabIll
  HHPercNeedHealth
  HHPercNeedSafety
  HHPercNeedEducation
  HHPercNeedCaregive
  HHPercNeedInfo
  HHPercNeedAsstInfo
  CMPercNeedJustice
  CMPercNeedGBViolence
  CMPercNeedSubstAbuse
  CMPercNeedMentalCare
  CMPercNeedCaregiving
  0    'No serious problem'
  1    'Serious problem'
  8888 "Don't know, not applicable, declines to answer".
EXECUTE.

* Add value labels for the problems - make sure that all variables are nominal.
VALUE LABELS
  CMPercNeedRFirst 
  CMPercNeedRSec
  CMPercNeedRThird
  1  'Drinking water' 
  2  'Food' 
  3  'Place to live in' 
  4  'Toilets' 
  5  'Keeping clean' 
  6  'Clothes, shoes, bedding or blankets'
  7  'Income or livelihood' 
  8  'Physical health' 
  9  'Health care' 
  10 'Safety' 
  11 'Education for your children'
  12 'Care for family members' 
  13 'Information' 
  14 'The way aid is provided' 
  15 'Law and injustice in your community' 
  16 'Safety or protection from violence for women in your community' 
  17 'Alcohol or drug use in your community' 
  18 'Mental illness in your community' 
  19 'Care for people in your community who are on their own' 
  20 'Other problem'.
EXECUTE.

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
* For each aspect/question, report the share of households who indicated it as a "serious problem"
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*

* Frequencies. 	
CTABLES 
  /VLABELS VARIABLES=HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet 
    HHPercNeedHygiene HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll HHPercNeedHealth 
    HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive HHPercNeedInfo HHPercNeedAsstInfo 
    CMPercNeedJustice CMPercNeedGBViolence CMPercNeedSubstAbuse CMPercNeedMentalCare 
    CMPercNeedCaregiving CMPercNeedOther 
    DISPLAY=LABEL 
  /TABLE HHPercNeedWater [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedFood [COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + HHPercNeedHousing [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedToilet 
    [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedHygiene [COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    HHPercNeedClothTex [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedLivelihood [COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + HHPercNeedDisabIll [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedHealth 
    [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedSafety [COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    HHPercNeedEducation [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedCaregive [COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + HHPercNeedInfo [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedAsstInfo 
    [COUNT F40.0, COLPCT.COUNT PCT40.1] + CMPercNeedJustice [COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    CMPercNeedGBViolence [COUNT F40.0, COLPCT.COUNT PCT40.1] + CMPercNeedSubstAbuse [COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + CMPercNeedMentalCare [COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    CMPercNeedCaregiving [COUNT F40.0, COLPCT.COUNT PCT40.1] + CMPercNeedOther [COUNT F40.0, 
    COLPCT.COUNT PCT40.1] 
  /CATEGORIES VARIABLES=HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet 
    HHPercNeedHygiene HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll HHPercNeedHealth 
    HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive HHPercNeedInfo HHPercNeedAsstInfo 
    CMPercNeedJustice CMPercNeedGBViolence CMPercNeedSubstAbuse CMPercNeedMentalCare 
    CMPercNeedCaregiving CMPercNeedOther ORDER=A KEY=VALUE EMPTY=EXCLUDE 
  /CRITERIA CILEVEL=95. 

* show only the share of households that reported an aspect as serious problem out of the total populations (including those that did not answer).
PRESERVE.

* First recode into 8888 to 0 into new variables.
RECODE 
  HHPercNeedWater 
  HHPercNeedFood
  HHPercNeedHousing
  HHPercNeedToilet
  HHPercNeedHygiene
  HHPercNeedClothTex
  HHPercNeedLivelihood
  HHPercNeedDisabIll
  HHPercNeedHealth
  HHPercNeedSafety
  HHPercNeedEducation
  HHPercNeedCaregive
  HHPercNeedInfo
  HHPercNeedAsstInfo
  CMPercNeedJustice
  CMPercNeedGBViolence
  CMPercNeedSubstAbuse
  CMPercNeedMentalCare
  CMPercNeedCaregiving
  (8888=0) (else=copy) INTO 
  rec_HHPercNeedWater 
  rec_HHPercNeedFood
  rec_HHPercNeedHousing
  rec_HHPercNeedToilet
  rec_HHPercNeedHygiene
  rec_HHPercNeedClothTex
  rec_HHPercNeedLivelihood
  rec_HHPercNeedDisabIll
  rec_HHPercNeedHealth
  rec_HHPercNeedSafety
  rec_HHPercNeedEducation
  rec_HHPercNeedCaregive
  rec_HHPercNeedInfo
  rec_HHPercNeedAsstInfo
  rec_CMPercNeedJustice
  rec_CMPercNeedGBViolence
  rec_CMPercNeedSubstAbuse
  rec_CMPercNeedMentalCare
  rec_CMPercNeedCaregiving.
EXECUTE.

DESCRIPTIVES VARIABLES=rec_HHPercNeedWater rec_HHPercNeedFood rec_HHPercNeedHousing 
    rec_HHPercNeedToilet rec_HHPercNeedHygiene rec_HHPercNeedClothTex rec_HHPercNeedLivelihood 
    rec_HHPercNeedDisabIll rec_HHPercNeedHealth rec_HHPercNeedSafety rec_HHPercNeedEducation 
    rec_HHPercNeedCaregive rec_HHPercNeedInfo rec_HHPercNeedAsstInfo rec_CMPercNeedJustice 
    rec_CMPercNeedGBViolence rec_CMPercNeedSubstAbuse rec_CMPercNeedMentalCare rec_CMPercNeedCaregiving
  /STATISTICS=MEAN.

* Now drop the recoded variables.
DELETE VARIABLES rec_HHPercNeedWater rec_HHPercNeedFood rec_HHPercNeedHousing 
    rec_HHPercNeedToilet rec_HHPercNeedHygiene rec_HHPercNeedClothTex rec_HHPercNeedLivelihood 
    rec_HHPercNeedDisabIll rec_HHPercNeedHealth rec_HHPercNeedSafety rec_HHPercNeedEducation 
    rec_HHPercNeedCaregive rec_HHPercNeedInfo rec_HHPercNeedAsstInfo rec_CMPercNeedJustice 
    rec_CMPercNeedGBViolence rec_CMPercNeedSubstAbuse rec_CMPercNeedMentalCare rec_CMPercNeedCaregiving.
EXECUTE.

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
* For each aspect/question, report the share of households who indicated it among their top three problems (among their first, second, and third ranked problems).
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*

* For each problem generate a variable indicating if the respondent mentioned it among their top three problems.
COMPUTE Top3_Water      =(CMPercNeedRFirst=1 OR CMPercNeedRSec=1 OR CMPercNeedRThird=1).
COMPUTE Top3_Food       =(CMPercNeedRFirst=2 OR CMPercNeedRSec=2 OR CMPercNeedRThird=2).
COMPUTE Top3_Housing    =(CMPercNeedRFirst=3 OR CMPercNeedRSec=3 OR CMPercNeedRThird=3).
COMPUTE Top3_Toilet     =(CMPercNeedRFirst=4 OR CMPercNeedRSec=4 OR CMPercNeedRThird=4).
COMPUTE Top3_Hygiene    =(CMPercNeedRFirst=5 OR CMPercNeedRSec=5 OR CMPercNeedRThird=5).
COMPUTE Top3_ClothTex   =(CMPercNeedRFirst=6 OR CMPercNeedRSec=6 OR CMPercNeedRThird=6).
COMPUTE Top3_Livelihood =(CMPercNeedRFirst=7 OR CMPercNeedRSec=7 OR CMPercNeedRThird=7).
COMPUTE Top3_Disabil    =(CMPercNeedRFirst=8 OR CMPercNeedRSec=8 OR CMPercNeedRThird=8).
COMPUTE Top3_Health     =(CMPercNeedRFirst=9 OR CMPercNeedRSec=9 OR CMPercNeedRThird=9).
COMPUTE Top3_Safety     =(CMPercNeedRFirst=10 OR CMPercNeedRSec=10 OR CMPercNeedRThird=10).
COMPUTE Top3_Education  =(CMPercNeedRFirst=11 OR CMPercNeedRSec=11 OR CMPercNeedRThird=11).
COMPUTE Top3_Caregive   =(CMPercNeedRFirst=12 OR CMPercNeedRSec=12 OR CMPercNeedRThird=12).
COMPUTE Top3_Info       =(CMPercNeedRFirst=13 OR CMPercNeedRSec=13 OR CMPercNeedRThird=13).
COMPUTE Top3_AsstInfo   =(CMPercNeedRFirst=14 OR CMPercNeedRSec=14 OR CMPercNeedRThird=14).
COMPUTE Top3_Justice    =(CMPercNeedRFirst=15 OR CMPercNeedRSec=15 OR CMPercNeedRThird=15).
COMPUTE Top3_GBViolence =(CMPercNeedRFirst=16 OR CMPercNeedRSec=16 OR CMPercNeedRThird=16).
COMPUTE Top3_SubstAbuse =(CMPercNeedRFirst=17 OR CMPercNeedRSec=17 OR CMPercNeedRThird=17).
COMPUTE Top3_MentalCare =(CMPercNeedRFirst=18 OR CMPercNeedRSec=18 OR CMPercNeedRThird=18).
COMPUTE Top3_Caregiving =(CMPercNeedRFirst=19 OR CMPercNeedRSec=19 OR CMPercNeedRThird=19).
COMPUTE Top3_Other      =(CMPercNeedRFirst=20 OR CMPercNeedRSec=20 OR CMPercNeedRThird=20).
EXECUTE.

* Recode missings to zero.
RECODE Top3_Water Top3_Food Top3_Housing Top3_Toilet Top3_Hygiene Top3_ClothTex 
    Top3_Livelihood Top3_Disabil Top3_Health Top3_Safety Top3_Education Top3_Caregive Top3_Info 
    Top3_AsstInfo Top3_Justice Top3_GBViolence Top3_SubstAbuse Top3_MentalCare Top3_Caregiving 
    Top3_Other (sysmis=0).
EXECUTE.

* Report share of households who indicated an area among their top three problems.
DESCRIPTIVES VARIABLES=Top3_Water Top3_Food Top3_Housing Top3_Toilet Top3_Hygiene Top3_ClothTex 
    Top3_Livelihood Top3_Disabil Top3_Health Top3_Safety Top3_Education Top3_Caregive Top3_Info 
    Top3_AsstInfo Top3_Justice Top3_GBViolence Top3_SubstAbuse Top3_MentalCare Top3_Caregiving 
    Top3_Other
  /STATISTICS=MEAN.

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
* Mean/median number of aspects indicated as "serious problems"
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*

* Create a variable that counts the number of aspects perceived as serious problems.
COUNT Perceived_total=HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet 
    HHPercNeedHygiene HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll HHPercNeedHealth 
    HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive HHPercNeedInfo HHPercNeedAsstInfo 
    CMPercNeedJustice CMPercNeedGBViolence CMPercNeedSubstAbuse CMPercNeedMentalCare 
    CMPercNeedCaregiving CMPercNeedOther (1).
VARIABLE LABELS Perceived_total 'Total number of problems identified'.
EXECUTE.

FREQUENCIES VARIABLES=Perceived_total
  /STATISTICS=MEAN MEDIAN.

* End of Scripts