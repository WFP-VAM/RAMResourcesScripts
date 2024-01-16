* Encoding: UTF-8.


****Syntax for Calculating Main Food Sources 
***define variable labels

Variable labels
FCSStap 'Cereals, grains, roots and tubers'
FCSPulse 'Pulses, legumes, nuts'
FCSDairy 'Milk and other dairy products'
FCSPr 'Meat, fish and eggs'
FCSVeg  'Vegetables and leaves'
FCSFruit 'Fruits'
FCSFat 'Oil and fat'
FCSSugar 'Sugar or sweets'
FCSCond 'Condiments and spices'.

Variable labels
FCSStap_SRf 'Staples – main source'
FCSPulse_SRf 'Pulses – main source'
FCSDairy_SRf 'Dairy – main source'
FCSPr_SRf 'Protein – main source'
FCSVeg_SRf 'Veg – main source'
FCSFruit_SRf 'Fruit – main source'
FCSFat_SRf 'Fat – main source'
FCSSugar_SRf 'Sugar – main source'
FCSCond_SRf 'Condiments – main source'.  

***define value labels

Value labels  
FCSStap_SRf FCSPulse_SRf FCSDairy_SRf FCSPr_SRf FCSVeg_SRf FCSFruit_SRf FCSFat_SRf FCSSugar_SRf FCSCond_SRf
100 'Own production' 
200 'Fishing_hunting'
300 'Gathering'
400 'Loaned_borrowed'
500 'Purchased'
600 'Credit'
700 'Begging'
800 'Exchange for labour or items'
900 'Gifts from family_friends'
1000 'Food aid'.

***Step 1 - Calculate unique variable for each source   

***Staples***  

DO IF (FCSStap_SRf = 100). 
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Ownprod_cereal. 
END IF. 
EXECUTE. 

DO IF (FCSStap_SRf = 200).  
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO HuntFish_cereal.  
END IF.  
EXECUTE.  

DO IF (FCSStap_SRf = 300).  
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Gather_cereal.  
END IF.  
EXECUTE.   

DO IF (FCSStap_SRf = 400).  
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Borrow_cereal.  
END IF.  
EXECUTE.  

DO IF (FCSStap_SRf = 500).  
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Cash_cereal.  
END IF.  
EXECUTE.  

DO IF (FCSStap_SRf = 600).  
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Credit_cereal.  
END IF.  
EXECUTE.  

DO IF (FCSStap_SRf = 700).  
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Beg_cereal.  
END IF.  
EXECUTE.  

DO IF (FCSStap_SRf= 800).  
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_cereal.  
END IF.  
EXECUTE.  

DO IF (FCSStap_SRf = 900).  
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Gift_cereal.  
END IF.  
EXECUTE.  

DO IF (FCSStap_SRf = 1000).  
RECODE FCSStap (0 thru 7=Copy) (SYSMIS=0) INTO Assistance_cereal.  
END IF.  
EXECUTE.  

RECODE Ownprod_cereal (SYSMIS=0). 
EXECUTE. 
RECODE HuntFish_cereal (SYSMIS=0). 
EXECUTE. 
RECODE Gather_cereal (SYSMIS=0). 
EXECUTE. 
RECODE Borrow_cereal (SYSMIS=0). 
EXECUTE. 
RECODE Cash_cereal (SYSMIS=0). 
EXECUTE. 
RECODE Credit_cereal (SYSMIS=0). 
EXECUTE. 
RECODE Beg_cereal (SYSMIS=0). 
EXECUTE. 
RECODE Exchange_cereal (SYSMIS=0). 
EXECUTE. 
RECODE Gift_cereal (SYSMIS=0). 
EXECUTE. 
RECODE Assistance_cereal (SYSMIS=0). 
EXECUTE. 

***Pulses*** 

DO IF (FCSPulse_SRf = 100).  
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Ownprod_pulses.  
END IF.  
EXECUTE.  

DO IF (FCSPulse_SRf = 200).  
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO HuntFish_pulses.  
END IF.  
EXECUTE.  

DO IF (FCSPulse_SRf = 300).  
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Gather_pulses.  
END IF.  
EXECUTE. 

