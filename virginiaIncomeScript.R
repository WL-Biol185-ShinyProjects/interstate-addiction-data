library(ggplot2)

source("virginiaStatisticsScript.R")

virginiaIncome <- read_csv("Dataset-CSV-files/VA Median Income by County - 2014-2018.csv", 
                                                 na = "NA")

# Make average deaths column to match average data from income dataset

virginiaStatistics$Average_Deaths <- rowMeans(virginiaStatistics[ , 9:13], na.rm = TRUE)

# Take out commas in income values

virginiaIncome$Value <- gsub(",", "", virginiaIncome$Value, fixed = TRUE)

# Combine income value column with virginiaStatistics dataset to make one dataset

vaCompleteTable <- merge(x = virginiaStatistics, y = virginiaIncome, by = "Locality", all.x = TRUE)

# example ggplot
