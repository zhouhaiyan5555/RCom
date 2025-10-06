library(survival)
library(dplyr)

sdat_df_merged_2_cohorts <- read.csv("sdat_df_merged_2_cohorts.csv")

sdat_df_merged <- sdat_df_merged_2_cohorts %>%  mutate(signature_group = ifelse(signature_zsum >= median(signature_zsum, na.rm = TRUE), "High", "Low"))

sdat_df_merged$signature_group <- factor(sdat_df_merged$signature_group, levels = c("Low", "High"))

table(sdat_df_cohort1$Gender)

cox_fit_merged <- coxph(Surv(OS, Death) ~ signature_group + ATB + strata(Cohort),  data = sdat_df_merged)

summary(cox_fit_merged)

fit_km_merged <- survfit(Surv(OS, Death) ~ signature_group, data = sdat_df_merged)

km_plot_merged <- ggsurvplot(
     fit_km_merged,
    data = sdat_df_merged,
     risk.table = TRUE,       
     pval = TRUE,             
     conf.int = FALSE,        
     palette = c("#1F77B4", "#D62728"), 
     legend.title = "Signature",
     legend.labs = c("Low", "High"),
     xlab = "Time (months)",  
     ylab = "Overall Survival probability",
     surv.median.line = "hv", 
     risk.table.height = 0.25,
     risk.table.y.text.col = TRUE,
     risk.table.y.text = FALSE
 )

km_plot_merged

median_os <- surv_median(fit_km_merged)

