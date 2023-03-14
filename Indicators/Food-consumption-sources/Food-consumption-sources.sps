* Encoding: UTF-8.


****Syntax for Calculating Food Sources 
***define variable labels

Variable labels
FCSStap 'Cereals, grains, roots and tubers, such as:'
FCSPulse 'Pulses/ legumes / nuts, such as:'
FCSDairy 'Milk and other dairy products, such as:'
FCSPr 'Meat, fish and eggs, such as:'
FCSVeg  'Vegetables and leaves, such as:'
FCSFruit 'Fruits, such as:'
FCSFat 'Oil/fat/butter, such as:'
FCSSugar 'Sugar, or sweet, such as:'
FCSCond 'Condiments/Spices, such as:'.

Variable labels
FCSStap_SRf 'What was the main source of food for this food group?'
FCSPulse_SRf 'What was the main source of food for this food group?'
FCSDairy_SRf 'What was the main source of food for this food group?'
FCSPr_SRf 'What was the main source of food for this food group?'
FCSVeg_SRf 'What was the main source of food for this food group?'
FCSFruit_SRf 'What was the main source of food for this food group?'
FCSFat_SRf 'What was the main source of food for this food group?'
FCSSugar_SRf 'What was the main source of food for this food group?'
FCSCond_SRf 'What was the main source of food for this food group?'.  

***define value labels

Value labels  
FCSStap_SRf FCSPulse_SRf FCSDairy_SRf FCSPr_SRf FCSVeg_SRf FCSFruit_SRf FCSFat_SRf FCSSugar_SRf FCSCond_SRf
100 'Own production' 
200 'Fishing/ hunting'
300 'Gathering'
400 'Loaned/borrowed'
500 'Purchased'
600 'Credit'
700 'Begging'
800 'Exchange for labour or items'
900 'Gifts from family/friends'
999 'Other'
1000 'Food aid'.

***Staples***  

DO IF (FCSStap_SRf = "100" | FCSStap_SRf = "200"). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStap_SRf = "300" | FCSStap_SRf = "900" | FCSStap_SRf = "1000"). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStap_SRf = "400" | FCSStap_SRf = "600"). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Credit_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStap_SRf = "500"). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Cash_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStap_SRf  = "700"). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Beg_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStap_SRf= "800"). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStap_SRf= "999"). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Other_cereal. 
END IF. 
EXECUTE. 

***Pulses*** 

DO IF (FCSPulse_SRf = "100" | FCSPulse_SRf = "200"). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_pulses. 
END IF. 
EXECUTE. 

DO IF (FCSPulse_SRf = "300" | FCSPulse_SRf = "900" | FCSPulse_SRf = "1000"). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_pulses. 
END IF. 
EXECUTE. 

DO IF (FCSPulse_SRf = "400" | FCSPulse_SRf = "600"). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Credit_pulses. 
END IF. 
EXECUTE. 

DO IF (FCSPulse_SRf = "500"). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Cash_pulses. 
END IF. 
EXECUTE. 

DO IF (FCSPulse_SRf  = "700"). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Beg_pulses. 
END IF. 
EXECUTE. 

DO IF (FCSPulse_SRf= "800"). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_pulses. 
END IF. 
EXECUTE. 

DO IF (FCSPulse_SRf= "999"). 
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Other_pulses. 
END IF. 
EXECUTE. 

***Dairy*** 

DO IF (FCSDairy_SRf = "100" | FCSDairy_SRf = "200"). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_dairy. 
END IF. 
EXECUTE. 

DO IF (FCSDairy_SRf = "300" | FCSDairy_SRf = "900" | FCSDairy_SRf = "1000"). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_dairy. 
END IF. 
EXECUTE. 

DO IF (FCSDairy_SRf = "400" | FCSDairy_SRf = "600"). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Credit_dairy. 
END IF. 
EXECUTE. 

DO IF (FCSDairy_SRf = "500"). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Cash_dairy. 
END IF. 
EXECUTE. 

DO IF (FCSDairy_SRf  = "700"). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Beg_dairy. 
END IF. 
EXECUTE. 

DO IF (FCSDairy_SRf = "800"). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_dairy. 
END IF. 
EXECUTE. 

DO IF (FCSDairy_SRf = "999"). 
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Other_dairy. 
END IF. 
EXECUTE. 

***Protein*** 

