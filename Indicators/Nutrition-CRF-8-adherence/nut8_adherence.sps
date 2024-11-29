********************************************************************************
*                          WFP Standardized Scripts
*                         NUT8 Adherence Indicator
********************************************************************************

* Note: This syntax file processes the NUT8 adherence indicator by assessing 
* whether participants received an adequate number of distributions as per 
* program requirements.

* Can only download repeat CSV data as a zip file from MODA with group names.
* Will update this code to remove group names.

* Rename to remove group names.
RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgCard      = PNutProgCard).
RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgShouldN_A = PNutProgShouldNbrCard).
RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgDidNbrC   = PNutProgDidNbrCard).
RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgShouldN   = PNutProgShouldNbrNoCard).
RENAME VARIABLES (Nutrition_moduleNutProg_submoduleRepeatNutProgPNutProgDidNbrN   = PNutProgDidNbrNoCard).

* Define variable and value labels.
VARIABLE LABELS PNutProgCard             "May I see participant's program participation card?".
VARIABLE LABELS PNutProgShouldNbrCard    "Number of distributions entitled to - measured with participation card".
VARIABLE LABELS PNutProgDidNbrCard       "Number of distributions received - measured with participation card".
VARIABLE LABELS PNutProgShouldNbrNoCard  "Number of distributions entitled to - measured without participation card".
VARIABLE LABELS PNutProgDidNbrNoCard     "Number of distributions received - measured without participation card".

VALUE LABELS PNutProgCard 1 'Yes' 0 'No'.

* Create variable which classifies if participant received 66% or more of planned distributions.
DO IF ((PNutProgCard = 1) & ((PNutProgDidNbrCard / PNutProgShouldNbrCard) >= .66)) OR ((PNutProgCard = 0) & ((PNutProgDidNbrNoCard / PNutProgShouldNbrNoCard) >= .66)).
    COMPUTE NutProgRecAdequate = 1.
ELSE.
    COMPUTE NutProgRecAdequate = 0.
END IF.

VARIABLE LABELS NutProgRecAdequate "Participant received adequate number of distributions?".
VALUE LABELS NutProgRecAdequate 1 'Yes' 0 'No'.

* Frequency table for NutProgRecAdequate.
FREQUENCIES VARIABLES=NutProgRecAdequate.

* End of Scripts.