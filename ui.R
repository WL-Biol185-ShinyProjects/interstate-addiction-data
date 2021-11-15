# ui.R #

library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)

virginiaStatistics <- read.csv("Dataset-CSV-files/VAstatisticsCleaned.csv", header = TRUE)

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
              width = 4,
              solidHeader = TRUE,
              "can't run this code when I delete this text lol"
            #  img(src = "Common-Drugs.png", height = 50, width = 50),
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
              width = 500
              # size = NULL
            )
          )
        ),
        # leafletOutput('myMap'))),
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
              width = 500
              # size = NULL
            )
          )
        ),
        br(),

        # plotOutput(), - insert ggplot line graph that shows the selected states' trend over the years.

        fluidRow(
          # ggplot point graph - hover over each states' data point to see the exact number; x-axis is state abbreviation;
          # y-axis is # 2019 deaths.

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
              width = 500
              # size = NULL
            )
          ),
          box(
            title = "SELECTED STATE'S drug use trends over X YEARS",
            width = 4,
            solidHeader = TRUE,
            "___ has seen a significant incr/decr/no change in drug use in the last X years"
          )
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
              width = 500
              # size = NULL
            )
          )

          # plotOutput(), - insert ggplot - x-axis = MonthYear, y-axis = % reported
        ),
        h4("Survey data was sourced from the American Addiction Center, based on the percentage of drug users per city population surveyed.", style = "font-size:15px;", align = "center")
      ),

      # Third tab content - info about VA counties' drug use, median incomes, and other categories

      tabItem(
        tabName = "virginiaTab",
        h1(strong("Addiction in Virginia")),
        fluidRow(
          box(
            selectInput("locality", label = "Select a VA locality to view the number of opioid deaths per year",
                           choices = c("Select a locality...", "Accomack County", "Albemarle County", "Alexandria City", "Alleghany County", "Amelia County", "Amherst County", "Appomattox County", "Arlington County", 
                                       "Augusta County", "Bath County", "Bedford City", "Bedford County", "Bland County", "Botetourt County", "Bristol City", "Brunswick County", "Buchanan County", 
                                       "Buckingham County", "Buena Vista City", "Campbell County", "Caroline County", "Carroll County", "Charles City County", "Charlotte County", "Charlottesville City", 
                                       "Chesapeake City", "Chesterfield County", "Clarke County", "Colonial Heights City", "Covington City", "Craig County", "Culpeper County", "Cumberland County", "Danville City", 
                                       "Dickenson County", "Dinwiddie County", "Emporia City", "Essex County", "Fairfax City", "Fairfax County", "Falls Church City", "Fauquier County", "Floyd County", "Fluvanna County", 
                                       "Franklin City", "Franklin County", "Frederick County", "Fredericksburg City", "Galax City", "Giles County", "Gloucester County", "Goochland County", "Grayson County","Greene_County",
                                       "Greensville County", "Halifax County", "Hampton City", "Hanover County", "Harrisonburg City", "Henrico County", "Henry County", "Highland County", "Hopewell City", "Isle of Wight County",
                                       "James City County", "King and Queen County", "King George County", "King William County", "Lancaster County", "Lee County", "Lexington City", "Loudoun County", "Louisa County", 
                                       "Lunenburg County", "Lynchburg City", "Madison County", "Manassas City", "Manassas Park City", "Martinsville City", "Mathews County", "Mecklenburg County", "Middlesex County",
                                       "Montgomery County", "Nelson County", "New Kent County", "Newport News City", "Norfolk City", "Northampton County", "Northumberland County", "Norton City", "Nottoway County", "Orange County",
                                       "Page County", "Patrick County", "Petersburg City", "Pittsylvania_County", "Poquoson City", "Portsmouth City", "Powhatan County", "Prince Edward County", "Prince George County", "Prince William County",
                                       "Pulaski County", "Radford City", "Rappahannock County", "Richmond City", "Richmond County", "Roanoke City", "Roanoke County", "Rockbridge County", "Rockingham County", "Russell County", "Salem City",
                                       "Scott County", "Shenandoah County", "Smyth County", "Southampton County", "Spotsylvania County", "Stafford County", "Staunton City", "Suffolk City", "Surry County", "Sussex County", "Tazewell County", 
                                       "Virginia Beach City", "Warren County", "Washington County", "Waynesboro City", "Westmoreland County", "Williamsburg City", "Winchester City", "Wise County", "Wythe County", "York County", "Total"),
                           selected = NULL,
                           multiple = FALSE,
                           width = 500,
                           size = NULL),
            plotOutput("virginiaStatisticsGraph")
          )
        )

        # Insert VA heat tiles/chloropeth map to show all the counties
        # Counties with higher opioid death rates will be colored darker
        # Hovering over the county's outline will show you the county's number of deaths (as per the data set)

        # Infographic to the right of the heat tiles/chloropeth map

        # Insert text box with description/short info about the possible link between drug use and median income/poverty

        # Insert ggplot trend line graph comparing county income vs. opioid use/death rate - IN PROGRESS
      ),

      # Fourth tab content

      tabItem(
        tabName = "datasourcesTab",
        h1(strong("Data Sources and Further Information"))
      )
    )
  )
)
