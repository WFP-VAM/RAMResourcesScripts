* Encoding: UTF-8.
**** Calculating CC.3.5 Variable**.

**Defining Variable Labels**

** Preconditions Questions.

VARIABLE LABELS INDAsstWFPRecCashYN1Y "Did you receive cash-based WFP assistance in the last 12 months?".
VARIABLE LABELS  INDAsstWFPRecCapBuildYN1Y "Did you receive WFP capacity building assistance in the last 12 months?".

VALUE LABELS INDAsstWFPRecCashYN1Y, INDAsstWFPRecCapBuildYN1Y 0 "No" 1 "Yes".

** Demographics**.

VARIABLE LABELS RESPSex	"Sex of the Respondent".
VALUE LABELS RESPSex 0 "Female" 1 "Male".

VARIABLE LABELS RESPAge	"What is your age (in years)?".

VARIABLE LABELS RDisabSee	"Do you have difficulty seeing, even if wearing glasses?".
VARIABLE LABELS RDisabHear	"Do you have difficulty hearing, even if using a hearing aid(s)?".
VARIABLE LABELS RDisabWalk	"Do you have difficulty walking or climbing steps?".
VARIABLE LABELS RDisabRemember	"Do you have difficulty remembering or concentrating?".
VARIABLE LABELS RDisabUnderstand	"Using your usual language, do you have difficulty communicating, for example understanding or being understood?".
VARIABLE LABELS RDisabWash	"Do you have difficulty with self-care, such as washing all over or dressing?".

VALUE LABELS RDisabSee, RDisabHear, RDisabWalk, RDisabRemember, RDisabUnderstand, RDisabWash 1		"No difficulty" 2		"Some difficulty" 3		"A lot of difficulty" 4		"Cannot do at all"
888		"Don't know" 999		"Refuse".

VARIABLE LABELS HHGenMembers	"What is the composition of you household? By this, I mean which household members slept in your house at least 5 out of the last 7 nights.".

VALUE LABELS HHGenMembers 
1 "Couple household without children" 2 "Couple household with children" 3 "Single-parent household" 4 "Polygamous households" 5 "Single person household" 6 "Extended family household" 7 "Other household type".

** Other Questions**.

VARIABLE LABELS RFinancSit	"Your current financial situation compared to one year back has… please, complete the sentence.".
VALUE LABELS  RFinancSit 1		"Improved" 2		"Stayed the same" 3		"Worsened" 999		"Prefer not to answer".

VARIABLE LABELS RFinancSitRsn	"What do you think are the main reasons why your financial situation changed?".
VALUE LABELS RFinancSitRsn
1		"Employment Changes (Gaining or losing a job/business, changes in income, or shifts in working hours, and transitions between employment statuses.)" 
2		"Life Events (Marriage, divorce, childbirth, death of a spouse, retirement, or other significant personal milestones.)"
3		"Economic Factors (Fluctuations in the economy, such as recessions, inflation, changes in interest rates, shifts in the stock market, and the impact of events like wars or geopolitical tensions.)"
4		"Health Issues (Medical emergencies, chronic illnesses, or injuries that lead to increased healthcare expenses, loss of income due to inability to work, or other financial burdens.)"
5		"Environmental Factors (Natural events such as droughts, floods, hurricanes, or earthquakes that can have significant economic consequences, affecting crops, industries, resource availability, and individuals' financial situations.)"
999		"Others". 


* Define binary variables for each Reason.
COMPUTE Employment_Changes = (RFinancSitRsn = 1).
COMPUTE Life_Events = (RFinancSitRsn = 2).
COMPUTE Economic_Factors = (RFinancSitRsn =3).
COMPUTE Health_Issues = (RFinancSitRsn = 4).
COMPUTE Environmental_Factors = (RFinancSitRsn = 5).
COMPUTE Others = (RFinancSitRsn = 999).

