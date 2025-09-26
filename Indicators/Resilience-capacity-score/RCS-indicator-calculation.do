/*
The RCS is calculated from 9 sub-statements using a five-point Likert scale (ranging from 'strongly disagree' to 'strongly agree') to capture the household perception of existing resilience capacities or livelihood capital. 
The Resilience Capacity Score aggregates the unweighted answers to the nine statements and is normalized to provide a score ranging from 0 to 100. 
This result is used to classify households in three groups (low, medium, or high). The percentages at each level are used later in following the changes over time in these percentages for a specific target group of households. 
Progress achieved or change over time in any of the 9 items is also calculated to understand which capacities or capitals contribute the most to the final score and which need to be reinforced to enhance future climate resilience. */

import delim using "../../Static/RCS_Sample_Survey.csv", clear case(preserve) bindquotes(strict) varn(1)
qui foreach var of varlist HHRCSBounce HHRCSRevenue HHRCSIncrease HHRCSFinAccess HHRCSSupportCommunity HHRCSSupportPublic HHRCSLessonsLearnt HHRCSFutureChallenge HHRCSWarningAccess {
	cap destring `var', replace i("n/a")
}
/// GENERATE RANDOM DATA
*/
expand 100 in 4
generate w = runiform()

foreach var of varlist HHRCSBounce HHRCSRevenue HHRCSIncrease HHRCSFinAccess HHRCSSupportCommunity HHRCSSupportPublic HHRCSLessonsLearnt HHRCSFutureChallenge HHRCSWarningAccess {
	replace w = runiform()
	qui su w 
	replace `var'=round((w-r(min))*(5-1)/(r(max)-r(min)) + 1,1)
	
}
*/
//// END OF RANDOM DATA GENERATION
***Resilience Capacity Score***
capture confirm variable RCS 
if !_rc {
cap rename RCS old_RCS
}
*
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


** 	Standardizing the score. ***************************************************
/*
Once answers to each of the statements have been gathered, they are numerically converted (Strongly agree = 1, Agree=2, Neutral =3, Disagree=4, Strongly disagree = 5). Individual answers are then used to compute an overall resilience score for each household as an equally weighted average of the nine answers.

The resilience score is standardized by minmax normalization , transforming the results in a score that ranges from 0 (not at all resilient) to 100 (fully resilient).
y = (ymax-ymin)*(x-xmin)/(xmax-xmin) + ymin;
RCS=(100-0)*(RCS/9-5)/(1-5) + 0
*/
egen RCS= rowtotal(HHRCSBounce HHRCSRevenue HHRCSIncrease HHRCSFinAccess HHRCSSupportCommunity HHRCSSupportPublic HHRCSLessonsLearnt HHRCSFutureChallenge HHRCSWarningAccess)
replace RCS=(100-0)*((RCS/9)-5)/(1-5) + 0
label var RCS "Resilience Capacity Score"

br RCS


/*
Once the RCS is calculated, households are divided in terciles (low-medium-high) to show the distribution of the RCS within the target population. Therefore:
	 if RCS<33 the household is categorized as reporting a low RCS,
	 if 33=<RCS<66 the household is categorized as reporting a medium RCS and
	 if RCS>=66 then the household is categorized as reporting a high RCS.
*/

gen RCSCat33=cond(RCS<33,1,cond(RCS<66,2,3))
label var RCSCat33 "RCS Categories, thresholds 33-66"
*** define variables labels and properties for "RCS Categories".
label define RCSCat 1 "low RCS" 2 "medium RCS" 3 "high RCS"
label define RCSCat2 1 "low" 2 "medium" 3 "high"

label values RCSCat33 RCSCat

*Once all households are categorized, counting the number of households in each tercile (low-medium-high) divided by the sample size (n) is the percentage to be reported in COMET.

*Steps a and b must be repeated with the first four statements separated. 
*In other words, including only answers to statements S1 to S4 produce the scores of resilience capacities as follows:
gen RCSAnticipatory=(100-0)*(HHRCSFutureChallenge-5)/(1-5) + 0
gen RCSAbsorptive=(100-0)*(HHRCSBounce-5)/(1-5) + 0
gen RCSTransformative=(100-0)*(HHRCSRevenue-5)/(1-5) + 0
gen RCSAdaptive=(100-0)*(HHRCSIncrease-5)/(1-5) + 0

gen RCSAnticipatoryCat33=cond(RCSAnticipatory<33,1,cond(RCSAnticipatory<66,2,3))
gen RCSAbsorptiveCat33=cond(RCSAbsorptive<33,1,cond(RCSAbsorptive<66,2,3))
gen RCSTransformativeCat33=cond(RCSTransformative<33,1,cond(RCSTransformative<66,2,3))
gen RCSSAdaptiveCat33=cond(RCSAdaptive<33,1,cond(RCSAdaptive<66,2,3))

label values RCSAnticipatoryCat33 RCSAbsorptiveCat33 RCSTransformativeCat33 RCSSAdaptiveCat33 RCSCat2
*** Let's now create the table of results needed in COMET reporting:
tabulate RCSAnticipatoryCat33, matcell(freq1) matrow(names1)
tabulate RCSAbsorptiveCat33, matcell(freq2) matrow(names2)
tabulate RCSTransformativeCat33, matcell(freq3) matrow(names3)
tabulate RCSSAdaptiveCat33, matcell(freq4) matrow(names4)
tabulate RCSCat33, matcell(freq5) matrow(names5)
matrix Anticipatory=freq1'/r(N)
matrix Absorptive=freq2'/r(N)
matrix Transformative=freq3'/r(N)
matrix Adaptive=freq4'/r(N)
matrix RCS=freq5'/r(N)
*All key results to be reported in COMET are shown in the following table:
putexcel set "RCS_COMET.xlsx", replace
putexcel B1:D1, merge
putexcel A1=("RCS - Components") B1=("RCS Levels (percentages)") A3=("Anticipatory capacity") A4=("Absorptive capacity") A5=("Transformative capacity") A6=("Adaptive capacity") A7=("Resilience capacity")
putexcel B2=("Low") C2=("Medium") D2=("High")
putexcel B3=matrix(Anticipatory), nformat("#.0 %")
putexcel B4=matrix(Absorptive), nformat("#.0 %")
putexcel B5=matrix(Transformative), nformat("#.0 %")
putexcel B6=matrix(Adaptive), nformat("#.0 %")
putexcel B7=matrix(RCS), nformat("#.0 %")
/*
As each figure represents the percentage of households at each level, the sum of each row must be 100% in all cases. 
	Individual statement score calculation:

The calculation of the average score for each statement is recommended for use in the narrative and in the further analysis of elements with higher incidence in the RCS calculation and/or for picking out the major variations over time of the elements of the score. 

Therefore, using answers coded as values from 1 to 5, the sum of all values for each statement(S), divided by the sample size (n) will yield 9 values (one for each Q) that could be compared over time and used as shown in the visualization section. 
*/
