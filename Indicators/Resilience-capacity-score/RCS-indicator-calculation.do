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
import delim using "../../Static/RCS_Sample_Survey.csv", clear case(preserve) bindquotes(strict) varn(1)

* Destring variables if necessary
qui foreach var of varlist HHRCSBounce HHRCSRevenue HHRCSIncrease HHRCSFinAccess HHRCSSupportCommunity HHRCSSupportPublic HHRCSLessonsLearnt HHRCSFutureChallenge HHRCSWarningAccess {
    cap destring `var', replace i("n/a")
}

* Generate random data (for testing purposes)
expand 100 in 4
generate w = runiform()

foreach var of varlist HHRCSBounce HHRCSRevenue HHRCSIncrease HHRCSFinAccess HHRCSSupportCommunity HHRCSSupportPublic HHRCSLessonsLearnt HHRCSFutureChallenge HHRCSWarningAccess {
    replace w = runiform()
    qui su w 
    replace `var'=round((w-r(min))*(5-1)/(r(max)-r(min)) + 1,1)
}

* Label variables and values
label var HHRCSBounce          "Your household can bounce back from any challenge that life throws at it."
label var HHRCSRevenue         "During times of hardship your household can change its primary income or source of livelihood if needed."
label var HHRCSIncrease        "If threats to your household became more frequent and intense, you would still find a way to get by."
label var HHRCSFinAccess       "During times of hardship your household can access the financial support you need."
label var HHRCSSupportCommunity "Your household can rely on the support of family or friends when you need help."
label var HHRCSLessonsLearnt    "Your household has learned important lessons from past hardships that will help you to better prepare for future challenges."
label var HHRCSSupportPublic    "Your household can rely on the support from public administration/government or other institutions when you need help."
label var HHRCSFutureChallenge  "Your household is fully prepared for any future challenges or threats that life throws at it."
label var HHRCSWarningAccess    "Your household receives useful information warning you about future risks in advance."

label define Likert5 1 "Strongly Agree" 2 "Partially agree" 3 "Neutral" 4 "Somewhat disagree" 5 "Totally disagree"
label values HHRCSBounce HHRCSRevenue HHRCSIncrease HHRCSFinAccess HHRCSSupportCommunity HHRCSSupportPublic HHRCSLessonsLearnt HHRCSFutureChallenge HHRCSWarningAccess Likert5

* Calculate the Resilience Capacity Score (RCS)
egen RCS = rowtotal(HHRCSBounce HHRCSRevenue HHRCSIncrease HHRCSFinAccess HHRCSSupportCommunity HHRCSSupportPublic HHRCSLessonsLearnt HHRCSFutureChallenge HHRCSWarningAccess)
replace RCS = (100-0) * ((RCS/9) - 5) / (1-5) + 0
label var RCS "Resilience Capacity Score"

* Classify households into RCS categories
gen RCSCat33 = cond(RCS < 33, 1, cond(RCS < 66, 2, 3))
label var RCSCat33 "RCS Categories, thresholds 33-66"
label define RCSCat 1 "low RCS" 2 "medium RCS" 3 "high RCS"
label values RCSCat33 RCSCat

* Calculate RCS components
gen RCSAnticipatory = (100-0) * (HHRCSFutureChallenge - 5) / (1-5) + 0
gen RCSAbsorptive = (100-0) * (HHRCSBounce - 5) / (1-5) + 0
gen RCSTransformative = (100-0) * (HHRCSRevenue - 5) / (1-5) + 0
gen RCSAdaptive = (100-0) * (HHRCSIncrease - 5) / (1-5) + 0

gen RCSAnticipatoryCat33 = cond(RCSAnticipatory < 33, 1, cond(RCSAnticipatory < 66, 2, 3))
gen RCSAbsorptiveCat33 = cond(RCSAbsorptive < 33, 1, cond(RCSAbsorptive < 66, 2, 3))
gen RCSTransformativeCat33 = cond(RCSTransformative < 33, 1, cond(RCSTransformative < 66, 2, 3))
gen RCSAdaptiveCat33 = cond(RCSAdaptive < 33, 1, cond(RCSAdaptive < 66, 2, 3))
label values RCSAnticipatoryCat33 RCSAbsorptiveCat33 RCSTransformativeCat33 RCSAdaptiveCat33 RCSCat

* Create the table of results needed in COMET reporting
tabulate RCSAnticipatoryCat33, matcell(freq1) matrow(names1)
tabulate RCSAbsorptiveCat33, matcell(freq2) matrow(names2)
tabulate RCSTransformativeCat33, matcell(freq3) matrow(names3)
tabulate RCSAdaptiveCat33, matcell(freq4) matrow(names4)
tabulate RCSCat33, matcell(freq5) matrow(names5)

matrix Anticipatory = freq1' / r(N)
matrix Absorptive = freq2' / r(N)
matrix Transformative = freq3' / r(N)
matrix Adaptive = freq4' / r(N)
matrix RCS = freq5' / r(N)

putexcel set "RCS_COMET.xlsx", replace
putexcel B1:D1, merge
putexcel A1=("RCS - Components") B1=("RCS Levels (percentages)") A3=("Anticipatory capacity") A4=("Absorptive capacity") A5=("Transformative capacity") A6=("Adaptive capacity") A7=("Resilience capacity")
putexcel B2=("Low") C2=("Medium") D2=("High")
putexcel B3=matrix(Anticipatory), nformat("#.0 %")
putexcel B4=matrix(Absorptive), nformat("#.0 %")
putexcel B5=matrix(Transformative), nformat("#.0 %")
putexcel B6=matrix(Adaptive), nformat("#.0 %")
putexcel B7=matrix(RCS), nformat("#.0 %")

* End of Scripts