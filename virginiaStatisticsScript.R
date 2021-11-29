library(tidyverse)

virginiaStatistics <- read.csv("Dataset-CSV-files/VAstatistics.csv", header = TRUE, na.strings = "**")

vaStatisticsTidy <- gather(virginiaStatistics,
       key = "Year",
       value = "Deaths",
       2:17)

vaStatisticsTidy$Year <- gsub("X", "", vaStatisticsTidy$Year, fixed = TRUE)


