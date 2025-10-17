# Microbial Interaction Analysis using SMETANA

This repository contains scripts and demo data for metabolic interaction analysis using **SMETANA**.  
The analysis quantifies potential **metabolic competition** and **cooperation** among microbial genomes using two complementary indices:
- **Metabolic Resource Overlap (MRO)** — measures potential *competition* for metabolites;
- **SMETANA score** — measures potential *metabolic cooperation*.

---

##  Repository Structure

```bash
├── data/
│   ├── demo_genomes/                     # Example genome files used for the demo
│   ├── inorganic_compounds.tsv           # List of inorganic compounds to exclude
│
├── scripts/
│   ├── 01_smetana_global_compute_batch.py           # Batch computation of MRO (competition score)
│   ├── 02_smetana_detail_compute_batch.py           # Batch computation of SMETANA score (cooperation score)
│   ├── 03_mro_score_sum.py            # Integrate and summarize MRO scores
│   ├── 04_smetana_score_sum.py        # Integrate and summarize SMETANA score
│   ├── 05_visualize_network.R            # R script to visualize microbial interaction networks
│
├── results/
│   ├── demo_MRO_results.txt
│   ├── demo_SMETANA_results.txt
│   └── demo_interaction_network.pdf
│
└── README.md
```

---

##  Installation

The **SMETANA** software is freely available and can be installed via Conda:

```bash
conda create -n smetana python=3.7
pip install smetana
```

Other dependencies:
```bash
pip install cplex
```

Alternatively, refer to the [official SMETANA documentation](https://github.com/cdanielmachado/smetana) for installation instructions.

- **Installation time:** approximately *15 minutes* on a standard workstation (256 cores, 755 GB RAM)


R packages required for visualization:
```R
install.packages(c("igraph", "ggraph", "ggplot2"))
```

---

## Usage

### Step 1. Run SMETANA batch analysis (demo data)

Example command for computing **MRO**:
```bash
python scripts/01_smetana_global_compute_batch.py 
```

Example command for computing **SMETANA score**:
```bash
python scripts/02_smetana_detail_compute_batch.py 
```

### Step 2. Integrate the results

```bash
python scripts/03_mro_score_sum.py 
python scripts/04_smetana_score_sum.py
```

### Step 3. Visualize microbial interaction network

```bash
Rscript scripts/05_visualize_network.R
```

---

##  Notes

- The **demo dataset** demonstrates the analysis of metabolic interactions among **12 randomly selected genomes**.  
  In the full study, the same workflow was applied to analyze **all combinations of 12–20 genomes** within each microbial community.
- The current demo serves as a **representative example** for reproducibility purposes.

---

## Runtime & Environment

| Step | Description | Approx. Runtime (on 256-core, 755 GB RAM) |
|------|--------------|------------------------------------------|
| Batch MRO computation | 12-genome demo | ~30 min |
| Batch SMETANA score computation | 12-genome demo | ~60 min |



