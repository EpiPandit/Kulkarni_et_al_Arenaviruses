setwd("/Users/pranavkulkarni/SDM/Climate_Models_Arenaviruses/Data")

# library(terra)
# library(raster)
library(tidyverse)

zyg_rf_noRFE <- read.csv("./Output/iterations/Z_brevicauda/rf_results_noRFE.csv")
zyg_et_noRFE <- read.csv("./Output/iterations/Z_brevicauda/et_results_noRFE.csv")
zyg_xgb_noRFE <- read.csv("./Output/iterations/Z_brevicauda/xgb_results_noRFE.csv")
zyg_lgbm_noRFE <- read.csv("./Output/iterations/Z_brevicauda/lgbm_results_noRFE.csv")

ccal_rf_noRFE <- read.csv("./Output/iterations/C_callosus/rf_results_noRFE.csv")
ccal_et_noRFE <- read.csv("./Output/iterations/C_callosus/et_results_noRFE.csv")
ccal_xgb_noRFE <- read.csv("./Output/iterations/C_callosus/xgb_results_noRFE.csv")
ccal_lgbm_noRFE <- read.csv("./Output/iterations/C_callosus/lgbm_results_noRFE.csv")

rf_p <- ggplot(zyg_rf_noRFE, aes(x = reorder(X, X0, FUN = mean), y = X0)) +
          geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3) +
          labs(title = "RF", x = "Features", y = "Importances") +
          coord_flip() +
          theme_minimal()
et_p <- ggplot(zyg_et_noRFE, aes(x = reorder(X, X0, FUN = mean), y = X0)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3) +
  labs(title = "ET", x = "Features", y = "Importances") +
  coord_flip() +
  theme_minimal()
xgb_p <- ggplot(zyg_xgb_noRFE, aes(x = reorder(X, X0, FUN = mean), y = X0)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3) +
  labs(title = "XGB", x = "Features", y = "Importances") +
  coord_flip() +
  theme_minimal()
lgbm_p <- ggplot(zyg_lgbm_noRFE, aes(x = reorder(X, X0, FUN = mean), y = X0)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3) +
  labs(title = "LGBM", x = "Features", y = "Importances") +
  coord_flip() +
  theme_minimal()

ggpubr::ggarrange(rf_p, et_p, xgb_p, lgbm_p, ncol = 2, nrow = 2)

zyg_rf <- read.csv("./Output/iterations/Z_brevicauda/rf_results.csv")
zyg_et <- read.csv("./Output/iterations/Z_brevicauda/et_results.csv")
zyg_xgb <- read.csv("./Output/iterations/Z_brevicauda/xgb_results.csv")
zyg_lgbm <- read.csv("./Output/iterations/Z_brevicauda/lgbm_results.csv")
rf_p <- ggplot(zyg_rf, aes(x = reorder(X, X0, FUN = mean), y = X0)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3) +
  labs(title = "RF", x = "Features", y = "Importances") +
  coord_flip() +
  theme_minimal()
et_p <- ggplot(zyg_et, aes(x = reorder(X, X0, FUN = mean), y = X0)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3) +
  labs(title = "ET", x = "Features", y = "Importances") +
  coord_flip() +
  theme_minimal()
xgb_p <- ggplot(zyg_xgb, aes(x = reorder(X, X0, FUN = mean), y = X0)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3) +
  labs(title = "XGB", x = "Features", y = "Importances") +
  coord_flip() +
  theme_minimal()
lgbm_p <- ggplot(zyg_lgbm, aes(x = reorder(X, X0, FUN = mean), y = X0)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3) +
  labs(title = "LGBM", x = "Features", y = "Importances") +
  coord_flip() +
  theme_minimal()

ggpubr::ggarrange(rf_p, et_p, xgb_p, lgbm_p, ncol = 2, nrow = 2)

sig_mod <- read.csv("./Output/iterations/S_alstoni/model_results.csv")
sig_mod_noRFE <- read.csv("./Output/iterations/S_alstoni/model_results_noRFE.csv")
sig_acc <- ggplot(sig_mod_noRFE, aes(x = Model, y = Acc_mean, fill = Model)) + 
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3, color = "black") +
  labs(x = "Algorithm", y = "score (%)", title = "Accuracy", fill = "Algorithm") +
  scale_fill_brewer(type = "qual", palette = 1) +
  coord_flip() +
  theme_minimal()