DO IF (FCSPulse_SRf = 400).  
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Borrow_pulses.  
END IF.  
EXECUTE.  

DO IF (FCSPulse_SRf = 500).  
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Cash_pulses.  
END IF.  
EXECUTE.  

DO IF (FCSPulse_SRf = 600).  
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Credit_pulses.  
END IF.  
EXECUTE.  

DO IF (FCSPulse_SRf  = 700).  
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Beg_pulses.  
END IF.  
EXECUTE.  

DO IF (FCSPulse_SRf= 800).  
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_pulses.  
END IF.  
EXECUTE.  

DO IF (FCSPulse_SRf = 900).  
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Gift_pulses.  
END IF.  
EXECUTE.  

DO IF (FCSPulse_SRf = 1000).  
RECODE FCSPulse (0 thru 7=Copy) (SYSMIS=0) INTO Assistance_pulses.  
END IF.  
EXECUTE.  

RECODE Ownprod_pulses (SYSMIS=0). 
EXECUTE. 
RECODE HuntFish_pulses (SYSMIS=0). 
EXECUTE. 
RECODE Gather_pulses (SYSMIS=0). 
EXECUTE. 
RECODE Borrow_pulses (SYSMIS=0). 
EXECUTE. 
RECODE Cash_pulses (SYSMIS=0). 
EXECUTE. 
RECODE Credit_pulses (SYSMIS=0). 
EXECUTE. 
RECODE Beg_pulses (SYSMIS=0). 
EXECUTE. 
RECODE Exchange_pulses (SYSMIS=0). 
EXECUTE. 
RECODE Gift_pulses (SYSMIS=0). 
EXECUTE. 
RECODE Assistance_pulses (SYSMIS=0). 
EXECUTE. 

***Dairy*** 

DO IF (FCSDairy_SRf = 100).  
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Ownprod_dairy.  
END IF.  
EXECUTE.  

DO IF (FCSDairy_SRf = 200).  
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO HuntFish_dairy.  
END IF.  
EXECUTE.  

DO IF (FCSDairy_SRf = 300).  
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Gather_dairy.  
END IF.  
EXECUTE.  

DO IF (FCSDairy_SRf = 400).  
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Borrow_dairy.  
END IF.  
EXECUTE.  

DO IF (FCSDairy_SRf = 500).  
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Cash_dairy.  
END IF.  
EXECUTE.  

DO IF (FCSDairy_SRf = 600).  
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Credit_dairy.  
END IF.  
EXECUTE.  

DO IF (FCSDairy_SRf  = 700).  
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Beg_dairy.  
END IF.  
EXECUTE.  

DO IF (FCSDairy_SRf = 800).  
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_dairy.  
END IF.  
EXECUTE.  

DO IF (FCSDairy_SRf = 900).  
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Gift_dairy.  
END IF.  
EXECUTE.  

DO IF (FCSDairy_SRf = 1000).  
RECODE FCSDairy (0 thru 7=Copy) (SYSMIS=0) INTO Assistance_dairy.  
END IF.  
EXECUTE.  

RECODE Ownprod_dairy (SYSMIS=0). 
EXECUTE. 
RECODE HuntFish_dairy (SYSMIS=0). 
EXECUTE. 
RECODE Gather_dairy (SYSMIS=0). 
EXECUTE. 
RECODE Borrow_dairy (SYSMIS=0). 
EXECUTE. 
RECODE Cash_dairy (SYSMIS=0). 
EXECUTE. 
RECODE Credit_dairy (SYSMIS=0). 
EXECUTE. 
RECODE Beg_dairy (SYSMIS=0). 
EXECUTE. 
RECODE Exchange_dairy (SYSMIS=0). 
EXECUTE. 
RECODE Gift_dairy (SYSMIS=0). 
EXECUTE. 
RECODE Assistance_dairy (SYSMIS=0). 
EXECUTE. 

***Protein*** 

DO IF (FCSPr_SRf = 100).  
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Ownprod_prot.  
END IF.  
EXECUTE.  

DO IF (FCSPr_SRf  = 200).  
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO HuntFish_prot.  
END IF.  
EXECUTE.  

