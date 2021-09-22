****Syntax for Calculating Food Sources 
***define variable labels    

Variable labels  
FCSStapSRf	‘Over the last 7 days, what was the main source of cereals, grains, roots and tubers?’. 
FCSPulseSRf	‘Over the last 7 days, what was the main source of legumes / nuts?’. 
FCSDairySRf	‘Over the last 7 days, what was the main source of milk and dairy products?’. 
FCSPrSRf		‘Over the last 7 days, what was the main source of meat, fish, eggs?’. 
FCSVegSRf		‘Over the last 7 days, what was the main source of vegetables and leaves?’. 
FCSFruitSRf	‘Over the last 7 days, what was the main source of fruits?’. 
FCSFatSRf		‘Over the last 7 days,What was the main source of oil/fat/butter?’. 
FCSSugarSRf	‘Over the last 7 days, what was the main source of sugar and sweets?’. 
FCSCondSRf	‘Over the last 7 days,What was the main source of condiments/spices?’. 

***define value labels   
Value labels  
 FCSStapSRf FCSPulseSRf FCSDairySRf FCSPrSRf FCSVegSRf FCSFruitSRf FCSFatSRf FCSSugarSRf FCSCondSRf	 
1 ‘Own production (crops, animals)’. 
2 ‘Fishing/ hunting’. 
3 ‘Gathering’.  
4 ‘Loan (including borrowed, credited)’. 
5 ‘Market (purchase with cash)’. 
6 ‘Market (purchase on credit)’. 
7 ‘Begging for food’. 
8 ‘Exchange for labour or items for food’. 
9 ‘Gift (food) from family friends’. 
10 ‘Food aid from civil society, NGO, government, WFP, etc’. 

***Staples***  
DO IF (FCSStapSRf = 1| FCSStapSRf = 2). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStapSRf = 3 | FCSStapSRf = 9| FCSStapSRf = 10). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStapSRf = 4 | FCSStapSRf = 6). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Credit_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStapSRf = 5). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Cash_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStapSRf = 7). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Beg_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStapSRf = 8). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_cereal. 
END IF. 
EXECUTE. 

***Pulses*** 
DO IF (FCSPulseSRf = 1| FCSPulseSRf = 2). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_pulses. 
END IF. 
EXECUTE. 

DO IF (FCSPulseSRf = 3 | FCSPulseSRf = 9 | FCSPulseSRf = 10). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_pulses. 
END IF. 
EXECUTE. 

DO IF (FCSPulseSRf = 4 | FCSPulseSRf = 6). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Credit_pulses. 
END IF. 
EXECUTE. 

DO IF (FCSPulseSRf = 5). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Cash_pulses. 
END IF. 
EXECUTE. 

DO IF (FCSPulseSRf = 7). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Beg_pulses. 
END IF. 
EXECUTE. 

DO IF (FCSPulseSRf = 8). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_ pulses. 
END IF. 
EXECUTE. 

***Dairy*** 
DO IF (FCSDairySRf = 1 | FCSDairySRf = 2). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_dairy. 
END IF. 
EXECUTE. 

DO IF (FCSDairySRf = 3 | FCSDairySRf = 9 | FCSDairySRf = 10). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_dairy. 
END IF. 
EXECUTE. 

DO IF (FCSDairySRf = 4 | FCSDairySRf = 6). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Credit_dairy. 
END IF. 
EXECUTE. 

DO IF (FCSDairySRf = 5). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Cash_dairy. 
END IF. 
EXECUTE. 

DO IF (FCSDairySRf = 7). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Beg_dairy. 
END IF. 
EXECUTE. 

DO IF (FCSDairySRf = 8). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_dairy. 
END IF. 
EXECUTE. 

***Protein*** 
DO IF (FCSPrSRf = 1| FCSPrSRf = 2). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_prot. 
END IF. 
EXECUTE. 

DO IF (FCSPrSRf = 3| FCSPrSRf = 9 | FCSPrSRf = 10). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_prot. 
END IF. 
EXECUTE. 

