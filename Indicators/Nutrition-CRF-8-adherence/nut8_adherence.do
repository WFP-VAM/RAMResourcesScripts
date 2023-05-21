*add sample data
import delimited using "../../Static/Nut_CRF_8_adherence_Sample_Survey/Nutrition_module_NutProg_submodule_RepeatNutProg.csv"


rename (v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13) (PNutProgParticName PNutProgCard PNutProgShouldNbrCard PNutProgDidNbrCard PNutwhendate PNutProgShouldNbrNoCard PNutProgDidNbrNoCard PNutProgEntitlements PNoNutProgReason PNoNutProgReason_other PNoNutProgCardReason PNoNutProgCardReason_other)
*#assign variable labels 

label var PNutProgCard "May I see participant's program participation card?"
label var PNutProgShouldNbrCard "number of distributions entitled to - measured with participation card"
label var PNutProgDidNbrCard "number of distributions received - measured with participation card"
label var PNutProgShouldNbrNoCard "number of distributions entitled to - measured without participation card"
label var PNutProgDidNbrNoCard "number of distributions received - measured without participation card"
label define Yesno 1 "Yes" 0 "No"

*#create variable which classifies if participant received 66% or more of planned distributions 
gen NutProgRecAdequate=cond((PNutProgCard == 1 & ((PNutProgDidNbrCard / PNutProgShouldNbrCard) >= .66) == 1) | ///
  (PNutProgCard == 0 & ((PNutProgDidNbrNoCard / PNutProgShouldNbrNoCard) >= .66) == 1),1,0)
label var NutProgRecAdequate "Participant recieved adequate number of distributions?"


label values PNutProgCard NutProgRecAdequate Yesno

/*
#creates a table of the weighted percentage of NutProgRecAdequate by
#creating a temporary variable to display value labels 
#and providing the option to use weights if needed
*/
cap gen WeightHH=1
tabulate NutProgRecAdequate [aw=WeightHH]