DO IF (FCSPr_SRf  = 300).  
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Gather_prot.  
END IF.  
EXECUTE.  

DO IF (FCSPr_SRf  = 400).  
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Borrow_prot.  
END IF.  
EXECUTE.  

DO IF (FCSPr_SRf  = 500).  
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Cash_prot.  
END IF.  
EXECUTE.  

DO IF (FCSPr_SRf   = 600).  
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Credit_prot.  
END IF.  
EXECUTE.  

DO IF (FCSPr_SRf   = 700).  
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Beg_prot.  
END IF.  
EXECUTE.  

DO IF (FCSPr_SRf  = 800).  
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_prot.  
END IF.  
EXECUTE.  

DO IF (FCSPr_SRf  = 900).  
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Gift_prot.  
END IF.  
EXECUTE.  

DO IF (FCSPr_SRf = 1000).  
RECODE FCSPr (0 thru 7=Copy) (SYSMIS=0) INTO Assistance_prot.  
END IF.  
EXECUTE.  

RECODE Ownprod_prot (SYSMIS=0). 
EXECUTE. 
RECODE HuntFish_prot (SYSMIS=0). 
EXECUTE. 
RECODE Gather_prot (SYSMIS=0). 
EXECUTE. 
RECODE Borrow_prot (SYSMIS=0). 
EXECUTE. 
RECODE Cash_prot (SYSMIS=0). 
EXECUTE. 
RECODE Credit_prot (SYSMIS=0). 
EXECUTE. 
RECODE Beg_prot (SYSMIS=0). 
EXECUTE. 
RECODE Exchange_prot (SYSMIS=0). 
EXECUTE. 
RECODE Gift_prot (SYSMIS=0). 
EXECUTE. 
RECODE Assistance_prot (SYSMIS=0). 
EXECUTE. 

***Vegetables*** 

DO IF (FCSVeg_SRf = 100).  
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Ownprod_veg.  
END IF.  
EXECUTE.  

DO IF (FCSVeg_SRf  = 200).  
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO HuntFish_veg.  
END IF.  
EXECUTE.  

DO IF (FCSVeg_SRf  = 300).  
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Gather_veg.  
END IF.  
EXECUTE.  

DO IF (FCSVeg_SRf  = 400).  
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Borrow_veg.  
END IF.  
EXECUTE.  

DO IF (FCSVeg_SRf  = 500).  
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Cash_veg.  
END IF.  
EXECUTE.  

DO IF (FCSVeg_SRf  = 600).  
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Credit_veg.  
END IF.  
EXECUTE.  

DO IF (FCSVeg_SRf   = 700).  
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Beg_veg.  
END IF.  
EXECUTE.  

DO IF (FCSVeg_SRf  = 800).  
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_veg.  
END IF.  
EXECUTE.  

DO IF (FCSVeg_SRf  = 900).  
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Gift_veg.  
END IF.  
EXECUTE.  

DO IF (FCSVeg_SRf = 1000).  
RECODE FCSVeg (0 thru 7=Copy) (SYSMIS=0) INTO Assistance_veg.  
END IF.  
EXECUTE.  

RECODE Ownprod_veg (SYSMIS=0). 
EXECUTE. 
RECODE HuntFish_veg (SYSMIS=0). 
EXECUTE. 
RECODE Gather_veg (SYSMIS=0). 
EXECUTE. 
RECODE Borrow_veg (SYSMIS=0). 
EXECUTE. 
RECODE Cash_veg (SYSMIS=0). 
EXECUTE. 
RECODE Credit_veg (SYSMIS=0). 
EXECUTE. 
RECODE Beg_veg (SYSMIS=0). 
EXECUTE. 
RECODE Exchange_veg (SYSMIS=0). 
EXECUTE. 
RECODE Gift_veg (SYSMIS=0). 
EXECUTE. 
RECODE Other_veg (SYSMIS=0). 
EXECUTE. 
RECODE Assistance_veg (SYSMIS=0). 
EXECUTE. 


***Fruit*** 

DO IF (FCSFruit_SRf = 100).  
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Ownprod_fruit.  
END IF.  
EXECUTE.  

