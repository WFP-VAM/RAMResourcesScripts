# RAM Resources - Scripts
<!-- badges: start -->

[![Project Status: WIP – Development is in progress, content is usable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

<!-- badges: end -->


This folder contains all standardized scripts for indicators, analysis and visualization. The folders are organized as follows:

- **Analysis:** Plots, cross-tabulations, output tables...etc.
- **Indicators**: Plain indicator calculations
- **Logical Cleaning**: Removing and replacing values that are outside logical boundaries for the specific data points (e.g.: negative expenditures, Food Consumption > 7,…)
- **Statistical Cleaning:** cleaning and replacing missing values based on analysis of the statistical distributions (e.g.: expenditures above the 99th percentile of the distribution,… )
- [**Static:**](https://github.com/WFP-VAM/RAMResourcesScripts/tree/main/Static) Sample _data_ files in CSV that can be used for testing scripts of the four types above. Data should include sufficient information for the aggregation as a simple average, weighted average.

> [!CAUTION]
> Continuous work is made by WFP - Research Assessment and Monitoring division to ensure the adherence of these scripts to the corporate analytical methods and standards. These standards can be found in the [Resource Centre](https://resources.vam.wfp.org/) which should be used as a main reference. This code comes with a specific license warranty, make sure to read it before using the code.


_Last update_: 2023/11/22
