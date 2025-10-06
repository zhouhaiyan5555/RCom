library(phyloseq)
library(dplyr)
library(survival)
library(survminer)

load("my_phyloseq.RData")

species_list <- readLines("15_species_list.txt")

tax_table_data <- tax_table(my_phyloseq)
species_names <- tax_table_data[, "Species"]
existing_species <- species_list[species_list %in% species_names]
matching_otu_ids <- rownames(tax_table_data)[tax_table_data[, "Species"] %in% existing_species]
physeq_target <- prune_taxa(matching_otu_ids, my_phyloseq)

phy <- physeq_target

if(taxa_are_rows(phy)){
  mat <- as.data.frame(t(otu_table(phy)))
} else {
  mat <- as.data.frame(otu_table(phy))
}
colnames(mat) <- taxa_names(phy)
rownames(mat) <- sample_names(phy)

rel <- sweep(mat, 1, rowSums(mat), "/")
zero_rows <- which(rowSums(mat)==0)
length(zero_rows)
apply(rel, 2, function(x) summary(x))

pseudocount <- 1e-6
logrel <- log(rel + pseudocount) 
mat_z <- scale(logrel)
signature_zsum <- rowSums(mat_z, na.rm=TRUE)
sdat$signature_zsum <- signature_zsum
summary(sdat$signature_zsum)
hist(sdat$signature_zsum, breaks=40, main="signature (z-sum) distribution")

sdat_df$signature_zsum <- signature_zsum[rownames(sdat_df)]
sum(is.na(sdat_df$signature_zsum))

time_col   <- "OS_time"   
status_col <- "OS_evt"

sdat_df[[time_col]]   <- as.numeric(as.character(sdat_df[[time_col]]))
sdat_df[[status_col]] <- as.numeric(as.character(sdat_df[[status_col]]))

cox_formula <- as.formula(paste0("Surv(", time_col, ", ", status_col, ") ~ signature_zsum"))
cox_sig1 <- coxph(cox_formula, data = sdat_df)
summary(cox_sig1)

cox_adj <- coxph(as.formula(paste0("Surv(", time_col, ", ", status_col, ") ~ signature_zsum + ATB")), data = sdat_df)

summary(cox_adj)
cox.zph(cox_adj)