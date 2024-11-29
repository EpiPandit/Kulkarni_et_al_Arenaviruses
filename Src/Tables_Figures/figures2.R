setwd("/Users/pranavkulkarni/SDM/Climate_Models_Arenaviruses/Data")

library(tidyverse)
zyg_rf <- read.csv("./Output/iterations/Z_brevicauda/rf_results.csv")
zyg_et <- read.csv("./Output/iterations/Z_brevicauda/et_results.csv")
zyg_xgb <- read.csv("./Output/iterations/Z_brevicauda/xgb_results.csv")
zyg_lgbm <- read.csv("./Output/iterations/Z_brevicauda/lgbm_results.csv")
sig_rf <- read.csv("./Output/iterations/S_alstoni/rf_results.csv")
sig_et <- read.csv("./Output/iterations/S_alstoni/et_results.csv")
sig_xgb <- read.csv("./Output/iterations/S_alstoni/xgb_results.csv")
sig_lgbm <- read.csv("./Output/iterations/S_alstoni/lgbm_results.csv")
cla_rf <- read.csv("./Output/iterations/C_laucha/rf_results.csv")
cla_et <- read.csv("./Output/iterations/C_laucha/et_results.csv")
cla_xgb <- read.csv("./Output/iterations/C_laucha/xgb_results.csv")
cla_lgbm <- read.csv("./Output/iterations/C_laucha/lgbm_results.csv")
cmus_rf <- read.csv("./Output/iterations/C_musculinus/rf_results.csv")
cmus_et <- read.csv("./Output/iterations/C_musculinus/et_results.csv")
cmus_xgb <- read.csv("./Output/iterations/C_musculinus/xgb_results.csv")
cmus_lgbm <- read.csv("./Output/iterations/C_musculinus/lgbm_results.csv")
ofl_rf <- read.csv("./Output/iterations/O_flavescens/rf_results.csv")
ofl_et <- read.csv("./Output/iterations/O_flavescens/et_results.csv")
ofl_xgb <- read.csv("./Output/iterations/O_flavescens/xgb_results.csv")
ofl_lgbm <- read.csv("./Output/iterations/O_flavescens/lgbm_results.csv")
ccal_rf <- read.csv("./Output/iterations/C_callosus/rf_results.csv")
ccal_et <- read.csv("./Output/iterations/C_callosus/et_results.csv")
ccal_xgb <- read.csv("./Output/iterations/C_callosus/xgb_results.csv")
ccal_lgbm <- read.csv("./Output/iterations/C_callosus/lgbm_results.csv")
zyg_mod <- read.csv("./Output/iterations/Z_brevicauda/model_results.csv")
zyg_mod$spp <- rep("zyg", nrow(zyg_mod))
sig_mod <- read.csv("./Output/iterations/S_alstoni/model_results.csv")
sig_mod$spp <- rep("sig", nrow(sig_mod))
ccal_mod <- read.csv("./Output/iterations/C_callosus/model_results.csv")
ccal_mod$spp <- rep("ccal", nrow(ccal_mod))
cmus_mod <- read.csv("./Output/iterations/C_musculinus/model_results.csv")
cmus_mod$spp <- rep("cmus", nrow(cmus_mod))
cla_mod <- read.csv("./Output/iterations/C_laucha/model_results.csv")
cla_mod$spp <- rep("cla", nrow(cla_mod))
ofl_mod <- read.csv("./Output/iterations/O_flavescens/model_results.csv")
ofl_mod$spp <- rep("ofl", nrow(ofl_mod))
all_mod <- do.call(rbind, mget(ls(pattern = "_mod")))
all_mod_summary <- all_mod %>% group_by(spp, Model) %>% summarise(ACC_mean = mean(Acc_mean),
                                                       ACC_sd = mean(ACC_std),
                                                       Prec_mean = mean(Precision_mean),
                                                       Prec_sd = mean(Precision_std),
                                                       ROC_mean = mean(ROC_AUC_mean),
                                                       ROC_sd = mean(ROC_AUC_std),
                                                       Recall_mean = mean(Recall_mean),
                                                       Recall_sd = mean(Recall_std),
                                                       tp_median = median(tp),
                                                       fp_median = median(fp),
                                                       fn_median = median(fn),
                                                       tn_median = median(tn))