VALUE LABELS Employment_Changes, Life_Events, Economic_Factors, Health_Issues, Environmental_Factors, Others 0 "No" 1"Yes".

**Ladder**

VARIABLE LABELS RGenLadderNoteF	"Please imagine a five-step ladder where at the bottom, on the first step, stand women of the community with little to say about important affairs in their lives,   such as their working life, whether to start or end a relationship in their personal life, or starting a new agricultural or other type of business. On the highest step, the fifth, stand those women who have a great capacity to make important decisions for themselves.".

VARIABLE LABELS RGenLadderNoteM	"Please imagine a five-step ladder where at the bottom, on the first step, stand men of the community with little  to say about important affairs in their lives,  such as their working life, whether to start or end a relationship in their personal life,  or starting a new agricultural or other type of business. On the highest step, the fifth, stand those men who have a great capacity to make important decisions for themselves.".

VARIABLE LABELS RGenLadderToday	"On which step of this ladder, would you position yourself today?".
VARIABLE LABELS RGenLadder1Y	"Where were you one year ago?".

VALUE LABELS  RGenLadderToday  RGenLadder1Y 1 	"Step 1 - Almost no power or freedom to make decisions" 2	"	Step 2 - Only a small amount of power & freedom"
3		"Step 3 - Power & freedom to make some major economic decisions"
4		"Step 4 – Power & freedom to make many major economic decisions"
5		"Step 5 - Power & freedom to make most/all major economic decisions".


VARIABLE LABELS RGenLadderRsn	"In a short sentence, what do you think are the main reasons why your rating (increased/stayed the same/decreased)?".



**==============================================================================**
                                                         *Indicator calcualtions*
**===============================================================================**.
**NOTE: Always filter for Q1 OR Q2 =1.

** Step 1: Calculating G1 : Total number of women reporting an improvement in their financial situation since this time last year (Question 1 = 1).
COMPUTE G1 = (INDAsstWFPRecCashYN1Y =1 |  INDAsstWFPRecCapBuildYN1Y= 1) & RFinancSit=1.
EXECUTE.

VARIABLE LABELS G1 "Total number of women reporting an improvement in their financial situation since this time last year ".

**Step 2: Calculating G2 : Total number of women reporting an improvement in agency (Question 4 value (step) < or = Question 3 Value step). 

COMPUTE G2= (INDAsstWFPRecCashYN1Y =1 | INDAsstWFPRecCapBuildYN1Y= 1) &( RGenLadder1Y <= RGenLadderToday).
EXECUTE.

VARIABLE LABELS G2 "Total number of women reporting an improvement in agency".

** Step 3: Now, count for an improvement only if G1 and G2 are showing improvement together - considering they are women.

COMPUTE G1.2= (G1=1 & G2=1) & RESPSex=0.
VARIABLE LABELS G1.2 "Women perceived economic empowerment".
EXECUTE.

COMPUTE i=  (INDAsstWFPRecCashYN1Y =1 | INDAsstWFPRecCapBuildYN1Y= 1) & RESPSex=0 .
 VARIABLE LABELS i "number of women".

* Step 4: Count the number of cases where G1.2= 1 and i = 1.
COUNT Sum_G1.2= G1.2 (1).
COUNT Sum_i = i (1).
EXECUTE.

* Step 5: Calculate the proportion of Sum_G1.2 divided by Sum_i.
COMPUTE Percentage_Women_Reporting_economic_empowerment= (Sum_G1.2 / Sum_i) * 100.
VALUE LABELS Percentage_Women_Reporting_economic_empowerment 0 "Do not Report economic empowerment" 100 "Reports economic empowerment".
EXECUTE.

* Step 6: Display the computed results ** TAKE VALID PERCENT VALUE*.

FREQUENCIES VARIABLES=Sum_G1.2 Sum_i  Percentage_Women_Reporting_economic_empowerment
  /STATISTICS=MEAN SUM
  /ORDER=ANALYSIS.