DO IF (FCSPrSRf= 4| FCSPrSRf= 6). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Credit_prot. 
END IF. 
EXECUTE. 

DO IF (FCSPrSRf = 5). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Cash_prot. 
END IF. 
EXECUTE. 

DO IF (FCSPrSRf = 7). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Beg_prot. 
END IF. 
EXECUTE. 

DO IF (FCSPrSRf = 8). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_prot. 
END IF. 
EXECUTE. 

***Vegetables*** 
DO IF (FCSVegSRf = 1 | FCSVegSRf = 2). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_veg. 
END IF. 
EXECUTE. 

DO IF (FCSVegSRf = 3| FCSVegSRf = 9 | FCSVegSRf = 10). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_veg. 
END IF. 
EXECUTE. 

DO IF (FCSVegSRf = 4 | FCSVegSRf = 6). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Credit_veg. 
END IF. 
EXECUTE. 

DO IF (FCSVegSRf = 5). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Cash_veg. 
END IF. 
EXECUTE. 

DO IF (FCSVegSRf = 7). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Beg_veg. 
END IF. 
EXECUTE. 

DO IF (FCSVegSRf = 8). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_veg. 
END IF. 
EXECUTE. 

***Fruit*** 
DO IF (FCSFruitSRf = 1| FCSFruitSRf = 2). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_fruit. 
END IF. 
EXECUTE. 

DO IF (FCSFruitSRf= 3| FCSFruitSRf=9 | FCSFruitSRf=10). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_fruit. 
END IF. 
EXECUTE. 

DO IF (FCSFruitSRf = 4| FCSFruitSRf = 6). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Credit_fruit. 
END IF. 
EXECUTE. 

DO IF (FCSFruitSRf = 5). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Cash_fruit. 
END IF. 
EXECUTE. 

DO IF (FCSFruitSRf = 7). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Beg_fruit. 
END IF. 
EXECUTE. 

DO IF (FCSFruitSRf = 8). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_fruit. 
END IF. 
EXECUTE. 

***Sugar*** 
DO IF (FCSSugarSRf = 1| FCSSugarSRf = 2). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_sugar. 
END IF. 
EXECUTE. 

DO IF (FCSSugarSRf = 3 | FCSSugarSRf = 9| FCSSugarSRf = 10). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_sugar. 
END IF. 
EXECUTE. 

DO IF (FCSSugarSRf= 4 | FCSSugarSRf= 6). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Credit_sugar. 
END IF. 
EXECUTE. 

DO IF (FCSSugarSRf = 5). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Cash_sugar. 
END IF. 
EXECUTE. 

DO IF (FCSSugarSRf = 7). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Beg_sugar. 
END IF. 
EXECUTE. 

DO IF (FCSSugarSRf = 8). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_sugar. 
END IF. 
EXECUTE. 

***Oil/Fat*** 
DO IF (FCSFatSRf = 1| FCSFatSRf = 2). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_fat. 
END IF. 
EXECUTE. 

DO IF (FCSFatSRf = 3| FCSFatSRf = 9| FCSFatSRf = 10). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_fat. 
END IF. 
EXECUTE. 

DO IF (FCSFatSRf = 4 | FCSFatSRf = 6). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Credit_fat. 
END IF. 
EXECUTE. 

DO IF (FCSFatSRf = 5). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Cash_fat. 
END IF. 
EXECUTE. 

DO IF (FCSFatSRf = 7). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Beg_fat. 
END IF. 
EXECUTE. 

DO IF (FCSFatSRf = 8). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_fat. 
END IF. 
EXECUTE. 

***Condiment*** 
DO IF (FCSCondSRf = 1| FCSCondSRf = 2). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_condiment. 
END IF. 
EXECUTE. 

DO IF (FCSCondSRf = 3 | FCSCondSRf = 9 | FCSCondSRf =10). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_condiment. 
END IF. 
EXECUTE. 

DO IF (FCSCondSRf = 4 | FCSCondSRf = 6). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Credit_condiment. 
END IF. 
EXECUTE. 

