*------------------------------------------------------------------------------
*                          WFP Standardized Scripts
*         Nutritious Crop Production Increase Calculation (SAMS Indicator 31)
*------------------------------------------------------------------------------

* This script calculates the proportion of farmers reporting an increase in 
* nutritious crop production based on SAMS Indicator 31 guidelines.
* Detailed guidelines can be found in the SAMS documentation.

* This syntax is based on SPSS download version from MoDA.
* More details can be found in the background document at: 
* https://wfp.sharepoint.com/sites/CRF2022-2025/CRF%20Outcome%20indicators/Forms/AllItems.aspx

*------------------------------------------------------------------------------
* Import Dataset 1
*------------------------------------------------------------------------------

import delimited "C:\Users\b\Desktop\demo\SAMS31\data.csv", clear
save temp_data1, replace

*------------------------------------------------------------------------------
* Import Dataset 2
*------------------------------------------------------------------------------

import delimited "C:\Users\b\Desktop\demo\SAMS31\SAMS_module_Indicator31_submodule_RepeatNutCrop.csv", clear
rename _parent_index index
save temp_data2, replace

*------------------------------------------------------------------------------
* Merge Datasets
*------------------------------------------------------------------------------

use temp_data1, clear
rename _index index
merge 1:1 index using temp_data2

*------------------------------------------------------------------------------
* Rename Variables
*------------------------------------------------------------------------------

rename SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropName_A PSAMSNutCropName
rename SAMS_moduleIndicator31_submoduleRepeatNutCropPSAMSNutCropIncr   PSAMSNutCropIncr
rename Demographic_moduleDemographicBasic_submoduleRespSex             RespSex

*------------------------------------------------------------------------------
* Define Variable and Value Labels
*------------------------------------------------------------------------------

label variable PSAMSNutCropName       "What is the name of crop?"
label variable PSAMSNutCropIncr       "Did you produce more, less or the same amount of this nutritious crop in the last 12 months compared to the 12 months before that?"
label variable RespSex                "Sex of the Respondent"

label define PSAMSNutCropName_lbl     1 "Crop 1" 2 "Crop 2" 3 "Crop 3" 4 "Crop 4" 5 "Crop 5" 999 "Other"
label values PSAMSNutCropName         PSAMSNutCropName_lbl

label define PSAMSNutCropIncr_lbl     1 "More" 2 "Less" 3 "The same" 9999 "Not applicable"
label values PSAMSNutCropIncr         PSAMSNutCropIncr_lbl

label define RespSex_lbl              0 "Female" 1 "Male"
label values RespSex                  RespSex_lbl

*------------------------------------------------------------------------------
* Selecting Farmers that Grew "Crop 1" and Show Proportion Reporting Increase, Decrease, or Same Production
*------------------------------------------------------------------------------

keep if PSAMSNutCropName == 1 & PSAMSNutCropIncr != 9999

* Create table
tabulate RespSex PSAMSNutCropIncr, row nofreq

* End of Scripts