*** =================================================***
*Percentage_Men_Reporting_economic_empowerment Indicator
**=====================================================**
** Step 1: Calculating G3 : Total number of men reporting an improvement in their financial situation since this time last year (Question 1 = 1).
COMPUTE G3 = (INDAsstWFPRecCashYN1Y =1 | INDAsstWFPRecCapBuildYN1Y= 1) & RFinancSit=1.
EXECUTE.

VARIABLE LABELS G3 "Total number of men reporting an improvement in their financial situation since this time last year ".

**Step 2: Calculating G4 : Total number of men reporting an improvement in agency (Question 4 value (step) < or = Question 3 Value step). 

COMPUTE G4= (INDAsstWFPRecCashYN1Y =1 | INDAsstWFPRecCapBuildYN1Y= 1) &( RGenLadder1Y <= RGenLadderToday).
EXECUTE.

VARIABLE LABELS G4 "Total number of men reporting an improvement in agency".

** Step 3: Now, count for an improvement only if G3 and G4 are showing improvement together - considering they are MEN.

COMPUTE G3.4= (G3=1 & G4=1) & RESPSex=1.
VARIABLE LABELS G3.4 "Men perceived economic empowerment".
EXECUTE.

COMPUTE j=  (INDAsstWFPRecCashYN1Y =1 | INDAsstWFPRecCapBuildYN1Y= 1) & RESPSex=1 .
 VARIABLE LABELS j "number of men".

* Step 4: Count the number of cases where G3.4= 1 and j = 1.
COUNT Sum_G3.4= G3.4 (1).
COUNT Sum_j =j (1).
EXECUTE.

* Step 5: Calculate the proportion of Sum_G3.4 divided by Sum_j.
COMPUTE Percentage_men_Reporting_economic_empowerment= (Sum_G3.4 / Sum_j) * 100.
VALUE LABELS Percentage_men_Reporting_economic_empowerment 0 "Do not Report economic empowerment" 100 "Reports economic empowerment".
EXECUTE.

* Step 6: Display the computed results ** TAKE VALID PERCENT VALUE*.

FREQUENCIES VARIABLES=Sum_G3.4 Sum_j Percentage_men_Reporting_economic_empowerment
  /STATISTICS=MEAN SUM
  /ORDER=ANALYSIS.
 

**================================================================**
**                             Repeat the indicators for disabled people.
**================================================================**
**Create a new variable for disabled people 1= has disability 0= does not have a disability.

COMPUTE Disabled= (RDisabSee>= 3 |  RDisabHear >= 3 |  RDisabWalk>=3 |  RDisabRemember>= 3 | RDisabUnderstand >= 3 | RDisabWash >= 3).
EXECUTE.
VALUE LABELS Disabled 1"has disability" 0 "does not have a disability".


**================================================================**
           Percentage_DISABLED_WOMEN_Reporting_economic_empowerment
**================================================================**..
**Step 1: Calculating G5 : Total number of women with disability reporting an improvement in their financial situation since this time last year (Question 1 = 1).
COMPUTE G5 = (INDAsstWFPRecCashYN1Y =1 | INDAsstWFPRecCapBuildYN1Y= 1) & Disabled=1 & RFinancSit=1.
EXECUTE.

VARIABLE LABELS G6 "Total number of women with disability reporting an improvement in their financial situation since this time last year ".

**Step 2: Calculating G6 : Total number of women with disabiliy reporting an improvement in agency (Question 4 value (step) < or = Question 3 Value step). 



COMPUTE G6= (INDAsstWFPRecCashYN1Y =1 | INDAsstWFPRecCapBuildYN1Y= 1) & Disabled=1 & (RGenLadder1Y <= RGenLadderToday).

VARIABLE LABELS G6 "Total number of women reporting an improvement in agency".
EXECUTE.
** Step3: Now, count for an improvement only if G5 and G6 are showing improvement together - considering they are WOMEN.

