library(shiny)
library(shinydashboard)
library(leaflet)

CityLatLon <- read.csv("Dataset-CSV-files/CityLatLon", header = TRUE)

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
}