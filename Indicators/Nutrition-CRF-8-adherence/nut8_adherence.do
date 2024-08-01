*------------------------------------------------------------------------------*
*                          WFP Standardized Scripts
*                         NUT8 Adherence Indicator
*------------------------------------------------------------------------------*

* Note: This syntax file processes the NUT8 adherence indicator by assessing 
* whether participants received an adequate number of distributions as per 
* program requirements.

* Can only download repeat CSV data as a zip file from MODA with group names.
* Will update this code to remove group names.

* Add sample data.
*import delimited using "~/GitHub/RAMResourcesScripts/Static/Nut_CRF_8_adherence_Sample_Survey/Nutrition_module_NutProg_submodule_RepeatNutProg.csv"

* Rename to remove group names.
rename Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgCard       PNutProgCard
rename Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgShouldN_A  PNutProgShouldNbrCard
rename Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgDidNbrC    PNutProgDidNbrCard
rename Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgShouldN    PNutProgShouldNbrNoCard
rename Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgDidNbrN    PNutProgDidNbrNoCard

* Define variable and value labels.
label variable PNutProgCard            "May I see participant's program participation card?"
label variable PNutProgShouldNbrCard   "Number of distributions entitled to - measured with participation card"
label variable PNutProgDidNbrCard      "Number of distributions received - measured with participation card"
label variable PNutProgShouldNbrNoCard "Number of distributions entitled to - measured without participation card"
label variable PNutProgDidNbrNoCard    "Number of distributions received - measured without participation card"
label define Yesno 1 "Yes" 0 "No"
label values PNutProgCard NutProgRecAdequate Yesno

* Create variable which classifies if participant received 66% or more of planned distributions.
gen NutProgRecAdequate = cond((PNutProgCard == 1 & ((PNutProgDidNbrCard / PNutProgShouldNbrCard) >= .66)) | ///
  (PNutProgCard == 0 & ((PNutProgDidNbrNoCard / PNutProgShouldNbrNoCard) >= .66)), 1, 0)
label variable NutProgRecAdequate "Participant received adequate number of distributions?"

* Create a table of the weighted percentage of NutProgRecAdequate.
cap gen WeightHH = 1
tabulate NutProgRecAdequate [aw=WeightHH]

* End of Scripts.