setwd("~/SDM/Climate_Models_Arenaviruses/Data/Output/iterations")
library(raster)
library(terra)
library(tidyverse)
library(yardstick)

curr_zyg <- rast("./Z_brevicauda/current/foi_0.02.tif")
curr_sig <- rast("./S_alstoni/current/foi_0.02.tif")
plot(curr_sig)

curr_guan <- mean(curr_zyg, curr_sig, na.rm = T)
writeRaster(curr_guan, "foi_current_guan.tif", overwrite = T)
rm(curr_zyg, curr_sig)

ssp2_zyg <- rast("./Z_brevicauda/ssp2/foi_0.02.tif")
ssp2_sig <- rast("./S_alstoni/ssp2/foi_0.02.tif")
plot(ssp2_sig)

ssp2_guan <- mean(ssp2_zyg, ssp2_sig, na.rm = T)
writeRaster(ssp2_guan, "foi_ssp2_guan.tif", overwrite = T)
rm(ssp2_zyg, ssp2_sig)

ssp5_zyg <- rast("./Z_brevicauda/ssp5/foi_0.02.tif")
ssp5_sig <- rast("./S_alstoni/ssp5/foi_0.02.tif")
plot(ssp5_sig)

ssp5_guan <- mean(ssp5_zyg, ssp5_sig, na.rm = T)
writeRaster(ssp5_guan, "foi_ssp5_guan.tif", overwrite = T)
rm(ssp5_zyg, ssp5_sig)

curr_machu <- rast("./C_callosus/current/foi_0.02.tif")
writeRaster(curr_machu, "foi_current_machu.tif", overwrite = T)

ssp2_machu <- rast("./C_callosus/ssp2/foi_0.02.tif")

writeRaster(ssp2_machu, "foi_ssp2_machu.tif", overwrite = T)

ssp5_machu <- rast("./C_callosus/ssp5/foi_0.02.tif")

writeRaster(ssp5_machu, "foi_ssp5_machu.tif", overwrite = T)


curr_cmus <- rast("./C_musculinus/current/foi_0.02.tif")
curr_cla <- rast("./C_laucha/current/foi_0.02.tif")
curr_ofl <- rast("./O_flavescens/current/foi_0.02.tif")


curr_junin <- mean(curr_cmus, curr_cla, curr_ofl, na.rm = T)
writeRaster(curr_junin, "foi_current_junin.tif", overwrite = T)
rm(curr_zyg, curr_sig)

ssp2_cmus <- rast("./C_musculinus/ssp2/foi_0.02.tif")
ssp2_cla <- rast("./C_laucha/ssp2/foi_0.02.tif")
ssp2_ofl <- rast("./O_flavescens/ssp2/foi_0.02.tif")

ssp2_junin <- mean(ssp2_cmus, ssp2_cla, ssp2_ofl, na.rm = T)
writeRaster(ssp2_junin, "foi_ssp2_junin.tif", overwrite = T)
rm(ssp2_zyg, ssp2_sig)

ssp5_cmus <- rast("./C_musculinus/ssp5/foi_0.02.tif")
ssp5_cla <- rast("./C_laucha/ssp5/foi_0.02.tif")
ssp5_ofl <- rast("./O_flavescens/ssp5/foi_0.02.tif")

ssp5_junin <- mean(ssp5_cmus, ssp5_cla, ssp5_ofl, na.rm = T)
writeRaster(ssp5_junin, "foi_ssp5_junin.tif", overwrite = T)
rm(ssp5_zyg, ssp5_sig)


curr_df_guan <- as.data.frame(curr_guan, xy = FALSE, na.rm = TRUE)
raster_colname <- names(curr_df_guan)[1]

ssp2_df_guan <- as.data.frame(ssp2_guan, xy = FALSE, na.rm = TRUE)
raster_colname <- names(ssp2_df_guan)[1]

ssp5_df_guan <- as.data.frame(ssp5_guan, xy = FALSE, na.rm = TRUE)
raster_colname <- names(ssp5_df_guan)[1]

curr_df_junin <- as.data.frame(curr_junin, xy = FALSE, na.rm = TRUE)
raster_colname <- names(curr_df_junin)[1]

ssp2_df_junin <- as.data.frame(ssp2_junin, xy = FALSE, na.rm = TRUE)
raster_colname <- names(ssp2_df_junin)[1]

