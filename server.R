library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)

CityLatLon <- read.csv("Dataset-CSV-files/CityLatLon", header = TRUE)
virginiaStatistics <- read.csv("Dataset-CSV-files/VAstatisticsCleaned.csv", header = TRUE)


#function(input,output, session) {  
#  output$CityLatLon <- renderLeaflet({
#    leaflet(data = CityLatLon) %>%
#      addTiles() %>%
#      addMarkers(popup = ~place)})
  
#}

function(input, output, session) {
  leaflet(data = CityLatLon) %>%
    addTiles() %>%
    addMarkers(popup = ~place)
  
  output$virginiaStatisticsGraph <- renderPlot ({
    
    ggplot(virginiaStatistics, aes(Year, Accomack_County)) + geom_bar(stat = 'identity', fill = "#572EFD") + theme(axis.text.x= element_text(angle = 60, hjust = 1))
    
  })
}
