* Encoding: UTF-8.

*import sample SPSS data - put in a link to sample data

GET
  FILE='./RAMResourceScripts/Indicators/Static/Gender-CRF-C31.sav'.
DATASET NAME DataSet2 WINDOW=FRONT.

*create new variable to be used as filter for households that recieved cash/voucher where HHHStatus == "Married monogamous" | HHHStatus == "Polygamous married" | HHHStatus_single == "No"

do if ((HHHStatus = 200) | (HHHStatus = 300) | 
(HHHStatus_single = 0)) & HHAsstWFPReceivedCashYN_1yr = 1. 
compute HHAsstCashNotSingle = 1.
end if. 

COMPUTE filter_HHAsstCashNotSingle=(HHAsstCashNotSingle  = 1).
FILTER BY filter_HHAsstCashNotSingle.
EXECUTE.

freq HHAsstCashDescWho.

*create new variable to be used as filter for households that recieved inkind where HHHStatus == "Married monogamous" | HHHStatus == "Polygamous married" | HHHStatus_single == "No"

do if ((HHHStatus = 200) | (HHHStatus = 300) | 
(HHHStatus_single = 0)) & HHAsstWFPReceivedInKindYN_1yr = 1. 
compute HHAsstFoodNotSingle = 1.
end if. 

USE ALL.  

COMPUTE filter_HHAsstFoodNotSingle=(HHAsstFoodNotSingle  = 1).
FILTER BY filter_HHAsstFoodNotSingle.
EXECUTE.

freq HHAsstInKindDescWho.

