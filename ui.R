# ui.R #

library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "Interstate Addiction"),

  dashboardSidebar(
    
    #Define content of sidebar - options to go to different pages (US, VA, types of drugs, etc.)
    
    sidebarMenu(
      menuItem("Background", tabName = "Background", icon = icon("dashboard")),
      menuItem("United States", tabName = "United States", icon = icon("dashboard")),
      menuItem("Virginia", tabName = "Virginia", icon = icon("dashboard")),
      menuItem("Data Sources", tabName = "Data Sources", icon = icon("dashboard"))
      )
    ),

  dashboardBody(
    tabItems(
      tabItem(tabName = "Background",
              h2("Preliminary Information")),
      
      tabItem(tabName = "United States",
              h2("Addiction in the United States")),
      
      tabItem(tabName = "Virginia",
              h2("Addiction in Virginia")),
      
      tabItem(tabName = "Data Sources",
              h2("Data Sources and Further Information"))
      )
    )
)