DO IF (FCSFruit_SRf  = 200).  
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO HuntFish_fruit.  
END IF.  
EXECUTE.  

DO IF (FCSFruit_SRf  = 300).  
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Gather_fruit.  
END IF.  
EXECUTE.  

DO IF (FCSFruit_SRf  = 400).  
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Borrow_fruit.  
END IF.  
EXECUTE.  

DO IF (FCSFruit_SRf = 500).  
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Cash_fruit.  
END IF.  
EXECUTE.  

DO IF (FCSFruit_SRf = 600).  
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Credit_fruit.  
END IF.  
EXECUTE.   

DO IF (FCSFruit_SRf = 700).  
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Beg_fruit.  
END IF.  
EXECUTE.  

DO IF (FCSFruit_SRf  = 800).  
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_fruit.  
END IF.  
EXECUTE.  

DO IF (FCSFruit_SRf  = 900).  
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Gift_fruit.  
END IF.  
EXECUTE.  

DO IF (FCSFruit_SRf = 1000).  
RECODE FCSFruit (0 thru 7=Copy) (SYSMIS=0) INTO Assistance_fruit.  
END IF.  
EXECUTE.  

RECODE Ownprod_fruit (SYSMIS=0). 
EXECUTE. 
RECODE HuntFish_fruit (SYSMIS=0). 
EXECUTE. 
RECODE Gather_fruit (SYSMIS=0). 
EXECUTE. 
RECODE Borrow_fruit (SYSMIS=0). 
EXECUTE. 
RECODE Cash_fruit (SYSMIS=0). 
EXECUTE. 
RECODE Credit_fruit (SYSMIS=0). 
EXECUTE. 
RECODE Beg_fruit (SYSMIS=0). 
EXECUTE. 
RECODE Exchange_fruit (SYSMIS=0). 
EXECUTE. 
RECODE Gift_fruit (SYSMIS=0). 
EXECUTE. 
RECODE Assistance_fruit (SYSMIS=0). 
EXECUTE. 

***Sugar*** 

DO IF (FCSSugar_SRf = 100).  
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Ownprod_sugar.  
END IF.  
EXECUTE.  

DO IF (FCSSugar_SRf  = 200).  
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO HuntFish_sugar.  
END IF.  
EXECUTE.  

DO IF (FCSSugar_SRf  = 300).  
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Gather_sugar.  
END IF.  
EXECUTE.  

DO IF (FCSSugar_SRf  = 400).  
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Borrow_sugar.  
END IF.  
EXECUTE.  

DO IF (FCSSugar_SRf  = 500).  
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Cash_sugar.  
END IF.  
EXECUTE.  

DO IF (FCSSugar_SRf  = 600).  
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Credit_sugar.  
END IF.  
EXECUTE.  

DO IF (FCSSugar_SRf = 700).  
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Beg_sugar.  
END IF.  
EXECUTE.  

DO IF (FCSSugar_SRf  = 800).  
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_sugar.  
END IF.  
EXECUTE.  

DO IF (FCSSugar_SRf  = 900).  
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Gift_sugar.  
END IF.  
EXECUTE.  

DO IF (FCSSugar_SRf = 1000).  
RECODE FCSSugar (0 thru 7=Copy) (SYSMIS=0) INTO Assistance_sugar.  
END IF.  
EXECUTE.  

RECODE Ownprod_sugar (SYSMIS=0). 
EXECUTE. 
RECODE HuntFish_sugar (SYSMIS=0). 
EXECUTE. 
RECODE Gather_sugar (SYSMIS=0). 
EXECUTE. 
RECODE Borrow_sugar (SYSMIS=0). 
EXECUTE. 
RECODE Cash_sugar (SYSMIS=0). 
EXECUTE. 
RECODE Credit_sugar (SYSMIS=0). 
EXECUTE. 
RECODE Beg_sugar (SYSMIS=0). 
EXECUTE. 
RECODE Exchange_sugar (SYSMIS=0). 
EXECUTE. 
RECODE Gift_sugar (SYSMIS=0). 
EXECUTE. 
RECODE Assistance_sugar (SYSMIS=0). 
EXECUTE. 