ssp5_df_junin <- as.data.frame(ssp5_junin, xy = FALSE, na.rm = TRUE)
raster_colname <- names(ssp5_df_junin)[1]

curr_df_machu <- as.data.frame(curr_machu, xy = FALSE, na.rm = TRUE)
raster_colname <- names(curr_df_machu)[1]

ssp2_df_machu <- as.data.frame(ssp2_machu, xy = FALSE, na.rm = TRUE)
raster_colname <- names(ssp2_df_machu)[1]

ssp5_df_machu <- as.data.frame(ssp5_machu, xy = FALSE, na.rm = TRUE)
raster_colname <- names(ssp5_df_machu)[1]


curr_df_guan$scenario <- rep("Current", nrow(curr_df_guan))
ssp2_df_guan$scenario <- rep("SSP2-4.5", nrow(ssp2_df_guan))
ssp5_df_guan$scenario <- rep("SSP5-8.5", nrow(ssp5_df_guan))

df_guan <- do.call("rbind", list(curr_df_guan, ssp2_df_guan, ssp5_df_guan))
rm(curr_df_guan, ssp2_df_guan, ssp5_df_guan)

curr_df_machu$scenario <- rep("Current", nrow(curr_df_machu))
ssp2_df_machu$scenario <- rep("SSP2-4.5", nrow(ssp2_df_machu))
ssp5_df_machu$scenario <- rep("SSP5-8.5", nrow(ssp5_df_machu))

df_machu <- do.call("rbind", list(curr_df_machu, ssp2_df_machu, ssp5_df_machu))
rm(curr_df_machu, ssp2_df_machu, ssp5_df_machu)

curr_df_junin$scenario <- rep("Current", nrow(curr_df_junin))
ssp2_df_junin$scenario <- rep("SSP2-4.5", nrow(ssp2_df_junin))
ssp5_df_junin$scenario <- rep("SSP5-8.5", nrow(ssp5_df_junin))

df_junin <- do.call("rbind", list(curr_df_junin, ssp2_df_junin, ssp5_df_junin))
rm(curr_df_junin, ssp2_df_junin, ssp5_df_junin)

ggplot(df_guan, aes(x = `foi_0.02`, fill = scenario)) +
  geom_histogram(bins = 25, color = "white", position = position_identity(),
                 alpha = 0.3) +
  labs(
    x = "FOI (%/100)",
    y = "Count",
    fill = "Climate \n Scenario"
  ) + 
  geom_vline(aes(xintercept = 0.03), color = "green") +
  annotate("text", x = 0.2, y = 50000,
           label = "mean = 0.06 \n median = 0.03", color = "green") +
  geom_vline(aes(xintercept = 0.08), color = "blue") +
  annotate("text", x = 0.2, y = 35000,
           label = "mean = 0.1 \n median = 0.08", color = "blue") +
  geom_vline(aes(xintercept = 0.1), color = "orange") +
  annotate("text", x = 0.2, y = 20000,
           label = "mean = 0.1 \n median = 0.1", color = "orange") +
  scale_y_continuous(limits = c(0, 60000)) +
  scale_fill_manual(values = c("green", "blue", "orange")) +
  theme_minimal() +
  theme(axis.text = element_text(size = 10),
        axis.title = element_text(size = 12, face = "bold"),
        legend.title = element_text(size = 12, face = "bold"),
        legend.text = element_text(size = 10))
ggsave("guan_hist_all.png", dpi = 300, width = 5, height = 3.5)

ggplot(df_junin, aes(x = `foi_0.02`, fill = scenario)) +
  geom_histogram(bins = 25, color = "white", position = position_identity(),
                 alpha = 0.4) +
  labs(
    x = "FOI (%/100)",
    y = "Count",
    fill = "Climate \n Scenario"
  ) + 
  geom_vline(aes(xintercept = 0.04), color = "green") +
  annotate("text", x = 0.2, y = 50000,
           label = "mean = 0.07 \n median = 0.04", color = "green") +
  geom_vline(aes(xintercept = 0.07), color = "blue") +
  annotate("text", x = 0.2, y = 35000,
           label = "mean = 0.09 \n median = 0.07", color = "blue") +
  geom_vline(aes(xintercept = 0.075), color = "orange") +
  annotate("text", x = 0.2, y = 20000,
           label = "mean = 0.08 \n median = 0.07", color = "orange") +
  scale_y_continuous(limits = c(0, 60000)) +
  scale_fill_manual(values = c("green", "blue", "orange")) +
  theme_minimal() +
  theme(axis.text = element_text(size = 10),
        axis.title = element_text(size = 12, face = "bold"),
        legend.title = element_text(size = 12, face = "bold"),
        legend.text = element_text(size = 10))
