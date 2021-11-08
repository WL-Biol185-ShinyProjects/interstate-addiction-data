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
      menuItem("Data Sources", tabName = "datasourcesTab", icon = icon("server"))
      )
    ),

  #Dashboard - main info and data
  dashboardBody(

    tabItems(
      #First tab content - info about drug addiction in the US and why we chose this topic

      tabItem(
        tabName = "backgroundTab",
        h1(strong("Preliminary Information")),
        h4(("Our project seeks to analyze the relationships between drug use and various factors (income, location, drug type, etc.) within the United States and within the state of Virginia."), style = "font-size:25px;", align = "center"),
        br(),
        
        fluidRow(
          box(
            icon("prescription-bottle", class = NULL, lib = "font-awesome"),
            width = 4, height = 160, status = "primary", style = "font-size:20px;",
            "On average, 38% of US adults battled an illegal drug use disorder each year"),
          box(
            icon("search-dollar", class = NULL, lib = "font-awesome"),
            width = 4, height = 160, status = "primary", style = "font-size:20px;",
            "Drug addiction costs American society upwards of $740 billion annually in lost productivity, healthcare expenses, and crime-related expenses"),
          box(
            icon("tablets", class = NULL, lib = "font-awesome"),
            width = 4, height = 160, status = "primary", style = "font-size:20px;",
            "The drugs most commonly associated with overdose include: fentanyl, heroin, cocaine, opioids, and methamphetamine."),
        
        br(),
        
        fluidRow(
          box(
            title = "Types of Drugs",
            width = 4, solidHeader = TRUE,
            "Types of drugs infographic"),
          box(
            title = "Drug Use Trends from xYear to xYear",
            width = 4, solidHeader = TRUE,
            "ggplot trend line showing increase in drug use over the last 50 years"),
          box(
            title = "% Addicts receiving treatment",
            width = 4, solidHeader = TRUE,
            "ggplot percent of addicts receiving treatment vs. admitted to ER?"))
        )
      ),

      # Second tab content - info about US cities' drug use, death rates, and other categories

      tabItem(
        tabName = "unitedstatesTab",
        h1(strong("Addiction in the United States")),
        h4("Addiction is a common problem in several of the United States' major cities. Check out the interactive map below to see
           addiction trends and drug use within the United States' major cities.", style= "font-size:20px;"),
        
        fluidRow(
          box(leafletOutput("CityLatLon"))),
        
        h4("Survey data was sourced from the American Addiction Center, based on the percentage of drug users per city population surveyed.", style = "font-size:15px;", align = "center")
        
      ),
      
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