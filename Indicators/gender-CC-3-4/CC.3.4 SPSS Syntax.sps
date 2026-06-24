* Encoding: UTF-8.
*Variables Labels and Coding.
*ENUgenEntity Variable.
VARIABLE LABELS 
ENUGenEntityYN "Does a WFP food assistance decision-making entity exist, and are one or more members present at the site? ".
VARIABLE LABELS
RGenEntityYN  "Are you a member of, or do you participate in one or more of the following entities? Food distribution related entity, nutrition-related entity,  farmer group or related, school feeding related entity, climate change or disaster risk reduction related entity or any other entity".

VALUE LABELS 
ENUGenEntityYN RGenEntityYN 0 "No" 1 "Yes".
EXECUTE.

*RGenEntityYN Variable.

VALUE LABELS
RGenEntityYN 0 "No" 1 "Yes". 
EXECUTE.



* Define binary variables for each entity type.
COMPUTE Entity_FoodDist = (RGenEntityType = 1).
COMPUTE Entity_Nutrition = (RGenEntityType = 2).
COMPUTE Entity_FarmerGroup = (RGenEntityType = 3).
COMPUTE Entity_SchoolFeeding = (RGenEntityType = 4).
COMPUTE Entity_ClimateChange = (RGenEntityType = 5).
COMPUTE Entity_Other = (RGenEntityType = 999).
EXECUTE.

* Label the new variables.
VARIABLE LABELS Entity_FoodDist "Food distribution related entity".
VARIABLE LABELS Entity_Nutrition "Nutrition-related entity".
VARIABLE LABELS Entity_FarmerGroup "Farmer group or related".
VARIABLE LABELS Entity_SchoolFeeding "School feeding related entity".
VARIABLE LABELS Entity_ClimateChange "Climate change or disaster risk reduction related entity".
VARIABLE LABELS Entity_Other "Other (Specify)".
EXECUTE.

* Assign value labels.
VALUE LABELS Entity_FoodDist Entity_Nutrition Entity_FarmerGroup Entity_SchoolFeeding Entity_ClimateChange Entity_Other
    0 "No"
    1 "Yes".
EXECUTE.

*Other entity.
VARIABLE LABELS
RGenEntityType_oth "Other (Specify)".
EXECUTE.

*Sex of the respondent.
VARIABLE LABELS
RESPSex	"Sex of the Respondent".
VALUE LABELS
RESPSex	0 "Female" 1 "Male".
EXECUTE.

*Age of the respondent.
VARIABLE LABELS
RESPAge "What is your age in years?".
EXECUTE.

*Disability questions.
*Seeing.
VARIABLE LABELS
RDisabSee "Do you have difficulty seeing, even if wearing glasses?".
*Hearing.
VARIABLE LABELS
RDisabHear "Do you have difficulty hearing, even if using a hearing aid(s)?".
*Walking.
VARIABLE LABELS
RDisabWalk	"Do you have difficulty walking or climbing steps?".
*Remember.
VARIABLE LABELS
RDisabRemember	"Do you have difficulty remembering or concentrating?".
*Understanding.
VARIABLE LABELS
RDisabUnderstand	"Using your usual language, do you have difficulty communicating, for example understanding or being understood?".
*Wash.
VARIABLE LABELS
RDisabWash	"Do you have difficulty with self-care, such as washing all over or dressing?".


VALUE LABELS 
RDisabSee RDisabHear RDisabWalk RDisabRemember RDisabUnderstand	RDisabWash 1	"No difficulty"2 "Some difficulty" 3 "A lot of difficulty" 4 "Cannot do at all" 888	"Don’t know" 999 "Refuse".
EXECUTE.



*When was the last time you participated in the entity?.
VARIABLE LABELS
RGenEntityDate	"When was the last time you participated in the entity?".
VALUE LABELS
RGenEntityDate 1	"Less than a week" 2  "Less than a month" 3  "Between one and three months" 4 "More than three months" 888	"Don’t know" 999  "Refuse".
EXECUTE.