***Oil and Fat*** 

DO IF (FCSFat_SRf = 100).  
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Ownprod_fat.  
END IF.  
EXECUTE.  

DO IF (FCSFat_SRf  = 200).  
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO HuntFish_fat.  
END IF.  
EXECUTE.  

DO IF (FCSFat_SRf  = 300).  
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Gather_fat.  
END IF.  
EXECUTE.  

DO IF (FCSFat_SRf  = 400).  
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Borrow_fat.  
END IF.  
EXECUTE.  

DO IF (FCSFat_SRf  = 500).  
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Cash_fat.  
END IF. 
EXECUTE.  

DO IF (FCSFat_SRf  = 600).  
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Credit_fat.  
END IF.  
EXECUTE.  

DO IF (FCSFat_SRf  = 700).  
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Beg_fat.  
END IF.  
EXECUTE.  

DO IF (FCSFat_SRf  = 800).  
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_fat.  
END IF.  
EXECUTE.  

DO IF (FCSFat_SRf  = 900).  
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Gift_fat.  
END IF.  
EXECUTE.  

DO IF (FCSFat_SRf  = 1000).  
RECODE FCSFat (0 thru 7=Copy) (SYSMIS=0) INTO Assistance_fat.  
END IF.  
EXECUTE.  

RECODE Ownprod_fat (SYSMIS=0). 
EXECUTE. 
RECODE HuntFish_fat (SYSMIS=0). 
EXECUTE. 
RECODE Gather_fat (SYSMIS=0). 
EXECUTE. 
RECODE Borrow_fat (SYSMIS=0). 
EXECUTE. 
RECODE Cash_fat (SYSMIS=0). 
EXECUTE. 
RECODE Credit_fat (SYSMIS=0). 
EXECUTE. 
RECODE Beg_fat (SYSMIS=0). 
EXECUTE. 
RECODE Exchange_fat (SYSMIS=0). 
EXECUTE. 
RECODE Gift_fat (SYSMIS=0). 
EXECUTE. 
RECODE Assistance_fat (SYSMIS=0). 
EXECUTE. 

***Condiment*** Cond - condiment

DO IF (FCSCond_SRf = 100).  
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Ownprod_condiment.  
END IF.  
EXECUTE.  

DO IF (FCSCond_SRf  = 200).  
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO HuntFish_condiment.  
END IF.  
EXECUTE.  

DO IF (FCSCond_SRf = 300).  
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Gather_condiment.  
END IF.  
EXECUTE.  

DO IF (FCSCond_SRf  = 400).  
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Borrow_condiment.  
END IF.  
EXECUTE.  

DO IF (FCSCond_SRf  = 500).  
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Cash_condiment.  
END IF.  
EXECUTE.  

DO IF (FCSCond_SRf  = 600).  
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Credit_condiment.  
END IF.  
EXECUTE.  

DO IF (FCSCond_SRf   = 700).  
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Beg_condiment.  
END IF.  
EXECUTE.  

DO IF (FCSCond_SRf  = 800).  
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Exchange_condiment.  
END IF.  
EXECUTE.  

DO IF (FCSCond_SRf  = 900).  
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Gift_condiment.  
END IF.  
EXECUTE.  

DO IF (FCSCond_SRf = 1000).  
RECODE FCSCond (0 thru 7=Copy) (SYSMIS=0) INTO Assistance_condiment.  
END IF.  
EXECUTE.  

RECODE Ownprod_condiment (SYSMIS=0). 
EXECUTE. 
RECODE HuntFish_condiment (SYSMIS=0). 
EXECUTE. 
RECODE Gather_condiment (SYSMIS=0). 
EXECUTE. 
RECODE Borrow_condiment (SYSMIS=0). 
EXECUTE. 
RECODE Cash_condiment (SYSMIS=0). 
EXECUTE. 
RECODE Credit_condiment (SYSMIS=0). 
EXECUTE. 
RECODE Beg_condiment (SYSMIS=0). 
EXECUTE. 
RECODE Exchange_condiment (SYSMIS=0). 
EXECUTE. 
RECODE Gift_condiment (SYSMIS=0). 
EXECUTE. 
RECODE Assistance_condiment (SYSMIS=0). 
EXECUTE. 

