library(leaflet)
library(ggplot2)

source("datasets.R")

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

  # I think we need to call the renderLeaflet function somewhere in this blurb.

  output$virginiaDeathsPlot <- renderPlot ({
    df <- vaStatisticsTidy %>%
      filter(Locality %in% input$locality)
    ggplot(df, aes(Year, Deaths, color = Locality)) + geom_point()
  })
}