all_mod_summary <- all_mod_summary %>% ungroup() %>% 
  mutate(f1score = all_mod_summary$tp_median/(all_mod_summary$tp_median + 0.5*(all_mod_summary$fp_median + all_mod_summary$fn_median)))

all_mod_summary <- all_mod_summary %>% 
  mutate(tp = tp_median/(tp_median + fn_median), 
         fp = fp_median/(fp_median + tn_median),
         fn = fn_median/(tp_median + fn_median),
         tn = tn_median/ (fp_median + tn_median))

mod_perf_data1 <- all_mod_summary %>% select(spp, Model, ACC_mean, Prec_mean, ROC_mean, Recall_mean) %>%
   pivot_longer(., ACC_mean:Recall_mean, names_to = "indicator", values_to = "vals")
mod_perf_data2 <- all_mod_summary %>% select(spp, Model, ACC_sd, Prec_sd, ROC_sd, Recall_sd) %>%
  pivot_longer(., ACC_sd:Recall_sd, names_to = "indicator_sd", values_to = "vals_sd")

mod_perf_data <- cbind(mod_perf_data1, mod_perf_data2$indicator_sd, mod_perf_data2$vals_sd)
colnames(mod_perf_data) <- c("spp", "Model", "indicator_mean", "values_mean", "indicator_sd", "values_sd")
rm(list = setdiff(ls(), list("mod_perf_data", "all_mod", "all_mod_summary")))
mod_perf_data$spp <- factor(mod_perf_data$spp, levels = c("ccal", "cmus", "cla",
                                                          "ofl", "sig", "zyg"),
                            labels = c("C.callosus", "C.musculinus", "C.laucha", 
                                       "O.flavescens", "S.alstoni", "Z.brevicauda"))
mod_perf <- ggplot(mod_perf_data, aes(x = Model, y = values_mean, 
                                      color = indicator_mean)) +
  geom_point(size = 3, position=position_dodge(width=0.9)) +
  geom_errorbar(aes(ymin = values_mean - values_sd, ymax = values_mean + values_sd),
                position=position_dodge(width=0.9)) +
  labs(x = "Model algorithm", y = "(%) performance", color = "Metric") + 
  scale_color_brewer(palette = "Set2", labels = c("Accuracy", "Precision", "Precall", "ROC")) +
  theme_minimal() +
  coord_flip() +
  facet_wrap(~spp, ncol = 1)
mod_perf

mod_conf_data = all_mod_summary %>% select(spp, Model,
                                           tp = tp_median,
                                           fp = fp_median,
                                           fn = fn_median,
                                           tn = tn_median) %>%
  pivot_longer(., tp:tn, names_to = "class", values_to = "numbers")



mod_conf_data$spp <- factor(mod_conf_data$spp, levels = c("ccal", "cmus", "cla",
                                                          "ofl", "sig", "zyg"),
                            labels = c("C.callosus", "C.musculinus", "C.laucha", 
                                       "O.flavescens", "S.alstoni", "Z.brevicauda"))

mod_conf <- ggplot(mod_conf_data, aes(x = Model, y = numbers, fill = class)) +
  geom_bar(stat = "identity", position = "stack", width = 0.5, color = "black") +
  theme_linedraw() + theme(panel.grid = element_line(linewidth = NA),
                           legend.position = "bottom",
                           panel.background = element_rect(fill = "transparent",
                                                           colour = NA_character_),
                           legend.background = element_rect(fill = "transparent"),
                           legend.box.background = element_rect(fill = "transparent"),
                           legend.key = element_rect(fill = "transparent")) +
  labs(x = "Model Algorithm", y = "Number of samples", fill = "Classification") +
  scale_fill_brewer(palette = "Set2", labels = c("FN", "FP", "TN", "TP")) +
  facet_wrap(vars(spp), nrow = 1, scales = "free_y")
mod_conf


ggsave("/Users/pranavkulkarni/Desktop/mod_perf.png", mod_perf, height = 11, width = 8.5, units = "in", dpi = 300)
ggsave("/Users/pranavkulkarni/Desktop/mod_conf.png", mod_conf, height = 11, width = 8.5, units = "in", dpi = 300)

