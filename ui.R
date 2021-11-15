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
        h4("Our project seeks to analyze the relationships between drug use and various factors (income, location, drug type, etc.) within the United States and within the state of Virginia.", style = "font-size:25px;", align = "center"),
        br(),
        fluidRow(
          box(
            icon("prescription-bottle", class = NULL, lib = "font-awesome"),
            width = 4,
            height = 160,
            status = "primary",
            style = "font-size:20px;",
            "On average, 38% of US adults battled an illegal drug use disorder each year"),
          box(
            icon("search-dollar", class = NULL, lib = "font-awesome"),
            width = 4,
            height = 160,
            status = "primary",
            style = "font-size:20px;",
            "Drug addiction costs American society upwards of $740 billion annually in lost productivity, healthcare expenses, and crime-related expenses"),
          box(
            icon("tablets", class = NULL, lib = "font-awesome"),
            width = 4,
            height = 160,
            status = "primary",
            style = "font-size:20px;",
            "The drugs most commonly associated with overdose include: fentanyl, heroin, cocaine, opioids, and methamphetamine."),
          br(),
          fluidRow(
            box(
              title = "Types of Drugs",
              width = 4,
              solidHeader = TRUE,
              "this won't run lol"),
              #img(src = "Common-Drugs.png", height = 50, width = 50),
            box(
              title = "Drug Use Trends from xYear to xYear",
              width = 4,
              solidHeader = TRUE,
              "ggplot trend line showing increase in drug use over the last 50 years"),
            box(
              title = "% Addicts receiving treatment",
              width = 4,
              solidHeader = TRUE,
              "ggplot percent of addicts receiving treatment vs. admitted to ER?")
          )
        )
      ),

      tabItem(
        tabName = "unitedstatesTab",
        h1(strong("Addiction in the United States")),
        h4("Addiction is a common problem in several of the United States' major cities. Check out the interactive map below to see addiction trends and drug use within the United States' major cities.", style = "font-size:20px;"),
        fluidRow(
          box(
            icon = NULL,
            width = 8,
            height = 110,
            status = "primary",
            style = "font-size:16px;",
            selectInput(
              inputId = "",
              label = "Compare US cities to see which cities use different drugs the most",
              choices = c("Select a category...", "Top 5 Marijuana Use", "Top 5 Cocaine Use", "Top 5 Heroin Use", "Top 5 Meth Use"),
              selected = NULL,
              multiple = FALSE,
              selectize = FALSE,
              width = 500,
              size = NULL)
            # leafletOutput('myMap')
            )
          ),
        br(),

        # Clicking on a city's pin will show the city's drug stats to the RIGHT of the map.

        fluidRow(
          box(
            icon = NULL,
            width = 12,
            height = 110,
            status = "primary",
            style = "font-size:16px;",
            selectInput(
              inputId = "",
              label = "Compare drug use trends within each of the 50 US states",
              choices = c("Select a state...", state.name),
              multiple = FALSE,
              selectize = FALSE,
              width = 500,
              size = NULL)
          )
        ),
        br(),

        # plotOutput(), - insert ggplot line graph that shows the selected states' trend over the years.

        fluidRow(
          # ggplot point graph - hover over each states' data point to see the exact number; x-axis is state abbreviation;y-axis is number of 2019 deaths
          box(
            icon = NULL,
            width = 8,
            height = 110,
            status = "primary",
            style = "font-size:16px;",
            selectInput(
              inputId = "",
              label = "Drug-related death rates in each US state in 2019",
              choices = c("Select a state...", state.name),
              selected = NULL,
              multiple = FALSE,
              selectize = FALSE,
              width = 500,
              size = NULL)
          ),
          box(
            title = "SELECTED STATE'S drug use trends over X YEARS",
            width = 4,
            solidHeader = TRUE,
            "___ has seen a significant incr/decr/no change in drug use in the last X years")
        ),
        fluidRow(
          box(
            icon = NULL,
            width = 12,
            height = 110,
            status = "primary",
            style = "font-size:16px;",
            selectInput(
              inputId = "",
              label = "Compare each states' monthly reporting compliance rates regarding drug overdoses over the past 6 years",
              choices = c("Select a state...", state.name),
              selected = NULL,
              multiple = FALSE,
              selectize = FALSE,
              width = 500,
              size = NULL)
          )
        ),
            
          # plotOutput(), - insert ggplot - x-axis = MonthYear, y-axis = % reported
        
        h4("Survey data was sourced from the American Addiction Center, based on the percentage of drug users per city population surveyed.", style = "font-size:15px;", align = "center")
      ),
      
      tabItem(
        tabName = "virginiaTab",
        h1(strong("Addiction in Virginia")),
        fluidRow(
          box(
            plotOutput("virginiaStatisticsGraph")
          )
        )
      ),
          
      tabItem(
        tabName = "datasourcesTab",
        h1(strong("Data Sources and Further Information"))
      )
      
        # Insert VA heat tiles/chloropeth map to show all the counties
        # Counties with higher opioid death rates will be colored darker
        # Hovering over the county's outline will show you the county's number of deaths (as per the data set)

        # Infographic to the right of the heat tiles/chloropeth map

        # Insert text box with description/short info about the possible link between drug use and median income/poverty

        # Insert ggplot trend line graph comparing county income vs. opioid use/death rate - IN PROGRESS

      #tabItem(
      #  tabName = "datasourcesTab",
      #  h1(strong("Data Sources and Further Information")),
      #  h5("Virginia opioid statistics by county were sourced from https://www.vdh.virginia.gov/medical-examiner/forensic-epidemiology/"),
      #  h5("Virginia median household income data was sourced from https://fred.stlouisfed.org/release/tables?eid=268980&rid=175"),
      #  h5("States' drug overdose reporting rates and quality levels data was sourced from https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm"),
      #  h5("States' total drug overdose deaths from 2019 were sourced from https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm"),
      #  h5("Data regarding the surveillance of emergency room visits involving drug overdoses was sourced from https://www.cdc.gov/drugoverdose/nonfatal/all-drugs.html"),
      # h5("Data regarding provisional drug overdose death counts was sourced from https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm"),
      #  h5("Overdose-related deaths from 1999 to 2019 were sourced from https://www.drugabuse.gov/drug-topics/trends-statistics/overdose-death-rates"),
      #  h5("Major cities' substance use estimates were sourced from https://americanaddictioncenters.org/learn/substance-abuse-by-city/"))
    )
  )
)