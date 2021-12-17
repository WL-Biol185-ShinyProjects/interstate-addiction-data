library(ggplot2)
library(tidyverse)
library(tidyr)

overdosesByState2019 <- read.csv("Dataset-CSV-files/2019 Drug Overdose Deaths Per State.csv", header = TRUE)
reportingRates <- read.csv("Dataset-CSV-files/Reporting Rates and Quality Per State.csv", header = TRUE)
substanceUseEstimatesByCity <- read.csv("Dataset-CSV-files/Substance use estimates by city.csv", header = TRUE)
surveillanceTrends <- read.csv("Dataset-CSV-files/Surveillance of ER Visit Trends for Overdose Per State.csv", header = TRUE)
virginiaIncome <- read_csv("Dataset-CSV-files/VA Median Income by County - 2014-2018.csv")
virginiaStatistics <- read.csv("Dataset-CSV-files/VAstatistics.csv", header = TRUE, na.strings = "**")
VSRRDeathCounts <- read.csv("Dataset-CSV-files/VSRR_Provisional_Drug_Overdose_Death_Counts.csv", header = TRUE)

# Substance use estimates cleanup and tidying
substanceUseEstimatesByCityTidy <- gather(substanceUseEstimatesByCity, key = "Drug_Type", value = "Percent_Used", 2:5)

surveyERTrends <- read.csv("Dataset-CSV-files/Surveillance of ER Visit Trends for Overdose Per State.csv", header = TRUE, na.strings = "**")

cityLatLon <- read.csv("Dataset-CSV-files/CityLatLon", header = TRUE)
substanceUseEstimatesByCity <- read.csv("Dataset-CSV-files/Substance use estimates by city.csv", header = TRUE)

# Top five substances wrangling (in descending order)
allCities <- merge(substanceUseEstimatesByCity, cityLatLon, by.x = "City_State", by.y = "place")
marijuanaTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimatesByCity$Marijuana),][1:5,]
cocaineTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimatesByCity$Cocaine),][1:5,]
heroinTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimatesByCity$Heroin),][1:5,]
methTopFive <- substanceUseEstimatesByCity[order(-substanceUseEstimatesByCity$Meth),][1:5,]

# Since lat/lon is not in the substances data we need to merge it with the cityLatLon data
marijuanaLatLon <- merge(marijuanaTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
cocaineLatLon <- merge(cocaineTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
heroinLatLon <- merge(heroinTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
methLatLon <- merge(methTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))

# ER surveillance trends of drug use per state wrangling

# surveyERTrends <- read.csv("Dataset-CSV-files/Surveillance of ER Visit Trends for Overdose Per State.csv", header = TRUE, na.strings = "**")
surveyERTrends <- read.csv("Dataset-CSV-files/Surveillance of ER Visit Trends for Overdose Per State.csv", header = TRUE, na.strings = "**")[1:13]
# sert <- read.csv("Dataset-CSV-files/Surveillance of ER Visit Trends for Overdose Per State.csv", header = TRUE, na.strings = "**")[1:13]
surveyERTrendsTidy <- gather(surveyERTrends, key = "Month", value = "Trend", 2:13)
# surveyERTrendsTidy <- gather(surveyERTrends, key = "Month", value = "Trend", 2:16)
surveyERTrendsTidy$Month <- gsub("X", "", surveyERTrendsTidy$Month, fixed = TRUE)

# PROBLEM with these 2 lines:
# surveyERTrendsByState <- surveyERTrendsTidy[1:728] # won't establish a variable if NA is there, but need NA option for graphing
# surveyERTrendChanges <- surveyERTrendsTidy[729:780] # won't establish a variable if NA is there, but need NA option for graphing
# ggplot that plots points and connects them with a line for each state
  # x-axis: each month in chronological order, y-axis: # from 0 to max/limit
# want the text box next to this graph to be filled by dataset's last column, "change", so that it says "STATE had a sig incr/decr/no change in drug use" OR to say "STATE did not report ER visit trends for drug overdoses in this time period."
  # need to edit surveillanceTrends table

# Data wrangling for Reporting Rates

#   ggplot line graph, x-axis: monthYaer, y-axis: percentReported
#   ggplot tri-bar graph, each monthYear has %reported, %pending, and %specified
    # key/label for graph that specifies which % is which color


virginiaIncome <- read.csv("Dataset-CSV-files/VA Median Income by County - 2014-2018.csv", header = TRUE)
virginiaIncome[virginiaIncome == "NaN"] <- NA

# Virginia data


virginiaIncome <- read.csv("Dataset-CSV-files/VA Median Income by County - 2014-2018.csv", header = TRUE)
virginiaStatistics <- read.csv("Dataset-CSV-files/VAstatistics.csv", header = TRUE, na.strings = "**")
vaStatisticsTidy <- gather(virginiaStatistics, key = "Year", value = "Deaths", 2:17)
vaStatisticsTidy$Year <- gsub("X", "", vaStatisticsTidy$Year, fixed = TRUE)

# VSRR drug overdose death counts data

VSRR_Provisional_Drug_Overdose_Death_Counts <- read.csv("Dataset-CSV-files/VSRR_Provisional_Drug_Overdose_Death_Counts.csv", header = TRUE)
# dropVSRR <- c("Period","Percent.Complete","Percent.Pending.Investigation","State.Name","Footnote","Footnote.Symbol") %>%
#    VSRR_edited <- VSRRDeathCounts[,!(names(VSRRDeathCounts) %in% dropVSRR)]

#VSRRedited <- VSRR_Provisional_Drug_Overdose_Death_Counts %>%
#  VSRRdeaths <- VSRRedited[!(VSRRedited$Name=="Psychostimulants with abuse potential (T43.6)" | VSRRedited$Name=="Percent with drugs specified"),]
  # need stateAbbrev to be strings, and need to make a ggplot that plots points and connects them with a line for each state
  # want the text box next to this graph to be filled by dataset's last column, "change", so that it says "STATE had a sig incr/decr/no change in drug use"
  # x-axis: each month
  # y-axis: #, just a ylin from 0 to ymax
  # some states didn't report ER trends data - when that state is selected, have empty graph and text box to the right that says "STATE did not report ER surveillance trends of drug use for this time period."
  
# Virginia statistics wrangling

virginiaStatistics$Total <- NULL
vaStatisticsTidy <- gather(virginiaStatistics, key = "Year", value = "Deaths", 2:16)
vaStatisticsTidy$Year <- gsub("X", "", vaStatisticsTidy$Year, fixed = TRUE)

# Virginia statistics wrangling for use with income dataset

virginiaStatistics$Average_Deaths <- rowMeans(virginiaStatistics[ , 9:13], na.rm = TRUE)
virginiaIncome$Average_Income <- gsub(",", "", virginiaIncome$Average_Income, fixed = TRUE)


vaCompleteTable <- merge(x = virginiaStatistics, y = virginiaIncome, by = "Locality", all.x = TRUE)
vaCompleteTable[vaCompleteTable == "NaN"] <- NA

#VSRR provisional drug overdose death counts wrangling
  # csv too large to open inside RStudio - need to look at it in Excel

