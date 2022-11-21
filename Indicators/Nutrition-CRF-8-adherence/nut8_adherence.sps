* Encoding: UTF-8.

*can only download repeat csv data as zip file from moda with group names - will update this code to remove group names
*rename to remove group names - because of the variable length SPSS truncates name

RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgCard = PNutProgCard).
RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgShouldN_A = PNutProgShouldNbrCard).
RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgDidNbrC = PNutProgDidNbrCard).
RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgShouldN = PNutProgShouldNbrNoCard).
RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgDidNbrN = PNutProgDidNbrNoCard).

* define variable and value labels

Variable labels PNutProgCard "May I see participant's program participation card?".
Variable labels PNutProgShouldNbrCard 'number of distributions entitled to - measured with participation card'.
Variable labels PNutProgDidNbrCard 'number of distributions received - measured with participation card'.
Variable labels PNutProgShouldNbrNoCard 'number of distributions entitled to - measured without participation card'.
Variable labels PNutProgDidNbrNoCard 'number of distributions received - measured without participation card'.

Value labels PNutProgCard 1 'Yes' 0  'No '.

*create variable which classifies if participant received 66% or more of planned distributions 

do if ((PNutProgCard = 1) & ((PNutProgDidNbrCard / PNutProgShouldNbrCard) >= .66)) OR ((PNutProgCard = 0) & ((PNutProgDidNbrNoCard / PNutProgShouldNbrNoCard) >= .66)) . 
compute NutProgRecAdequate = 1.
Else.
Compute NutProgRecAdequate = 0.
End if.

Variable labels PNutProgDidNbrNoCard "Participant recieved adequate number of distributions?".
Value labels NutProgRecAdequate 1 'Yes' 0  'No '.

freq NutProgRecAdequate.