zyg_all <- do.call(rbind, list(zyg_rf, zyg_et, zyg_xgb,zyg_lgbm))
zyg_all$algorithm <- rep(c("rf", "et", "xgb", "lgbm"), each = nrow(zyg_rf)) 
zyg_all$sp <- rep("zyg", nrow(zyg_all))

sig_all <- do.call(rbind, list(sig_rf, sig_et, sig_xgb,sig_lgbm))
sig_all$algorithm <- rep(c("rf", "et", "xgb", "lgbm"), each = nrow(sig_rf)) 
sig_all$sp <- rep("sig", nrow(sig_all))

ccal_all <- do.call(rbind, list(ccal_rf, ccal_et, ccal_xgb,ccal_lgbm))
ccal_all$algorithm <- rep(c("rf", "et", "xgb", "lgbm"), each = nrow(ccal_rf)) 
ccal_all$sp <- rep("ccal", nrow(ccal_all))

cmus_all <- do.call(rbind, list(cmus_rf, cmus_et, cmus_xgb,cmus_lgbm))
cmus_all$algorithm <- rep(c("rf", "et", "xgb", "lgbm"), each = nrow(cmus_rf)) 
cmus_all$sp <- rep("cmus", nrow(cmus_all))

cla_all <- do.call(rbind, list(cla_rf, cla_et, cla_xgb,cla_lgbm))
cla_all$algorithm <- rep(c("rf", "et", "xgb", "lgbm"), each = nrow(cla_rf)) 
cla_all$sp <- rep("cla", nrow(cla_all))

ofl_all <- do.call(rbind, list(ofl_rf, ofl_et, ofl_xgb,ofl_lgbm))
ofl_all$algorithm <- rep(c("rf", "et", "xgb", "lgbm"), each = nrow(ofl_rf)) 
ofl_all$sp <- rep("ofl", nrow(ofl_all))



all_sp <- do.call(rbind, mget(ls(pattern = "_all")))
colnames(all_sp) <- c("features", "importances", "algorithm", "spp")
row.names(all_sp) <- NULL

all_selected <- all_sp %>% group_by(spp, algorithm, features) %>%
  summarise(sel = n())
all_summary <- all_sp %>%  group_by(spp, features, algorithm) %>% 
  summarise(., mean_fi = mean(importances),
            sd_fi = sd(importances)) %>% ungroup()
all_summary <- all_summary %>% left_join(all_selected, by = c("spp", "algorithm", "features"))
all_model <- all_summary %>% left_join(all_mod_summary, by = c("spp" = "spp", "algorithm" = "Model"))
plot_model_ACC <- all_model %>% pivot_longer(cols = c(ACC_mean, mean_fi), names_to = "type", values_to = "values")

ggplot(plot_model_ACC, aes(y = values, axis1 = spp, axis2 = algorithm, axis3 = features)) +
  geom_alluvium(aes(fill = values)) +
  geom_stratum() +
  geom_text(stat = "stratum", aes(label = after_stat(stratum)))
# ggplot(data = all_summary,
#        aes( axis1 = algorithm, axis2 = features, y = mean_fi)) +
#   geom_alluvium(aes(fill = algorithm)) +
#   geom_stratum() +
#   geom_text(stat = "stratum", aes(label = after_stat(stratum))) +
#   labs(title = "Mean Feature Importances by Species and Algorithm", y = "Importance", x = "") +
#   theme_classic()


# Sample data with two different importances: one between Species and Algorithm, another between Algorithm and Feature
# data <- data.frame(
#   Algorithm = rep(c("Random Forest", "XGBoost", "SVM", "Logistic Regression"), each = 5),
#   Feature = rep(c("Feature 1", "Feature 2", "Feature 3", "Feature 4", "Feature 5"), times = 4),
#   Species = rep(c("Species A", "Species B"), each = 10),
#   Importance_1 = c(5, 7, 3, 4, 2, 6, 5, 6, 7, 8),  # Importance between Species and Algorithm
#   Importance_2 = c(3, 4, 2, 1, 5, 4, 3, 7, 6, 2)   # Importance between Algorithm and Feature
# )
# 
# # Prepare a long format dataset for ggalluvial
# long_data <- data %>%
#   pivot_longer(cols = c("Importance_1", "Importance_2"), names_to = "Importance_Type", values_to = "Importance")