***Step 2 - Calculate unique variable for each source 
COMPUTE Ownprod = sum (Ownprod_cereal, Ownprod_pulses, Ownprod_prot, Ownprod_dairy, Ownprod_veg, Ownprod_fruit, Ownprod_fat, Ownprod_sugar, Ownprod_condiment).  
COMPUTE HuntFish= sum (HuntFish_cereal, HuntFish_pulses, HuntFish_prot, HuntFish_dairy, HuntFish_veg, HuntFish_fruit, HuntFish_fat, HuntFish_sugar, HuntFish_condiment).  
COMPUTE Gather= sum (Gather_cereal, Gather_pulses, Gather_prot, Gather_dairy, Gather_veg, Gather_fruit, Gather_fat, Gather_sugar, Gather_condiment).  
COMPUTE Borrow = sum (Borrow_cereal, Borrow_pulses, Borrow_prot, Borrow_dairy, Borrow_veg, Borrow_fruit, Borrow_fat, Borrow_sugar, Borrow_condiment).  
COMPUTE Cash = sum (Cash_cereal, Cash_pulses, Cash_prot, Cash_dairy, Cash_veg, Cash_fruit, Cash_fat, Cash_sugar, Cash_condiment).  
COMPUTE Credit = sum (Credit_cereal, Credit_pulses, Credit_prot, Credit_dairy, Credit_veg, Credit_fruit, Credit_fat, Credit_sugar, Credit_condiment).  
COMPUTE Beg = sum (Beg_cereal, Beg_pulses, Beg_prot, Beg_dairy, Beg_veg, Beg_fruit, Beg_fat, Beg_sugar, Beg_condiment).  
COMPUTE Exchange = sum (Exchange_cereal, Exchange_pulses, Exchange_prot, Exchange_dairy, Exchange_veg, Exchange_fruit, Exchange_fat, Exchange_sugar, Exchange_condiment).  
COMPUTE Gift = sum (Gift_cereal, Gift_pulses, Gift_prot, Gift_dairy, Gift_veg, Gift_fruit, Gift_fat, Gift_sugar, Gift_condiment).  
COMPUTE Assistance = sum (Assistance_cereal, Assistance_pulses, Assistance_prot, Assistance_dairy, Assistance_veg, Assistance_fruit, Assistance_fat, Assistance_sugar, Assistance_condiment).   

***Step 3 - Compute the total sources of food 

COMPUTE Total_source = Ownprod + HuntFish + Gather + Borrow + Cash + Credit + Beg + Exchange + Gift + Assistance 
EXECUTE.

***Step 4 - Calculate % of each food source 

COMPUTE Percent_Ownprod = (Ownprod/Total_source)*100.  
COMPUTE Percent_HuntFish = (HuntFish/Total_source)*100.  
COMPUTE Percent_Gather = (Gather/Total_source)*100.  
COMPUTE Percent_Borrow = (Borrow/Total_source)*100.  
COMPUTE Percent_cash = (Cash / Total_source)*100.  
COMPUTE Percent_credit = (Credit/ Total_source)*100.  
COMPUTE Percent_beg = (Beg / Total_source)*100.  
COMPUTE Percent_exchange = (Exchange / Total_source)*100.  
COMPUTE Percent_Gift = (Gift/Total_source)*100.  
COMPUTE Percent_assistance = (Assistance / Total_source)*100.  
EXECUTE.  

* Define Variable Properties. 
* Own production

VARIABLE LEVEL Percent_ownprod(SCALE).  
VARIABLE LABELS Percent_ownprod '% of main source: Own production'.  
FORMATS Percent_ownprod(F8.0).  

*Hunting or fishing 

VARIABLE LEVEL Percent_HuntFish(SCALE).  
VARIABLE LABELS Percent_HuntFish '% of main source: Hunted or fished'.  
FORMATS Percent_HuntFish(F8.0).  

*Gathering 

