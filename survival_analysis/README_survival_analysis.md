# Survival Analysis of Microbial Signature in Two Cohorts

This repository provides R scripts and example data used for survival analyses of a 15-microbe signature across two independent cohorts.  
The analyses include Kaplan–Meier (KM) survival estimation and stratified Cox proportional hazards regression.

---

## Repository Structure

```text
├── data/
│   ├── my_phyloseq_cohort1.RData            # Clinical & microbial data for Cohort 1
│   ├── sdat_df_merged_2_cohorts.csv         # Combined data for the merged cohorts
│
├── scripts/
│   ├── 01_Species_signature_calculation.R   # Calculate the 15-microbe signature (z-score)
│   ├── 02_merged_cohorts_survival_analysis.R # Perform KM and stratified Cox analysis
│
├── results/
│   └── merged_cohorts_KM_plot.pdf           # Example Kaplan–Meier survival curve
│
└── README_survival_analysis.md
```

---

## Requirements

- **R version:** ≥ 4.2.0  
- **R packages:**

```R
install.packages(c(
  "phyloseq",
  "survival",
  "survminer",
  "dplyr",
  "ggplot2",
  "readr"
))
```

---

## Step 1. Compute Microbial Signature

This script computes the 15-microbe signature (z-score, `signature_zsum`) for each sample.

```bash
Rscript scripts/01_Species_signature_calculation.R
```

---

## Step 2. Merge Cohorts and Perform Survival Analysis

Run the second script to merge the two cohorts and perform:

- Kaplan–Meier survival curve analysis  
- Stratified Cox proportional hazards regression (`strata(Cohort)`)

```bash
Rscript scripts/02_merged_cohorts_survival_analysis.R
```

Output:
- KM plots (e.g., `merged_cohorts_KM_plot.pdf`)

---

## Analysis Notes

- **Kaplan–Meier survival curves** were used to estimate overall survival (OS) between high vs. low signature groups.  
- **P-values** were calculated using the two-tailed **log-rank test**.  
- **Hazard ratios (HRs)** and 95% confidence intervals were obtained from **Cox proportional hazards regression models**.  
- For merged analyses, a **stratified Cox model** (`strata(Cohort)`) was applied to account for cohort-specific effects.  
- All analyses were conducted in R version 4.2.2.

---