sig_p <- ggplot(sig_mod_noRFE, aes(x = Model, y = Precision_mean, fill = Model)) + 
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3, color = "black") +
  labs(x = "Algorithm", y = "score (%)", title = "Precision", fill = "Algorithm") +
  scale_fill_brewer(type = "qual", palette = 1) +
  coord_flip() +
  theme_minimal()
sig_auc <- ggplot(sig_mod_noRFE, aes(x = Model, y = ROC_AUC_mean, fill = Model)) + 
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3, color = "black") +
  labs(x = "Algorithm", y = "score (%)", title = "ROC_AUC", fill = "Algorithm") +
  scale_fill_brewer(type = "qual", palette = 1) +
  coord_flip() +
  theme_minimal()
sig_rec <- ggplot(sig_mod_noRFE, aes(x = Model, y = Recall_mean, fill = Model)) + 
  geom_boxplot(outlier.colour = "red", outlier.shape = 8, outlier.size = 3, color = "black") +
  # geom_segment(data = sig_mod_noRFE, aes(x = Model, 
  #                                        yend = Recall_mean - Recall_std, 
  #                                        y = Recall_mean + Recall_std),
  #              colour = "black", size = 0.5) +
  labs(x = "Algorithm", y = "score (%)", title = "Recall", fill = "Algorithm") +
  scale_fill_brewer(type = "qual", palette = 1) +
  coord_flip() +
  theme_minimal()
ggpubr::ggarrange(sig_acc, sig_p, sig_auc, sig_rec, ncol = 2, nrow = 2, common.legend = T)

zyg_rf <- read.csv("./Output/iterations/Z_brevicauda/rf_results.csv")
zyg_et <- read.csv("./Output/iterations/Z_brevicauda/et_results.csv")
zyg_xgb <- read.csv("./Output/iterations/Z_brevicauda/xgb_results.csv")
zyg_lgbm <- read.csv("./Output/iterations/Z_brevicauda/lgbm_results.csv")
zyg_rf_noRFE <- read.csv("./Output/iterations/Z_brevicauda/rf_results_noRFE.csv")
zyg_et_noRFE <- read.csv("./Output/iterations/Z_brevicauda/et_results_noRFE.csv")
zyg_xgb_noRFE <- read.csv("./Output/iterations/Z_brevicauda/xgb_results_noRFE.csv")
zyg_lgbm_noRFE <- read.csv("./Output/iterations/Z_brevicauda/lgbm_results_noRFE.csv")
zyg_merged <- cbind(zyg_rf, zyg_et$X0, zyg_xgb$X0, zyg_lgbm$X0)
zyg_merged_noRFE <- cbind(zyg_rf_noRFE, zyg_et_noRFE$X0, zyg_xgb_noRFE$X0, zyg_lgbm_noRFE$X0)

colnames(zyg_merged) <- c("features", "rf", "et", "xgb", "lgbm")
colnames(zyg_merged_noRFE) <- c("features", "rf_noRFE", "et_noRFE", "xgb_noRFE", "lgbm_noRFE")

zyg_merged <- zyg_merged %>% pivot_longer(., cols = rf:lgbm, 
                                          names_to = "algorithm", 
                                          values_to = "importances")
zyg_merged <- zyg_merged %>% group_by(features, algorithm) %>%
  summarise(., mean_importances = mean(importances, na.rm = T), sd_importances = sd(importances, na.rm = T))


zyg_merged_noRFE <- zyg_merged_noRFE %>% pivot_longer(., cols = rf_noRFE:lgbm_noRFE, 
                                          names_to = "algorithm", 
                                          values_to = "importances")
zyg_merged_noRFE <- zyg_merged_noRFE %>% group_by(features, algorithm) %>%
  summarise(., mean_importances = mean(importances, na.rm = T), 
            sd_importances = sd(importances, na.rm = T))

