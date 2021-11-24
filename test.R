library(readr)
library(ggplot2)

#getwd()
surveillanceTrends <- read.csv("./Dataset-CSV-files/Surveillance of ER Visit Trends for Overdose Per State.csv")
#mean(surveillanceTrends$Jan2018_to_Jan2019, is.numeric()
#View(surveillanceTrends)
#surveillanceTrends %>% summarise_if(is.numeric, mean)

ggplot(surveillanceTrends)
#sum(surveillanceTrends$Jan2018_to_Jan2019)/nrow(surveillanceTrends)

