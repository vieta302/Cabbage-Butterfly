library(readxl)
library(tidyverse)
library(dplyr)
library(lubridate)
library(reshape)
library(ggpubr)
rm(list = ls())

setwd("~/Desktop/Fall 2022/DATA 331/Final /cabbage_butterfly-main")
df_raw <- read.csv("data/main.csv")

#Formatting and choosing columns 
df <- df_raw %>%
  dplyr::select("ID", "Country", 
                "LWingLength", "LWingWidth","RWingLength", "RWingWidth") %>%
  dplyr::filter(LWingLength > 0, LWingWidth > 0, RWingLength > 0, RWingWidth >0)

#Mean values of Wing Length/Width group by Country
df_values <- df %>%
  group_by(Country) %>%
  summarise(`Left Wing Length` = mean(LWingLength), `Left Wing Width` = mean(LWingWidth), 
            `Right Wing Length` = mean(RWingLength), `Right Wing Width` = mean(RWingWidth))

#Change from Wide -> Long format
df_final <- pivot_longer(df_values, cols = 2:5, names_to = "functions", values_to = "measurement")

#Finalized raw data
df_final$Country <- factor(df_final$Country, 
                            levels = c("Canada", "United States", "United Kingdom", "Republic of Ireland"))

#Finalized graph
graph <- ggplot(df_final, aes(fill = Country, x = functions, y = measurement))+
  geom_bar(position = "dodge", stat = "identity") + theme_minimal()+
  ggtitle("Wing Length/Width by Country") + ylim(0, 30)+
  labs(x = "", y = "") +
  scale_fill_manual(values = c("#009E73", "#F0E442", "#0072B2", "#D55E00"), 
                    name = "Country")+
  theme_minimal()


