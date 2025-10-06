library(ggplot2)
library(dplyr)
library(forcats)
library(readr)

df <- read_csv("merged_3_cohort_masslin2_results.csv")

df <- df %>%
  mutate(
    ci_low  = coef - 1.96 * stderr,
    ci_high = coef + 1.96 * stderr,
    p_label = ifelse(pval < 0.1, sprintf("%.2g", pval), "NS"),
    species_name = fct_reorder(species_name, coef, .fun = mean)
  )


x_min <- min(df$ci_low, na.rm = TRUE)
x_max <- max(df$ci_high, na.rm = TRUE)
x_pad <- 0.1 * (x_max - x_min)
x_limits <- c(x_min - x_pad, x_max + x_pad)


p <- ggplot(df, aes(x = coef, y = species_name)) +

  geom_vline(xintercept = 0, linetype = "dashed", color = "gray50") +
  geom_errorbarh(aes(xmin = ci_low, xmax = ci_high), height = 0.2, color = "gray40") +
  geom_point(size = 3, color = "#2C7BB6") +
  facet_grid(. ~ Cohort, scales = "fixed") +
  scale_x_continuous(limits = x_limits) +
  geom_text(
    data = df %>%
      group_by(Cohort) %>%
      mutate(panel_max = max(ci_high, na.rm = TRUE)), 
    aes(x = panel_max + 0.05 * (x_max - x_min), label = p_label),
    hjust = 0, size = 3, color = "black"
  ) +
  coord_cartesian(clip = "off") +
  theme_bw(base_size = 12) +
  theme(
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title.y = element_blank(),
    strip.background = element_rect(fill = "gray90"),
    strip.text = element_text(face = "bold"),
    plot.margin = margin(5.5, 50, 5.5, 5.5)  
  ) +
  xlab("Effect size")
