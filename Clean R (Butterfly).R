library(readxl)
library(tidyverse)
library(dplyr)
library(lubridate)
rm(list = ls())

setwd("~/Desktop/Fall 2022/DATA 331/Final /cabbage_butterfly-main")
df_raw <- read_excel("data/CompletePierisData_2022-03-09.xlsx")

#Formating and choosing columns 
df <- df_raw %>%
  dplyr::rename("ID" = "coreid",
                "Country" = "dwc:country", 
                "Year" = "YearUpdated",
                "Sex" = "SexUpdated") %>%
  dplyr::select("ID", "Country", "Year","Sex", "LWingLength", "LWingWidth",
                "LBlackPatchApex", "LAnteriorSpotM3", "LPosteriorSpotCu2", 
                "RWingLength", "RWingWidth", "RBlackPatchApex","RAnteriorSpotM3", 
                "RPosteriorSpotCu2" )

#Clean "ID" 
df %>%
  dplyr::distinct(ID)

#Clean "Sex" 

df$Sex[df$Sex == "Female"] <- "female"
df$Sex[df$Sex == "F"] <- "female"
df$Sex[df$Sex == "F?"] <- "female"
df$Sex[df$Sex == "Male"] <- "male"
df$Sex[df$Sex == "M"] <- "male"
df$Sex[df$Sex == "female?"] <- "unknown"
df$Sex[df$Sex =="male?"] <- "unknown"
df$Sex[is.na(df$Sex)] <- "unknown"

#Clean "Year" 
df$Year[is.na(df$Year)] <- df$Year[is.na(df$Year)]
df$Year[df$Year == 200] <- 2000

#Clean "Country" 
df$Country<- gsub("(?i)USA|(?i)U.S.A.", "United States", df$Country)
df$Country[is.na(df$Country)] <- "United Kingdom"

#Format numerical data
df$Year <- as.numeric(df$Year)
df$LWingLength <- round(as.numeric(df$LWingLength), digits = 3)
df$LWingWidth <- round(as.numeric(df$LWingWidth), digits = 3)
df$LBlackPatchApex <- round(as.numeric(df$LBlackPatchApex),digits = 3)
df$LAnteriorSpotM3 <- round(as.numeric(df$LAnteriorSpotM3), digits = 3)
df$LPosteriorSpotCu2 <- round(as.numeric(df$LPosteriorSpotCu2), digits = 3)
df$RWingLength <- round(as.numeric(df$RWingLength), digits = 3)
df$RWingWidth <- round(as.numeric(df$RWingWidth), digits = 3)
df$RBlackPatchApex <- round(as.numeric(df$RBlackPatchApex), digits = 3)
df$RAnteriorSpotM3 <- round(as.numeric(df$RAnteriorSpotM3), digits = 3)
df$RPosteriorSpotCu2 <- round(as.numeric(df$RPosteriorSpotCu2), digits = 3)

#Remove unecessary rows 
df_na <- df %>%
  drop_na()

#Sort 
df_main <- df_na %>%
  arrange(Sex, Year, Country)

#Create finalized data
write.csv(df_main, "~/Desktop/Fall 2022/DATA 331/Final /cabbage_butterfly-main/data/main.csv", row.names = FALSE)


