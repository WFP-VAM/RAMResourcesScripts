*------------------------------------------------------------------------------
*                          WFP Standardized Scripts
*                  Resilience Capacity Score (RCS) Calculation
*------------------------------------------------------------------------------

* The RCS is calculated from 9 sub-statements using a five-point Likert scale 
* (ranging from 'strongly disagree' to 'strongly agree') to capture the household 
* perception of existing resilience capacities or livelihood capital. 
* The Resilience Capacity Score aggregates the unweighted answers to the nine 
* statements and is normalized to provide a score ranging from 0 to 100. 
* This result is used to classify households in three groups (low, medium, or high). 
* The percentages at each level are used later in following the changes over time 
* in these percentages for a specific target group of households. 
* Progress achieved or change over time in any of the 9 items is also calculated 
* to understand which capacities or capitals contribute the most to the final score 
* and which need to be reinforced to enhance future climate resilience.

* Load the data
GET DATA /TYPE=TXT
  /FILE="C:\Path\To\RCS_Sample_Survey.csv"
  /ENCODING='UTF8'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /DATATYPEMIN PERCENTAGE=95.0
  /VARIABLES=
  HHRCSBounce AUTO
  HHRCSRevenue AUTO
  HHRCSIncrease AUTO
  HHRCSFinAccess AUTO
  HHRCSSupportCommunity AUTO
  HHRCSSupportPublic AUTO
  HHRCSLessonsLearnt AUTO
  HHRCSFutureChallenge AUTO
  HHRCSWarningAccess AUTO.

* Label variables and values
VARIABLE LABELS 
  HHRCSBounce           "Your household can bounce back from any challenge that life throws at it."
  HHRCSRevenue          "During times of hardship your household can change its primary income or source of livelihood if needed."
  HHRCSIncrease         "If threats to your household became more frequent and intense, you would still find a way to get by."
  HHRCSFinAccess        "During times of hardship your household can access the financial support you need."
  HHRCSSupportCommunity "Your household can rely on the support of family or friends when you need help."
  HHRCSLessonsLearnt    "Your household has learned important lessons from past hardships that will help you to better prepare for future challenges."
  HHRCSSupportPublic    "Your household can rely on the support from public administration/government or other institutions when you need help."
  HHRCSFutureChallenge  "Your household is fully prepared for any future challenges or threats that life throws at it."
  HHRCSWarningAccess    "Your household receives useful information warning you about future risks in advance."

VALUE LABELS 
  HHRCSBounce HHRCSRevenue HHRCSIncrease HHRCSFinAccess HHRCSSupportCommunity HHRCSSupportPublic HHRCSLessonsLearnt HHRCSFutureChallenge HHRCSWarningAccess
  1 "Strongly Agree" 
  2 "Partially agree" 
  3 "Neutral" 
  4 "Somewhat disagree" 
  5 "Totally disagree".

* Calculate the Resilience Capacity Score (RCS)
COMPUTE RCS = (SUM(HHRCSBounce, HHRCSRevenue, HHRCSIncrease, HHRCSFinAccess, HHRCSSupportCommunity, HHRCSSupportPublic, HHRCSLessonsLearnt, HHRCSFutureChallenge, HHRCSWarningAccess) / 9 - 1) * (100 / 4).
VARIABLE LABELS RCS 'Resilience Capacity Score'.
EXECUTE.

* Classify households into RCS categories
COMPUTE RCSCat33 = 1.
IF (RCS >= 33) RCSCat33 = 2.
IF (RCS >= 66) RCSCat33 = 3.
VARIABLE LABELS RCSCat33 "RCS Categories, thresholds 33-66".
VALUE LABELS RCSCat33 1 "low RCS" 2 "medium RCS" 3 "high RCS".
EXECUTE.

* Calculate RCS components
COMPUTE RCSAnticipatory = (HHRCSFutureChallenge - 1) * (100 / 4).
COMPUTE RCSAbsorptive = (HHRCSBounce - 1) * (100 / 4).
COMPUTE RCSTransformative = (HHRCSRevenue - 1) * (100 / 4).
COMPUTE RCSAdaptive = (HHRCSIncrease - 1) * (100 / 4).

COMPUTE RCSAnticipatoryCat33 = 1.
IF (RCSAnticipatory >= 33) RCSAnticipatoryCat33 = 2.
IF (RCSAnticipatory >= 66) RCSAnticipatoryCat33 = 3.

COMPUTE RCSAbsorptiveCat33 = 1.
IF (RCSAbsorptive >= 33) RCSAbsorptiveCat33 = 2.
IF (RCSAbsorptive >= 66) RCSAbsorptiveCat33 = 3.

COMPUTE RCSTransformativeCat33 = 1.
IF (RCSTransformative >= 33) RCSTransformativeCat33 = 2.
IF (RCSTransformative >= 66) RCSTransformativeCat33 = 3.

COMPUTE RCSAdaptiveCat33 = 1.
IF (RCSAdaptive >= 33) RCSAdaptiveCat33 = 2.
IF (RCSAdaptive >= 66) RCSAdaptiveCat33 = 3.

VALUE LABELS 
  RCSAnticipatoryCat33 RCSAbsorptiveCat33 RCSTransformativeCat33 RCSAdaptiveCat33
  1 "low" 
  2 "medium" 
  3 "high".

* Create the table of results needed in COMET reporting
CROSSTABS /TABLES=RCSAnticipatoryCat33 BY RCSCat33 /CELLS=COUNT.
CROSSTABS /TABLES=RCSAbsorptiveCat33 BY RCSCat33 /CELLS=COUNT.
CROSSTABS /TABLES=RCSTransformativeCat33 BY RCSCat33 /CELLS=COUNT.
CROSSTABS /TABLES=RCSAdaptiveCat33 BY RCSCat33 /CELLS=COUNT.

* End of Scripts