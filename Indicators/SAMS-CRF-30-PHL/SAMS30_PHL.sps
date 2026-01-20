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
* Rename variables
*------------------------------------------------------------------------------

RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommName_A = PSAMSPHLCommName).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommName = PSAMSPHLCommName_oth).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommClas = PSAMSPHLCommClass).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntH_B = PSAMSPHLCommQntHand).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntH_A = PSAMSPHLCommQntHandUnit).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntH = PSAMSPHLCommQntHandUnit_oth).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntL = PSAMSPHLCommQntLost).
RENAME VARIABLES (@_parent_index = PSAMSPHLFarmerNum).

*------------------------------------------------------------------------------
* Define variable and value labels
*------------------------------------------------------------------------------

Variable labels PSAMSPHLCommName       "What is the name of commodity?".
Variable labels PSAMSPHLCommClass      "Which of the following groups does this commodity belong to?".
Variable labels PSAMSPHLCommQntHand    "What is the amount of this commodity initially stored?".
Variable labels PSAMSPHLCommQntHandUnit "Enter unit of measure.".
Variable labels PSAMSPHLCommQntLost    "Of the total quantity you stored how much was lost?".

*------------------------------------------------------------------------------
* Calculate % loss per row
*------------------------------------------------------------------------------

COMPUTE perc_loss = (PSAMSPHLCommQntLost / PSAMSPHLCommQntHand) * 100.
EXECUTE.

*------------------------------------------------------------------------------
* Average loss per farmer
*------------------------------------------------------------------------------

DATASET DECLARE avglossperfarmer_table.
AGGREGATE
  /OUTFILE='avglossperfarmer_table'
  /BREAK=PSAMSPHLFarmerNum
  /perc_loss_mean = MEAN(perc_loss).

*------------------------------------------------------------------------------
* Average across farmers
*------------------------------------------------------------------------------

DATASET ACTIVATE avglossperfarmer_table.
DESCRIPTIVES VARIABLES=perc_loss_mean
  /STATISTICS=MEAN.

* End of Scripts