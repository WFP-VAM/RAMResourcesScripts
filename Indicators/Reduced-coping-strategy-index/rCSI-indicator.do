*STATA Syntax for the reduced Coping Strategy Index (rCSI)
					 

*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*FOOD DIMENSION
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*rCSI (Reduced Consumption Strategies Index)
*Define Lables  
lab var rCSILessQlty "Relied on less preferred, less expensive food"
lab var rCSIMealNb "Borrowed food or relied on help from friends or relatives"
lab var rCSIMealNb "Reduced the number of meals eaten per day"
lab var rCSIMealSize "Reduced portion size of meals at meals time"
lab var rCSIMealAdult "Restrict consumption by adults in order for young-children to eat"

*Compute rCSI
gen rCSI=(rCSILessQlty*1) + (rCSIBorrow*2) + (rCSIMealNb*1) + (rCSIMealSize*1) + (rCSIMealAdult*3)
lab var rCSI "Reduced Consumption Strategies Index"
