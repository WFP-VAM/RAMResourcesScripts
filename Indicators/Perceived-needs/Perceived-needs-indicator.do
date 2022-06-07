*Objective: Perceived Needs Analysis 
*Survey module: https://docs.wfp.org/api/documents/WFP-0000121342/download/ 

*Variable labels for all indicators
lab var HHPercNeedWater "Not enough water that is safe for drinking or cooking" 
lab var HHPercNeedFood "Not enough food, or good enough food, or because you are not able to cook food" 
lab var HHPercNeedHousing "No suitable place to live in"
lab var HHPercNeedToilet "No easy and safe access to a clean toilet" 
lab var HHPercNeedHygienem "For men: Not enough soap, water or a suitable place to wash"
lab var HHPercNeedHygienew "For women: Not enough soap, sanitary materials, water or a suitable place to wash"
lab var HHPercNeedClothTex	"Not enough or good enough, clothes, shoes, bedding or blankets"
lab var HHPercNeedLivelihood "Not enough income, money or resources to live" 
lab var HHPercNeedDisabIll "A serious problem with your physical health"
lab var HHPercNeedHealthm "For men: Not able to get adequate health care for yourself"
lab var HHPercNeedHealthw "For women: Not able to get adequate health care for yourself (Including health care during pregnancy or childbirth)"
lab var HHPercNeedSafety "Your family are not safe or protected where you live now"
lab var HHPercNeedEducation "Your children are not in school, or are not getting a good enough education"
lab var HHPercNeedCaregive "It is difficult to care for family members who live with you"
lab var HHPercNeedInfoDis "For displaced people: Do you have a serious problem because you do not have enough information" 
lab var HHPercNeedInfoND "For non-displaced people: Do you have a serious problem because you do not have enough information" 
lab var HHPercNeedAsstInfo "Inadequate aid"
lab var CMPercNeedJustice "Inadequate system for law and justice, or because people do not know enough about their legal rights"
lab var CMPercNeedGBViolence "Physical or sexual violence towards them, either in the community or in their homes" 
lab var CMPercNeedSubstAbuse "Is there a serious problem in your community because people drink a lot of alcohol, or use harmful drugs?" 
lab var CMPercNeedMentalCare "Is there a serious problem in your community because people have a mental illness?"
lab var CMPercNeedCaregiving "Is there a serious problem in your community because there is not enough care for people who are on their own?" 


*Value labels for indicators  
lab def HHPercNeed_label 0"No serious problem" 1"Serious problem" 8888"Don't know, not applicable, declines to answer"

foreach var of varlist HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet HHPercNeedHygienem HHPercNeedHygienew HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll HHPercNeedHealthm HHPercNeedHealthw HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive HHPercNeedInfoDis HHPercNeedInfoND HHPercNeedAsstInfo CMPercNeedJustice CMPercNeedGBViolence CMPercNeedSubstAbuse CMPercNeedMentalCare CMPercNeedCaregiving {
	lab val `var' HHPercNeed_label
}
 

lab def RESPSex_label 0"Female" 1"Male"
lab val RESPSex RESPSex_label







*Frequencies 			 
table (var) (result) (), statistic(fvpercent HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet HHPercNeedHygienem HHPercNeedHygienew HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll HHPercNeedHealthm HHPercNeedHealthw HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive HHPercNeedInfoDis HHPercNeedInfoND HHPercNeedAsstInfo CMPercNeedJustice CMPercNeedGBViolence CMPercNeedSubstAbuse CMPercNeedMentalCare CMPercNeedCaregiving ) statistic(fvfrequency HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet HHPercNeedHygienem HHPercNeedHygienew HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll HHPercNeedHealthm HHPercNeedHealthw HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive HHPercNeedInfoDis HHPercNeedInfoND HHPercNeedAsstInfo CMPercNeedJustice CMPercNeedGBViolence CMPercNeedSubstAbuse CMPercNeedMentalCare CMPercNeedCaregiving)


recode HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet HHPercNeedHygienem HHPercNeedHygienew HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll HHPercNeedHealthm HHPercNeedHealthw HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive HHPercNeedInfoDis HHPercNeedInfoND HHPercNeedAsstInfo CMPercNeedJustice CMPercNeedGBViolence CMPercNeedSubstAbuse CMPercNeedMentalCare CMPercNeedCaregiving (8888=0)

tabstat HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet HHPercNeedHygienem HHPercNeedHygienew HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll HHPercNeedHealthm HHPercNeedHealthw HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive HHPercNeedInfoDis HHPercNeedInfoND HHPercNeedAsstInfo CMPercNeedJustice CMPercNeedGBViolence CMPercNeedSubstAbuse CMPercNeedMentalCare CMPercNeedCaregiving, stats(mean) columns(statistics)


*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*Analyze the most serious problems
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*Add value labels for the problems - make sure that all variables are nominal 
*value labels - make sure that all variables are nominal
lab def CMPercNeedR_label 1"Drinking water" 2"Food" 3"Place to live in" 4"Toilets" 5"Keeping clean" 6"Clothes, shoes, bedding or blankets" 7"Income or livelihood" 8"Physical health" 9"Health care" 10"Safety" 11 "Education for your children" 12	"Care for family members" 13"Information" 14"The way aid is provided" 15"Law and injustice in your community" 16"Safety or protection from violence for women in your community" 17	"Alcohol or drug use in your community" 18"Mental illness in your community" 19	"Care for people in your community who are on their own" 20	"Any other serious problem that was not asked but mentioned" 999"No serious problem" 8888"Don't know, not applicable, declines to answer"

foreach var of varlist CMPercNeedRFirst  CMPercNeedRSec CMPercNeedRThird {
	lab val `var' CMPercNeedR_label
}
 

*Percentage of households who rank a certain problem among their top three priority problems 
table (var) (result) (), statistic(fvpercent CMPercNeedRFirst CMPercNeedRSec CMPercNeedRThird) statistic(fvfrequency CMPercNeedRFirst CMPercNeedRSec CMPercNeedRThird)

 
*----------------------------------------------------------------------------------------------------------------------------------------------------------------*
*Mean or median number of problems  
*---------------------------------------------------------------------------------------------------------------------------------------------------------------
egen Perceived_total=rowtotal(HHPercNeedWater HHPercNeedFood HHPercNeedHousing HHPercNeedToilet HHPercNeedHygienem HHPercNeedHygienew HHPercNeedClothTex HHPercNeedLivelihood HHPercNeedDisabIll HHPercNeedHealthm HHPercNeedHealthw HHPercNeedSafety HHPercNeedEducation HHPercNeedCaregive HHPercNeedInfoDis HHPercNeedInfoND HHPercNeedAsstInfo CMPercNeedJustice CMPercNeedGBViolence CMPercNeedSubstAbuse CMPercNeedMentalCare CMPercNeedCaregiving)    
lab var Perceived_total "Total number of problems identified" 

tabstat Perceived_total, stats(mean median) columns(statistics)
