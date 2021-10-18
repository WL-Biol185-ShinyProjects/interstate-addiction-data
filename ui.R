# ui.R #

library(shiny)
library(shinydashboard)

dashboardPage(skin = "purple",
  dashboardHeader(title = "Interstate Addiction"),

  dashboardSidebar(
    
    #Define content of sidebar - options to go to different pages (US, VA, types of drugs, etc.)
    
    sidebarMenu(
      menuItem("Background", tabName = "backgroundTab", icon = icon("info")),
      menuItem("United States", tabName = "unitedstatesTab", icon = icon("map-marker-alt")),
      menuItem("Virginia", tabName = "virginiaTab", icon = icon("map-marked")),
      menuItem("Data Sources", tabName = "datasourcesTab", icon=icon("server"))
      )
    ),

  dashboardBody(
    tabItems(
      #First tab content
      tabItem(tabName = "backgroundTab",
              h2("Preliminary Information")),
      
      #Second tab content
      tabItem(tabName = "unitedstatesTab",
              h2("Addiction in the United States")),
      
      #Third tab content
      tabItem(tabName = "virginiaTab",
              h2("Addiction in Virginia")),
      
      #Fourth tab content
      tabItem(tabName = "datasourcesTab",
              h2("Data Sources and Further Information")))
    )
)
