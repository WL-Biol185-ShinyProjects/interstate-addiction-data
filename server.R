# libraries used

library(leaflet)
library(ggplot2)
library(tidyr)
library(htmltools)

# files sourced

source("datasets.R")

# server function

function(input, output, session) {
  
# Value Boxes for Front Page
  
  output$reasoning <- renderValueBox({
    valueBox(
      value = "Why addiction?",
      subtitle = "Drug addiction has become an increasingly prevalent issue in the United States and affects millions of people and families every year. Both recreational substance use and substance abuse can have detrimental affects not only on one's personal life, but also their economic, medical, and mental well-being. Drug addiction and overdoses claim thousands of Americans' lives every year, and as such, prompted us to take a further look into where drug use is the worst in the United States and what types of drugs are most common.",
      icon = icon("pills"),
      color = "purple",
      width = 500
    )
  })

  output$averageUse <- renderValueBox({
    valueBox(
      value = "38%",
      subtitle = "On average, 38% of US adults battle an illegal drug use disorder each year.",
      icon = icon("prescription-bottle"),
      color = "purple",
      width = 5
    )
  })

  output$drugCosts <- renderValueBox({
    valueBox(
      value = "$740 billion",
      subtitle = "The annual cost of drug addiction due to lost productivity, healthcare, and crime-related expenses.",
      icon = icon("search-dollar"),
      color = "purple",
      width = 5
    )
  })

  # US Graphs

  output$topFiveMap <- renderLeaflet({
    if (input$topFiveCategory == "Select a category...") {
      allCitiesLabels <- lapply(
        seq(nrow(allCities)),
        function(i) {
          paste0(
            '<b>', toupper(allCities[i, "City_State"]), '</b><br/>',
            # "<hr style=\"height:2px;color:black\">",
            'Marijuana: ', allCities[i, "Marijuana"], '%<br/>',
            'Cocaine: ', allCities[i, "Cocaine"], '%<br/>',
            'Heroin: ', allCities[i, "Heroin"], '%<br/>',
            'Meth: ', allCities[i, "Meth"], '%'
          )
        }
      )

      leaflet(data = cityLatLon) %>%
        addTiles() %>%
        addMarkers(popup = ~place)
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

  output$substanceUseGraph <- renderPlot({
    df6 <- substanceUseEstimatesByCityTidy %>%
      filter(City_State %in% input$city_state)
    ggplot(df6, aes(Drug_Type, Percent_Used)) + geom_bar(stat = "identity", fill = "#BF347C") + ylab("Percent of City Population") + xlab("Drug Type") + geom_text(aes(label = Percent_Used), vjust=1.6, color = "white", size=3.5) +
      theme_minimal()
  })

  output$drugUseTrendsPlot <- renderPlot({
    df3 <- surveyERTrendsTidy %>%
      filter(surveyERTrendsTidy$stateAbbrev %in% input$location) # %>%
      # filter(Month %in% input$months)
      ggplot(df3, aes(x=match(Month, month.abb), y=Trend)) + geom_line(aes(colour=df3$stateAbbrev)) + xlab("Month") + ylab("Trend (%)") + labs(color = "State") + scale_color_brewer(palette = "Spectral")
      # ggplot(df3, aes(stateAbbrev, Trend, color = stateAbbrev)) + geom_line(size=0.75) + xlab("State") + ylab("Trend (%)") + labs(color = "State") + scale_color_brewer(palette = "Spectral")
      # other labelling option that we originally had: + geom_point() + ylab("Trend (%)") + xlab("State")
  })

  output$overdosesByStateDeathsPlot <- renderPlot({
    df4 <- overdosesByState2019 %>%
      filter(State %in% input$statename)
    ggplot(df4, aes(State, Deaths)) + geom_bar(stat = "identity", fill = "#BF347C") + geom_text(aes(label = Deaths), vjust=1.6, color = "white", size=3.5) + theme_minimal()
  })

  output$reportingRatesPlot <- renderPlot({
   df5 <- reportingRates %>%
     filter(State %in% input$area) %>%
     filter(Month %in% input$monthOfYear)
   ggplot(df5, aes(State, Percent_with_drugs_specified, fill = Month)) + geom_bar(stat = "identity", position=position_dodge()) + geom_text(aes(label = Month), vjust=1.6, color = "white", size=3.5) + theme_minimal()
  })

# Virginia Graphs

  output$virginiaDeathsPlot <- renderPlot ({
    df <- vaStatisticsTidy %>%
      filter(Locality %in% input$locality)
    ggplot(df, aes(Year, Deaths, color = Locality)) + geom_bar(stat = "identity", fill = "#BF347C") + geom_text(aes(label = Deaths), vjust=1.6, color = "white", size=3.5) + theme_minimal()
  })

  output$virginiaIncomePlot <- renderPlot ({
    df2 <- vaCompleteTable %>%
      filter(Locality %in% input$place)
    ggplot(df2, aes(Locality, Average_Income, fill = Average_Deaths)) + geom_bar(stat = "identity") + ylab("Average Income (2014-2018)") + geom_text(aes(label = Average_Deaths), vjust=1.6, color = "white", size=3.5) + theme_minimal()
  })
}
