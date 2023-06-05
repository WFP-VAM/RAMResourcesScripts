* Encoding: UTF-8.

* define variable and value labels

Variable labels HHFFAPart "Have you or any of your household member participated in the asset creation activities and received a food assistance transfer?".
 Variable labels HHAssetProtect "Do you think that the assets that were built or rehabilitated in your community are better protecting your household,  from floods / drought / landslides / mudslides?".
 Variable labels HHAssetProduct "Do you think that the assets that were built or rehabilitated in your community have allowed your household to increase or diversify its production (agriculture / livestock / other)?".
 Variable labels HHAssetDecHardship "Do you think that the assets that were built or rehabilitated in your community have decreased the day-to-day hardship and released time for any of your family members (including women and children)?".
 Variable labels HHAssetAccess "Do you think that the assets that were built or rehabilitated in your community have improved the ability of any of your household member to access markets and/or basic services (water, sanitation, health, education, etc)?".
 Variable labels HHTrainingAsset "Do you think that the trainings and other support provided in your community have improved your household’s ability to manage and maintain assets?".
 Variable labels HHAssetEnv "Do you think that the assets that were built or rehabilitated in your community have improved your natural environment (for example more vegetal cover, water table increased, less erosion, etc.)?".
 Variable labels HHWorkAsset "Do you think that the works undertaken in your community have restored your ability to access and/or use basic asset functionalities?".    
    
 Value labels HHFFAPart 1 'Yes' 0  'No'.
Value labels  HHAssetProtect HHAssetProduct HHAssetDecHardship HHAssetAccess HHTrainingAsset HHAssetEnv HHWorkAsset 1 'Yes' 0  'No' 9999 "Not applicable".

*take a look at of responses by community and note how many questions (and which were not answered by each community) for each community
 
CROSSTABS
  /TABLES= HHAssetProtect HHAssetProduct HHAssetDecHardship HHAssetAccess HHTrainingAsset HHAssetEnv HHWorkAsset BY ADMIN5Name
  /CELLS=COUNT  
  /COUNT ROUND CELL.

* recode 9999 to 0 

RECODE  HHAssetProtect HHAssetProduct HHAssetDecHardship HHAssetAccess HHTrainingAsset HHAssetEnv HHWorkAsset  (9999=0) (0=0) (1=1).
EXECUTE.


*create values with the denominator of questions asked for each community - should scan through the data and values from tables above to generate these values

do if  ADMIN5Name = "Community A".
compute ABIdenom =5. 
else. 
compute ABIdenom = 6. 
end if. 
EXECUTE.

*Create ABI score (summing all response) and ABI percent (dividing total score by denominator of applicaple questions)
    
Compute ABIScore = sum(HHAssetProtect,HHAssetProduct,HHAssetDecHardship,HHAssetAccess,HHTrainingAsset,HHAssetEnv,HHWorkAsset).
Compute ABIPerc = ((ABIScore / ABIdenom) * 100).
EXECUTE.


* Creates table of values - participants vs non-participants

DATASET DECLARE ABIperc_particp.
AGGREGATE
  /OUTFILE='ABIperc_particp'
  /BREAK=HHFFAPart
  /ABIPerc_mean=MEAN(ABIPerc).

* calculate the ABI across using weight value of 2 for non-participants which accounts for sampling imbalance between participants and non-participants
* if ration of participants vs non-participants is not 2/1 then a more sophisticated method for creating weights should be used

Dataset Activate ABIperc_particp.
do if  HHFFAPart = 0.
compute ABIperc_wtd =2. 
else. 
compute ABIperc_wtd = 1. 
end if. 
EXECUTE.

* add weight for non particpant and compute average

compute ABIperc_total_partic = ((ABIPerc_mean * ABIperc_wtd)/3).
EXECUTE.

AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=
  /ABIperc_total =SUM(ABIperc_total_partic).