zyg_rf <- read.csv("./Output/iterations/Z_brevicauda/rf_results.csv")
zyg_et <- read.csv("./Output/iterations/Z_brevicauda/et_results.csv")
zyg_xgb <- read.csv("./Output/iterations/Z_brevicauda/xgb_results.csv")
zyg_lgbm <- read.csv("./Output/iterations/Z_brevicauda/lgbm_results.csv")
zyg_rf_noRFE <- read.csv("./Output/iterations/Z_brevicauda/rf_results_noRFE.csv")
zyg_et_noRFE <- read.csv("./Output/iterations/Z_brevicauda/et_results_noRFE.csv")
zyg_xgb_noRFE <- read.csv("./Output/iterations/Z_brevicauda/xgb_results_noRFE.csv")
zyg_lgbm_noRFE <- read.csv("./Output/iterations/Z_brevicauda/lgbm_results_noRFE.csv")
sig_rf <- read.csv("./Output/iterations/S_alstoni/rf_results.csv")
sig_et <- read.csv("./Output/iterations/S_alstoni/et_results.csv")
sig_xgb <- read.csv("./Output/iterations/S_alstoni/xgb_results.csv")
sig_lgbm <- read.csv("./Output/iterations/S_alstoni/lgbm_results.csv")
sig_rf_noRFE <- read.csv("./Output/iterations/S_alstoni/rf_results_noRFE.csv")
sig_et_noRFE <- read.csv("./Output/iterations/S_alstoni/et_results_noRFE.csv")
sig_xgb_noRFE <- read.csv("./Output/iterations/S_alstoni/xgb_results_noRFE.csv")
sig_lgbm_noRFE <- read.csv("./Output/iterations/S_alstoni/lgbm_results_noRFE.csv")
zyg_rf <- rbind(zyg_rf,zyg_rf_noRFE)
zyg_et <- rbind(zyg_et,zyg_et_noRFE)
zyg_xgb <- rbind(zyg_xgb,zyg_xgb_noRFE)
zyg_lgbm <- rbind(zyg_lgbm,zyg_lgbm_noRFE)
sig_rf <- rbind(sig_rf,sig_rf_noRFE)
sig_et <- rbind(sig_et,sig_et_noRFE)
sig_xgb <- rbind(sig_xgb,sig_xgb_noRFE)
sig_lgbm <- rbind(sig_lgbm,sig_lgbm_noRFE)
rm(list = ls(pattern = "_noRFE"))
zyg_rf_sum <- zyg_rf %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("rf", nrow(.)), spp = rep("Z.brevicauda", nrow(.)))
zyg_et_sum <- zyg_et %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("et", nrow(.)), spp = rep("Z.brevicauda", nrow(.)))
zyg_xgb_sum <- zyg_xgb %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("xgb", nrow(.)), spp = rep("Z.brevicauda", nrow(.)))
zyg_lgbm_sum <- zyg_lgbm %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("lgbm", nrow(.)), spp = rep("Z.brevicauda", nrow(.)))
sig_rf_sum <- sig_rf %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("rf", nrow(.)), spp = rep("S.alstoni", nrow(.)))
sig_et_sum <- sig_et %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("et", nrow(.)), spp = rep("S.alstoni", nrow(.)))
sig_xgb_sum <- sig_xgb %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("xgb", nrow(.)), spp = rep("S.alstoni", nrow(.)))
sig_lgbm_sum <- sig_lgbm %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("lgbm", nrow(.)), spp = rep("S.alstoni", nrow(.)))
rm(list = setdiff(ls(), ls(pattern = "_sum")))
guan_merged <- do.call(rbind, mget(ls()))
rm(list = setdiff(ls(), "guan_merged"))

