# ui.R #

library(shiny)
library(shinydashboard)
library(leaflet)


dashboardPage(skin = "purple",

  dashboardHeader(title = "Addiction Statistics", titleWidth = 300),
  dashboardSidebar(width = 300,
                   
    #Sidebar - options to go to different pages (US, VA, types of drugs, etc.)
    
    sidebarMenu(
      menuItem("Background", tabName = "backgroundTab", icon = icon("info")),
      menuItem("United States", tabName = "unitedstatesTab", icon = icon("map-marker-alt")),
      menuItem("Virginia", tabName = "virginiaTab", icon = icon("map-marked")),
      menuItem("Data Sources", tabName = "datasourcesTab", icon=icon("server"))
      )
    ),

  #Dashboard - main info and data
  dashboardBody(

    tabItems(
      #First tab content - info about drug addiction in the US and why we chose this topic

      tabItem(
        tabName = "backgroundTab",
        h1(strong("Preliminary Information")),
        br(),
        h1(strong("Welcome to our drug addiction statistics project"), style = "color: #2C69D2", align = "center"),
        br(),
        h4(("United States Drug addiction data was compiled from -. We used these datasets to visualize the relationships between"), align = "center"),
        br()
      ),

      # Second tab content - info about US cities' drug use, death rates, and other categories

      tabItem(
        tabName = "unitedstatesTab",
        h1(strong("Addiction in the United States"))),

      
      # Third tab content - info about VA counties' drug use, median incomes, and other categories

      tabItem(
        tabName = "virginiaTab",
        h1(strong("Addiction in Virginia"))
      ),

      # Fourth tab content

      tabItem(
        tabName = "datasourcesTab",
        h1(strong("Data Sources and Further Information"))
      )
    )
  )
)