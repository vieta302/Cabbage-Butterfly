library(readxl)
library(tidyverse)
library(dplyr)
library(lubridate)
library(reshape)
library(ggpubr)
rm(list = ls())

setwd("~/Desktop/Fall 2022/DATA 331/Final /cabbage_butterfly-main")
df_raw <- read.csv("data/main.csv")

#Remove unnecessary rows
df_raw <-subset(df_raw, Sex != "unknown")

#Formating and choosing columns 
df <- df_raw %>%
  dplyr::select("ID", "Sex", 
                "LWingLength", "LWingWidth","RWingLength", "RWingWidth") %>%
  dplyr::filter(LWingLength > 0, LWingWidth > 0, RWingLength > 0, RWingWidth >0)

#Left wing length by Sex
df_lwl <- df %>%
  group_by(Sex) %>%
  summarise(min.LWingLength = min(LWingLength),
            mean.LWingLength = mean(LWingLength),
            median.LWingLength = median(LWingLength),
            max.LWingLength = max(LWingLength))

df_lwl <- pivot_longer(df_lwl, cols = 2:5, 
                    names_to = "functions", values_to = "measurement")

lwl <- ggplot(df_lwl, aes(fill = functions, x = Sex, y = measurement)) +
  geom_bar(position = "dodge", stat = "identity") + ylim(0, 40)+
  theme_minimal() +
  scale_fill_manual(name = "Values", 
                    labels = c("Max", "Mean","Median", "Min"), 
                    values = c("#009E73", "#F0E442", "#0072B2", "#D55E00")) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank())

#Left wing width by Sex
df_lww <- df %>%
  group_by(Sex) %>%
  summarise(min.LWingWidth = min(LWingWidth),
            mean.LWingWidth = mean(LWingWidth),
            median.LWingWidth = median(LWingWidth),
            max.LWingWidth = max(LWingWidth))

df_lww <- pivot_longer(df_lww, cols = 2:5, 
                    names_to = "functions", values_to = "measurement")

lww <- ggplot(df_lww, aes(fill = functions, x = Sex, y = measurement)) +
  geom_bar(position = "dodge", stat = "identity")+ ylim(0, 30)+
  theme_minimal()+
  scale_fill_manual(name = "Values", 
                    labels = c("Max", "Mean","Median", "Min"), 
                    values = c("#009E73", "#F0E442", "#0072B2", "#D55E00")) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank())

#Right wing length by Sex
df_rwl <- df %>%
  group_by(Sex) %>%
  summarise(min.RWingLength = min(RWingLength),
            mean.RWingLength = mean(RWingLength),
            median.RWingLength = median(RWingLength),
            max.RWingLength = max(RWingLength))

df_rwl <- pivot_longer(df_rwl, cols = 2:5,
                    names_to = "functions", values_to = "measurement")

rwl <- ggplot(df_rwl, aes(fill = functions, x = Sex, y = measurement)) +
  geom_bar(position = "dodge", stat = "identity") + ylim(0, 40)+
  theme_minimal()+ 
  scale_fill_manual(name = "Values", 
                    labels = c("Max", "Mean","Median", "Min"), 
                    values = c("#009E73", "#F0E442", "#0072B2", "#D55E00")) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank())

#Right wing width by Sex
df_rww <- df %>%
  group_by(Sex) %>%
  summarise(min.RWingWidth = min(RWingWidth),
            mean.RWingWidth = mean(RWingWidth),
            median.RWingWidth = median(RWingWidth),
            max.RWingWidth = max(RWingWidth))

df_rww <- pivot_longer(df_rww, cols = 2:5, 
                    names_to = "functions", values_to = "measurement")

rww <- ggplot(df_rww, aes(fill = functions, x = Sex, y = measurement)) +
  geom_bar(position = "dodge", stat = "identity")+ ylim(0, 30)+
  theme_minimal() +
  scale_fill_manual(name = "Values", 
                    labels = c("Max", "Mean","Median", "Min"), 
                    values = c("#009E73", "#F0E442", "#0072B2", "#D55E00")) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank())

#Finalized graph
graph <- ggarrange(lwl, rwl, lww, rww, ncol = 2, nrow = 2, 
                    common.legend = TRUE, legend = "right",
                    labels = c("Left Wing Length", "Right Wing Length",
                               "Left Wing Width","Right Wing Width"),
                    font.label = list(size = 12, color = "black", face = "plain"))

annotate_figure(graph, top = text_grob("Wing Length/Width by Sex", size = 14))

