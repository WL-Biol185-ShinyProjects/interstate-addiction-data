library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)

cityLatLon <- read.csv("Dataset-CSV-files/CityLatLon", header = TRUE)
vaStatistics <- read.csv("Dataset-CSV-files/VAstatisticsCleaned.csv", header = TRUE)
substanceUseEstimatesByCity <- read.csv("Dataset-CSV-files/Substance use estimates by city.csv", header = TRUE)


## The following gets the top five substances in descending order.

marijuanaTopFive <- substanceUseEstimates[order(-substanceUseEstimates$Marijuana),][1:5,]
cocaineTopFive <- substanceUseEstimates[order(-substanceUseEstimates$Cocaine),][1:5,]
heroinTopFive <- substanceUseEstimates[order(-substanceUseEstimates$Heroin),][1:5,]
methTopFive <- substanceUseEstimates[order(-substanceUseEstimates$Meth),][1:5,]

## Since lat/lon is not in the substances data we need to merge it with the cityLatLon data.

marijuanaLatLon <- merge(marijuanaTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
cocaineLatLon <- merge(cocaineTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
heroinLatLon <- merge(heroinTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))
methLatLon <- merge(methTopFive, cityLatLon, by.x=c("City_State"), by.y=c("place"))

function(input, output, session) {
  output$topFiveMap <- renderLeaflet({
    if (input$topFiveCategory == "Select a category...") {
      leaflet(data = cityLatLon) %>%
        addTiles() %>%
        addMarkers(popup = ~place)
    }
    else if (input$topFiveCategory == "Top 5 Marijuana Use") {
      leaflet(data = marijuanaLatLon) %>%
        addTiles() %>%
        addMarkers(popup = ~City_State)
    }
    else if (input$topFiveCategory == "Top 5 Cocaine Use") {
      leaflet(data = cocaineLatLon) %>%
        addTiles() %>%
        addMarkers(popup = ~City_State)
    }
    else if (input$topFiveCategory == "Top 5 Heroin Use") {
      leaflet(data = heroinLatLon) %>%
        addTiles() %>%
        addMarkers(popup = ~City_State)
    }
    else if (input$topFiveCategory == "Top 5 Meth Use") {
      leaflet(data = methLatLon) %>%
        addTiles() %>%
        addMarkers(popup = ~City_State)
    }
  })

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
