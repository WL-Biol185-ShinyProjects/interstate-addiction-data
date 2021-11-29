library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)

CityLatLon <- read.csv("Dataset-CSV-files/CityLatLon", header = TRUE)
virginiaStatistics <- read.csv("Dataset-CSV-files/VAstatistics.csv", header = TRUE)


#function(input,output, session) {  
#  output$CityLatLon <- renderLeaflet({
#    leaflet(data = CityLatLon) %>%
#      addTiles() %>%
#      addMarkers(popup = ~place)})
  
#}

function(input, output, session) {

#I think we need to call the renderLeaflet function somewhere in this blurb
  
  output$CityLatLon <- renderLeaflet({
    
  leaflet(data = CityLatLon) %>%
    addTiles() %>%
    addMarkers(popup = ~place)

  })
  
  #data <- reactive({
   # req(input$locality_choose)
  #  df <- virginiaStatistics %>% filter(locality %in% input$locality_choose)
  #  %>% group_by(Year)})
  
 # output$plot <- renderPlot ({
  #  g <- ggplot(df, aes(y = locality, x = Year))
   # g + geom_bar(stat = "identity")
  # })
  
  output$fatalitiesPlot <- renderPlot({
    df <- virginiaStatistics[[input$location]]
    ggplot(df, aes(Year, Locality)) +
      geom_line() +
      geom_point() +
      xlab("Year") +
      ylab("Locality")
  })
  
}