**Meaningful Participation Questions.
*Participation info.
VARIABLE LABELS
RGenEntityInf	"The last time you participated in the entity, were you informed about an intervention's update, your rights, responsibilities, or options (related to the entity´s mandate, project ongoing or about to start…)?".
*Consulted through the meeting.
VARIABLE LABELS
RGenEntityCon	"The last time you participated in the entity, were you consulted through meetings or other means (interviews, surveys…)  about a new initiative, a challenge, or a new plan?".
*were you asked to put your opinion.
VARIABLE LABELS
RGenEntityPla	"The last time you participated in the entity, were you informed and consulted but your opinion was not reflected in final decisions?".
*were you able to negotiate?.
VARIABLE LABELS
RGenEntityNeg	"The last time you participated in the entity, could you negotiate with the decision makers on decisions that would affect you?".
*The last time you participated in the entity, did decision makers negotiate with you to ensure viability of a project, intervention or to address an important issue?.
VARIABLE LABELS
RGenEntityDel	"The last time you participated in the entity, did decision makers negotiate with you to ensure viability of a project, intervention or to address an important issue?".
*were you a decision maker?.
VARIABLE LABELS
RGenEntityDM	"The last time you participated in the entity, were you a decision-maker?".
VALUE LABELS
RGenEntityInf RGenEntityCon RGenEntityPla RGenEntityNeg RGenEntityDel RGenEntityDM 1 "Yes" 2 "No".
EXECUTE.


**--------------------------------------------------------------------------------------------------------------------------------------------------------**
* Create the variable CC.3.4: Meaningful participation in WFP-supported entities at the community level*
**--------------------------------------------------------------------------------------------------------------------------------------------------------**
** make sure to apply pre-conditions of questions 1 and 2**.
** Filter for the Year K.
*====================================================================================*
***Proportion of women in decision-making entities who report a meaningful participation in year k
*====================================================================================*
  * Step 1: Identify women reporting meaningful participation (G1). 
COMPUTE G1 =(ENUGenEntityYN = 1 AND RGenEntityYN =1) AND ( RGenEntityNeg = 1 |  RGenEntityDel = 1 | RGenEntityDM = 1) AND RESPSex = 0. 
* Step 2: Identify women in decision-making entities (i). 
COMPUTE i = (ENUGenEntityYN = 1 AND RGenEntityYN =1 AND RESPSex= 0). 
EXECUTE.

VARIABLE LABELS 
G1 "Women reporting meaningful participation in decision making entities".
VARIABLE LABELS
i "Number of women who confirm they are members of or participants in decision-making entities".
EXECUTE.

* Step 3: Count the number of cases where G1 = 1 and i = 1.
COUNT Sum_G1 = G1 (1).
COUNT Sum_i = i (1).
EXECUTE.

* Step 4: Calculate the proportion of Sum_G1 divided by Sum_i.
COMPUTE Proportion_Women_Meaningful_Participation = (Sum_G1 / Sum_i) * 100.
VALUE LABELS Proportion_Women_Meaningful_Participation 0 "No meaningful participation" 100 "Meaningful Participation".
EXECUTE.

* Step 5: Display the computed results ** TAKE VALID PERCENT VALUE*.
FREQUENCIES VARIABLES=Sum_G1 Sum_i Proportion_Women_Meaningful_Participation
  /STATISTICS=MEAN SUM
  /ORDER=ANALYSIS.

*====================================================================================*
***Proportion of men in decision-making entities who report a meaningful participation in year k
*====================================================================================*
  * Step 1: Identify men reporting meaningful participation (G2). 
COMPUTE G2 = (ENUGenEntityYN = 1 AND RGenEntityYN =1) AND ( RGenEntityNeg = 1 |  RGenEntityDel = 1 | RGenEntityDM = 1) AND RESPSex = 1. 
* Step 2: Identify men  in decision-making entities (j). 
COMPUTE j = (ENUGenEntityYN = 1 AND RGenEntityYN =1) AND RESPSex= 1. 
EXECUTE.

VARIABLE LABELS 
G2 "Men reporting meaningful participation in decision making entities".
VARIABLE LABELS
j "Number of men who confirm they are members of or participants in decision-making entities".
EXECUTE.

* Step 3: Count the number of cases where G2 = 1 and j= 1.
COUNT Sum_G2 = G2 (1).
COUNT Sum_j = j (1).
EXECUTE.

* Step 4: Calculate the proportion of Sum_G2 divided by Sum_j.
COMPUTE Proportion_men_Meaningful_Participation = (Sum_G2 / Sum_j) * 100.
VALUE LABELS Proportion_men_Meaningful_Participation 0 "No meaningful participation" 100 "Meaningful Participation".
EXECUTE.

* Step 5: Display the computed results ** TAKE VALID PERCENT VALUE*.
FREQUENCIES VARIABLES=Sum_G2 Sum_j Proportion_men_Meaningful_Participation
  /STATISTICS=MEAN SUM
  /ORDER=ANALYSIS.