cla_rf <- read.csv("./Output/iterations/C_laucha/rf_results.csv")
cla_et <- read.csv("./Output/iterations/C_laucha/et_results.csv")
cla_xgb <- read.csv("./Output/iterations/C_laucha/xgb_results.csv")
cla_lgbm <- read.csv("./Output/iterations/C_laucha/lgbm_results.csv")
cla_rf_noRFE <- read.csv("./Output/iterations/C_laucha/rf_results_noRFE.csv")
cla_et_noRFE <- read.csv("./Output/iterations/C_laucha/et_results_noRFE.csv")
cla_xgb_noRFE <- read.csv("./Output/iterations/C_laucha/xgb_results_noRFE.csv")
cla_lgbm_noRFE <- read.csv("./Output/iterations/C_laucha/lgbm_results_noRFE.csv")
cla_rf <- rbind(cla_rf,cla_rf_noRFE)
cla_et <- rbind(cla_et,cla_et_noRFE)
cla_xgb <- rbind(cla_xgb,cla_xgb_noRFE)
cla_lgbm <- rbind(cla_lgbm,cla_lgbm_noRFE)
cmus_rf <- read.csv("./Output/iterations/C_musculinus/rf_results.csv")
cmus_et <- read.csv("./Output/iterations/C_musculinus/et_results.csv")
cmus_xgb <- read.csv("./Output/iterations/C_musculinus/xgb_results.csv")
cmus_lgbm <- read.csv("./Output/iterations/C_musculinus/lgbm_results.csv")
cmus_rf_noRFE <- read.csv("./Output/iterations/C_musculinus/rf_results_noRFE.csv")
cmus_et_noRFE <- read.csv("./Output/iterations/C_musculinus/et_results_noRFE.csv")
cmus_xgb_noRFE <- read.csv("./Output/iterations/C_musculinus/xgb_results_noRFE.csv")
cmus_lgbm_noRFE <- read.csv("./Output/iterations/C_musculinus/lgbm_results_noRFE.csv")
cmus_rf <- rbind(cmus_rf,cmus_rf_noRFE)
cmus_et <- rbind(cmus_et,cmus_et_noRFE)
cmus_xgb <- rbind(cmus_xgb,cmus_xgb_noRFE)
cmus_lgbm <- rbind(cmus_lgbm,cmus_lgbm_noRFE)
ofl_rf <- read.csv("./Output/iterations/O_flavescens/rf_results.csv")
ofl_et <- read.csv("./Output/iterations/O_flavescens/et_results.csv")
ofl_xgb <- read.csv("./Output/iterations/O_flavescens/xgb_results.csv")
ofl_lgbm <- read.csv("./Output/iterations/O_flavescens/lgbm_results.csv")
ofl_rf_noRFE <- read.csv("./Output/iterations/O_flavescens/rf_results_noRFE.csv")
ofl_et_noRFE <- read.csv("./Output/iterations/O_flavescens/et_results_noRFE.csv")
ofl_xgb_noRFE <- read.csv("./Output/iterations/O_flavescens/xgb_results_noRFE.csv")
ofl_lgbm_noRFE <- read.csv("./Output/iterations/O_flavescens/lgbm_results_noRFE.csv")
ofl_rf <- rbind(ofl_rf,ofl_rf_noRFE)
ofl_et <- rbind(ofl_et,ofl_et_noRFE)
ofl_xgb <- rbind(ofl_xgb,ofl_xgb_noRFE)
ofl_lgbm <- rbind(ofl_lgbm,ofl_lgbm_noRFE)
cla_rf_sum <- cla_rf %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("rf", nrow(.)), spp = rep("C.laucha", nrow(.)))
cla_et_sum <- cla_et %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("et", nrow(.)), spp = rep("C.laucha", nrow(.)))
cla_xgb_sum <- cla_xgb %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("xgb", nrow(.)), spp = rep("C.laucha", nrow(.)))
cla_lgbm_sum <- cla_lgbm %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("lgbm", nrow(.)), spp = rep("C.laucha", nrow(.)))
cmus_rf_sum <- cmus_rf %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("rf", nrow(.)), spp = rep("C.musculinus", nrow(.)))
cmus_et_sum <- cmus_et %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("et", nrow(.)), spp = rep("C.musculinus", nrow(.)))
cmus_xgb_sum <- cmus_xgb %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("xgb", nrow(.)), spp = rep("C.musculinus", nrow(.)))
cmus_lgbm_sum <- cmus_lgbm %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("lgbm", nrow(.)), spp = rep("C.musculinus", nrow(.)))
ofl_rf_sum <- ofl_rf %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("rf", nrow(.)), spp = rep("O.flavescens", nrow(.)))
ofl_et_sum <- ofl_et %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("et", nrow(.)), spp = rep("O.flavescens", nrow(.)))
ofl_xgb_sum <- ofl_xgb %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("xgb", nrow(.)), spp = rep("O.flavescens", nrow(.)))
ofl_lgbm_sum <- ofl_lgbm %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("lgbm", nrow(.)), spp = rep("O.flavescens", nrow(.)))

