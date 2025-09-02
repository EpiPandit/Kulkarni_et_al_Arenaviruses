setwd("/Users/pranavkulkarni/SDM/Climate_Models_Arenaviruses/Data/Input/Processed/Projected")
ssp2_guan_perm <- read.csv("./guan/delta_SSP2/delta_foi_data/perm_imp.csv")
ssp2_machu_perm <- read.csv("./machu/delta_SSP2/delta_foi_data/perm_imp.csv")
ssp2_junin_perm <- read.csv("./junin/delta_SSP2/delta_foi_data/perm_imp.csv")

ssp5_guan_perm <- read.csv("./guan/delta_SSP5/delta_foi_data/perm_imp.csv")
ssp5_machu_perm <- read.csv("./machu/delta_SSP5/delta_foi_data/perm_imp.csv")
ssp5_junin_perm <- read.csv("./junin/delta_SSP5/delta_foi_data/perm_imp.csv")
library(tidyverse)


ssp2_guan_perm <- ssp2_guan_perm %>% select(-X) %>% mutate(scenario = rep("SSP 2-4.5", nrow(.)),
                                        virus = rep("GTOV", nrow(.)))
ssp2_machu_perm <- ssp2_machu_perm %>% select(-X) %>% mutate(scenario = rep("SSP 2-4.5", nrow(.)),
                                            virus = rep("MACV", nrow(.)))
ssp2_junin_perm <- ssp2_junin_perm %>% select(-X) %>% mutate(scenario = rep("SSP 2-4.5", nrow(.)),
                                            virus = rep("JUNV", nrow(.)))
ssp5_guan_perm <- ssp5_guan_perm %>% select(-X) %>% mutate(scenario = rep("SSP 5-8.5", nrow(.)),
                                            virus = rep("GTOV", nrow(.)))
ssp5_machu_perm <- ssp5_machu_perm %>% select(-X) %>% mutate(scenario = rep("SSP 5-8.5", nrow(.)),
                                            virus = rep("MACV", nrow(.)))
ssp5_junin_perm <- ssp5_junin_perm %>% select(-X) %>% mutate(scenario = rep("SSP 5-8.5", nrow(.)),
                                            virus = rep("JUNV", nrow(.)))

perm_imp <- data.table::rbindlist(list(ssp2_guan_perm, ssp2_machu_perm, ssp2_junin_perm,
                                       ssp5_guan_perm, ssp5_machu_perm, ssp5_junin_perm),
                                  use.names = T, idcol = F)

rm(list = setdiff(ls(), "perm_imp"))

setwd("/Users/pranavkulkarni/SDM/Climate_Models_Arenaviruses/")
fi_guan_ssp2 <- read.csv("./Data/Input/Processed/Projected/guan/delta_SSP2/delta_foi_data/guan_ssp2_feature_importances.csv")
fi_guan_ssp5 <- read.csv("./Data/Input/Processed/Projected/guan/delta_SSP5/delta_foi_data/guan_ssp5_feature_importances.csv")
fi_machu_ssp2 <- read.csv("./Data/Input/Processed/Projected/machu/delta_SSP2/delta_foi_data/machu_ssp2_feature_importances.csv")
fi_machu_ssp5 <- read.csv("./Data/Input/Processed/Projected/machu/delta_SSP5/delta_foi_data/machu_ssp5_feature_importances.csv")
fi_junin_ssp2 <- read.csv("./Data/Input/Processed/Projected/junin/delta_SSP2/delta_foi_data/junin_ssp2_feature_importances.csv")
fi_junin_ssp5 <- read.csv("./Data/Input/Processed/Projected/junin/delta_SSP5/delta_foi_data/junin_ssp5_feature_importances.csv")

fi_guan_ssp2 <- fi_guan_ssp2  %>% mutate(scenario = rep("SSP 2-4.5", nrow(.)),
                                                           virus = rep("GTOV", nrow(.)))
fi_machu_ssp2 <- fi_machu_ssp2  %>% mutate(scenario = rep("SSP 2-4.5", nrow(.)),
                                                             virus = rep("MACV", nrow(.)))