withRFE <- ggplot(zyg_merged, aes(x = algorithm, y = features, fill = mean_importances)) +
  geom_tile(col = "black") + 
  geom_text(aes(label = round(mean_importances,3)), col = "white") +
  scale_fill_viridis_c(option = "C", direction = -1) +
  labs(title = "with RFE") +
  theme_minimal()

noRFE <- ggplot(zyg_merged_noRFE, aes(x = algorithm, y = features, fill = mean_importances)) +
  geom_tile(col = "black") + 
  geom_text(aes(label = round(mean_importances,3)), col = "white") +
  scale_fill_viridis_c(option = "C", direction = -1) +
  labs(title = "without RFE") +
  theme_minimal()

ggpubr::ggarrange(withRFE, noRFE, ncol = 2, nrow = 1, common.legend = T)

sig_rf <- read.csv("./Output/iterations/S_alstoni/rf_results.csv")
sig_et <- read.csv("./Output/iterations/S_alstoni/et_results.csv")
sig_xgb <- read.csv("./Output/iterations/S_alstoni/xgb_results.csv")
sig_lgbm <- read.csv("./Output/iterations/S_alstoni/lgbm_results.csv")
sig_rf_noRFE <- read.csv("./Output/iterations/S_alstoni/rf_results_noRFE.csv")
sig_et_noRFE <- read.csv("./Output/iterations/S_alstoni/et_results_noRFE.csv")
sig_xgb_noRFE <- read.csv("./Output/iterations/S_alstoni/xgb_results_noRFE.csv")
sig_lgbm_noRFE <- read.csv("./Output/iterations/S_alstoni/lgbm_results_noRFE.csv")
sig_merged <- cbind(sig_rf, sig_et$X0, sig_xgb$X0, sig_lgbm$X0)
sig_merged_noRFE <- cbind(sig_rf_noRFE, sig_et_noRFE$X0, sig_xgb_noRFE$X0, sig_lgbm_noRFE$X0)

colnames(sig_merged) <- c("features", "rf", "et", "xgb", "lgbm")
colnames(sig_merged_noRFE) <- c("features", "rf_noRFE", "et_noRFE", "xgb_noRFE", "lgbm_noRFE")

sig_merged <- sig_merged %>% pivot_longer(., cols = rf:lgbm, 
                                          names_to = "algorithm", 
                                          values_to = "importances")
sig_merged <- sig_merged %>% group_by(features, algorithm) %>%
  summarise(., mean_importances = mean(importances, na.rm = T), sd_importances = sd(importances, na.rm = T))


sig_merged_noRFE <- sig_merged_noRFE %>% pivot_longer(., cols = rf_noRFE:lgbm_noRFE, 
                                                      names_to = "algorithm", 
                                                      values_to = "importances")
sig_merged_noRFE <- sig_merged_noRFE %>% group_by(features, algorithm) %>%
  summarise(., mean_importances = mean(importances, na.rm = T), 
            sd_importances = sd(importances, na.rm = T))

guan_merged <- sig_merged %>% left_join(zyg_merged, by = c("features", "algorithm"), suffix = c("_sig", "_zyg"))
guan_merged1 <- guan_merged %>% select(features, algorithm, 
                                      sig = mean_importances_sig, 
                                      zyg = mean_importances_zyg) %>%
  pivot_longer(., cols = c(sig,zyg), 
               names_to = "rodent", values_to = "mean_importances")
guan_merged2 <- guan_merged %>% select(features, algorithm, 
                                       sig = sd_importances_sig, 
                                       zyg = sd_importances_zyg) %>%
  pivot_longer(., cols = c(sig,zyg), 
               names_to = "rodent", values_to = "sd_importances")

guan_merged <- left_join(guan_merged1, guan_merged2, by = c("features", "algorithm", "rodent"))
rm(guan_merged1, guan_merged2)
ggplot(guan_merged, aes(x = reorder(features, mean_importances, FUN = mean), 
                        y = mean_importances, 
                        group = algorithm, 
                        col = rodent)) +
  geom_point(position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = mean_importances - sd_importances,
                    ymax = mean_importances + sd_importances)) +
  labs(x = "features", y = "mean importances", title = "Guanarito virus - with RFE") +
  scale_color_manual(labels = c("S.alstoni", "Z.brevicauda"), values = c("violet" , "green" )) +
  coord_flip() +
  facet_wrap(~algorithm) +
  theme_minimal()