junin_merged <- do.call(rbind, mget(ls(pattern = "_sum")))
rm(list = setdiff(ls(), list("guan_merged", "junin_merged")))


ccal_rf_noRFE <- read.csv("./Output/iterations/C_callosus/rf_results_noRFE.csv")
ccal_et_noRFE <- read.csv("./Output/iterations/C_callosus/et_results_noRFE.csv")
ccal_xgb_noRFE <- read.csv("./Output/iterations/C_callosus/xgb_results_noRFE.csv")
ccal_lgbm_noRFE <- read.csv("./Output/iterations/C_callosus/lgbm_results_noRFE.csv")
ccal_rf <- read.csv("./Output/iterations/C_callosus/rf_results.csv")
ccal_et <- read.csv("./Output/iterations/C_callosus/et_results.csv")
ccal_xgb <- read.csv("./Output/iterations/C_callosus/xgb_results.csv")
ccal_lgbm <- read.csv("./Output/iterations/C_callosus/lgbm_results.csv")
ccal_rf <- rbind(ccal_rf,ccal_rf_noRFE)
ccal_et <- rbind(ccal_et,ccal_et_noRFE)
ccal_xgb <- rbind(ccal_xgb,ccal_xgb_noRFE)
ccal_lgbm <- rbind(ccal_lgbm,ccal_lgbm_noRFE)
ccal_rf_sum <- ccal_rf %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("rf", nrow(.)), spp = rep("C.callosus", nrow(.)))
ccal_et_sum <- ccal_et %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("et", nrow(.)), spp = rep("C.callosus", nrow(.)))
ccal_xgb_sum <- ccal_xgb %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("xgb", nrow(.)), spp = rep("C.callosus", nrow(.)))
ccal_lgbm_sum <- ccal_lgbm %>% group_by(X) %>% 
  summarise(fi = mean(X0), fi_sd = sd(X0), n_sel = n()) %>%
  mutate(Model = rep("lgbm", nrow(.)), spp = rep("C.callosus", nrow(.)))
machu_merged <- do.call(rbind, list(ccal_rf_sum, ccal_et_sum, ccal_xgb_sum, ccal_lgbm_sum))
rm(list = setdiff(ls(), list("guan_merged", "junin_merged", "machu_merged")))

guan_merged$virus <- rep("(guanarito virus)", nrow(guan_merged))
junin_merged$virus <- rep("(junin virus)", nrow(junin_merged))
machu_merged$virus <- rep("(machupo virus)", nrow(machu_merged))

merged_fi <- do.call(rbind, mget(ls(pattern = "merged")))
rm(list = setdiff(ls(), list("merged_fi")))

merged_fi %>% mutate(prop_sel = (n_sel-50)/50,
                     fi = round(fi, 3),
                     fi_sd = round(fi_sd, 3)) -> merged_fi

fi_all = ggplot(merged_fi, aes(x = reorder(X, fi, FUN = median), y = fi, color = Model, shape = spp, alpha = prop_sel)) +
  geom_point(size = 2, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = fi - fi_sd, ymax = fi+ fi_sd), position = position_dodge(width = 0.9)) +
  scale_alpha_continuous(range = c(0.1, 1), labels = c("0%", "25%", "50%", "75%", "100%")) + 
  scale_y_continuous(expand = c(0,0)) +
  coord_flip() +
  facet_wrap(spp~virus, nrow = 1) +
  labs(x = "features", y = "importances (mean reduced impurity)",
       color = "Model algorithm", shape = "Rodent reservoir", alpha = "RFE_selected proportion") +
  theme_classic() + 
  theme(axis.line = element_line(colour = "black", linewidth = 0.5),
        panel.grid.minor.x = element_line(color = "grey", linewidth = 0.25),
        panel.border = element_rect(fill = NA, color = "black"))
fi_all


merged_fi