ggsave("junin_hist_all.png", dpi = 300, width = 5, height = 3.5)

ggplot(df_machu, aes(x = `foi_0.02`, fill = scenario)) +
  geom_histogram(bins = 25, color = "white", position = position_identity(),
                 alpha = 0.4) +
  labs(
    x = "FOI (%/100)",
    y = "Count",
    fill = "Climate \n Scenario"
  ) + 
  geom_vline(aes(xintercept = 0.09), color = "green") +
  annotate("text", x = 0.15, y = 50000,
           label = "mean = 0.11 \n median = 0.09", color = "green") +
  geom_vline(aes(xintercept = 0.28), color = "blue") +
  annotate("text", x = 0.15, y = 35000,
           label = "mean = 0.23 \n median = 0.28", color = "blue") +
  geom_vline(aes(xintercept = 0.275), color = "orange") +
  annotate("text", x = 0.15, y = 20000,
           label = "mean = 0.22 \n median = 0.27", color = "orange") +
  scale_y_continuous(limits = c(0, 60000)) +
  scale_fill_manual(values = c("green", "blue", "orange")) +
  theme_minimal() +
  theme(axis.text = element_text(size = 10),
        axis.title = element_text(size = 12, face = "bold"),
        legend.title = element_text(size = 12, face = "bold"),
        legend.text = element_text(size = 10))
ggsave("machu_hist_all.png", dpi = 300, width = 5, height = 3.5)

rmse_ssp2_guan <- rmse_vec(values(ssp2_guan)[,1], values(curr_guan)[,1])
rmse_ssp5_guan <- rmse_vec(values(ssp5_guan)[,1], values(curr_guan)[,1])
rmse_ssp2_junin <- rmse_vec(values(ssp2_junin)[,1], values(curr_junin)[,1])
rmse_ssp5_junin <- rmse_vec(values(ssp5_junin)[,1], values(curr_junin)[,1])
rmse_ssp2_machu <- rmse_vec(values(ssp2_machu)[,1], values(curr_machu)[,1])
rmse_ssp5_machu <- rmse_vec(values(ssp5_machu)[,1], values(curr_machu)[,1],)


cor_ssp2_guan <- values(focalPairs(c(curr_guan, ssp2_guan), 
                                   fun = "pearson", na.rm = T), na.rm = T)[,1]
cor_ssp5_guan <- values(focalPairs(c(curr_guan, ssp5_guan), 
                                   fun = "pearson", na.rm = T), na.rm = T)[,1]
cor_ssp2_junin <- values(focalPairs(c(curr_junin, ssp2_junin), 
                                    fun = "pearson", na.rm = T), na.rm = T)[,1]
cor_ssp5_junin <- values(focalPairs(c(curr_junin, ssp5_junin), 
                                    fun = "pearson", na.rm = T), na.rm = T)[,1]
cor_ssp2_machu <- values(focalPairs(c(curr_machu, ssp2_machu), 
                                    fun = "pearson", na.rm = T), na.rm = T)[,1]
cor_ssp5_machu <- values(focalPairs(c(curr_machu, ssp5_machu), 
                                    fun = "pearson", na.rm = T), na.rm = T)[,1]

cor_df <- as.data.frame(cbind(cor_ssp2_guan,cor_ssp5_guan,
                              cor_ssp2_junin, cor_ssp5_junin,
                              cor_ssp2_machu, cor_ssp5_machu))
cor_df <- cor_df %>% pivot_longer(cor_ssp2_guan:cor_ssp5_machu, 
                                  names_to = "scenario", values_to = "cor") %>%
  arrange(scenario)

cor_df$virus <- ifelse(str_sub(cor_df$scenario, -4, -1) == "guan", "GTOV",
                       ifelse(str_sub(cor_df$scenario, -4, -1) == "unin", "JUNV", "MACV"))

cor_df$scenario <- ifelse(str_sub(cor_df$scenario, 5, 8) == "ssp2", "SSP 2-4.5", "SSP5-8.5")
                       
