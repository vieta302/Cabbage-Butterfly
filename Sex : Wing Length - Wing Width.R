library(tidyverse)
library(dplyr)
library(readxl)
library(lubridate)
library(reshape)
library(ggpubr)
library(ggplot2)
rm(list = ls())

setwd("~/Desktop/Fall 2022/DATA 331/Final /cabbage_butterfly-main")
df_raw <- read.csv("data/main.csv")

#Remove unecessary rows
df_raw <-subset(df_raw, Sex != "unknown")

#Formating and choosing columns 
df <- df_raw %>%
  dplyr::select("ID", "Sex", 
                "LWingLength", "LWingWidth","RWingLength", "RWingWidth") %>%
  dplyr::filter(LWingLength > 0, LWingWidth > 0, RWingLength > 0, RWingWidth >0)

#plot left wing length
df1 <- df %>%
  group_by(Sex) %>%
  summarise(min.LWingLength = min(LWingLength),
            mean.LWingLength = mean(LWingLength),
            median.LWingLength = median(LWingLength),
            max.LWingLength = max(LWingLength))

df1 <- pivot_longer(df1, cols = 2:5, 
                    names_to = "functions", values_to = "measurement")

a <- ggplot(df1, aes(fill = functions, x = Sex, y = measurement)) +
  geom_bar(position = "dodge", stat = "identity") + ylim(0, 40)+
  theme_minimal() +
  scale_fill_manual(name = "Values", 
                    labels = c("max", "mean","median", "min"), 
                    values = c("#FF9900", "#99CCFF", "#006600", "#CC88CC")) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank())

#plot left wing width
df2 <- df %>%
  group_by(Sex) %>%
  summarise(min.LWingWidth = min(LWingWidth),
            mean.LWingWidth = mean(LWingWidth),
            median.LWingWidth = median(LWingWidth),
            max.LWingWidth = max(LWingWidth))

df2 <- pivot_longer(df2, cols = 2:5, 
                    names_to = "functions", values_to = "measurement")

b <- ggplot(df2, aes(fill = functions, x = Sex, y = measurement)) +
  geom_bar(position = "dodge", stat = "identity")+ ylim(0, 30)+
  theme_minimal()+
  scale_fill_manual(name = "Values", 
                    labels = c("max", "mean","median", "min"), 
                    values = c("#FF9900", "#99CCFF", "#006600", "#CC88CC")) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank())

#plot right wing length
df3 <- df %>%
  group_by(Sex) %>%
  summarise(min.RWingLength = min(RWingLength),
            mean.RWingLength = mean(RWingLength),
            median.RWingLength = median(RWingLength),
            max.RWingLength = max(RWingLength))

df3 <- pivot_longer(df3, cols = 2:5,
                    names_to = "functions", values_to = "measurement")

c <- ggplot(df3, aes(fill = functions, x = Sex, y = measurement)) +
  geom_bar(position = "dodge", stat = "identity") + ylim(0, 40)+
  theme_minimal()+ 
  scale_fill_manual(name = "Values", 
                    labels = c("max", "mean","median", "min"), 
                    values = c("#FF9900", "#99CCFF", "#006600", "#CC88CC")) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank())

#plot right wing width
df4 <- df %>%
  group_by(Sex) %>%
  summarise(min.RWingWidth = min(RWingWidth),
            mean.RWingWidth = mean(RWingWidth),
            median.RWingWidth = median(RWingWidth),
            max.RWingWidth = max(RWingWidth))

df4 <- pivot_longer(df4, cols = 2:5, 
                    names_to = "functions", values_to = "measurement")

d <- ggplot(df4, aes(fill = functions, x = Sex, y = measurement)) +
  geom_bar(position = "dodge", stat = "identity")+ ylim(0, 30)+
  theme_minimal() +
  scale_fill_manual(name = "Values", 
                    labels = c("max", "mean","median", "min"), 
                    values = c("#FF9900", "#99CCFF", "#006600", "#CC88CC")) +
  theme(axis.title.x = element_blank(), axis.title.y = element_blank())

#combine
figure <- ggarrange(a, c, b, d, ncol = 2, nrow = 2, 
                    common.legend = TRUE, legend = "right",
                    labels = c("Left Wing Length", "Right Wing Length",
                               "Left Wing Width","Right Wing Width"),
                    font.label = list(size = 14, color = "black", face = "plain"))

annotate_figure(figure, top = text_grob("Wing Span Visualization by Sex", face = "bold", size = 20))

