setwd("/Users/pranavkulkarni/SDM/Climate_Models_Arenaviruses/Data/Input/Processed/Projected")
guan_ssp2 <- read.csv("./guan/delta_SSP2/delta_foi_data/guan_ssp2_partial_dependence_top_features.csv")
guan_ssp5 <- read.csv("./guan/delta_SSP5/delta_foi_data/guan_ssp5_partial_dependence_top_features.csv")

guan_ssp2$scenario <- rep("SSP 2-4.5", nrow(guan_ssp2))
guan_ssp5$scenario <- rep("SSP 5-8.5", nrow(guan_ssp2))

guan_pdp <- data.table::rbindlist(list(guan_ssp2, guan_ssp5), idcol = F)
guan_pdp <- guan_pdp %>% mutate(lowCI = pdp_mean - 2*pdp_se,
                                upCI = pdp_mean + 2*pdp_se)
ggplot(guan_pdp, aes(x = grid_value, y = pdp_mean, 
                     color = feature)) +
  geom_line(aes(linetype = scenario), stat = "identity",
            position = position_identity(),
            linewidth = 1.5) +
  geom_hline(yintercept = 0, color = "black") +
  geom_vline(xintercept = 0, color = "black") +
  scale_fill_manual(values = c("darkblue", "orchid", "plum4",
                               "sienna3", "olivedrab")) +
  scale_color_manual(values = c("darkblue", "orchid", "plum4",
             "sienna3", "olivedrab")) +
  scale_y_continuous(breaks = round(seq(-0.7,0.7, 0.1), digits = 2),
                     labels = round(seq(-0.7,0.7, 0.1), digits = 2)) +
  scale_x_continuous(breaks = round(seq(-8.5,7, 0.5), digits = 2),
                     labels = round(seq(-8.5,7, 0.5), digits = 2)) +
  labs(x = "Change in Feature value",
       y = "Predicted Marginal Change in FOI",
       color = "Top 3 most important features",
       fill = "Top 3 most important features",
       linetype = "Climate Change Scenario") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 12, angle = 90,
                                   margin = margin(t = 20,
                                                   r = 0,
                                                   b = 20,
                                                   l = 0)),
        axis.text.y = element_text(size = 10, 
                                   margin = margin(t = 20,
                                                   r = 0,
                                                   b = 10,
                                                   l = 0)),
        axis.title = element_text(size = 14),
        axis.ticks = element_line(color = "black"),
        legend.text = element_text(size = 12),
        legend.position = "right",
        panel.border = element_rect(color = "black", fill = NA))

ggsave("/Users/pranavkulkarni/SDM/Climate_Models_Arenaviruses//Docs/Tables and Figures/for manuscript/figure arrangements/delta_models/pdp_guan.png",
       width = 12, height = 8, dpi = 300)  
         
       