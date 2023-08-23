********************************************************************************
*						reduced Coping Strategy Index (rCSI)
*******************************************************************************/

** Load data
* ---------
import delim using "../GitHub/RAMResourcesScripts/Static/rCSI_Sample_Survey.csv", ///
       clear case(preserve)
       
** Check and recode missing values as 0
	sum rCSI*
	recode rCSI* （. = 0）

** Label rCSI relevant variables
	lab var rCSILessQlty 	"Relied on less preferred, less expensive food"
	lab var rCSIMealNb 		"Borrowed food or relied on help from friends or relatives"
	lab var rCSIMealNb 		"Reduced the number of meals eaten per day"
	lab var rCSIMealSize 	"Reduced portion size of meals at meals time"
	lab var rCSIMealAdult 	"Restricted consumption by adults in order for young children to eat"

** Calculate rCSI
	gen rCSI = (rCSILessQlty * 1) + (rCSIBorrow * 2) + (rCSIMealNb * 1) + ///
			   (rCSIMealSize * 1) + (rCSIMealAdult * 3)		   
	lab var rCSI "Reduced Consumption Strategies Index"

** End of Scripts
