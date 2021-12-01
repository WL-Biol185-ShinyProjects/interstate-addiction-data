library(tidyverse)

# Load File

virginiaStatistics <- read.csv("Dataset-CSV-files/VAstatistics.csv", header = TRUE, na.strings = "**")

# Delete "Total" column and "Out of State", "Unknown", and "TOTAL" rows



# Gather data, remove X from Year column names

vaStatisticsTidy <- gather(virginiaStatistics,
       key = "Year",
       value = "Deaths",
       2:17)

vaStatisticsTidy$Year <- gsub("X", "", vaStatisticsTidy$Year, fixed = TRUE)


