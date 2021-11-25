/*Debt Indicators for Essential Needs Assessments 
**************************************************************************************************************
** Objective: Debt Analysis for the standard module 
/* Survey module : https://docs.wfp.org/api/documents/WFP-0000122078/download/

***Calculate mean and median debt for the last 30  days and for the total outstanding debt.

Variable labels 
    HHDebt_Est 'Total outstanding debt'
    HHBorrowEst_1M 'Total borrowed money/contracted debt in the last 30 days'.
execute.


frequencies HHDebt_Est HHBorrowEst_1M /statistics=mean /statistics=median /histogram.

*** % of households with debt by reason disaggregated for total debt and total debt in the last 30 days**
    /* Add value and variable labels
    
variable labels  
    HHBorrowFrom 'From whom did you borrow money or contracted debt'
     HHBorrowFrom_1M ' From whom did you borrow money or contracted debt in the last 30 days'.
execute.
value labels   HHBorrowFrom_1M HHBorrowFrom
100	'Relatives'
101	'Relatives (excluding  remittances from migrants abroad)'
102	'Relatives (living outside the country)'
200	'Traders/shopkeepers'
300	'Bank/ Credit institution/Micro-credit project'
301	'Humanitarian agencies'
302	'Cooperative'
400	'Money lender'
500	'Landlord (more than 1 month behind in rent)'
600	'Informal savings group'
700	'Employer'
999	'Other'.
execute.
    
frequencies HHBorrowFrom_1M HHBorrowFrom.

*** % of households with debt by source disaggregated for total debt and total debt in the last 30 days**
    /* Add value and variable labels

    
variable labels  
    HHBorrowWhy 'The main reason to borrow money or to contract debt'
    HHBorrowWhy_1M 'The main reason to borrow money or contract debt in the last 30 days'.
execute.

value labels HHBorrowWhy_1M  HHBorrowWhy
10100	'To buy food'
10200	'To buy non-food items (clothes, small furniture...)'
10300	'To rent an accommodation'
10400	'To pay school, education costs'
10500	'To cover health expenses'
20100	'To pay for durable goods (scooter, TV,...)'
20200	'To pay for ceremonies/social events'
20300	'To rent/buy a flat/house'
30100	'To pay ticket/cover travel for migration'
40100	'To buy agricultural land, inputs or livestock'
40200	'To invest in business'
50100	'To pay back another loan'
999	'Other (Please specify.)'.
execute.

frequencies HHBorrowWhy_1M  HHBorrowWhy. 

*** The estimated time for repayment (in months) can be used as an indicator of over-indebtedness**
   

variable labels  HHDebtPaidWhen ' How many months will you need to be able to repay the debts?'.
execute.
frequencies HHDebtPaidWhen /statistics=mean /statistics=median /histogram.