DO IF (FCSCondSRf = 5). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Cash_condiment. 
END IF. 
EXECUTE. 

DO IF (FCSCondSRf = 7). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Beg_condiment. 
END IF. 
EXECUTE. 

DO IF (FCSCondSRf = 8). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_condiment. 
END IF. 
EXECUTE. 

***Step 2 - Calculate unique variable for each source 
COMPUTE Ownprodfish = sum (Ownprodfish_cereal, Ownprodfish_pulses, Ownprodfish_prot, Ownprodfish_dairy, Ownprodfish_fat, Ownprodfish_veg, Ownprodfish_fruit, Ownprodfish_sugar, Ownprodfish_condiment). 
COMPUTE Gath_Gift= sum (GathGift_cereal, GathGift_pulses, GathGift_prot, GathGift_dairy, GathGift_fat, GathGift_veg, GathGift_fruit, GathGift_sugar, GathGift_condiment). 
COMPUTE Credit = sum (Credit_cereal, Credit_pulses, Credit_prot, Credit_dairy _fat, Credit_veg, Credit_fruit, Credit_sugar, Credit_condiment. 
COMPUTE Cash = sum (Cash_cereal, Cash_pulses, Cash_prot, Cash_dairy, Cash_fat, Cash_veg, Cash_fruit, Cash_sugar, Cash_condiment). 
COMPUTE Beg = sum (Beg_cereal, Beg_pulses, Beg_prot, Beg_dairy, Beg_fat, Beg_veg, Beg_fruit, Beg_sugar, Beg_condiment). 
COMPUTE Exchange = sum (Exchange_cereal, Exchange_pulses, Exchange_prot, Exchange_dairy, Exchange_fat, Exchange_veg, Exchange_fruit, Exchange_sugar, Exchange_condiment). 

***Step 3 - Compute the total sources of food 
COMPUTE totsource = sum (Ownprodfish, Gath_Gift, Credit, Cash, Beg, Exchange). 
EXECUTE. 

***Step 4 - Calculate % of each food source 
COMPUTE pownprod = (Ownprodfish/ totsource)*100. 
COMPUTE pgathering_gift = (Gath_Gift/ totsource)*100. 
COMPUTE pcredit = (Credit/ totsource)*100. 
COMPUTE pcash = (Cash / totsource)*100. 
COMPUTE pbeg = (Beg / totsource)*100. 
COMPUTE pexchange = (Exchange / totsource)*100. 
EXECUTE. 

* Define Variable Properties. 
* Own production and fishing 

VARIABLE LEVEL pownprod(SCALE). 
VARIABLE LABELS pownprod '% of food from own production and fishing (food source)'. 
FORMATS pownprod(F8.0). 

*Gathering and gifts 
VARIABLE LEVEL pgathering_gift (SCALE). 
VARIABLE LABELS pgathering_gift '% of food from gathering, gifts and assistance (food source)'. 
FORMATS pgathering_gift (F8.0). 

*Credit purchases 
VARIABLE LEVEL pcredit (SCALE). 
VARIABLE LABELS pcredit '% of food from market credit purchases (food source)'. 
FORMATS pcredit (F8.0). 

*Cash purchases 
VARIABLE LEVEL pcash (SCALE). 
VARIABLE LABELS pcash '% of food from market cash purchases (food source)'. 
FORMATS pcash (F8.0). 

 

*Begging 
VARIABLE LEVEL pbeg (SCALE). 
VARIABLE LABELS pbeg '% of food from begging (food source)'. 
FORMATS pgift(F8.0). 

*Exchange for food 
VARIABLE LEVEL pexchange (SCALE). 
VARIABLE LABELS pexchange '% of food from exchanges (food source)'. 
FORMATS pexchange (F8.0). 

DESCRIPTIVES VARIABLES=pownprod pgathering_gift pcredit pcash pbeg pexchange 

  /STATISTICS=MEAN STDDEV MIN MAX. 

 

 