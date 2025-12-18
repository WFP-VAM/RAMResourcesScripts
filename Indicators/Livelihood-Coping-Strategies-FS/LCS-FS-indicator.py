import pandas as pd
import numpy as np

# Reading in file
filepath = "~/GitHub/RAMResourcesScripts/Static/LCS_Sample_Survey/LHCS_FS_Sample_Survey.csv"
df = pd.read_csv(filepath)

# The rest of this assumes that the labels are as in the sample provided in the link below:
# https://docs.wfp.org/api/documents/WFP-0000147801/download/
# Users should adjust accordingly based on the adapted LCS module used for their implementation

relevant_cols = ["Lcs_stress_DomAsset",
                 "Lcs_stress_Saving",
                 "Lcs_stress_EatOut",
                 "Lcs_stress_CrdtFood",
                 "Lcs_crisis_ProdAssets",
                 "Lcs_crisis_Health",
                 "Lcs_crisis_OutSchool",
                 "Lcs_em_ResAsset",
                 "Lcs_em_Begged",
                 "Lcs_em_IllegalAct"]

# Defining which cols correspond to which level of coping strategies
stress_cols = ["Lcs_stress_DomAsset",
                 "Lcs_stress_Saving",
                 "Lcs_stress_EatOut",
                 "Lcs_stress_CrdtFood"]
crisis_cols = ["Lcs_crisis_ProdAssets",
                 "Lcs_crisis_Health",
                 "Lcs_crisis_OutSchool"]
emergency_cols = ["Lcs_em_ResAsset",
                 "Lcs_em_Begged",
                 "Lcs_em_IllegalAct"]


# --- Response code handling ---
# Codes: 10 = No (did not need), 20 = No (already did within last 12 months), 30 = Yes, 9999 = Not applicable
# Assumptions: BOTH 20 and 30 count as "engaged". 9999 should NOT count.

# --- Defining the conditions under which a certain maximum coping strategy is met ---
cond_stress = df[relevant_cols][stress_cols].isin([20, 30]).any(axis=1)
cond_crisis = df[relevant_cols][crisis_cols].isin([20, 30]).any(axis = 1)
cond_em = df[relevant_cols][emergency_cols].isin([20, 30]).any(axis = 1)

# --- Assigning maximum coping behaviours ---
df["Max_coping_behaviourFS"] = np.select(
    [cond_em, cond_crisis, cond_stress],
    [4, 3, 2],
    default = 1
)

# --- Map labels ---
label_map = {
    1: "HH not adopting coping strategies",
    2: "Stress coping strategies",
    3: "Crisis coping strategies",
    4: "Emergencies coping strategies",
}


# --- Set a label column for presentation ---
label_map = {
    1: "HH not adopting coping strategies",
    2: "Stress coping strategies",
    3: "Crisis coping strategies",
    4: "Emergencies coping strategies",
}
df["Max_coping_behaviourFS_lab"] = df["Max_coping_behaviourFS"].map(label_map)

# --- Unweighted percentage distribution (drop rows where summary is NA if any) ---
table = (
    df.dropna(subset=["Max_coping_behaviourFS_lab"])
      .value_counts("Max_coping_behaviourFS_lab")
      .rename("n")
      .reset_index()
)

total_n = table["n"].sum()
table["Percentage"] = (100 * table["n"] / total_n) if total_n > 0 else 0

# --- Pivot to wide format and ensure consistent column order ---
out = (
    table[["Max_coping_behaviourFS_lab", "Percentage"]]
         .pivot_table(index=None,
                      columns="Max_coping_behaviourFS_lab",
                      values="Percentage",
                      fill_value=0)
)

ordered_cols = [label_map[i] for i in sorted(label_map)]
for col in ordered_cols:
    if col not in out.columns:
        out[col] = 0.0
out = out[ordered_cols].round(2)

print("\nMax_coping_behaviourFS_table_wide (%):\n")
print(out)

# --- OPTIONAL: Weighted version ---
# weight_col = "nameofweightvariable"  # <-- Replace with an actual weight column if available
# if weight_col in df.columns:
#     wtbl = (
#         df.dropna(sub#         df.dropna(subset=["Max_coping_behaviourFS_lab"])
#           .groupby("Max_coping_behaviourFS_lab", as_index=False)[weight_col]
#           .sum()
#           .rename(columns={weight_col: "n"})
#     )
#     total_w = wtbl["n"].sum()
#     wtbl["Percentage"] = (100 * wtbl["n"] / total_w) if total_w > 0 else 0
#     wout = (
#         wtbl[["Max_coping_behaviourFS_lab", "Percentage"]]
#             .pivot_table(index=None, columns="Max_coping_behaviourFS_lab",
#                          values="Percentage", fill_value=0)
#     )
#     for col in ordered_cols:
#         if col not in wout.columns:
#             wout[col] = 0.0
#     wout = wout[ordered_cols].round(2)
#     print("\nWeighted Max_coping_behaviourFS_table_wide (%):\n")