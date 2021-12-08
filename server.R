# libraries used

library(leaflet)
library(ggplot2)
library(tidyr)
library(htmltools)
# library(plotly)

# files sourced

source("datasets.R")

# server function

function(input, output, session) {
  output$topFiveMap <- renderLeaflet({
    if (input$topFiveCategory == "Select a category...") {
#      mainMapLabels <- lapply(
#        seq(nrow(cityLatLon)),
#        function(i) {
#          paste0('<p>', cityLatLon[i, "City_State"], '</p>', '<p>', 'All Drugs: ', cityLatLon[i, "All Drugs"], '</p>')
#        }
#      )
# trying to make it like the Top 5 selections, where clicking on the marker will show you a text box saying "All Drugs: Marijuana: %, Cocaine: %, etc."
      
      leaflet(data = cityLatLon) %>%
        addTiles() %>%
        addMarkers(
#          lng = ~lon,
#          lat = ~lat,
          popup = ~place
#          label = lapply(mainMapLabels, htmltools::HTML)
        )
    }
    
    else if (input$topFiveCategory == "Top 5 Marijuana Use") {
      marijuanaLabels <- lapply(
        seq(nrow(marijuanaLatLon)),
        function(i) {
          paste0('<p>', marijuanaLatLon[i, "City_State"], '</p>', '<p>', 'Marijuana: ', marijuanaLatLon[i, "Marijuana"], '</p>')
        }
      )

      leaflet(data = marijuanaLatLon) %>%
        addTiles() %>%
        addCircles(
          lng = ~lon,
          lat = ~lat,
          fillColor = 'darkBlue',
          radius = 25000,
          stroke = FALSE,
          fillOpacity = 0.8,
          label = lapply(marijuanaLabels, htmltools::HTML)
        )
    }
    else if (input$topFiveCategory == "Top 5 Cocaine Use") {
      cocaineLabels <- lapply(
        seq(nrow(cocaineLatLon)),
        function(i) {
          paste0('<p>', cocaineLatLon[i, "City_State"], '</p>', '<p>', 'Cocaine: ', cocaineLatLon[i, "Cocaine"], '</p>')
        }
      )

      leaflet(data = cocaineLatLon) %>%
        addTiles() %>%
        addCircles(
          lng = ~lon,
          lat = ~lat,
          fillColor = 'darkBlue',
          radius = 25000,
          stroke = FALSE,
          fillOpacity = 0.8,
          label = lapply(cocaineLabels, htmltools::HTML)
        )
    }
    else if (input$topFiveCategory == "Top 5 Heroin Use") {
      heroinLabels <- lapply(
        seq(nrow(heroinLatLon)),
        function(i) {
          paste0('<p>', heroinLatLon[i, "City_State"], '</p>', '<p>', 'Heroin: ', heroinLatLon[i, "Heroin"], '</p>')
        }
      )

      leaflet(data = heroinLatLon) %>%
        addTiles() %>%
        addCircles(
          lng = ~lon,
          lat = ~lat,
          fillColor = 'darkBlue',
          radius = 25000,
          stroke = FALSE,
          fillOpacity = 0.8,
          label = lapply(heroinLabels, htmltools::HTML)
        )
    }
    else if (input$topFiveCategory == "Top 5 Meth Use") {
      methLabels <- lapply(
        seq(nrow(methLatLon)),
        function(i) {
          paste0('<p>', methLatLon[i, "City_State"], '</p>', '<p>', 'Meth: ', methLatLon[i, "Meth"], '</p>')
        }
      )

      leaflet(data = methLatLon) %>%
        addTiles() %>%
        addCircles(
          lng = ~lon,
          lat = ~lat,
          fillColor = 'darkBlue',
          radius = 25000,
          stroke = FALSE,
          fillOpacity = 0.8,
          label = lapply(methLabels, htmltools::HTML)
        )
    }
  })

  output$drugUseTrendsPlot <- renderPlot({
    # df3 <- surveyERTrendsTidy %>%
    #     filter(stateAbbrev %in% input$location) %>%
    #     filter(Month %in% input$months)
    # ggplot(surveyERTrendsTidy, aes(Month, Trend)) + geom_point or geom_col
    # plot months chronologically, not alphabetically

    df3 <- surveyERTrendsTidy %>%
      filter(surveyERTrendsTidy$stateAbbrev %in% input$location) %>%
      filter(Month %in% input$months)
    ggplot(df3, aes(stateAbbrev, Trend, color = Month)) + geom_point()
  })
  
  output$overdosesByStateDeathsPlot <- renderPlot({
    df4 <- overdosesByState2019 %>%
      filter(State %in% input$statename)
    ggplot(df4, aes(State, Deaths)) + geom_bar(stat = "identity", fill = "#BF347C") + geom_text(aes(label = Deaths), vjust=1.6, color = "white", size=3.5) + theme_minimal()
  })

# other option - ggplot + geom_point()

  output$reportingRatesPlot <- renderPlot({
   df5 <- reportingRates %>%
     filter(State %in% input$area) %>%
     filter(Month %in% input$monthOfYear)
   ggplot(df5, aes(State, Percent_with_drugs_specified, fill = Month)) + geom_bar(stat = "identity", position=position_dodge()) + geom_text(aes(label = Month), vjust=1.6, color = "white", size=3.5)+
     theme_minimal()
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
  
}
