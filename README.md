# Cabbage_Butterfly
<div align = "center">
<img src = "https://github.com/vieta302/Cabbage-Butterfly/blob/main/Types-of-Butterfly.jpeg" width = "450")>
</div>

## It's Coming Home Team Members:
Viet Anh Nguyen, Houssam Hallouch, Dawit Tadele

---
## Data Prep 
I. Choosing columns and renaming them
```
df <- df_raw %>%
  dplyr::rename("ID" = "coreid",
                "Country" = "dwc:country", 
                "Year" = "YearUpdated",
                "Sex" = "SexUpdated") %>%
  dplyr::select("ID", "Country", "Year","Sex", "LWingLength", "LWingWidth",
                "LBlackPatchApex", "LAnteriorSpotM3", "LPosteriorSpotCu2", 
                "RWingLength", "RWingWidth", "RBlackPatchApex","RAnteriorSpotM3", 
                "RPosteriorSpotCu2" )
```

II. Tidy Data
1. Clean "ID"" (removing duplicates):
```
df %>%
  dplyr::distinct(ID)
```

2. Clean "Sex" (return "unknown" if left blanked and if have "?", unify format)
```
df$Sex[df$Sex == "female"] <- "Female"
df$Sex[df$Sex == "F"] <- "Female"
df$Sex[df$Sex == "male"] <- "Male"
df$Sex[df$Sex == "M"] <- "Male"
df$Sex[df$Sex == "F?"] <- "unknown"
df$Sex[df$Sex == "female?"] <- "unknown"
df$Sex[df$Sex =="male?"] <- "unknown"
df$Sex[is.na(df$Sex)] <- "unknown"
```

3. Clean "Year" (There was a typo in one row)
```
df$Year[df$Year == 200] <- 2000
```

4. Clean "Country" (Unify format and manually fill in the blank row after looking at its' locality)
```
df$Country<- gsub("(?i)USA|(?i)U.S.A.", "United States", df$Country)
df$Country[is.na(df$Country)] <- "United Kingdom"
```

5. Format numerical data (change all to numeric data, roundup to third decimal)
```
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
```

6. Remove unnecessary data (Rows with N/A value)
```
df_na <- df %>%
  drop_na()
```

7. Sort data for easier viewing 
```
df_main <- df_na %>%
  arrange(Sex, Year, Country)
```

8. Create finalized data file 
```
write.csv(df_main, "~/Desktop/Fall 2022/DATA 331/Final /cabbage_butterfly-main/data/main.csv", row.names = FALSE)

```

---
## Visualizations
I. Wing Length/Width by Country 
- The bar chart illustrates the average length of both right/left wings in each country.
- From the graph, it is apparent that averages from the America region are slightly higher than European countries.

<div align = "center">
<img src = "https://github.com/vieta302/Cabbage-Butterfly/blob/main/Graphs%20/Wing%20Length:Width%20by%20Country.png" width = "600")>
</div>

II. Wing Length/Width by Sex
- We uses Descriptive Statistics in order to calculate the wings' length/width in terms of their maximum value, minimum value, average and median.
- Based on the charts, we can conclude that both sex shares similar wing's length/width.

<div align = "center">
<img src = "https://github.com/vieta302/Cabbage-Butterfly/blob/main/Graphs%20/Wing%20Length:Width%20by%20Sex.png" width = "600")>
</div>

III. Total number of Butterflies for each decade
*Prep: We first have to group the years by decades.
```
df$Year <-substring(df$Year, 1,3)
df$Year <- paste(df$Year, "0s", sep = "")

df_final <- df %>%
  count(Year)
```
- 
<div align = "center">
<img src = "https://github.com/vieta302/Cabbage-Butterfly/blob/main/Graphs%20/Wing%20Length:Width%20by%20Sex.png" width = "800")>
</div>








