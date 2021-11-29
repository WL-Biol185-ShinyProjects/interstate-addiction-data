library(lubridate)
library(tidyverse)

virginiaStatistics <- read.csv("Dataset-CSV-files/VAstatistics.csv", header = TRUE, na.strings = "**")

tables <- lapply(virginiaStatistics, function(table) {

names(virginiaStatistics) <- lapply(virginiaStatistics[1, ], as.character)


tidyTable <- gather(virginiaStatistics[1:16],
                    key = "year",
                    value = "deaths",
                    2:16) %>%
            rename(Locality = "Locality")
            filter(!is.na(deaths)) %>%
            mutate(Year = as.numeric(year)) %>%
            select(-(year))

tidyTable <- tidyTable %>%
  mutate(fatalities = as.numeric(deaths)) %>%
  select(-(deaths))

tidyTable
}
)

table1 <- tables[[1]]