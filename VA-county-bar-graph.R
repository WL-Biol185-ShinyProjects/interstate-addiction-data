library(ggplot2)

ggplot(VAstatisticsCleaned, aes(Year, Charlottesville_City)) + geom_bar(stat = 'identity', fill = "#572EFD") + theme(axis.text.x= element_text(angle = 60, hjust = 1))