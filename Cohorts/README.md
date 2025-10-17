# Survival Analysis of Microbial Signature in Two Cohorts

This repository contains R scripts and example data used to perform survival analyses of a 15-microbe signature across two independent cohorts.  
Analyses include Kaplan–Meier (KM) survival curves and stratified Cox proportional hazards models for reproducibility.

---

## Repository Structure

```text
├── data/
│ ├── my_phyloseq_cohort1.RData # Clinical & microbial data for Cohort 1
│ ├── sdat_df_merged_2_cohorts.csv # Clinical & microbial data for Cohorts
│
├── scripts/
│ ├── 01_Species_signature_calculation.R # Calculate the 15-microbe signature (z-score)
│ ├── 02_merged_cohorts_survival_analysis.R # Perform KM and stratified Cox analysis
│
├── results/
│ └── merged_cohorts_KM_plot.pdf # Example Kaplan–Meier survival curve
│
└── README.md

## Requirements

- **R version:** ≥ 4.2.0  
- **R packages:**
   ```R
  install.packages(c("phyloseq","survival", "survminer", "dplyr", "ggplot2", "readr"))


## Step 1. Compute microbial signature
Run the first script to compute the 15-microbe signature score (signature_zsum):
Rscript scripts/01_Species_signature_calculation.R

## Step 2. Merge cohorts and run stratified Cox + KM
Rscript scripts/02_merged_cohorts_survival_analysis.R


# All analyses were conducted using R version 4.2.2.