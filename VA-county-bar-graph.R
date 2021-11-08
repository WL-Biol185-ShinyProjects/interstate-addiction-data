library(ggplot2)

ggplot(VAstatisticsCleaned, aes(Year, Accomack_County)) + geom_bar(stat = 'identity', fill = "#572EFD") + theme(axis.text.x= element_text(angle = 60, hjust = 1))