VARIABLE LEVEL Percent_Gather(SCALE).  
VARIABLE LABELS Percent_Gather '% of main source: Gathered’.  
FORMATS Percent_Gather(F8.0).  

*Borrowing from family or friends   

VARIABLE LEVEL Percent_Borrow(SCALE).  
VARIABLE LABELS Percent_Borrow '% of main source: borrowed from family or friends'.  
FORMATS Percent_Borrow(F8.0).  

*Cash purchases  

VARIABLE LEVEL Percent_cash(SCALE).  
VARIABLE LABELS Percent_cash '% of main source: purchased with cash'.  
FORMATS Percent_cash(F8.0). 

*Credit purchases  

VARIABLE LEVEL Percent_credit(SCALE).  
VARIABLE LABELS Percent_credit'% of main source: purchased with cash'.  
FORMATS Percent_credit(F8.0).  

*Begging  

VARIABLE LEVEL Percent_beg(SCALE).  
VARIABLE LABELS Percent_beg '% of main source: begging'.  
FORMATS Percent_beg(F8.0).  

*Exchange for food  

VARIABLE LEVEL Percent_exchange (SCALE).  
VARIABLE LABELS Percent_exchange '% of main source: barter or exchange'.  
FORMATS Percent_exchange (F8.0).  

*Gifts from family or friends   

VARIABLE LEVEL Percent_Gift(SCALE).  
VARIABLE LABELS Percent_Gift '% of main source: gifts from family or friends'.  
FORMATS Percent_Gift(F8.0).  

*Assistance 

VARIABLE LEVEL Percent_assistance (SCALE).  
VARIABLE LABELS Percent_assistance '% of main source: assistance'.  
FORMATS Percent_assistance (F8.0).  

** Run analysis 

DESCRIPTIVES VARIABLES= Percent_ownprod Percent_HuntFish Percent_Gather Percent_Borrow Percent_cash Percent_credit Percent_beg Percent_exchange Percent_Gift Percent_assistance 
  /STATISTICS=MEAN STDDEV MIN MAX. 

** Delete interim variables  

DELETE VARIABLES Ownprod_cereal Ownprod_pulses Ownprod_dairy Ownprod_prot Ownprod_veg Ownprod_fruit Ownprod_sugar Ownprod_fat Ownprod_condiment. 
DELETE VARIABLES HuntFish_cereal HuntFish_pulses HuntFish_dairy HuntFish_prot HuntFish_veg HuntFish_fruit HuntFish_sugar HuntFish_fat HuntFish_condiment. 
DELETE VARIABLES Gather_cereal Gather_pulses Gather_dairy Gather_prot Gather_veg Gather_fruit Gather_sugar Gather_fat Gather_condiment. 
DELETE VARIABLES Borrow_cereal Borrow_pulses Borrow_dairy Borrow_prot Borrow_veg Borrow_fruit Borrow_sugar Borrow_fat Borrow_condiment. 
DELETE VARIABLES Cash_cereal Cash_pulses Cash_dairy Cash_prot Cash_veg Cash_fruit Cash_sugar Cash_fat Cash_condiment. 
DELETE VARIABLES Credit_cereal Credit_pulses Credit_dairy Credit_prot Credit_veg Credit_fruit Credit_sugar Credit_fat Credit_condiment. 
DELETE VARIABLES Beg_cereal Beg_pulses Beg_dairy Beg_prot Beg_veg Beg_fruit Beg_sugar Beg_fat Beg_condiment. 
DELETE VARIABLES Exchange_cereal Exchange_pulses Exchange_dairy Exchange_prot Exchange_veg Exchange_fruit Exchange_sugar Exchange_fat Exchange_condiment. 
DELETE VARIABLES Gift_cereal Gift_pulses Gift_dairy Gift_prot Gift_veg Gift_fruit Gift_sugar Gift_fat Gift_condiment. 
DELETE VARIABLES Assistance_cereal Assistance_pulses Assistance_dairy Assistance_prot Assistance_veg Assistance_fruit Assistance_sugar Assistance_fat Assistance_condiment. 
DELETE VARIABLES Ownprod HuntFish Gather Borrow Cash Credit Beg Exchange Gift Assistance. 

 

