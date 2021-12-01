library(tidyverse)
library(ggplot2)

# Read all data CSVs.

overdosesByState2019 <- read.csv("Dataset-CSV-files/2019 Drug Overdose Deaths Per State.csv", header = TRUE)
cityLatLon <- read.csv("Dataset-CSV-files/CityLatLon", header = TRUE)
# reportingRates <- read.csv("Dataset-CSV-files/Reporting Rates and Quality Per State.csv", header = TRUE)
# stateDrugUseTrends <- read.csv("Dataset-CSV-files/State Drug Use Trends.csv", header = TRUE)
substanceUseEstimatesByCity <- read.csv("Dataset-CSV-files/Substance use estimates by city.csv", header = TRUE)
surveyERTrends <- read.csv("Dataset-CSV-files/Surveillance of ER Visit Trends for Overdose Per State.csv", header = TRUE, na.strings = "**")
virginiaIncome <- read.csv("Dataset-CSV-files/VA Median Income by County - 2014-2018.csv", header = TRUE)
virginiaStatistics <- read.csv("Dataset-CSV-files/VAstatistics.csv", header = TRUE, na.strings = "**")
VSRRDeathCounts <- read.csv("Dataset-CSV-files/VSRR_Provisional_Drug_Overdose_Death_Counts.csv", header = TRUE)

# Overdoses by state 2019 wrangling
  # x-axis: state.abbrev
  # y-axis: # of deaths, just a ylim from 0 to y-max
  # ggplot(overdosesByState2019, aes(stateAbbrev, Deaths)) + geom_point()

# Overdose deaths by state wrangling

# Reporting rates by state wrangling
  # too many rows to manunally edit csv file
  # need to make the rows just: State,MonthYear,percentComplete,percentPending,percentSpecified,stateName
  # need to delete the New York City rows - KEEP New York STATE rows
  # there are United States (US) rows - KEEP these, make it an option in the dropdown to include United States
  # x-axis: monthYear
  # y-axis: percentReported
  # want to make a ggplot bar graph next to the one above, where each monthYear has 3 bars for %reported, %pending, and %specified
    # need to make a key on the graph that tells you which color is which %
    # x-axis: monthYear
    # y-axis: percent, at 5% increments

# Substance use estimates by city wrangling

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

# Surveillance trends (ER) of drug use per state wrangling

surveyERTrendsTidy <- gather(surveyERTrends, key = "Month", value = "Trend", 2:16)
surveyERTrendsTidy$Month <- gsub("X", "", surveyERTrendsTidy$Month, fixed = TRUE)
# surveyERTrendsByState <- surveyERTrendsTidy[1:728] - won't establish a variable if NA is there, but need NA option for graphing
# surveyERTrendChanges <- surveyERTrendsTidy[729:780] - won't establish a variable if NA is there, but need NA option for graphing

  # ggplot that plots points and connects them with a line for each state
  # want the text box next to this graph to be filled by dataset's last column, "change", so that it says "STATE had a sig incr/decr/no change in drug use"
  # want each x-axis point to be a month - gather those columns into one variable name? but keep numbers distinct
  # x-axis: each month
  # y-axis: #, just a ylin from 0 to ymax
  # some states didn't report ER trends data - when that state is selected, have empty graph and text box to the right that says "STATE did not report ER surveillance trends of drug use for this time period."
  
# Virginia income wrangling
  
# Virginia statistics wrangling

vaStatisticsTidy <- gather(virginiaStatistics, key = "Year", value = "Deaths", 2:17)
vaStatisticsTidy$Year <- gsub("X", "", vaStatisticsTidy$Year, fixed = TRUE)

#VSRR provisional drug overdose death counts wrangling
  # csv too large to open inside RStudio - need to look at it in Excel
