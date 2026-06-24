*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*       Disability Status and Assistance Received (Roster Method)
*------------------------------------------------------------------------------*
/*
Note: This script is based on the assumption that the dataset has already 
been imported and includes variables related to disability status and 
assistance received.

The following variables should have been defined before running this script:
- TechnicalAdd_submodule/HHAsstWFPRecCashYN1Y
- TechnicalAdd_submodule/HHAsstWFPRecInKindYN1Y
- TechnicalAdd_submodule/HHAsstWFPRecCapBuildYN1Y
- Demographic_module/DisabilityHHMemb_submodule/RepeatDisabHHMembers
*/

* Import dataset 1.
import delimited "C:\Users\b\Desktop\demo\RosterMethod\data.csv", clear

* Rename to remove group names.
rename TechnicalAdd_submoduleHHAsstWFPRecCashYN1Y HHAsstWFPRecCashYN1Y
rename TechnicalAdd_submoduleHHAsstWFPRecInKindYN1Y HHAsstWFPRecInKindYN1Y
rename TechnicalAdd_submoduleHHAsstWFPRecCapBuildYN1Y HHAsstWFPRecCapBuildYN1Y
rename _index index

* Save the first dataset.
save "C:\Users\b\Desktop\demo\RosterMethod\data1.dta", replace

* Import dataset 2.
import delimited "C:\Users\b\Desktop\demo\RosterMethod\Demographic_module_DisabilityHHMemb_submodule_RepeatDisabHHMembers.csv", clear

* Rename to remove group names.
rename Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_G PDisabAge
rename Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_F PDisabSex
rename Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_E PDisabSee
rename Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_D PDisabHear
rename Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_C PDisabWalk
rename Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_B PDisabRemember
rename Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe_A PDisabUnderstand
rename Demographic_moduleDisabilityHHMemb_submoduleRepeatDisabHHMembe PDisabWash
rename _parent_index index

* Save the second dataset.
save "C:\Users\b\Desktop\demo\RosterMethod\data2.dta", replace

* Merge the datasets.
use "C:\Users\b\Desktop\demo\RosterMethod\data1.dta", clear
merge 1:1 index using "C:\Users\b\Desktop\demo\RosterMethod\data2.dta"

* Assign variable and value labels.
label variable HHAsstWFPRecCashYN1Y     "Did your household receive cash-based WFP assistance in the last 12 months?"
label variable HHAsstWFPRecInKindYN1Y   "Did your household receive in-kind WFP assistance in the last 12 months?"
label variable HHAsstWFPRecCapBuildYN1Y "Did you household receive WFP capacity building assistance in the last 12 months?"

label variable PDisabAge         "What is the age of ${PDisabName}?"
label variable PDisabSex         "What is the sex of ${PDisabName}?"
label variable PDisabSee         "Does ${PDisabName} have difficulty seeing, even if wearing glasses? Would you say…"
label variable PDisabHear        "Does ${PDisabName} have difficulty hearing, even if using a hearing aid(s)? Would you say…"
label variable PDisabWalk        "Does ${PDisabName} have difficulty walking or climbing steps? Would you say…"
label variable PDisabRemember    "Does ${PDisabName} have difficulty remembering or concentrating? Would you say…"
label variable PDisabUnderstand  "Using your usual language, does ${PDisabName} have difficulty communicating, for example understanding or being understood? Would you say…"
label variable PDisabWash        "Does ${PDisabName} have difficulty with self-care, such as washing all over or dressing? Would you say…"

label define YesNo 0 "No" 1 "Yes"
label values HHAsstWFPRecCashYN1Y HHAsstWFPRecInKindYN1Y HHAsstWFPRecCapBuildYN1Y YesNo

label define Sex 0 "Female" 1 "Male"
label values PDisabSex Sex

label define Difficulty 1 "No difficulty" 2 "Some difficulty" 3 "A lot of difficulty" 4 "Cannot do at all" 888 "Don't know" 999 "Refuse"
label values PDisabSee PDisabHear PDisabWalk PDisabRemember PDisabUnderstand PDisabWash Difficulty

* Calculate whether the respondent had "A lot of difficulty" or "Cannot do at all" for any of the 6 questions.
gen PDisabCat3 = 0
replace PDisabCat3 = 1 if inlist(PDisabSee, 3, 4) | inlist(PDisabHear, 3, 4) | inlist(PDisabWalk, 3, 4) | inlist(PDisabRemember, 3, 4) | inlist(PDisabUnderstand, 3, 4) | inlist(PDisabWash, 3, 4)

label define Cat3 0 "without disability (category 3 criteria)" 1 "with disability (category 3 criteria)"
label values PDisabCat3 Cat3

* Create tables of the percentage of type of assistance received by PDisabCat3.
* Cash.
tabulate HHAsstWFPRecCashYN1Y PDisabCat3, column

* In-kind.
tabulate HHAsstWFPRecInKindYN1Y PDisabCat3, column

* Capacity building.
tabulate HHAsstWFPRecCapBuildYN1Y PDisabCat3, column

* End of Scripts