guan_merged_noRFE <- sig_merged_noRFE %>% left_join(zyg_merged_noRFE, by = c("features", "algorithm"), suffix = c("_sig", "_zyg"))
guan_merged_noRFE1 <- guan_merged_noRFE %>% select(features, algorithm, 
                                       sig = mean_importances_sig, 
                                       zyg = mean_importances_zyg) %>%
  pivot_longer(., cols = c(sig,zyg), 
               names_to = "rodent", values_to = "mean_importances")
guan_merged_noRFE2 <- guan_merged_noRFE %>% select(features, algorithm, 
                                       sig = sd_importances_sig, 
                                       zyg = sd_importances_zyg) %>%
  pivot_longer(., cols = c(sig,zyg), 
               names_to = "rodent", values_to = "sd_importances")

guan_merged_noRFE <- left_join(guan_merged_noRFE1, guan_merged_noRFE2, by = c("features", "algorithm", "rodent"))
rm(guan_merged_noRFE1, guan_merged_noRFE2)
ggplot(guan_merged_noRFE, aes(x = reorder(features, mean_importances, FUN = mean), 
                        y = mean_importances, 
                        group = algorithm, 
                        col = rodent)) +
  geom_point(position = position_dodge(width = 0.2)) +
  geom_errorbar(aes(ymin = mean_importances - sd_importances,
                    ymax = mean_importances + sd_importances)) +
  labs(x = "features", y = "mean importances", title = "Guanarito virus - no RFE") +
  scale_color_manual(labels = c("S.alstoni", "Z.brevicauda"), values = c("violet" , "green" )) +
  coord_flip() +
  facet_wrap(~algorithm) +
  theme_minimal()

cla_rf <- read.csv("./Output/iterations/C_laucha/rf_results.csv")
cla_et <- read.csv("./Output/iterations/C_laucha/et_results.csv")
cla_xgb <- read.csv("./Output/iterations/C_laucha/xgb_results.csv")
cla_lgbm <- read.csv("./Output/iterations/C_laucha/lgbm_results.csv")
cla_rf_noRFE <- read.csv("./Output/iterations/C_laucha/rf_results_noRFE.csv")
cla_et_noRFE <- read.csv("./Output/iterations/C_laucha/et_results_noRFE.csv")
cla_xgb_noRFE <- read.csv("./Output/iterations/C_laucha/xgb_results_noRFE.csv")
cla_lgbm_noRFE <- read.csv("./Output/iterations/C_laucha/lgbm_results_noRFE.csv")
cla_merged <- cbind(cla_rf, cla_et$X0, cla_xgb$X0, cla_lgbm$X0)
colnames(cla_merged) <- c("features", "rf", "et", "xgb", "lgbm")
cla_merged_noRFE <- cbind(cla_rf_noRFE, cla_et_noRFE$X0, cla_xgb_noRFE$X0, cla_lgbm_noRFE$X0)
colnames(cla_merged_noRFE) <- c("features", "rf", "et", "xgb", "lgbm")

cla_merged <- cla_merged %>% pivot_longer(., cols = rf:lgbm, 
                                          names_to = "algorithm", 
                                          values_to = "importances")
cla_merged <- cla_merged %>% group_by(features, algorithm) %>%
  summarise(., mean_importances = mean(importances, na.rm = T), sd_importances = sd(importances, na.rm = T))


cla_merged_noRFE <- cla_merged_noRFE %>% pivot_longer(., cols = rf:lgbm, 
                                                      names_to = "algorithm", 
                                                      values_to = "importances")
cla_merged_noRFE <- cla_merged_noRFE %>% group_by(features, algorithm) %>%
  summarise(., mean_importances = mean(importances, na.rm = T), 
            sd_importances = sd(importances, na.rm = T))

