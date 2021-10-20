library(readr)

ERVisits <- read_csv("Surveillance of ER Visit Trends for Overdose Per State.csv")
View(ERVisits)

OverdoseDeathCounts <- read_csv("VSRR_Provisional_Drug_Overdose_Death_Counts.csv")
View(OverdoseDeathCounts)

OverdoseDeathsByState <- read_csv("2019 Drug Overdose Deaths Per State.csv")
View(OverdoseDeathsByState)

ReportingQualityByState <- read_csv("Reporting Rates and Quality Per State.csv")
View(ReportingQualityByState)

MajorCitiesDrugUse <- read_csv("Substance use estimates by city.csv")
View(MajorCitiesDrugUse)