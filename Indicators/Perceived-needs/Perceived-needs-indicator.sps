* Encoding: UTF-8.
***Perceived Needs Analysis for Essential Needs**
**************************************************************************************************************
** Objective: Perceived Needs Analysis
/* Survey module : https://docs.wfp.org/api/documents/WFP-0000121342/download/

***Variable labels for all indicators**
    
variable labels 
HHPercNeedWater	'Not enough water that is safe for drinking or cooking'
HHPercNeedFood	'Not enough food, or good enough food, or because you are not able to cook food'
HHPercNeedHousing	'No suitable place to live in'
HHPercNeedToilet	'No easy and safe access to a clean toilet'
HHPercNeedHygienem	'For men: Not enough soap, water or a suitable place to wash'
HHPercNeedHygienew	'For women: Not enough soap, sanitary materials, water or a suitable place to wash'
HHPercNeedClothTex	'Not enough or good enough, clothes, shoes, bedding or blankets'
HHPercNeedLivelihood	'Not  enough income, money or resources to live'
HHPercNeedDisabIll	'A serious problem with your physical health'
HHPercNeedHealthm	'For men: Not able to get adequate health care for yourself'
HHPercNeedHealthw	'For women: Not able to get adequate health care for yourself (Including health care during pregnancy or childbirth)'
HHPercNeedSafety	'Your family are not safe or protected where you live now'
HHPercNeedEducation	'Your children are not in school, or are not getting a good enough education'
HHPercNeedCaregive	'It is difficult to care for family members who live with you'
HHPercNeedInfoDis	'For displaced people: Do you have a serious problem because you do not have enough information'
HHPercNeedInfoND	'For non-displaced people: Do you have a serious problem because you do not have enough information'
HHPercNeedAsstInfo	'Inadequate aid'
CMPercNeedJustice	'Inadequate system for law and justice, or because people do not know enough about their legal rights'
CMPercNeedGBViolence 'Physical or sexual violence towards them, either in the community or in their homes'
CMPercNeedSubstAbuse 'Is there a serious problem in your community because people drink a lot of alcohol, or use harmful drugs?'
CMPercNeedMentalCare	 'Is there a serious problem in your community because people have a mental illness?'
CMPercNeedCaregiving	 'Is there a serious problem in your community because there is not enough care for people who are on their own?'.
execute.


/**Value labels for indicators 
    
    
value labels HHPercNeedWater
HHPercNeedFood
HHPercNeedHousing
HHPercNeedToilet
HHPercNeedHygienem
HHPercNeedHygienew
HHPercNeedClothTex
HHPercNeedLivelihood
HHPercNeedDisabIll
HHPercNeedHealthm
HHPercNeedHealthw
HHPercNeedSafety
HHPercNeedEducation
HHPercNeedCaregive
HHPercNeedInfoDis
HHPercNeedInfoND
HHPercNeedAsstInfo
CMPercNeedNote
CMPercNeedJustice
CMPercNeedGBViolence
CMPercNeedSubstAbuse
CMPercNeedMentalCare
CMPercNeedCaregiving
 0	'No serious problem'
1	'Serious problem'
8888	"Don't know, not applicable, declines to answer".
execute.

value labels  RESPSex
0 'Female'
1 'Male'.
execute.
/**Frequencies 
    
CTABLES
  /VLABELS VARIABLES=HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet 
    HHPercNeedHygienem HHPercNeedHygienew HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll 
    HHPercNeedHealthm HHPercNeedHealthw HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive 
    HHPercNeedInfoDis HHPercNeedInfoND HHPercNeedAsstInfo CMPercNeedJustice CMPercNeedGBViolence 
    CMPercNeedSubstAbuse CMPercNeedMentalCare CMPercNeedCaregiving 
    DISPLAY=LABEL
  /TABLE HHPercNeedWater [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedFood [COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + HHPercNeedHousing [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedToilet 
    [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedHygienem [COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    HHPercNeedHygienew [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedClothTex [COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + HHPercNeedLivelihood [COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    HHPercNeedDisabIll [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedHealthm [COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + HHPercNeedHealthw [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedSafety 
    [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedEducation [COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    HHPercNeedCaregive [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedInfoDis [COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + HHPercNeedInfoND [COUNT F40.0, COLPCT.COUNT PCT40.1] + HHPercNeedAsstInfo 
    [COUNT F40.0, COLPCT.COUNT PCT40.1] + CMPercNeedJustice [COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    CMPercNeedGBViolence [COUNT F40.0, COLPCT.COUNT PCT40.1] + CMPercNeedSubstAbuse [COUNT F40.0, 
    COLPCT.COUNT PCT40.1] + CMPercNeedMentalCare [COUNT F40.0, COLPCT.COUNT PCT40.1] + 
    CMPercNeedCaregiving [COUNT F40.0, COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet 
    HHPercNeedHygienem ORDER=A KEY=VALUE EMPTY=INCLUDE
  /CATEGORIES VARIABLES=HHPercNeedHygienew HHPercNeedClothTex HHPercNeedLivelihood 
    HHPercNeedDisabIll HHPercNeedHealthm HHPercNeedHealthw HHPercNeedSafety HHPercNeedEducation 
    HHPercNeedCaregive HHPercNeedInfoDis HHPercNeedInfoND HHPercNeedAsstInfo CMPercNeedJustice 
    CMPercNeedGBViolence CMPercNeedSubstAbuse CMPercNeedMentalCare CMPercNeedCaregiving ORDER=A 
    KEY=VALUE EMPTY=EXCLUDE
**Recode all not answered options into system missing
    
recode HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet 
    HHPercNeedHygienem HHPercNeedHygienew HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll 
    HHPercNeedHealthm HHPercNeedHealthw HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive 
    HHPercNeedInfoDis HHPercNeedInfoND HHPercNeedAsstInfo CMPercNeedJustice CMPercNeedGBViolence 
    CMPercNeedSubstAbuse CMPercNeedMentalCare CMPercNeedCaregiving (8888=0).
    


***Create multiple response dataset to show average of all response %
    
MRSETS
  /MDGROUP NAME=$AllPercNeeds LABEL='All perceived needs indicators ' CATEGORYLABELS=VARLABELS 
    VARIABLES=HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet HHPercNeedHygienem 
    HHPercNeedHygienew HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll HHPercNeedHealthm 
    HHPercNeedHealthw HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive HHPercNeedInfoDis 
    HHPercNeedInfoND HHPercNeedAsstInfo CMPercNeedJustice CMPercNeedGBViolence CMPercNeedSubstAbuse 
    CMPercNeedMentalCare CMPercNeedCaregiving VALUE=1
  /DISPLAY NAME=[$AllPercNeeds].

**Analyze all problems with average of all response %
    

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=$AllPercNeeds DISPLAY=LABEL
  /TABLE $AllPercNeeds [TABLEPCT.RESPONSES PCT40.1]
  /CATEGORIES VARIABLES=$AllPercNeeds  EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.
  /CRITERIA CILEVEL=95.



***Analyze the most serious problems**
    
/**Add value labels for the problems - make sure that all variables are nominal
    
value labels  CMPercNeedRFirst  CMPercNeedRSec CMPercNeedRThird
1	'Drinking water'
2	'Food'
3	'Place to live in'
4	'Toilets'
5	'Keeping clean'
6	'Clothes, shoes, bedding or blankets'
7	'Income or livelihood'
8	'Physical health'
9	'Health care'
10	'Safety'
11	'Education for your children'
12	'Care for family members'
13	'Information'
14	'The way aid is provided'
15	'Law and injustice in your community'
16	'Safety or protection from violence for women in your community'
17	'Alcohol or drug use in your community'
18	'Mental illness in your community'
19	'Care for people in your community who are on their own'
20	'Any other serious problem that was not asked but mentioned'
999	'No serious problem'
8888	"Don't know, not applicable, declines to answer".
execute.


    

/***Percentage of households who rank a certain problem among their top three priority problems

* Custom Tables.
CTABLES
  /VLABELS VARIABLES=CMPercNeedRFirst CMPercNeedRSec CMPercNeedRThird DISPLAY=LABEL
  /TABLE CMPercNeedRFirst [COLPCT.COUNT PCT40.1] + CMPercNeedRSec [COLPCT.COUNT PCT40.1] + 
    CMPercNeedRThird [COLPCT.COUNT PCT40.1]
  /CATEGORIES VARIABLES=CMPercNeedRFirst CMPercNeedRSec CMPercNeedRThird ORDER=A KEY=VALUE 
    EMPTY=INCLUDE
  /CRITERIA CILEVEL=95.

/**Mean or median number of problems 
    
recode HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet 
    HHPercNeedHygienem HHPercNeedHygienew HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll 
    HHPercNeedHealthm HHPercNeedHealthw HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive 
    HHPercNeedInfoDis HHPercNeedInfoND HHPercNeedAsstInfo CMPercNeedJustice CMPercNeedGBViolence 
    CMPercNeedSubstAbuse CMPercNeedMentalCare CMPercNeedCaregiving (8888=0).
    
compute Perceived_total=sum( HHPercNeedWater, HHPercNeedFood, HHPercNeedHousing, HHPercNeedToilet, HHPercNeedHygienem, 
    HHPercNeedHygienew, HHPercNeedClothTex, HHPercNeedLivelihood, HHPercNeedDisabIll, HHPercNeedHealthm, 
    HHPercNeedHealthw, HHPercNeedSafety, HHPercNeedEducation, HHPercNeedCaregive, HHPercNeedInfoDis, 
    HHPercNeedInfoND, HHPercNeedAsstInfo, CMPercNeedJustice, CMPercNeedGBViolence, CMPercNeedSubstAbuse, 
    CMPercNeedMentalCare, CMPercNeedCaregiving).
execute.
variable labels Perceived_total 'Total number of problems identified'.
execute.
frequencies Perceived_total /statistics=mean /statistics=median.



