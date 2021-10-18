# ui.R #

library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "Interstate Addiction"),

  dashboardSidebar(
    
    #Define content of sidebar - options to go to different pages (US, VA, types of drugs, etc.)
    
    sidebarMenu(
      menuItem("Background", tabName = "Background", icon = icon("Background")),
      menuItem("United States", tabName = "United States", icon = icon("United States")),
      menuItem("Virginia", tabName = "Virginia", icon = icon("Virginia")),
      menuItem("Data Sources", tabName = "Data Sources", icon=icon("Data Sources"))
      )
    ),

  dashboardBody(
    tabItems(
      
      #First tab content
      tabItem(tabName = "Background",
              h1("Preliminary Information")),
      
      #Second tab content
      tabItem(tabName = "United States",
              h2("Addiction in the United States")),
      
      #Third tab content
      tabItem(tabName = "Virginia",
              h3("Addiction in Virginia")),
      
      #Fourth tab content
      tabItem(tabName = "Data Sources",
              h4("Data Sources and Further Information")))
    )
)