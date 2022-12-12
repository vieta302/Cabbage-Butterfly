library(readxl)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list = ls())

setwd("~/Desktop/Fall 2022/DATA 331/Final /cabbage_butterfly-main")
df_raw <- read.csv("data/main.csv")

#Group data by Male 
male <- df_raw %>%
  dplyr::select("Sex", "LWingLength","RWingLength") %>%
  dplyr::filter(Sex == "Male")
#Group data by Female
female <- df_raw %>%
  dplyr::select("Sex", "LWingLength","RWingLength") %>%
  dplyr::filter(Sex == "Female")

#Perform T-Test
t.test(male$LWingLength, female$LWingLength, mu=0, alt="two.sided", conf=0.95, var.eq=F, paired=F)
t.test(male$RWingLength, female$RWingLength, mu=0, alt="two.sided", conf=0.95, var.eq=F, paired=F)

