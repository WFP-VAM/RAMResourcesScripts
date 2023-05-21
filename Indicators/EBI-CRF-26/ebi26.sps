* Encoding: UTF-8.
* define variable and value labels

Variable labels EBIFFAPart 'Have you or any of your household member participated in the asset creation activities and received a food assistance transfer?'.
Variable labels EBISoilFertility 'Do you think that the assets that were built or rehabilitated in your community have allowed to increase agricultural potential due to greater water availability and/or soil fertility (e.g. increased or diversified production not requiring expanded irrigation)'.
Variable labels EBIStabilization 'Do you think that the assets that were built or rehabilitated in your community have improved natural environment due to land stabilization and restoration (e.g. more natural vegetal cover, increase in indigenous flora/fauna, less erosion or siltation, etc.)?'.
Variable labels EBISanitation 'Do you think that the assets that were built or rehabilitated in your community have improved environmental surroundings due to enhanced water and sanitation measures (i.e., greater availability/longer duration of water for domestic non-human consumption, improved hygiene practices – less open defecation)?'.

Value labels EBIFFAPart 1 'Yes' 0  'No'.
Value labels  EBISoilFertility EBIStabilization EBISanitation 1 'Yes' 0  'No' 9999 'Not applicable'.

*take a look at of responses by community and note how many questions were answered for each community
 
CROSSTABS
  /TABLES= EBISoilFertility EBIStabilization EBISanitation BY ADMIN5Name
  /CELLS=COUNT  
  /COUNT ROUND CELL.

* recode 9999 to 0 

RECODE EBISoilFertility EBIStabilization EBISanitation  (9999=0) (0=0) (1=1).
EXECUTE.

* create table of % of yes responses to each of the 3 questions by ADMIN5Name

DATASET DECLARE table_allperc.
SORT CASES BY ADMIN5Name.
AGGREGATE
  /OUTFILE='table_allperc'
  /PRESORTED
  /BREAK=ADMIN5Name
  /EBISoilFertility_mean=MEAN(EBISoilFertility) 
  /EBIStabilization_mean=MEAN(EBIStabilization) 
  /EBISanitation_mean=MEAN(EBISanitation) .

DATASET ACTIVATE table_allperc.
COMPUTE EBISoilFertility_perc=EBISoilFertility_mean * 100.
COMPUTE EBIStabilization_perc=EBIStabilization_mean * 100.
COMPUTE EBISanitation_perc=EBISanitation_mean * 100.
EXECUTE.

*create values with the denominator of questions asked for each community - should scan through the data and values from tables above to generate these values

DATASET ACTIVATE table_allperc.
do if  ADMIN5Name = "Community A".

compute EBIdenom =2. 
else. 
compute EBIdenom = 3. 
end if. 
EXECUTE.

*calculate EBI by community

DATASET ACTIVATE table_allperc.    
compute EBI_ADMIN5Name = (EBISoilFertility_perc + EBIStabilization_perc + EBISanitation_perc) / EBIdenom.
EXECUTE.

*finally calculate total EBI average EBI across all communities

DATASET ACTIVATE table_allperc.
DESCRIPTIVES VARIABLES=EBI_ADMIN5Name
  /STATISTICS=MEAN.
