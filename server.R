library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)
library(readr)

drug_overdose_deaths_table <- read.table("DrugOverdoseDeathsPerState.txt", header = TRUE, sep = ",")

function(input, output) { 
  
  ouput$drug_overdose_deaths <- renderPlot({
    
    ggplot(drug_overdose_deaths_table, aes(State, Number_of_Deaths)) + geom_point()
  })
  
  }