# ui.R #

library(shiny)
library(shinydashboard)

dashboardPage(skin = "purple",
  dashboardHeader(title = "Addiction Statistics", titleWidth = 600),
  dashboardSidebar(width = 300,
    
    #Define content of sidebar - options to go to different pages (US, VA, types of drugs, etc.)
    
    sidebarMenu(
      menuItem("Background", tabName = "backgroundTab", icon = icon("info")),
      menuItem("United States", tabName = "unitedstatesTab", icon = icon("map-marker-alt")),
      menuItem("Virginia", tabName = "virginiaTab", icon = icon("map-marked")),
      menuItem("Data Sources", tabName = "datasourcesTab", icon=icon("server"))
      )
    ),

  #Dashboard is created
  dashboardBody(
    tabItems(

      #First tab content - contains info about drug addiction in the United States and why we chose this topic
      tabItem(tabName = "backgroundTab",
              h2("Preliminary Information"), br(),
              h1(strong("Welcome to our drug addiction statistics project"), style = "color: #2C69D2", align = "center"),
              h3("United States Drug addiction data was compiled from . We used these data to visualize the relationships between
                 drug type and death, etc. We also used these data to hone in on these relationships specifically within the state
                 of Virginia."), br(),
      
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
))
