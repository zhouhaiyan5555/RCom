# Integrated Analysis of Microbial Signature and Metabolic Interactions

This repository contains all scripts, data, and example workflows used in the study of microbial signatures and community interactions, including both **survival analysis** and **metabolic network analysis**.

---

##  Overview

| Module | Description | Main Tools |
|--------|--------------|-------------|
| **1️ Survival Analysis** | Association of 15-microbe signature with patient survival across multiple cohorts. | R (`survival`, `survminer`) |
| **2️ SMETANA Interaction Analysis** | Prediction of metabolic cooperation and competition among microbial genomes. | Python + SMETANA + R visualization |

---

##  1️ Survival Analysis

Scripts for calculating the microbial signature, performing Cox proportional hazards models (stratified across cohorts), and visualizing Kaplan–Meier survival curves.

See detailed instructions in:  
👉 `README_survival_analysis.md`

---

##  2️ SMETANA Interaction Analysis

Scripts for running SMETANA-based metabolic interaction modeling, integrating competition and cooperation scores (MRO and SMETANA score), and visualizing network interactions.

See detailed instructions in:  
👉 `README_smetana_analysis.md`

---


##  Repository Structure

```bash
├── survival_analysis/
│   ├── data/
│   ├── scripts/
│   ├── results/
│   └── README_survival_analysis.md
│
├── smetana_analysis/
│   ├── data/
│   ├── scripts/
│   ├── results/
│   └── README_smetana_analysis.md
│
└── README_overall.md  # This overview file
```



