library(tidyverse)

# Read all data CSVs.

overdosesByState2019 <- read.csv("Dataset-CSV-files/2019 Drug Overdose Deaths Per State.csv", header = TRUE)
cityLatLon <- read.csv("Dataset-CSV-files/CityLatLon.csv", header = TRUE)
overdoseDeathsByState <- read.csv("Dataset-CSV-files/Drug_Overdose_Deaths_Per_State.csv", header = TRUE)
reportingRates <- read.csv("Dataset-CSV-files/Reporting Rates and Quality Per State.csv", header = TRUE)
substanceUseEstimatesByCity <- read.csv("Dataset-CSV-files/Substance use estimates by city.csv", header = TRUE)
surveillanceTrends <- read.csv("Dataset-CSV-files/Surveillance of ER Visit Trends for Overdose Per State.csv", header = TRUE)
virginiaIncome <- read.csv("Dataset-CSV-files/VA Median Income by County - 2014-2018.csv", header = TRUE)
virginiaStatistics <- read.csv("Dataset-CSV-files/VAstatistics.csv", header = TRUE, na.strings = "**")
VSRRDeathCounts <- read.csv("Dataset-CSV-files/VSRR_Provisional_Drug_Overdose_Death_Counts.csv", header = TRUE)

# Overdoses by state 2019 wrangling

# Overdose deaths by state wrangling

# Reporting rates by state wrangling

# Substance use estimates by city wrangling

  # Top five substances wrangling (in descending order).

marijuanaTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimates$Marijuana),][1:5,]
cocaineTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimates$Cocaine),][1:5,]
heroinTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimates$Heroin),][1:5,]
methTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimates$Meth),][1:5,]

  # Since lat/lon is not in the substances data we need to merge it with the cityLatLon data.

marijuanaLatLon <- merge(marijuanaTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
cocaineLatLon <- merge(cocaineTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
heroinLatLon <- merge(heroinTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
methLatLon <- merge(methTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))

# Surveillance trends (ER) wrangling
  
# Virginia income wrangling
  
# Virginia statistics wrangling

vaStatisticsTidy <- gather(virginiaStatistics, key = "Year", value = "Deaths", 2:17)
vaStatisticsTidy$Year <- gsub("X", "", vaStatisticsTidy$Year, fixed = TRUE)

#VSRR provisional drug overdose death counts wrangling

#VSRR 