library(readxl)
library(tidyverse)
library(dplyr)
library(lubridate)
library(ggplot2)
rm(list = ls())

setwd("~/Desktop/Fall 2022/DATA 331/Final /cabbage_butterfly-main")
df_raw <- read.csv("data/main.csv")

#Choosing columns 
df <- df_raw %>%
  dplyr::select("ID", "Year")

#Group by decades 
df$Year <-substring(df$Year, 1,3)
df$Year <- paste(df$Year, "0s", sep = "")

df_final <- df %>%
  count(Year)

#Total number of Butterfies for each decade (Graph)
ggplot(df_final, aes(x=Year, y = n, group = 1)) +
  geom_line(color = "black") + 
  ggtitle("Total number of Butterfies for each decade")+
  labs(x = "Decades", y = "Number of Butterflies")+ 
  geom_point(color = "red")+
  theme_minimal()