b <- ggplot(cor_df, aes(x = virus, y = cor, fill = scenario)) +
  geom_boxplot(col = "black", position = position_dodge(width = 0.9), na.rm = T,
               staplewidth = 0.1, outlier.shape = NA, alpha = 0.4) +
  scale_fill_manual(values =c("orange", "blue")) +
  labs(x = "NWAs", y = "Pearson's \u03c1 (current, future)", fill = "Climate Scenario") +
  theme_minimal() +
  theme(axis.title = element_text(size = 12, face = "bold"),
        axis.text = element_text(size = 10),
        legend.title = element_text(size = 12),
        legend.position = "top")
b
ggsave("boxplots.png", dpi = 300, width = 5, height = 3.5)

diff_ssp2_guan <- as.data.frame(ssp2_guan - curr_guan, xy = T)
diff_ssp5_guan <- as.data.frame(ssp5_guan - curr_guan, xy = T)
diff_ssp2_junin <- as.data.frame(ssp2_junin - curr_junin, xy = T)
diff_ssp5_junin <- as.data.frame(ssp5_junin - curr_junin, xy = T)
diff_ssp2_machu <- as.data.frame(ssp2_machu - curr_machu, xy = T)
diff_ssp5_machu <- as.data.frame(ssp5_machu - curr_machu, xy = T)

diff_ssp2_guan$virus <- rep("GTOV", nrow(diff_ssp2_guan))
diff_ssp5_guan$virus <- rep("GTOV", nrow(diff_ssp5_guan))
diff_ssp2_junin$virus <- rep("JUNV", nrow(diff_ssp2_junin))
diff_ssp5_junin$virus <- rep("JUNV", nrow(diff_ssp5_junin))
diff_ssp2_machu$virus <- rep("MACV", nrow(diff_ssp2_machu))
diff_ssp5_machu$virus <- rep("MACV", nrow(diff_ssp5_machu))

diff_ssp2_guan$scenario <- rep("SSP 2-4.5", nrow(diff_ssp2_guan))
diff_ssp5_guan$scenario <- rep("SSP 5-8.5", nrow(diff_ssp5_guan))
diff_ssp2_junin$scenario <- rep("SSP 2-4.5", nrow(diff_ssp2_junin))
diff_ssp5_junin$scenario <- rep("SSP 5-8.5", nrow(diff_ssp5_junin))
diff_ssp2_machu$scenario <- rep("SSP 2-4.5", nrow(diff_ssp2_machu))
diff_ssp5_machu$scenario <- rep("SSP 5-8.5", nrow(diff_ssp5_machu))

diff_df <- do.call("rbind", list(diff_ssp2_guan, diff_ssp5_guan, diff_ssp2_junin,
                      diff_ssp5_junin, diff_ssp2_machu, diff_ssp5_machu))
diff_df1 <- diff_df %>% group_by(virus,scenario, x) %>% 
  summarise(mean = mean(`foi_0.02`, na.rm = T), 
            lowCI = mean - 1.96*sd(`foi_0.02`, na.rm = T),
            highCI = mean + 1.96*sd(`foi_0.02`, na.rm = T)) %>% ungroup()
a <- ggplot(diff_df1, aes(x = x, y = mean, fill = scenario)) +
  geom_ribbon(aes(ymin = lowCI, ymax = highCI), stat = "identity",alpha = 0.3) +
  geom_line(aes(color = scenario), stat = "identity", show.legend = F) +
  facet_grid(rows = vars(virus), scales = "free") +
  geom_hline(aes(yintercept = 0.0), linewidth = 0.5, color = "black") + 
  labs(x = "Longitude", y = "Difference in FOI", color = "Climate Scenario") +
  scale_color_manual(values = c("blue", "orange")) +
  scale_fill_manual(values = c("blue", "orange")) +
  theme_minimal() +
  theme(axis.text = element_text(size = 10),
        axis.title = element_text(size = 12, face = "bold"),
        legend.title = element_text(size = 12, face = "bold"),
        legend.text = element_text(size = 10),
        strip.text = element_text(size = 12, face = "bold"),
        legend.position = "top")
a
ggsave("longitude_vs_diff_foi.png",plot = a, dpi = 300, height = 5, width = 3.5)
ggpubr::ggarrange(a, b, common.legend = T)
ggsave("boxplot_longitude.png", dpi = 300, width = 5, height = 3.5)
