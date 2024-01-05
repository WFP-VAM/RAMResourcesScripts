Syntax for Calculating the Household Hunger Scale 

***Create Household Hunger Scale*** 

**define variables  

Variable labels  
HHSNoFood 	‘In the past [4 weeks/30 days], was there ever no food to eat of any kind in your house because of lack of resources to get food?’ 
HHSNoFood_FR	‘How often did this happen in the past [4 weeks/30 days]?’ 
HHSBedHung 	‘In the past [4 weeks/30 days], did you or any household member go to sleep at night hungry because there was not enough food?’ 
HHSBedHung_FR	‘How often did this happen in the past [4 weeks/30 days]?’ 
HHSNotEat	‘In the past 4 weeks (30 days), did you or any household member go a whole day and night without eating anything because there was not enough food?’ 
HHSNotEat_FR	‘How often did this happen in the past [4 weeks/30 days]?’. 


***define labels 

Value labels HHSNoFood HHSBedHung HHSNotEat 
0 ‘No’	 
1 ‘Yes’. 

Value labels HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR 
1 ‘Rarely (1–2 times)’	 
2 ‘Sometimes (3–10 times)’	 
3 ‘Often (more than 10 times)’.	 

**Cleaning of HHS variables: make sure that is consistency between the filter and the frequency questions** 

* HHSNoFood and HHSNoFood_FR* 

Do if (HHSNoFood_FR >0). 
Compute HHSNoFood =1. 
ELSE. 
End if. 
EXECUTE. 

* HHSBedHung and HHSBedHung_FR* 

Do if (HHSBedHung_FR >0). 
Compute HHSBedHung =1. 
ELSE. 
End if. 
EXECUTE. 

* HHSNotEat and HHSNotEat_FR* 

Do if (HHSNotEat_FR>0). 
Compute HHSNotEat =1. 
ELSE. 
End if. 
EXECUTE. 

**Create a new variable for each frequency-of-occurrence question: the objective is to recode each frequency-of-occurrence question from three frequency categories (“rarely,” “sometimes,” “often”) into two frequency categories (“rarely or sometimes” and “often”)** 

RECODE HHSNoFood_FR HHSBedHung_FR HHSNotEat_FR (1=1) (2=1) (3=2) (ELSE=0) INTO HHSQ1 HHSQ2 HHSQ3. 

***define variables 

 

Variable labels  
HHSQ1 	'Was there ever no food to eat in HH?'  
HHSQ2 	'Did any HH member go sleep hungry?'  
HHSQ3 	'Did any HH member go whole day without food?'. 
EXECUTE. 

 
**The values of HHSQ1, HHSQ2, and HHSQ3 are summed for each household to calculate the HHS score** 

COMPUTE HHS=HHSQ1 + HHSQ2 + HHSQ3. 

Variable labels HHS 'Household Hunger Score'. 
EXECUTE. 

**Each household should have an HHS score between 0 and 6. These values are then used to generate the HHS indicators** 

FREQUENCIES VARIABLES=HHS 
  /STATISTICS=MEAN MEDIAN MINIMUM MAXIMUM 
  /ORDER=ANALYSIS. 

**To tabulate the categorical HHS indicator, two different cutoff values (> 1 and > 3) are applied to the HHS scores that were generated in Step 3 above** 

RECODE HHS (0 thru 1=1) (2 thru 3=2) (4 thru Highest=3) INTO HHSCat. 
variable labels HHSCat 'Household Hunger Score Categories'. 
EXECUTE. 

 

***define labels 

Value labels HHSCat  

1 `No or little hunger in the household` 
2 `Moderate hunger in the household` 
3 `Severe hunger in the household`. 


**Note: to tabulate the categorical HHS indicator for the IPC, using the four IPC cutoff values (0, 1, 2-3, 4 and 5+) are applied to the HHS scores that were generated in Step 3 above** 

RECODE HHSr (0=0) (1=1) (2 thru 3=2) (4=3) (5 thru Highest=4) INTO HHSCatr. 
variable labels HHSCatr 'Household Hunger Score Categories'. 
EXECUTE. 


***define labels 

Value labels HHSCat_IPC 
0 No hunger in the household 
1 little hunger in the household stress 
2 Moderate hunger in the household crisis 
3 Severe hunger in the household emergency 
4 Very severe hunger in the household catastrophe. 

FREQUENCIES HHSCat_IPC. 

*****END***** 
