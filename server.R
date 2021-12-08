# libraries used

library(leaflet)
library(ggplot2)
library(tidyr)
# library(plotly)

# files sourced

source("datasets.R")

# server function

function(input, output, session) {
  
  # Value Boxes for Front Page
  
  output$averageUse <- renderValueBox({
    valueBox(value = "38%",
             subtitle = "On average, 38% of US adults battle an illegal drug use disorder each year.",
             icon = icon("prescription-bottle"),
             color = "purple",
             width = 5)
  })
  
  output$drugCosts <- renderValueBox({
    valueBox(value = "$740 billion",
             subtitle = "The annual cost of drug addiction due to lost productivity, healthcare, and crime-related expenses.",
             icon = icon("search-dollar"),
             color = "purple",
             width = 5)
  })
  
  # US Graphs
  
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
      filter(stateAbbrev %in% input$location) %>%
      filter(Month %in% input$months)
    ggplot(df3, aes(stateAbbrev, Trend, color = Month)) + geom_point() + ylab("Trend (%)") + xlab("State")
  })
  
  output$overdosesByStateDeathsPlot <- renderPlot({
    df4 <- overdosesByState2019 %>%
      filter(State %in% input$statename)
    ggplot(df4, aes(State, Deaths)) + geom_bar(stat = "identity", fill = "#34568b") + geom_text(aes(label = Deaths), vjust=1.6, color = "white", size=3.5) +
      theme_minimal()
# other option - ggplot + geom_point()
  })
  
  output$reportingRatesPlot <- renderPlot({
   df5 <- reportingRates %>%
     filter(State %in% input$area) %>%
     filter(Month %in% input$monthOfYear)
   ggplot(df5, aes(State, Percent_with_drugs_specified, fill = Month)) + geom_bar(stat = "identity", position=position_dodge()) + geom_text(aes(label = Month), vjust=1.6, color = "white", size=3.5)+
     theme_minimal()
  })
  
  output$substanceUseGraph <- renderPlot({
    df6 <- substanceUseEstimatesByCityTidy %>%
      filter(City_State %in% input$city_state)
    ggplot(df6, aes(Drug_Type, Percent_Used)) + geom_bar(stat = "identity", fill = "#BF347C") + ylab("Percent of City Population") + xlab("Drug Type") + geom_text(aes(label = Percent_Used), vjust=1.6, color = "white", size=3.5) +
      theme_minimal()
  })
  
  # Virginia Graphs
  
  output$virginiaDeathsPlot <- renderPlot ({
    df <- vaStatisticsTidy %>%
      filter(Locality %in% input$locality)
    ggplot(df, aes(Year, Deaths, color = Locality)) + geom_bar(stat = "identity", fill = "#BF347C") + geom_text(aes(label = Deaths), vjust=1.6, color = "white", size=3.5) +
      theme_minimal()
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