**================Create a new variable for disabled people 1= has disability 0= does not have a disability======*.

COMPUTE Disabled= (RDisabSee>= 3 |  RDisabHear >= 3 |  RDisabWalk>=3 |  RDisabRemember>= 3 | RDisabUnderstand >= 3 | RDisabWash >= 3).
EXECUTE.
VALUE LABELS Disabled 1"has disability" 0 "does not have a disability".


*====================================================================================*
***Proportion of women living with disabilities in decision-making entities who report a meaningful participation in year k
*====================================================================================*
**Identify women with disabilities reporting meaningful participation  decision making entities*.
*=====================================================================================*.
*=====================================================================================*.
  * Step 1: Identify disabled women reporting meaningful participation (G3). 
COMPUTE G3= (ENUGenEntityYN = 1 AND RGenEntityYN =1) AND Disabled=1  AND ( RGenEntityNeg = 1 |  RGenEntityDel = 1 | RGenEntityDM = 1) AND  RESPSex= 0.
EXECUTE.
*====================================================================================*
**Step 2: Identify women with disabilities who are members in decision making entities*
*=====================================================================================*.
COMPUTE m =  (ENUGenEntityYN = 1 AND RGenEntityYN =1) AND Disabled=1  AND RESPSex= 0. 
EXECUTE. 

VARIABLE LABELS
G3 "Women living with disabilities reporting meaningful participation in decision-making entities".
VARIABLE LABELS
m "Number of women living with disabilities who confirm they are members of or participants in decision-making entities".

* Step 3: Count the number of cases where G3= 1 and m = 1.
COUNT Sum_G3 = G3 (1).
COUNT Sum_m = m (1).
EXECUTE.

* Step 4: Calculate the proportion of Sum_G3 divided by Sum_m.
COMPUTE Proportion_Disabled_Women_Meaningful_Participation = (Sum_G3 / Sum_m) * 100.
VALUE LABELS Proportion_Disabled_Women_Meaningful_Participation 0 "No meaningful participation" 100 "Meaningful Participation".
EXECUTE.

* Step 5: Display the computed results ** TAKE VALID PERCENT VALUE*.
** to remove missing cases found when dividing by zero, use select IF first**.
*SELECT IF (NOT MISSING(Proportion_Disabled_Women_Meaningful_Participation)).  

FREQUENCIES VARIABLES=Sum_G3 Sum_m Proportion_Disabled_Women_Meaningful_Participation
  /STATISTICS=MEAN SUM
  /ORDER=ANALYSIS.

* Another way of displaying the results but in a different dataset window, Aggregate data to sum G3 and m then calculate the indicator. 
 
AGGREGATE 
  /OUTFILE=*  /* Keeps the aggregated data in the current dataset */ 
  /BREAK=  /* Leave this blank if not grouping by any variables */ 
  /Sum_G3 = SUM(G3) 
  /Sum_m= SUM(m). 
COMPUTE Proportion_Women_Disability_Meaningful_Participation = (Sum_G3 / Sum_m) * 100. 
EXECUTE.


*====================================================================================*
***Proportion of men living with disabilities in decision-making entities who report a meaningful participation in year k
*====================================================================================*
** Step 1: Identify men with disabilities reporting meaningful participation  decision making entities*.

*=====================================================================================*.
COMPUTE G4= (ENUGenEntityYN = 1 AND RGenEntityYN =1)  AND Disabled=1 AND ( RGenEntityNeg = 1 |  RGenEntityDel = 1 | RGenEntityDM = 1) AND  RESPSex= 1.
EXECUTE.
*====================================================================================*
** Step 2: Identify men with disabilities who are members in decision making entities*
*=====================================================================================*.
COMPUTE  p =  (ENUGenEntityYN = 1 AND RGenEntityYN =1) AND Disabled=1 AND RESPSex= 1. 
EXECUTE. 

VARIABLE LABELS
G4 "Men living with disabilities reporting meaningful participation in decision-making entities".
VARIABLE LABELS
p "Number of men living with disabilities who confirm they are members of or participants in decision-making entities".

* Step 3: Count the number of cases where G4= 1 and p = 1.
COUNT Sum_G4 = G4 (1).
COUNT Sum_p = p (1).
EXECUTE.

