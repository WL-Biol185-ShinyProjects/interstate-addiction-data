# libraries used

library(leaflet)
library(ggplot2)
library(tidyr)
# library(plotly)

# files sourced

source("datasets.R")

# server function

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
    overdosesByState2019df <- overdosesByState2019 %>%
      filter(stateAbbrev %in% input$stateabbrev)
    ggplot(overdosesByState2019df, aes(stateAbbrev, Deaths)) + geom_col()
    # ggplot(overdosesByState2019df, aes(stateAbbrev, Deaths)) + geom_point() - other option
  })
  
  output$drugUseTrendsPlot <- renderPlot({
    drugUseTrendsdf <- surveyERTrendsTidy %>%
      filter(stateAbbrev %in% input$stateabbrev)
    ggplot(drugUseTrendsdf, aes(Month, Trend)) + geom_point()
  })
  
  # Virginia Graphs
  
  output$virginiaDeathsPlot <- renderPlot ({
    df <- vaStatisticsTidy %>%
      filter(Locality %in% input$locality)
    ggplot(df, aes(Year, Deaths, color = Locality)) + geom_bar(stat = "identity", fill = "#BF347C")
  })
  
  output$virginiaIncomePlot <- renderPlot ({
    df2 <- vaCompleteTable %>%
      filter(Locality %in% input$place)
    ggplot(df2, aes(Locality, Average_Deaths, fill = Income)) + geom_bar(stat = "identity") + ylab("Average Deaths (2014-2018)") + geom_text(aes(label = Income), vjust=1.6, color = "white", size=3.5)+
      theme_minimal()
    
  })

#  output$drugUseTrendsPlot <- renderPlot ({

#    ggplot(diamonds, aes(x=carat, y=price)) + geom_point()
#    df <- surveyERTrendsTidy %>%
#      filter(stateAbbrev %in% input$stateabbrev)
#    ggplot(df, aes(Month, Trend)) + geom_point()

    # ggplot(surveyERTrendsTidy, aes(Month, Trend)) + geom_col() - other option
    # months need to be plotted chronologically, NOT alphabetically
  }