DO IF (FCSPr_SRf = "100" | FCSPr_SRf  = "200"). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_prot. 
END IF. 
EXECUTE. 

DO IF (FCSPr_SRf  = "300" | FCSPr_SRf  = "900" | FCSPr_SRf = "1000"). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_prot. 
END IF. 
EXECUTE. 

DO IF (FCSPr_SRf  = "400" | FCSPr_SRf  = "600"). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Credit_prot. 
END IF. 
EXECUTE. 

DO IF (FCSPr_SRf  = "500"). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Cash_prot. 
END IF. 
EXECUTE. 

DO IF (FCSPr_SRf   = "700"). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Beg_prot. 
END IF. 
EXECUTE. 

DO IF (FCSPr_SRf  = "800"). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_prot. 
END IF. 
EXECUTE. 

DO IF (FCSPr_SRf = "999"). 
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Other_prot. 
END IF. 
EXECUTE. 

***Vegetables*** 

DO IF (FCSVeg_SRf = "100" | FCSVeg_SRf  = "200"). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_veg. 
END IF. 
EXECUTE. 

DO IF (FCSVeg_SRf  = "300" | FCSVeg_SRf  = "900" | FCSVeg_SRf = "1000"). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_veg. 
END IF. 
EXECUTE. 

DO IF (FCSVeg_SRf  = "400" | FCSVeg_SRf  = "600"). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Credit_veg. 
END IF. 
EXECUTE. 

DO IF (FCSVeg_SRf  = "500"). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Cash_veg. 
END IF. 
EXECUTE. 

DO IF (FCSVeg_SRf   = "700"). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Beg_veg. 
END IF. 
EXECUTE. 

DO IF (FCSVeg_SRf  = "800"). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_veg. 
END IF. 
EXECUTE. 

DO IF (FCSVeg_SRf = "999"). 
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Other_veg. 
END IF. 
EXECUTE. 


***Fruit*** 

DO IF (FCSFruit_SRf = "100" | FCSFruit_SRf  = "200"). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_fruit. 
END IF. 
EXECUTE. 

DO IF (FCSFruit_SRf  = "300" | FCSFruit_SRf  = "900" | FCSFruit_SRf = "1000"). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_fruit. 
END IF. 
EXECUTE. 

DO IF (FCSFruit_SRf  = "400" | FCSFruit_SRf  = "600"). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Credit_fruit. 
END IF. 
EXECUTE. 

DO IF (FCSFruit_SRf  = "500"). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Cash_fruit. 
END IF. 
EXECUTE. 

DO IF (FCSFruit_SRf   = "700"). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Beg_fruit. 
END IF. 
EXECUTE. 

DO IF (FCSFruit_SRf  = "800"). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_fruit. 
END IF. 
EXECUTE. 

DO IF (FCSFruit_SRf = "999"). 
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Other_fruit. 
END IF. 
EXECUTE. 

***Sugar*** 

DO IF (FCSSugar_SRf = "100" | FCSSugar_SRf  = "200"). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_sugar. 
END IF. 
EXECUTE. 

DO IF (FCSSugar_SRf  = "300" | FCSSugar_SRf  = "900" | FCSSugar_SRf = "1000"). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_sugar. 
END IF. 
EXECUTE. 

DO IF (FCSSugar_SRf  = "400" | FCSSugar_SRf  = "600"). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Credit_sugar. 
END IF. 
EXECUTE. 

DO IF (FCSSugar_SRf  = "500"). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Cash_sugar. 
END IF. 
EXECUTE. 

DO IF (FCSSugar_SRf   = "700"). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Beg_sugar. 
END IF. 
EXECUTE. 

DO IF (FCSSugar_SRf  = "800"). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_sugar. 
END IF. 
EXECUTE. 

DO IF (FCSSugar_SRf = "999"). 
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Other_sugar. 
END IF. 
EXECUTE. 

***Oil/Fat*** 

DO IF (FCSFat_SRf = "100" | FCSFat_SRf  = "200"). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_fat. 
END IF. 
EXECUTE. 

DO IF (FCSFat_SRf  = "300" | FCSFat_SRf  = "900" | FCSFat_SRf = "1000"). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_fat. 
END IF. 
EXECUTE. 

DO IF (FCSFat_SRf  = "400" | FCSFat_SRf  = "600"). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Credit_fat. 
END IF. 
EXECUTE. 

DO IF (FCSFat_SRf  = "500"). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Cash_fat. 
END IF. 
EXECUTE. 