* Step 4: Calculate the proportion of Sum_G3 divided by Sum_m.
COMPUTE Proportion_Disabled_men_Meaningful_Participation = (Sum_G4 / Sum_p) * 100.
VALUE LABELS Proportion_Disabled_men_Meaningful_Participation 0 "No meaningful participation" 100 "Meaningful Participation".
EXECUTE.

* Step 5: Display the computed results ** TAKE VALID PERCENT VALUE*.
** to remove missing cases found when dividing by zero, use select IF first**.
*SELECT IF (NOT MISSING(Proportion_Disabled_men_Meaningful_Participation)).  

FREQUENCIES VARIABLES=Sum_G4 Sum_p Proportion_Disabled_men_Meaningful_Participation
  /STATISTICS=MEAN SUM
  /ORDER=ANALYSIS.

* another way of displaying the results but in a separate dataset window, Aggregate data to sum G4 and p then calculate the indicator. 
 
AGGREGATE 
  /OUTFILE=*  /* Keeps the aggregated data in the current dataset */ 
  /BREAK=  /* Leave this blank if not grouping by any variables */ 
  /Sum_G4 = SUM(G4) 
  /Sum_p= SUM(p). 
COMPUTE Proportion_Men_Disability_Meaningful_Participation = (Sum_G4 / Sum_p) * 100. 
EXECUTE.


**=======================================================================================*
***Proportion of women in decision-making entities who report being the decision maker
**=======================================================================================*.

  * Step 1: Identify  women being the decision maker (G5).

COMPUTE G5= (ENUGenEntityYN = 1 AND RGenEntityYN =1) AND RGenEntityDM=1 AND RESPSex = 0.
EXECUTE.

VARIABLE LABELS
G5 "Women reporting being the decision maker in decision-making entities".
VARIABLE LABELS
i "Number of women who confirm they are members of or participants in decision-making entities".
EXECUTE.

* Step 3: Count the number of cases where G5= 1 and i = 1.
COUNT Sum_G5 = G5 (1).
COUNT Sum_i = i(1).
EXECUTE.

* Step 4: Calculate the proportion of Sum_G5 divided by Sum_i.
COMPUTE Proportion_Women_DM_Reports_DMakers = (Sum_G5 / Sum_i) * 100.
VALUE LABELS Proportion_Women_DM_Reports_DMakers 0 "No meaningful participation" 100 "Meaningful Participation".
EXECUTE.

* Step 5: Display the computed results ** TAKE VALID PERCENT VALUE*.
** to remove missing cases found when dividing by zero, use select IF first**.
*SELECT IF (NOT MISSING(Proportion_Women_DM_Reports_DMakers )).  

FREQUENCIES VARIABLES=Sum_G5 Sum_i Proportion_Women_DM_Reports_DMakers 
  /STATISTICS=MEAN SUM
  /ORDER=ANALYSIS.

**=======================================================================================*
***Proportion of Men in decision-making entities who report being the decision maker
**=======================================================================================*.
  * Step 1: Identify  men being the decision maker (G6).
COMPUTE G6= (ENUGenEntityYN = 1 AND RGenEntityYN =1) AND RGenEntityDM=1 AND RESPSex = 1. .
EXECUTE.
COMPUTE j = (ENUGenEntityYN = 1 AND RGenEntityYN =1 AND RESPSex= 1). 
EXECUTE.
VARIABLE LABELS
G6 "Men reporting being the decision maker in decision-making entities".
VARIABLE LABELS
j "Number of men who confirm they are members of or participants in decision-making entities".
EXECUTE.

* Step 3: Count the number of cases where G6= 1 and j = 1.
COUNT Sum_G6 = G6 (1).
COUNT Sum_j = j(1).
EXECUTE.

* Step 4: Calculate the proportion of Sum_G6 divided by Sum_j.
COMPUTE Proportion_Men_DM_Reports_DMakers = (Sum_G6 / Sum_j) * 100.
VALUE LABELS Proportion_Men_DM_Reports_DMakers 0 "No meaningful participation" 100 "Meaningful Participation".
EXECUTE.

* Step 5: Display the computed results ** TAKE VALID PERCENT VALUE*.
** to remove missing cases found when dividing by zero, use select IF first**.
*SELECT IF (NOT MISSING(Proportion_Women_DM_Reports_DMakers )).  

FREQUENCIES VARIABLES=Sum_G6 Sum_j Proportion_Men_DM_Reports_DMakers 
  /STATISTICS=MEAN SUM
  /ORDER=ANALYSIS.