cmus_rf <- read.csv("./Output/iterations/C_musculinus/rf_results.csv")
cmus_et <- read.csv("./Output/iterations/C_musculinus/et_results.csv")
cmus_xgb <- read.csv("./Output/iterations/C_musculinus/xgb_results.csv")
cmus_lgbm <- read.csv("./Output/iterations/C_musculinus/lgbm_results.csv")
cmus_rf_noRFE <- read.csv("./Output/iterations/C_musculinus/rf_results_noRFE.csv")
cmus_et_noRFE <- read.csv("./Output/iterations/C_musculinus/et_results_noRFE.csv")
cmus_xgb_noRFE <- read.csv("./Output/iterations/C_musculinus/xgb_results_noRFE.csv")
cmus_lgbm_noRFE <- read.csv("./Output/iterations/C_musculinus/lgbm_results_noRFE.csv")
cmus_merged <- cbind(cmus_rf, cmus_et$X0, cmus_xgb$X0, cmus_lgbm$X0)
cmus_merged_noRFE <- cbind(cmus_rf_noRFE, cmus_et_noRFE$X0, cmus_xgb_noRFE$X0, cmus_lgbm_noRFE$X0)
colnames(cmus_merged) <- c("features", "rf", "et", "xgb", "lgbm")
colnames(cmus_merged_noRFE) <- c("features", "rf", "et", "xgb", "lgbm")

cmus_merged <- cmus_merged %>% pivot_longer(., cols = rf:lgbm, 
                                            names_to = "algorithm", 
                                            values_to = "importances")
cmus_merged <- cmus_merged %>% group_by(features, algorithm) %>%
  summarise(., mean_importances = mean(importances, na.rm = T), sd_importances = sd(importances, na.rm = T))


cmus_merged_noRFE <- cmus_merged_noRFE %>% pivot_longer(., cols = rf:lgbm, 
                                                        names_to = "algorithm", 
                                                        values_to = "importances")
cmus_merged_noRFE <- cmus_merged_noRFE %>% group_by(features, algorithm) %>%
  summarise(., mean_importances = mean(importances, na.rm = T), 
            sd_importances = sd(importances, na.rm = T))

ofl_rf <- read.csv("./Output/iterations/O_flavescens/rf_results.csv")
ofl_et <- read.csv("./Output/iterations/O_flavescens/et_results.csv")
ofl_xgb <- read.csv("./Output/iterations/O_flavescens/xgb_results.csv")
ofl_lgbm <- read.csv("./Output/iterations/O_flavescens/lgbm_results.csv")
ofl_rf_noRFE <- read.csv("./Output/iterations/O_flavescens/rf_results_noRFE.csv")
ofl_et_noRFE <- read.csv("./Output/iterations/O_flavescens/et_results_noRFE.csv")
ofl_xgb_noRFE <- read.csv("./Output/iterations/O_flavescens/xgb_results_noRFE.csv")
ofl_lgbm_noRFE <- read.csv("./Output/iterations/O_flavescens/lgbm_results_noRFE.csv")
ofl_merged <- cbind(ofl_rf, ofl_et$X0, ofl_xgb$X0, ofl_lgbm$X0)
ofl_merged_noRFE <- cbind(ofl_rf_noRFE, ofl_et_noRFE$X0, ofl_xgb_noRFE$X0, ofl_lgbm_noRFE$X0)
colnames(ofl_merged) <- c("features", "rf", "et", "xgb", "lgbm")
colnames(ofl_merged_noRFE) <- c("features", "rf", "et", "xgb", "lgbm")

ofl_merged <- ofl_merged %>% pivot_longer(., cols = rf:lgbm, 
                                          names_to = "algorithm", 
                                          values_to = "importances")
ofl_merged <- ofl_merged %>% group_by(features, algorithm) %>%
  summarise(., mean_importances = mean(importances, na.rm = T), sd_importances = sd(importances, na.rm = T))


ofl_merged_noRFE <- ofl_merged_noRFE %>% pivot_longer(., cols = rf:lgbm, 
                                                      names_to = "algorithm", 
                                                      values_to = "importances")
ofl_merged_noRFE <- ofl_merged_noRFE %>% group_by(features, algorithm) %>%
  summarise(., mean_importances = mean(importances, na.rm = T), 
            sd_importances = sd(importances, na.rm = T))