DO IF (FCSFat_SRf   = "700"). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Beg_fat. 
END IF. 
EXECUTE. 

DO IF (FCSFat_SRf  = "800"). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_fat. 
END IF. 
EXECUTE. 

DO IF (FCSFat_SRf = "999"). 
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Other_fat. 
END IF. 
EXECUTE. 


***Condiment*** Cond - condiment

DO IF (FCSCond_SRf = "100" | FCSCond_SRf  = "200"). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Ownprodfish_condiment. 
END IF. 
EXECUTE. 

DO IF (FCSCond_SRf  = "300" | FCSCond_SRf  = "900" | FCSCond_SRf = "1000"). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO GathGift_condiment. 
END IF. 
EXECUTE. 

DO IF (FCSCond_SRf  = "400" | FCSCond_SRf  = "600"). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Credit_condiment. 
END IF. 
EXECUTE. 

DO IF (FCSCond_SRf  = "500"). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Cash_condiment. 
END IF. 
EXECUTE. 

DO IF (FCSCond_SRf   = "700"). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Beg_condiment. 
END IF. 
EXECUTE. 

DO IF (FCSCond_SRf  = "800"). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_condiment. 
END IF. 
EXECUTE. 

DO IF (FCSCond_SRf = "999"). 
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Other_condiment. 
END IF. 
EXECUTE. 


***Step 2 - Calculate unique variable for each source 

COMPUTE Ownprodfish = sum (Ownprodfish_cereal, Ownprodfish_pulses, Ownprodfish_prot, Ownprodfish_dairy, Ownprodfish_veg, Ownprodfish_fruit, Ownprodfish_fat, Ownprodfish_sugar, Ownprodfish_condiment). 
COMPUTE Gath_Gift= sum (GathGift_cereal, GathGift_pulses, GathGift_prot, GathGift_dairy, GathGift_veg, GathGift_fruit, GathGift_fat, GathGift_sugar, GathGift_condiment). 
COMPUTE Credit = sum (Credit_cereal, Credit_pulses, Credit_prot, Credit_dairy, Credit_veg, Credit_fruit, Credit_fat, Credit_sugar, Credit_condiment). 
COMPUTE Cash =  sum (Cash_cereal, Cash_pulses, Cash_prot, Cash_dairy, Cash_veg, Cash_fruit, Cash_fat, Cash_sugar, Cash_condiment). 
COMPUTE Beg =  sum (Beg_cereal, Beg_pulses, Beg_prot, Beg_dairy, Beg_veg, Beg_fruit, Beg_fat, Beg_sugar, Beg_condiment). 
COMPUTE Exchange = sum (Exchange_cereal, Exchange_pulses, Exchange_prot, Exchange_dairy, Exchange_veg, Exchange_fruit, Exchange_fat, Exchange_sugar, Exchange_condiment). 
COMPUTE Other = sum (Other_cereal, Other_pulses, Other_prot, Other_dairy, Other_veg, Other_fruit, Other_fat, Other_sugar, Other_condiment). 

***Step 3 - Compute the total sources of food 

COMPUTE totsource = sum (Ownprodfish, Gath_Gift, Credit, Cash, Beg, Exchange, Other). 
EXECUTE. 

***Step 4 - Calculate % of each food source 

COMPUTE pownprod = (Ownprodfish/ totsource)*100. 
COMPUTE pgathering_gift = (Gath_Gift/ totsource)*100. 
COMPUTE pcredit = (Credit/ totsource)*100. 
COMPUTE pcash = (Cash / totsource)*100. 
COMPUTE pbeg = (Beg / totsource)*100. 
COMPUTE pexchange = (Exchange / totsource)*100. 
COMPUTE pother = (Other / totsource)*100. 
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
FORMATS pbeg(F8.0). 

*Exchange for food 

VARIABLE LEVEL pexchange (SCALE). 
VARIABLE LABELS pexchange '% of food from exchanges (food source)'. 
FORMATS pexchange (F8.0). 

*Other

VARIABLE LEVEL pother (SCALE). 
VARIABLE LABELS pother '% of food from other (food source)'. 
FORMATS pother (F8.0). 

DESCRIPTIVES VARIABLES=pownprod pgathering_gift pcredit pcash pbeg pexchange pother
  /STATISTICS=MEAN STDDEV MIN MAX. 

 

