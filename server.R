library(leaflet)
library(ggplot2)
library(tidyr)
# library(plotly)

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

  output$overdosesByStateDeathsPlot <- renderPlot({
    df <- overdosesByState2019 %>%
      filter(stateAbbrev %in% input$stateabbrev)
    ggplot(df, aes(stateAbbrev, Deaths)) + geom_col()
    # ggplot(overdosesByState2019, aes(stateAbbrev, Deaths)) + geom_point() - other option
  })
  
  output$virginiaDeathsPlot <- renderPlot ({
    df <- vaStatisticsTidy %>%
      filter(Locality %in% input$locality)
    ggplot(df, aes(Year, Deaths, color = Locality)) + geom_point()
  })

  output$drugUseTrendsPlot <- renderPlot ({
    ggplot(diamonds, aes(x=carat, y=price)) + geom_point()
#    df <- surveyERTrendsTidy %>%
#      filter(stateAbbrev %in% input$stateabbrev)
#    ggplot(df, aes(Month, Trend)) + geom_point()

    # ggplot(surveyERTrendsTidy, aes(Month, Trend)) + geom_col() - other option
    # months need to be plotted chronologically, NOT alphabetically
  })
}
