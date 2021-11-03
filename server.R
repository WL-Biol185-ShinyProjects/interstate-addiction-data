library(shiny)
library(shinydashboard)

read.csv(CityLatLon, "rt")

function(input,output, session) {  
  output$CityLatLon <- renderLeaflet({
    leaflet(data = CityLatLon) %>%
      addTiles() %>%
      addMarkers(popup = ~place)})
  
}