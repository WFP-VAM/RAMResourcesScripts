*** --------------------------------------------------------------------------
***	                           WFP Standardized Scripts
***                     Calculating Food Consumption Score (FCS)
*** --------------------------------------------------------------------------

* Encoding: UTF-8.

*** Define labels

Variable labels
rCSILessQlty        'Rely on less preferred and less expensive food in the past 7 days'
rCSIBorrow          'Borrow food or rely on help from a relative or friend in the past 7 days'
rCSIMealNb          'Reduce number of meals eaten in a day in the past 7 days'
rCSIMealSize        'Limit portion size of meals at meal times in the past 7 days'
rCSIMealAdult       'Restrict consumption by adults in order for small children to eat in the past 7 days'.

*** Calculate rCSI

Compute rCSI = sum(rCSILessQlty*1,rCSIBorrow*2,rCSIMealNb*1,rCSIMealSize*1,rCSIMealAdult*3).
Variable labels rCSI 'Reduced coping strategies index (rCSI)'.
EXECUTE.

*** End of scripts