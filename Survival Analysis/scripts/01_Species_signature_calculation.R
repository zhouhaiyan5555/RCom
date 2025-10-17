library(phyloseq)
library(dplyr)
library(survival)
library(survminer)

load("my_phyloseq_cohort1.RData")

species_list <- readLines("15_species_list.txt")

tax_table_data <- tax_table(my_phyloseq)
species_names <- tax_table_data[, "Species"]
existing_species <- species_list[species_list %in% species_names]
matching_otu_ids <- rownames(tax_table_data)[tax_table_data[, "Species"] %in% existing_species]
physeq_target <- prune_taxa(matching_otu_ids, my_phyloseq)

phy <- physeq_target

phy

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

zero_samples <- rownames(mat)[zero_rows]
zero_samples
physeq_target <- prune_samples(!(sample_names(physeq_target) %in% zero_samples), physeq_target)
physeq_target

phy <- physeq_target
if(taxa_are_rows(phy)){
  mat <- as.data.frame(t(otu_table(phy)))
} else {
  mat <- as.data.frame(otu_table(phy))
}
colnames(mat) <- taxa_names(phy)
rownames(mat) <- sample_names(phy)
sdat <- as.data.frame(sample_data(phy))

rel <- sweep(mat, 1, rowSums(mat), "/")
zero_rows <- which(rowSums(mat)==0)
length(zero_rows)
apply(rel, 2, function(x) summary(x))


pseudocount <- 1e-6
logrel <- log(rel + pseudocount) 
mat_z <- scale(logrel)
signature_zsum <- rowSums(mat_z, na.rm=TRUE)

sdat_df <- as(sample_data(phy), "data.frame")
class(sdat_df)
rownames(sdat_df) <- sample_names(phy) 
all(rownames(sdat_df) == rownames(mat))
if(is.null(names(signature_zsum))){
  names(signature_zsum) <- rownames(mat)   # 假设 mat 的行名就是样本名
}
sdat_df$signature_zsum <- signature_zsum[rownames(sdat_df)]

head(sdat_df)  
sum(is.na(sdat_df$signature_zsum))

hist(sdat_df$signature_zsum, breaks=40, main="signature (z-sum) distribution")

time_col   <- "OS"   
status_col <- "Death"

sdat_df[[time_col]]   <- as.numeric(as.character(sdat_df[[time_col]]))
sdat_df[[status_col]] <- as.numeric(as.character(sdat_df[[status_col]]))

cox_formula <- as.formula(paste0("Surv(", time_col, ", ", status_col, ") ~ signature_zsum"))
cox_sig1 <- coxph(cox_formula, data = sdat_df)
summary(cox_sig1)

cox_adj <- coxph(as.formula(paste0("Surv(", time_col, ", ", status_col, ") ~ signature_zsum + ATB")), data = sdat_df)

summary(cox_adj)