fi_junin_ssp2 <- fi_junin_ssp2  %>% mutate(scenario = rep("SSP 2-4.5", nrow(.)),
                                                             virus = rep("JUNV", nrow(.)))
fi_guan_ssp5 <- fi_guan_ssp5  %>% mutate(scenario = rep("SSP 5-8.5", nrow(.)),
                                                           virus = rep("GTOV", nrow(.)))
fi_machu_ssp5 <- fi_machu_ssp5  %>% mutate(scenario = rep("SSP 5-8.5", nrow(.)),
                                                             virus = rep("MACV", nrow(.)))
fi_junin_ssp5 <- fi_junin_ssp5  %>% mutate(scenario = rep("SSP 5-8.5", nrow(.)),
                                                             virus = rep("JUNV", nrow(.)))

fi_imp <- data.table::rbindlist(list(fi_guan_ssp2, fi_machu_ssp2, fi_junin_ssp2,
                                       fi_guan_ssp5, fi_machu_ssp5, fi_junin_ssp5),
                                  use.names = T, idcol = F)
rm(fi_guan_ssp2,fi_guan_ssp5, fi_junin_ssp2, fi_junin_ssp5, fi_machu_ssp2, fi_machu_ssp5)

fi_imp <- fi_imp %>% select(Feature = feature,
                  F_imp = importance, 
                  scenario,
                  virus)

perm_imp <- perm_imp %>% select(Feature,
                            P_imp = Importance.Mean,
                            P_imp_sd = Importance.Std,
                            scenario,
                            virus)
importances <- fi_imp %>% left_join(., perm_imp, by = c("Feature", "scenario", "virus"))


importances$Feature <- as.factor(importances$Feature)
importances$virus <- as.factor(importances$virus)
importances$scenario <- factor(importances$scenario, levels = c("SSP 2-4.5", "SSP 5-8.5"), ordered = T)
range01 <- function(x){(x-min(x))/(max(x)-min(x))}

importances$F_imp <- range01(importances$F_imp)
importances$P_imp_lowCI <- importances$P_imp - 1.96*importances$P_imp_sd
importances$P_imp_upCI <- importances$P_imp + 1.96*importances$P_imp_sd
importances$P_imp_lowCI <- range01(importances$P_imp_lowCI)
importances$P_imp_upCI <- range01(importances$P_imp_upCI)
importances$P_imp <- range01(importances$P_imp)
importances$arr <- importances$F_imp + importances$P_imp
importances <- importances %>% arrange(., arr)

ggplot(importances, aes(x = F_imp, y = reorder(Feature,F_imp), fill = scenario, 
                        color = scenario, alpha = scenario)) +
  geom_bar(stat = "identity", position = position_dodge(width =1), width = 0.7) +
  geom_point(aes(x = P_imp, color = scenario), size = 1,
             alpha = 1, position = position_dodge(width =1)) +
  geom_segment(aes(x = P_imp_lowCI,
                    xend = P_imp_upCI),
               position = position_dodge(width =1)) +
  scale_fill_manual(values = c("skyblue", "white")) +
  scale_color_manual(values = c("skyblue", "black")) +
  scale_alpha_manual(values = c(1, 0.3)) +
  labs(x = "Relative Feature Importances (scaled between 0-1)",
       y = "Features",
       fill = "Climate Change Scenario",
       color = "Climate Change Scenario",
       alpha = "Climate Change Scenario") +
  facet_grid(cols = vars(virus)) + 
  theme_minimal() +
  theme(axis.text.x = element_text(size = 12, angle = 90),
        axis.text.y = element_text(size = 10, 
                                   margin = margin(t = 200,
                                              r = 0,
                                              b = 10,
                                              l = 0)),
        axis.title = element_text(size = 14),
        legend.text = element_text(size = 12), 
        legend.position = "bottom",
        panel.grid.minor.y = element_line(linewidth = 1, 
                                          color = "black"),
        panel.border = element_rect(color = "black", fill = NA), 
        strip.background = element_rect(color = "black", fill = NA,
                                        linewidth = 1.5))
  
ggsave("./Docs/Tables and Figures/for manuscript/figure arrangements/delta_models/fi_all.png",
       width = 16, height = 10, dpi = 300)
