*------------------------------------------------------------------------------*
*	                          WFP Standardized Scripts
*                     Calculating Environmental Benefit Indicator (EBI) 26
*------------------------------------------------------------------------------*

* This script calculates the Environmental Benefit Indicator (EBI) based on various 
* environmental-related questions. It recodes the responses, calculates percentages, 
* and computes the EBI for each community and overall.

* Define variable and value labels
Variable labels
  EBIFFAPart       'Have you or any of your household member participated in the asset creation activities and received a food assistance transfer?'
  EBISoilFertility 'Do you think that the assets that were built or rehabilitated in your community have allowed to increase agricultural potential due to greater water availability and/or soil fertility (e.g. increased or diversified production not requiring expanded irrigation)?'
  EBIStabilization 'Do you think that the assets that were built or rehabilitated in your community have improved natural environment due to land stabilization and restoration (e.g. more natural vegetal cover, increase in indigenous flora/fauna, less erosion or siltation, etc.)?'
  EBISanitation    'Do you think that the assets that were built or rehabilitated in your community have improved environmental surroundings due to enhanced water and sanitation measures (i.e., greater availability/longer duration of water for domestic non-human consumption, improved hygiene practices – less open defecation)?'

Value labels
  EBIFFAPart       1 'Yes' 0 'No'
  EBISoilFertility 1 'Yes' 0 'No' 9999 'Not applicable'
  EBIStabilization 1 'Yes' 0 'No' 9999 'Not applicable'
  EBISanitation    1 'Yes' 0 'No' 9999 'Not applicable'

* Take a look at responses by community and note how many questions were answered for each community
CROSSTABS
  /TABLES=EBISoilFertility EBIStabilization EBISanitation BY ADMIN5Name
  /CELLS=COUNT
  /COUNT ROUND CELL.

* Recode 9999 to 0
RECODE EBISoilFertility EBIStabilization EBISanitation (9999=0) (0=0) (1=1).
EXECUTE.

* Create table of % of yes responses to each of the 3 questions by ADMIN5Name
DATASET DECLARE table_allperc.
SORT CASES BY ADMIN5Name.
AGGREGATE
  /OUTFILE='table_allperc'
  /PRESORTED
  /BREAK=ADMIN5Name
  /EBISoilFertility_mean=MEAN(EBISoilFertility)
  /EBIStabilization_mean=MEAN(EBIStabilization)
  /EBISanitation_mean=MEAN(EBISanitation).

DATASET ACTIVATE table_allperc.
COMPUTE EBISoilFertility_perc = EBISoilFertility_mean * 100.
COMPUTE EBIStabilization_perc = EBIStabilization_mean * 100.
COMPUTE EBISanitation_perc = EBISanitation_mean * 100.
EXECUTE.

* Create values with the denominator of questions asked for each community
DATASET ACTIVATE table_allperc.
DO IF ADMIN5Name = "Community A".
  COMPUTE EBIdenom = 2.
ELSE.
  COMPUTE EBIdenom = 3.
END IF.
EXECUTE.

* Calculate EBI by community
COMPUTE EBI_ADMIN5Name = (EBISoilFertility_perc + EBIStabilization_perc + EBISanitation_perc) / EBIdenom.
EXECUTE.

* Calculate total EBI average across all communities
DESCRIPTIVES VARIABLES=EBI_ADMIN5Name
  /STATISTICS=MEAN.

* End of Scripts