junin_merged_noRFE <- cmus_merged_noRFE %>% 
  left_join(cla_merged_noRFE, by = c("features", "algorithm"), suffix = c("_cmus", "_cla")) %>%
  left_join(ofl_merged_noRFE)
junin_merged_noRFE <- junin_merged_noRFE %>% mutate(mean_importances_ofl = mean_importances,
                                                    sd_importances_ofl = sd_importances) %>%
  select(-c(mean_importances, sd_importances))

junin_merged_noRFE1 <- junin_merged_noRFE %>% select(features, algorithm, 
                                                     cmus = mean_importances_cmus, 
                                                     cla = mean_importances_cla,
                                                     ofl = mean_importances_ofl) %>%
  pivot_longer(., cols = c(cmus, cla, ofl), 
               names_to = "rodent", values_to = "mean_importances")
junin_merged_noRFE2 <- junin_merged_noRFE %>% select(features, algorithm, 
                                                     cmus = sd_importances_cmus,
                                                     cla = sd_importances_cla,
                                                     ofl = sd_importances_ofl) %>%
  pivot_longer(., cols = c(cmus, cla, ofl), 
               names_to = "rodent", values_to = "sd_importances")

junin_merged_noRFE <- left_join(junin_merged_noRFE1, junin_merged_noRFE2, by = c("features", "algorithm", "rodent"))
rm(junin_merged_noRFE1, junin_merged_noRFE2)
ggplot(junin_merged_noRFE, aes(x = reorder(features, mean_importances, FUN = mean), 
                               y = mean_importances, 
                               group = algorithm, 
                               col = rodent)) +
  geom_point(position = position_dodge(width = 0.9), na.rm = T) +
  geom_errorbar(aes(ymin = mean_importances - sd_importances,
                    ymax = mean_importances + sd_importances),
                position = position_dodge(width = 0.9)) +
  labs(x = "features", y = "mean importances", title = "Guanarito virus - no RFE") +
  scale_color_manual(labels = c("C.laucha", "C.musculinus", "O.flavescens"), 
                     values = c("darkblue" , "green", "salmon")) +
  coord_flip() +
  facet_wrap(~algorithm) +
  theme_minimal()

junin_merged <- cmus_merged %>% 
  left_join(cla_merged, by = c("features", "algorithm"), suffix = c("_cmus", "_cla")) %>%
  left_join(ofl_merged)
junin_merged <- junin_merged %>% mutate(mean_importances_ofl = mean_importances,
                                        sd_importances_ofl = sd_importances) %>%
  select(-c(mean_importances, sd_importances))

junin_merged1 <- junin_merged %>% select(features, algorithm, 
                                         cmus = mean_importances_cmus, 
                                         cla = mean_importances_cla,
                                         ofl = mean_importances_ofl) %>%
  pivot_longer(., cols = c(cmus, cla, ofl), 
               names_to = "rodent", values_to = "mean_importances")
junin_merged2 <- junin_merged %>% select(features, algorithm, 
                                         cmus = sd_importances_cmus,
                                         cla = sd_importances_cla,
                                         ofl = sd_importances_ofl) %>%
  pivot_longer(., cols = c(cmus, cla, ofl), 
               names_to = "rodent", values_to = "sd_importances")

junin_merged <- left_join(junin_merged1, junin_merged2, by = c("features", "algorithm", "rodent"))
rm(junin_merged1, junin_merged2)
ggplot(junin_merged, aes(x = reorder(features, mean_importances, FUN = mean), 
                         y = mean_importances, 
                         group = algorithm, 
                         col = rodent)) +
  geom_point(position = position_dodge(width = 0.9), na.rm = T) +
  geom_errorbar(aes(ymin = mean_importances - sd_importances,
                    ymax = mean_importances + sd_importances),
                position = position_dodge(width = 0.9)) +
  labs(x = "features", y = "mean importances", title = "Guanarito virus - with RFE") +
  scale_color_manual(labels = c("C.laucha", "C.musculinus", "O.flavescens"), 
                     values = c("darkblue" , "green", "salmon")) +
  coord_flip() +
  facet_wrap(~algorithm) +
  theme_minimal()

