#library(readr)
#library(ggplot2)

#getwd()
#surveillanceTrends <- read.csv("./Dataset-CSV-files/Surveillance of ER Visit Trends for Overdose Per State.csv")
#mean(surveillanceTrends$Jan2018_to_Jan2019, is.numeric()
#View(surveillanceTrends)
#surveillanceTrends %>% summarise_if(is.numeric, mean)

#ggplot(surveillanceTrends)
#sum(surveillanceTrends$Jan2018_to_Jan2019)/nrow(surveillanceTrends)

# NOT RUN {
## Only run examples in interactive R sessions
if (interactive()) {
  
  # basic example
  shinyApp(
    ui = fluidPage(
      selectInput("variable", "Variable:",
                  c("Cylinders" = "cyl",
                    "Transmission" = "am",
                    "Gears" = "gear")),
      tableOutput("data")
    ),
    server = function(input, output) {
      output$data <- renderTable({
        mtcars[, c("mpg", input$variable), drop = FALSE]
      }, rownames = TRUE)
    }
  )
  
  # demoing group support in the `choices` arg
  shinyApp(
    ui = fluidPage(
      selectInput("state", "Choose a state:",
                  list(`East Coast` = list("NY", "NJ", "CT"),
                       `West Coast` = list("WA", "OR", "CA"),
                       `Midwest` = list("MN", "WI", "IA"))
      ),
      textOutput("result")
    ),
    server = function(input, output) {
      output$result <- renderText({
        paste("You chose", input$state)
      })
    }
  )
}

# }
