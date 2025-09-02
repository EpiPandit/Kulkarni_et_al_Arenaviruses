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
                                                                  F1_score_mean = (2*Prec_mean*Recall_mean)/(Prec_mean + Recall_mean),
                                                                  F1_score_sd = (2*Prec_sd*Recall_sd)/(Prec_sd + Recall_sd),
                                                                  tp_median = median(tp),
                                                                  fp_median = median(fp),
                                                                  fn_median = median(fn),
                                                                  tn_median = median(tn))
cv_results <- all_mod_summary %>% select(spp:F1_score_sd) %>% ungroup()
test_mod <- all_mod %>% group_by(spp, Model) %>%
  mutate(ACC_test = 100*(tp + tn)/(tp+tn+fp+fn),
         Prec_test = 100*tp/(tp + fp),
         Recall_test = 100*tp/(tp + fp),
         F1_score = (2*Prec_test*Recall_test)/(Prec_test + Recall_test))
test_results <- test_mod %>% group_by(spp, Model) %>%
  summarise(ACC_mean = mean(ACC_test),
            Prec_mean = mean(Prec_test),
            Recall_mean = mean(Recall_test),
            F1_score_mean = mean(F1_score),
            ACC_sd = sd(ACC_test),
            Prec_sd = sd(Prec_test),
            Recall_sd = sd(Recall_test),
            F1_score_sd = sd(F1_score)) %>% ungroup()

conf_mat <- all_mod_summary %>% select(spp, Model, tp_median:tn_median) %>% ungroup()

a <- ggplot(cv_results, aes(x = Model, color = spp)) +
  geom_point(aes(y = ACC_mean), size = 2, shape = 2, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = ACC_mean - ACC_sd,
                    ymax = ACC_mean + ACC_sd), position = position_dodge(width = 0.9),
                show.legend = F) +
  scale_color_brewer(palette = "Dark2") +
  labs(x = "Model algorithm", y = "Score", color = "Mean Accuracy (+/-SD)") +
  theme_minimal() +
  theme(axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 12),
        legend.position = "top")
a

b <- ggplot(cv_results, aes(x = Model, color = spp)) +
  geom_point(aes(y = Prec_mean), size = 2, shape = 4, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = Prec_mean - Prec_sd,
                    ymax = Prec_mean + Prec_sd), position = position_dodge(width = 0.9),
                show.legend = F) +
  scale_color_brewer(palette = "Dark2") +
  labs(x = "Model algorithm", y = "Score", color = "Mean Precision (+/-SD)") +
  theme_minimal() +
  theme(axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 12),
        legend.position = "top")
b

c <- ggplot(cv_results, aes(x = Model, color = spp)) +
  geom_point(aes(y = Recall_mean), size = 2, shape = 5, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = Recall_mean - Recall_sd,
                    ymax = Recall_mean + Recall_sd), position = position_dodge(width = 0.9),
                show.legend = F) +
  scale_color_brewer(palette = "Dark2") +
  labs(x = "Model algorithm", y = "Score", color = "Mean Recall (+/-SD)") +
  theme_minimal() +
  theme(axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 12),
        legend.position = "top")
c

d <- ggplot(cv_results, aes(x = Model, color = spp)) +
  geom_point(aes(y = ROC_mean), size = 2, shape = 7, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = ROC_mean - ROC_sd,
                    ymax = ROC_mean + ROC_sd), position = position_dodge(width = 0.9),
                show.legend = F) +
  scale_color_brewer(palette = "Dark2") +
  labs(x = "Model algorithm", y = "Score", color = "Mean AU ROCurve (+/-SD)") +
  theme_minimal() +
  theme(axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 12),
        legend.position = "top")
d

e <- ggplot(cv_results, aes(x = Model, color = spp)) +
  geom_point(aes(y = F1_score_mean), size = 2, shape = 8, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = F1_score_mean - F1_score_sd,
                    ymax = F1_score_mean + F1_score_sd), position = position_dodge(width = 0.9),
                show.legend = F) +
  scale_color_brewer(palette = "Dark2") +
  labs(x = "Model algorithm", y = "Score", color = "Mean F1 score (+/-SD)") +
  theme_minimal() +
  theme(axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 12),
        legend.position = "top")
e

ggsave("./Output/cv_metrics/accuracy.png", plot = a, dpi = 300, height = 4, width = 4)
ggsave("./Output/cv_metrics/precision.png", plot = b, dpi = 300, height = 4, width = 4)
ggsave("./Output/cv_metrics/recall.png", plot = c, dpi = 300, height = 4, width = 4)
ggsave("./Output/cv_metrics/roc.png", plot = d, dpi = 300, height = 4, width = 4)
ggsave("./Output/cv_metrics/f1.png", plot = e, dpi = 300, height = 4, width = 4)

a <- ggplot(test_results, aes(x = Model, color = spp)) +
  geom_point(aes(y = ACC_mean), size = 2, shape = 2, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = ACC_mean - ACC_sd,
                    ymax = ACC_mean + ACC_sd), position = position_dodge(width = 0.9),
                show.legend = F) +
  scale_color_brewer(palette = "Dark2") +
  labs(x = "Model algorithm", y = "Score", color = "Mean Accuracy (+/-SD)") +
  theme_minimal() +
  theme(axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 12),
        legend.position = "top")
a
b <- ggplot(test_results, aes(x = Model, color = spp)) +
  geom_point(aes(y = Prec_mean), size = 2, shape = 4, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = Prec_mean - Prec_sd,
                    ymax = Prec_mean + Prec_sd), position = position_dodge(width = 0.9),
                show.legend = F) +
  scale_color_brewer(palette = "Dark2") +
  labs(x = "Model algorithm", y = "Score", color = "Mean Precision (+/-SD)") +
  theme_minimal() +
  theme(axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 12),
        legend.position = "top")
b

c <- ggplot(test_results, aes(x = Model, color = spp)) +
  geom_point(aes(y = Recall_mean), size = 2, shape = 5, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = Recall_mean - Recall_sd,
                    ymax = Recall_mean + Recall_sd), position = position_dodge(width = 0.9),
                show.legend = F) +
  scale_color_brewer(palette = "Dark2") +
  labs(x = "Model algorithm", y = "Score", color = "Mean Recall (+/-SD)") +
  theme_minimal() +
  theme(axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 12),
        legend.position = "top")
c

e <- ggplot(test_results, aes(x = Model, color = spp)) +
  geom_point(aes(y = F1_score_mean), size = 2, shape = 8, position = position_dodge(width = 0.9)) +
  geom_errorbar(aes(ymin = F1_score_mean - F1_score_sd,
                    ymax = F1_score_mean + F1_score_sd), position = position_dodge(width = 0.9),
                show.legend = F) +
  scale_color_brewer(palette = "Dark2") +
  labs(x = "Model algorithm", y = "Score", color = "Mean F1 score (+/-SD)") +
  theme_minimal() +
  theme(axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 12),
        legend.position = "top")
e

ggsave("./Output/test_metrics/accuracy.png", plot = a, dpi = 300, height = 4, width = 4)
ggsave("./Output/test_metrics/precision.png", plot = b, dpi = 300, height = 4, width = 4)
ggsave("./Output/test_metrics/recall.png", plot = c, dpi = 300, height = 4, width = 4)
ggsave("./Output/test_metrics/f1.png", plot = e, dpi = 300, height = 4, width = 4)
