library(ggplot2)
library(tidyverse)
library(tidyr)

overdosesByState2019 <- read.csv("Dataset-CSV-files/2019 Drug Overdose Deaths Per State.csv", header = TRUE)
#   x-axis: stateAbbrev, y-axis: Deaths
#   ggplot(overdosesByState2019, aes(stateAbbrev, Deaths)) + geom_point()

cityLatLon <- read.csv("Dataset-CSV-files/CityLatLon", header = TRUE)
substanceUseEstimatesByCity <- read.csv("Dataset-CSV-files/Substance use estimates by city.csv", header = TRUE)

# Top five substances wrangling (in descending order).
marijuanaTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimatesByCity$Marijuana),][1:5,]
cocaineTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimatesByCity$Cocaine),][1:5,]
heroinTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimatesByCity$Heroin),][1:5,]
methTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimatesByCity$Meth),][1:5,]

# Since lat/lon is not in the substances data we need to merge it with the cityLatLon data.
marijuanaLatLon <- merge(marijuanaTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
cocaineLatLon <- merge(cocaineTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
heroinLatLon <- merge(heroinTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
methLatLon <- merge(methTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))

surveyERTrends <- read.csv("Dataset-CSV-files/Surveillance of ER Visit Trends for Overdose Per State.csv", header = TRUE, na.strings = "**")

# Surveillance trends (ER) of drug use per state wrangling

surveyERTrendsTidy <- gather(surveyERTrends, key = "Month", value = "Trend", 2:16)
surveyERTrendsTidy$Month <- gsub("X", "", surveyERTrendsTidy$Month, fixed = TRUE)

# PROBLEM with these 2 lines:
# surveyERTrendsByState <- surveyERTrendsTidy[1:728] # won't establish a variable if NA is there, but need NA option for graphing
# surveyERTrendChanges <- surveyERTrendsTidy[729:780] # won't establish a variable if NA is there, but need NA option for graphing
# ggplot that plots points and connects them with a line for each state
  # x-axis: each month in chronological order, y-axis: # from 0 to max/limit
# want the text box next to this graph to be filled by dataset's last column, "change", so that it says "STATE had a sig incr/decr/no change in drug use" OR to say "STATE did not report ER visit trends for drug overdoses in this time period."

reportingRates <- read.csv("Dataset-CSV-files/Reporting Rates and Quality Per State.csv", header = TRUE)
#   ggplot line graph, x-axis: monthYaer, y-axis: percentReported
#   ggplot tri-bar graph, each monthYear has %reported, %pending, and %specified
    # key/label for graph that specifies which % is which color

virginiaIncome <- read.csv("Dataset-CSV-files/VA Median Income by County - 2014-2018.csv", header = TRUE)

virginiaStatistics <- read.csv("Dataset-CSV-files/VAstatistics.csv", header = TRUE, na.strings = "**")
vaStatisticsTidy <- gather(virginiaStatistics, key = "Year", value = "Deaths", 2:17)
vaStatisticsTidy$Year <- gsub("X", "", vaStatisticsTidy$Year, fixed = TRUE)

VSRR_Provisional_Drug_Overdose_Death_Counts <- read.csv("Dataset-CSV-files/VSRR_Provisional_Drug_Overdose_Death_Counts.csv", header = TRUE)
# dropVSRR <- c("Period","Percent.Complete","Percent.Pending.Investigation","State.Name","Footnote","Footnote.Symbol") %>%
#    VSRR_edited <- VSRRDeathCounts[,!(names(VSRRDeathCounts) %in% dropVSRR)]

#VSRRedited <- VSRR_Provisional_Drug_Overdose_Death_Counts %>%
#  VSRRdeaths <- VSRRedited[!(VSRRedited$Name=="Psychostimulants with abuse potential (T43.6)" | VSRRedited$Name=="Percent with drugs specified"),]
