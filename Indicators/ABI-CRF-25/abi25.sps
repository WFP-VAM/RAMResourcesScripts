*------------------------------------------------------------------------------*
*	                          WFP Standardized Scripts
*                    Calculating Asset-Based Indicator (ABI) 25
*------------------------------------------------------------------------------*

* This script calculates the Asset-Based Indicator (ABI) based on various 
* asset-related questions. It recodes the responses, sums the scores, and 
* calculates the percentage ABI for each respondent.

* Define variable and value labels
Variable labels
  HHFFAPart          "Have you or any of your household member participated in the asset creation activities and received a food assistance transfer?".
  HHAssetProtect     "Do you think that the assets that were built or rehabilitated in your community are better protecting your household from floods / drought / landslides / mudslides?".
  HHAssetProduct     "Do you think that the assets that were built or rehabilitated in your community have allowed your household to increase or diversify its production (agriculture / livestock / other)?".
  HHAssetDecHardship "Do you think that the assets that were built or rehabilitated in your community have decreased the day-to-day hardship and released time for any of your family members (including women and children)?".
  HHAssetAccess      "Do you think that the assets that were built or rehabilitated in your community have improved the ability of any of your household member to access markets and/or basic services (water, sanitation, health, education, etc)?".
  HHTrainingAsset    "Do you think that the trainings and other support provided in your community have improved your household’s ability to manage and maintain assets?".
  HHAssetEnv         "Do you think that the assets that were built or rehabilitated in your community have improved your natural environment (for example more vegetal cover, water table increased, less erosion, etc.)?".
  HHWorkAsset        "Do you think that the works undertaken in your community have restored your ability to access and/or use basic asset functionalities?".

Value labels
  HHFFAPart          1 'Yes' 0 'No'.
  HHAssetProtect
  HHAssetProduct
  HHAssetDecHardship
  HHAssetAccess
  HHTrainingAsset
  HHAssetEnv
  HHWorkAsset        1 'Yes' 0 'No' 9999 "Not applicable".

* Recode 9999 to 0
RECODE
  HHAssetProtect
  HHAssetProduct
  HHAssetDecHardship
  HHAssetAccess
  HHTrainingAsset
  HHAssetEnv
  HHWorkAsset       (9999 = 0) (0 = 0) (1 = 1).
EXECUTE.

* Create denominator of questions asked for each community
DO IF ADMIN5Name = "Community A".
  COMPUTE ABIdenom = 5.
ELSE.
  COMPUTE ABIdenom = 6.
END IF.
EXECUTE.

* Create ABI score and ABI percent
COMPUTE ABIScore = SUM(HHAssetProtect, HHAssetProduct, HHAssetDecHardship, HHAssetAccess, HHTrainingAsset, HHAssetEnv, HHWorkAsset).
COMPUTE ABIPerc = ((ABIScore / ABIdenom) * 100).
EXECUTE.

* Create table of values - participants vs non-participants
DATASET DECLARE ABIperc_particp.
AGGREGATE
  /OUTFILE='ABIperc_particp'
  /BREAK=HHFFAPart
  /ABIPerc_mean = MEAN(ABIPerc).

* Calculate ABI using weight value of 2 for non-participants
DATASET ACTIVATE ABIperc_particp.
DO IF HHFFAPart = 0.
  COMPUTE ABIperc_wtd = 2.
ELSE.
  COMPUTE ABIperc_wtd = 1.
END IF.
EXECUTE.

* Add weight for non-participant and compute average
COMPUTE ABIperc_total_partic = ((ABIPerc_mean * ABIperc_wtd) / 3).
EXECUTE.

AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=
  /ABIperc_total = SUM(ABIperc_total_partic).

* End of Scripts