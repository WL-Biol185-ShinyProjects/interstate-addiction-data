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

  output$drugUseTrendsPlot <- renderPlot({
    df3 <- surveyERTrendsTidy %>%
      filter(stateAbbrev %in% input$location)
      filter(Month %in% input$months)
    ggplot(df3, aes(State, Trend)) + geom_point()
  })

  output$overdosesByStateDeathsPlot <- renderPlot({
    df4 <- overdosesByState2019 %>%
      filter(State %in% input$statename)
    ggplot(df4, aes(State, Deaths)) + geom_col()
# other option - ggplot + geom_point()
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
    ggplot(df2, aes(Locality, Average_Income, fill = Average_Deaths)) + geom_bar(stat = "identity") + ylab("Average Income (2014-2018)") + geom_text(aes(label = Average_Deaths), vjust=1.6, color = "white", size=3.5)+
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
