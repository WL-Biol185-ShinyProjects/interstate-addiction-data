# ui.R #

library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)

dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Addiction Statistics", titleWidth = 300),
  dashboardSidebar(
    width = 300,

        # Sidebar - options to go to different pages (US, VA, types of drugs, etc.)

    sidebarMenu(
      menuItem("Background", tabName = "backgroundTab", icon = icon("info")),
      menuItem("United States", tabName = "unitedstatesTab", icon = icon("map-marker-alt")),
      menuItem("Virginia", tabName = "virginiaTab", icon = icon("map-marked")),
      menuItem("Data Sources", tabName = "datasourcesTab", icon = icon("server"))
    )
  ),

  # Dashboard - main info and data

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
            width = 4,
            height = 160,
            status = "primary",
            style = "font-size:20px;",
            "On average, 38% of US adults battled an illegal drug use disorder each year"
          ),
          box(
            icon("search-dollar", class = NULL, lib = "font-awesome"),
            width = 4,
            height = 160,
            status = "primary",
            style = "font-size:20px;",
            "Drug addiction costs American society upwards of $740 billion annually in lost productivity, healthcare expenses, and crime-related expenses"
          ),
          box(
            icon("tablets", class = NULL, lib = "font-awesome"),
            width = 4,
            height = 160,
            status = "primary",
            style = "font-size:20px;",
            "The drugs most commonly associated with overdose include: fentanyl, heroin, cocaine, opioids, and methamphetamine."
          ),
          br(),
          fluidRow(
            box(
              title = "Types of Drugs",
              width = 4, solidHeader = TRUE,
              "Types of drugs infographic"
            ),
            box(
              title = "Drug Use Trends from xYear to xYear",
              width = 4,
              solidHeader = TRUE,
              "ggplot trend line showing increase in drug use over the last 50 years"
            ),
            box(
              title = "% Addicts receiving treatment",
              width = 4,
              solidHeader = TRUE,
              "ggplot percent of addicts receiving treatment vs. admitted to ER?"
            )
          )
        )
      ),

      # Second tab content - info about US cities' drug use, death rates, and other categories

      tabItem(
        tabName = "unitedstatesTab",
        h1(strong("Addiction in the United States")),
        h4("Addiction is a common problem in several of the United States' major cities. Check out the interactive map below to see addiction trends and drug use within the United States' major cities.", style= "font-size:20px;"),
        
        selectizeInput("", label = "Compare US cities to see which cities use different drugs the most",
                       choices = c("Select a category...", "Top 5 Marijuana Use", "Top 5 Cocaine Use", "Top 5 Heroin Use", "Top 5 Meth Use"),
                       selected = NULL,
                       multiple = FALSE,
                       width = 500,
                       size = NULL),
        
        #Clicking on city's pin will show city's drug stats to the right of the map
        
#        fluidRow(
#          box(
#            leafletOutput('myMap')),
          
#        ),

        selectizeInput("", label = "Compare drug use trends within each of the 50 US states",
                       choices = c("Select a state...", "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
                                   "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
                                   "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah",
                                   "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"),
                       selected = NULL,
                       multiple = FALSE,
                       width = 500,
                       size = NULL),
                       
        #Insert ggplot line graph that shows the selected (selectizeInput) states' trend over the years
        #Insert text box to the right of ggplot trend graph - shows whether state has experienced an increase, decrease, or stayed the same based on the data set values
            #Want the output to say "___ has seen a significant increase in drug use in the last 20 years"
        
        #insert dropdown for US states' death rates - ggplot

        #Insert ggplot graph using reporting rates per state data set - static graph
            #Make y-axis = years ... adjust y-axis if only using reporting data from 1 year
            #Make x-axis = percentage reported (50%, 75%, 100%)
            #Each data point can be clicked on to show the state's name and exact percentage
        
        h4("Survey data was sourced from the American Addiction Center, based on the percentage of drug users per city population surveyed.", style = "font-size:15px;", align = "center")
      ),

      # Third tab content - info about VA counties' drug use, median incomes, and other categories

      tabItem(
        tabName = "virginiaTab",
        h1(strong("Addiction in Virginia")),
        
        fluidRow(
          box(
            plotOutput("virginiaStatisticsGraph")
        )
        )
        
        #Insert VA heat tiles/chloropeth map to show all the counties
        #Counties with higher opioid death rates will be colored darker
        #Hovering over the county's outline will show you the county's number of deaths (as per the data set)
        
        #Infographic to the right of the heat tiles/chloropeth map
        
        #Insert text box with description/short info about the possible link between drug use and median income/poverty
        
        #Insert ggplot trend line graph comparing county income vs. opioid use/death rate - IN PROGRESS
        
      ),

      # Fourth tab content

      tabItem(
        tabName = "datasourcesTab",
        h1(strong("Data Sources and Further Information"))
      )
    )
  )
)
