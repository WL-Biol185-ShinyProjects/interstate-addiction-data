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
      leaflet(data = cityLatLon) %>%
        addTiles() %>%
        addMarkers(popup = ~place)
    }
    else if (input$topFiveCategory == "Top 5 Marijuana Use") {
      marijuanaLabels <- lapply(
        seq(nrow(marijuanaLatLon)),
        function(i) {
          paste0('<p>', marijuanaLatLon[i, "City_State"], '</p>', '<p>', 'Marijuana: ', methLatLon[i, "Marijuana"], '</p>')
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
        )}
    
    else if (input$topFiveCategory == "Top 5 Cocaine Use") {
      cocaineLabels <- lapply(
        seq(nrow(cocaineLatLon)),
        function(i) {
          paste0('<p>', cocaineLatLon[i, "City_State"], '</p>', '<p>', 'Cocaine: ', methLatLon[i, "Cocaine"], '</p>')
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
        )}
    
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
        )}
    
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
        )}

        # label = HTML(paste0('<p>', methLatLon$City_State, '</p>', '<p>', 'Meth: ', methLatLon$Meth, '</p>')))

        # addMarkers(popup = ~City_State)
  }
  )}

  output$drugUseTrendsPlot <- renderPlot({
    # df3 <- surveyERTrendsTidy %>%
    #     filter(stateAbbrev %in% input$location) %>%
    #     filter(Month %in% input$months)

    df3 <- surveyERTrendsTidy %>% filter(surveyERTrendsTidy$stateAbbrev %in% input$location)
    ggplot(df3, aes(stateAbbrev, Trend)) + geom_point()
  })

  output$overdosesByStateDeathsPlot <- renderPlot({
    df4 <- overdosesByState2019 %>% filter(State %in% input$statename)
    ggplot(df4, aes(State, Deaths)) + geom_bar(stat = "identity", fill = "#BF347C")
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