COMPUTE G5.6= (G5=1 & G6=1) & RESPSex=0.
VARIABLE LABELS G5.6 "Women with disability perceived economic empowerment".
EXECUTE.

COMPUTE m=  (INDAsstWFPRecCashYN1Y =1 | INDAsstWFPRecCapBuildYN1Y= 1) & Disabled=1 & RESPSex=0 .
 VARIABLE LABELS m "number of women with disability".

* Step 4: Count the number of cases where G5.6= 1 and m= 1.
COUNT Sum_G5.6= G5.6 (1).
COUNT Sum_m =m (1).
EXECUTE.

* Step 5: Calculate the proportion of Sum_G5.6 divided by Sum_m.
COMPUTE  Percentage_DISABLED_WOMEN_Reporting_economic_empowerment= (Sum_G5.6 / Sum_m) * 100.
VALUE LABELS  Percentage_DISABLED_WOMEN_Reporting_economic_empowerment 0 "Do not Report economic empowerment" 100 "Reports economic empowerment".
EXECUTE.

* Step 6: Display the computed results ** TAKE VALID PERCENT VALUE*.

FREQUENCIES VARIABLES=Sum_G5.6 Sum_m  Percentage_DISABLED_WOMEN_Reporting_economic_empowerment
  /STATISTICS=MEAN SUM
  /ORDER=ANALYSIS.



**================================================================**
           Percentage_DISABLED_MEN_Reporting_economic_empowerment
**================================================================**..

** Step 1: Calculating G7 : Total number of men with disability reporting an improvement in their financial situation since this time last year (Question 1 = 1).
COMPUTE G7 = (INDAsstWFPRecCashYN1Y =1 | INDAsstWFPRecCapBuildYN1Y= 1) & Disabled=1 & RFinancSit=1.
EXECUTE.

VARIABLE LABELS G7 "Total number of men with disability reporting an improvement in their financial situation since this time last year ".

**Step 2: Calculating G8 : Total number of men with disabiliy reporting an improvement in agency (Question 4 value (step) < or = Question 3 Value step). 

COMPUTE G8= (INDAsstWFPRecCashYN1Y =1 | INDAsstWFPRecCapBuildYN1Y= 1) & Disabled=1 &( RGenLadder1Y <= RGenLadderToday).
EXECUTE.

VARIABLE LABELS G8 "Total number of men reporting an improvement in agency".

** Step 3: Now, count for an improvement only if G5 and G6 are showing improvement together - considering they are WOMEN.

COMPUTE G7.8= (G7=1 & G8=1) & RESPSex=1.
VARIABLE LABELS G7.8 "Men perceived economic empowerment".
EXECUTE.

COMPUTE p=  (INDAsstWFPRecCashYN1Y =1 | INDAsstWFPRecCapBuildYN1Y= 1) & Disabled=1 & RESPSex=1 .
 VARIABLE LABELS p "number of men with disability".


* Step 4: Count the number of cases where G7.8= 1 and p= 1.
COUNT Sum_G7.8= G7.8 (1).
COUNT Sum_p =p(1).
EXECUTE.

* Step 5: Calculate the proportion of Sum_G7.8 divided by Sum_p.
COMPUTE  Percentage_DISABLED_MEN_Reporting_economic_empowerment= (Sum_G7.8/ Sum_p) * 100.
VALUE LABELS  Percentage_DISABLED_MEN_Reporting_economic_empowerment 0 "Do not Report economic empowerment" 100 "Reports economic empowerment".
EXECUTE.

* Step 6: Display the computed results ** TAKE VALID PERCENT VALUE*.

FREQUENCIES VARIABLES=Sum_G7.8 Sum_p  Percentage_DISABLED_MEN_Reporting_economic_empowerment
  /STATISTICS=MEAN SUM
  /ORDER=ANALYSIS.


