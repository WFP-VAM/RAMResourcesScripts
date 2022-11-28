*STATA Syntax for the reduced Coping Strategy Index (rCSI)
					 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*FOOD DIMENSION
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*rCSI (Reduced Consumption Strategies Index)
*Define Lables  
lab var rCSILessQlty "Rely on less preferred and less expensive food in the past 7 days"
lab var rCSIMealNb "Borrow food or rely on help from a relative or friend in the past 7 days"
lab var rCSIMealNb "Reduce number of meals eaten in a day in the past 7 days"
lab var rCSIMealSize "Limit portion size of meals at meal times in the past 7 days"
lab var rCSIMealAdult "Restrict consumption by adults in order for small children to eat in the past 7 days"

*Compute rCSI
gen rCSI=(rCSILessQlty*1) + (rCSIBorrow*2) + (rCSIMealNb*1) + (rCSIMealSize*1) + (rCSIMealAdult*3)
lab var rCSI "Reduced Consumption Strategies Index"
