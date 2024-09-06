#------------------------------------------------------------------------------#
#                          WFP Standardized Scripts
#  Calculating Percentage of School Absence Due to Ill Health
#------------------------------------------------------------------------------#

# Load Packages --------------------------------------------------------------#
import pandas as pd

# Load Sample Data ------------------------------------------------------------#
# Load the dataset (adjust the file path and name as needed)
# df = pd.read_csv("SBPProcessM_module_SchoolAgeChildRoster_submodule_RepeatSchoolAgeChild.csv")

# Rename variables to match the R script --------------------------------------#
df.rename(columns={
    'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildRegisterSchool': 'PChildRegisterSchool',
    'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAttendSchool': 'PChildDayAttendSchool',
    'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsSchool': 'PChildDayAbsSchool',
    'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsSchoolWhy/1': 'PChildDayAbsSchoolWhy_IllHealth',
    'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildDayAbsIllHealth': 'PChildDayAbsIllHealth',
    'SBPProcessM_module/SchoolAgeChildRoster_submodule/RepeatSchoolAgeChild/PChildAbsIllHealth': 'PChildAbsIllHealth'
}, inplace=True)

# Convert variables to appropriate types ---------------------------------------#
# Ensure PChildDayAbsSchoolWhy_IllHealth is binary (True/False)
df['PChildDayAbsSchoolWhy_IllHealth'] = df['PChildDayAbsSchoolWhy_IllHealth'] == 1

# Filter dataset for children registered to attend school -----------------------#
df_registered = df[df['PChildRegisterSchool'] == 1]

# Calculate the percentage of absences due to ill health ------------------------#
# Without weights
total_registered = len(df_registered)
absent_due_to_ill_health = df_registered['PChildDayAbsSchoolWhy_IllHealth'].sum()
percentage_absent_due_to_ill_health = (absent_due_to_ill_health / total_registered) * 100

print(f"Percentage of children absent due to ill health (without weights): {percentage_absent_due_to_ill_health:.2f}%")

# If you have a weight variable, include it in the calculation ------------------#
# Uncomment and adjust the following if a weight variable is available
# df_registered['WeightVariable'] = df_registered['WeightVariable'].fillna(0)  # Replace with actual weight column
# total_registered_weighted = df_registered['WeightVariable'].sum()
# absent_due_to_ill_health_weighted = df_registered.loc[df_registered['PChildDayAbsSchoolWhy_IllHealth'], 'WeightVariable'].sum()
# percentage_absent_due_to_ill_health_wt = (absent_due_to_ill_health_weighted / total_registered_weighted) * 100

# print(f"Percentage of children absent due to ill health (with weights): {percentage_absent_due_to_ill_health_wt:.2f}%")

# End of Scripts ----------------------------------------------------------------#