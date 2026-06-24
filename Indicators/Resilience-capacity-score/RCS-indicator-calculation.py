#------------------------------------------------------------------------------
#                          WFP Standardized Scripts
#                  Resilience Capacity Score (RCS) Calculation
#------------------------------------------------------------------------------

# The RCS is calculated from 9 sub-statements using a five-point Likert scale 
# (ranging from 'strongly disagree' to 'strongly agree') to capture the household 
# perception of existing resilience capacities or livelihood capital. 
# The Resilience Capacity Score aggregates the unweighted answers to the nine 
# statements and is normalized to provide a score ranging from 0 to 100. 
# This result is used to classify households in three groups (low, medium, or high). 
# The percentages at each level are used later in following the changes over time 
# in these percentages for a specific target group of households. 
# Progress achieved or change over time in any of the 9 items is also calculated 
# to understand which capacities or capitals contribute the most to the final score 
# and which need to be reinforced to enhance future climate resilience.

import pandas as pd
import numpy as np

# Load the data
data = pd.read_csv("path/to/RCS_Sample_Survey.csv")

# Label variables and values
labels = {
    'HHRCSBounce': "Your household can bounce back from any challenge that life throws at it.",
    'HHRCSRevenue': "During times of hardship your household can change its primary income or source of livelihood if needed.",
    'HHRCSIncrease': "If threats to your household became more frequent and intense, you would still find a way to get by.",
    'HHRCSFinAccess': "During times of hardship your household can access the financial support you need.",
    'HHRCSSupportCommunity': "Your household can rely on the support of family or friends when you need help.",
    'HHRCSLessonsLearnt': "Your household has learned important lessons from past hardships that will help you to better prepare for future challenges.",
    'HHRCSSupportPublic': "Your household can rely on the support from public administration/government or other institutions when you need help.",
    'HHRCSFutureChallenge': "Your household is fully prepared for any future challenges or threats that life throws at it.",
    'HHRCSWarningAccess': "Your household receives useful information warning you about future risks in advance."
}

likert_labels = {
    1: "Strongly Agree",
    2: "Partially agree",
    3: "Neutral",
    4: "Somewhat disagree",
    5: "Totally disagree"
}

for col in labels.keys():
    data[col] = data[col].astype(pd.CategoricalDtype(categories=likert_labels.keys(), ordered=True))
    data[col].cat.rename_categories(likert_labels, inplace=True)

# Calculate the Resilience Capacity Score (RCS)
data['RCS'] = ((data[list(labels.keys())].apply(lambda x: x.cat.codes + 1).sum(axis=1) / 9 - 1) * (100 / 4)).astype(float)
data['RCS'].attrs['label'] = "Resilience Capacity Score"

# Classify households into RCS categories
data['RCSCat33'] = pd.cut(data['RCS'], bins=[-np.inf, 33, 66, np.inf], labels=[1, 2, 3])

data['RCSCat33'] = data['RCSCat33'].astype(int)
data['RCSCat33'] = data['RCSCat33'].replace({1: 'low RCS', 2: 'medium RCS', 3: 'high RCS'})
data['RCSCat33'].attrs['label'] = "RCS Categories, thresholds 33-66"

# Calculate RCS components
data['RCSAnticipatory'] = ((data['HHRCSFutureChallenge'].cat.codes + 1 - 1) * (100 / 4)).astype(float)
data['RCSAbsorptive']   = ((data['HHRCSBounce'].cat.codes + 1 - 1) * (100 / 4)).astype(float)
data['RCSTransformative'] = ((data['HHRCSRevenue'].cat.codes + 1 - 1) * (100 / 4)).astype(float)
data['RCSAdaptive']     = ((data['HHRCSIncrease'].cat.codes + 1 - 1) * (100 / 4)).astype(float)

data['RCSAnticipatoryCat33'] = pd.cut(data['RCSAnticipatory'], bins=[-np.inf, 33, 66, np.inf], labels=[1, 2, 3])
data['RCSAbsorptiveCat33']   = pd.cut(data['RCSAbsorptive'], bins=[-np.inf, 33, 66, np.inf], labels=[1, 2, 3])
data['RCSTransformativeCat33'] = pd.cut(data['RCSTransformative'], bins=[-np.inf, 33, 66, np.inf], labels=[1, 2, 3])
data['RCSAdaptiveCat33']     = pd.cut(data['RCSAdaptive'], bins=[-np.inf, 33, 66, np.inf], labels=[1, 2, 3])

# Create a table of results for COMET reporting
RCS_summary = data['RCSCat33'].value_counts(normalize=True).reset_index()
RCS_summary.columns = ['RCSCat33', 'Percentage']
RCS_summary['Percentage'] = RCS_summary['Percentage'] * 100

# Save to CSV
RCS_summary.to_csv("RCS_COMET.csv", index=False)

# End of Scripts