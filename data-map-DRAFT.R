library(shiny)
library(leaflet)

# using this code as a guide - will put in our own datasets/values to make a leaflet US map
# want to map the locations of cities with these 4 drug types' usage rates
# clicking on a city's pindrop will take you to a pie chart with drug types' distributions

library(ggplot2)
fluidPage(
  titlePanel("Wine Data Table"), 
  fluidRow(
    column(2, 
           selectInput("country", 
                       "Country:", 
                       c("All",
                         unique(as.character(wine_data$country))))
    ), 
    column (6, 
            selectInput("price", 
                        "Price:", 
                        c("ALL", 
                          unique(as.character(wine_data$price))))
    ), 
    column (5, 
            selectInput("points", 
                        "Points:", 
                        c("ALL", 
                          unique(as.character(wine_data$points))))
    )
  ), 
  DT:: dataTableOutput("table")
  
)