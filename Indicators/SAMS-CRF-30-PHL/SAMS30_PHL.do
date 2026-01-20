*------------------------------------------------------------------------------
*                          WFP Standardized Scripts
*                Post-Harvest Loss Calculation (SAMS Indicator 30)
*------------------------------------------------------------------------------

* This script calculates the Post-Harvest Loss (PHL) based on SAMS Indicator 30 guidelines.
* Detailed guidelines can be found in the SAMS documentation.

* This syntax is based on SPSS download version from MoDA.
* More details can be found in the background document at: 
* https://wfp.sharepoint.com/sites/CRF2022-2025/CRF%20Outcome%20indicators/Forms/AllItems.aspx

*------------------------------------------------------------------------------
* Load dataset
*------------------------------------------------------------------------------

import delimited using "~/GitHub/RAMResourcesScripts/Static/SAMS_CRF_30_PHL_Sample_Survey/SAMS_module_Indicator30_submodule_RepeatSAMSPHL.csv", clear

*------------------------------------------------------------------------------
* Rename variables
*------------------------------------------------------------------------------

rename SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommName_A PSAMSPHLCommName
rename SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommName PSAMSPHLCommName_oth
rename SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommClas PSAMSPHLCommClass
rename SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntH_B PSAMSPHLCommQntHand
rename SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntH_A PSAMSPHLCommQntHandUnit
rename SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntH PSAMSPHLCommQntHandUnit_oth
rename SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntL PSAMSPHLCommQntLost
rename _parent_index PSAMSPHLFarmerNum

*------------------------------------------------------------------------------
* Define variable and value labels
*------------------------------------------------------------------------------

label var PSAMSPHLCommName "What is the name of commodity?"
label var PSAMSPHLCommClass "Which of the following groups does this commodity belong to?"
label var PSAMSPHLCommQntHand "What is the amount of this commodity initially stored?"
label var PSAMSPHLCommQntHandUnit "Enter unit of measure."
label var PSAMSPHLCommQntLost "Of the total quantity you stored how much was lost?"

*------------------------------------------------------------------------------
* Calculate % loss per row
*------------------------------------------------------------------------------

gen perc_loss = (PSAMSPHLCommQntLost / PSAMSPHLCommQntHand) * 100

*------------------------------------------------------------------------------
* Average loss per farmer
*------------------------------------------------------------------------------

collapse (mean) perc_loss, by(PSAMSPHLFarmerNum)

*------------------------------------------------------------------------------
* Average across farmers
*------------------------------------------------------------------------------

summarize perc_loss

* End of Scripts