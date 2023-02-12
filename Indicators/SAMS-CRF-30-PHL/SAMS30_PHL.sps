* Encoding: UTF-8.

*can only download repeat csv data as zip file from moda with group names - will update this code to remove group names
*rename to remove group names - because of the variable length SPSS changes name slightly

RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommName_A = PSAMSPHLCommName).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommName = PSAMSPHLCommName_oth).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommClas = PSAMSPHLCommClass).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntH_B = PSAMSPHLCommQntHand).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntH_A = PSAMSPHLCommQntHandUnit).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntH = PSAMSPHLCommQntHandUnit_oth).
RENAME VARIABLES (SAMS_moduleIndicator30_submoduleRepeatSAMSPHLPSAMSPHLCommQntL= PSAMSPHLCommQntLost ).

*also rename the _parent_index variable to farmer number 

RENAME VARIABLES (@_parent_index = PSAMSPHLFarmerNum).

* define variable and value labels

Variable labels PNutProgPartic_yn ‘Is participant enrolled in the ((insert name/description  of program, to be adapted locally)) programme?’.


Variable labels PSAMSPHLCommName "What is the name of commodity?".
Variable labels PSAMSPHLCommClass  "Which of the following groups does this commodity belong to?".
Variable labels PSAMSPHLCommQntHand "What is the amount of this commodity initially stored?".
Variable labels PSAMSPHLCommQntHandUnit  "Enter unit of measure.".
Variable labels PSAMSPHLCommQntLost  "Of the total quantity you stored how much was lost?".


*Calculate % loss per row

COMPUTE perc_loss=(PSAMSPHLCommQntLost / PSAMSPHLCommQntHand) * 100.
EXECUTE.


*Average loss per farmer 

DATASET DECLARE avglossperfarmer_table.
AGGREGATE
  /OUTFILE='avglossperfarmer_table'
  /BREAK=PSAMSPHLFarmerNum
  /perc_loss_mean=MEAN(perc_loss).


*Average across farmers

DATASET ACTIVATE avglossperfarmer_table.
DESCRIPTIVES VARIABLES=perc_loss_mean
  /STATISTICS=MEAN.












