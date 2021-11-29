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
      
      #IDEA - make a solid-color, long text column (width = 4) with a 2x2 of boxes that have info/graphs in them
      #use the long text column to expand upon what drug addiction is, why we chose the idea, etc.

      tabItem(
        tabName = "backgroundTab",
        h1(strong("Background Information")),
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
            "The drugs most commonly associated with overdose include: fentanyl, heroin, cocaine, opioids, and methamphetamine.")
        ),
        br(),
        fluidRow(
          box(
            width = 4,
            img(src = "Common-Drugs.png", height = 250, width = 300)),
          box(
            title = "Drug Use Trends from xYear to xYear",
            width = 4,
            solidHeader = TRUE,
            "ggplot trend line showing increase in drug use over the last 50 years"),
          box(
            title = "% Addicts receiving treatment",
            width = 4,
            solidHeader = 4,
            "ggplot percent of addicts receiving treatment vs. admitted to ER?")
        )
      ),

      tabItem(
        tabName = "unitedstatesTab",
        h1(strong("Addiction in the United States")),
        h4("Addiction is a common problem in several of the United States' major cities. Check out the interactives below to see addiction trends and drug use within the United States' major cities.", style = "font-size:20px;"),
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
              size = NULL),
            "insert leaflet map under this dropdown menu"
            # leafletOutput(CityLatLon)
            ),
          box(
            icon = NULL,
            width = 4,
            height = 110,
            status = "primary",
            style = "font-size:16px;",
            "make this box data-dependent, where based on the state's data, it'll show [state name] centered above a pie chart with the city's drug stats"
          )
        ),
        br(),
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
              size = NULL),
            "plotOutput() - insert ggplot line graph that will plot the selected state's yearly drug use vs. the MonthYear"
          )
        ),
        br(),
        fluidRow(
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
              size = NULL),
            "insert ggplot scatterplot that will plot state abbrev. vs. number of 2019 deaths (y-axis); goal is to hover over a data point and have a pop-up text box tell you the exact number of deaths"
          ),
          box(
            icon = NULL,
            width = 4,
            height = 110,
            status = "primary",
            style = "font-size:16px;",
            "make this box data-dependent, where based on the state's data, it'll say '[state's name] has seen a significant incr/significant decr/no changes in drug use over X years'")
        ),
        br(),
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
              size = NULL),
            "plotOutput() - insert ggplot trendline graph that shows MonthYear vs. % reported"
          )
        )
#        h4("Survey data was sourced from the American Addiction Center, based on the percentage of drug users per city population surveyed.", style = "font-size:15px;", align = "center")
      ),
      
      tabItem(
        tabName = "virginiaTab",
        h1(strong("Addiction in Virginia")),
        fluidRow(
          box(
            selectInput(inputId = "location",
                        label = "Choose a Virginia locality",
                        list("Accomack_County","Albemarle_County","Alexandria_City","Alleghany_County","Amelia_County","Amherst_County","Appomattox_County","Arlington_County","Augusta_County","Bath_County","Bedford_City","Bedford_County","Bland_County","Botetourt_County","Bristol_City","Brunswick_County","Buchanan_County","Buckingham_County","Buena_Vista_City","Campbell_County","Caroline_County","Carroll_County","Charles_City_County","Charlotte_County","Charlottesville_City","Chesapeake_City","Chesterfield_County","Clarke_County","Colonial_Heights_City","Covington_City","Craig_County","Culpeper_County","Cumberland_County","Danville_City","Dickenson_County","Dinwiddie_County","Emporia_City","Essex_County","Fairfax_City","Fairfax_County","Falls_Church_City","Fauquier_County","Floyd_County","Fluvanna_County","Franklin_City","Franklin_County","Frederick_County","Fredericksburg_City","Galax_City","Giles_County","Gloucester_County","Goochland_County","Grayson_County","Greene_County","Greensville_County","Halifax_County","Hampton_City","Hanover_County","Harrisonburg_City","Henrico_County","Henry_County","Highland_County","Hopewell_City","Isle_of_Wight_County","James_City_County","King_and_Queen_County","King_George_County","King_William_County","Lancaster_County","Lee_County","Lexington_City","Loudoun_County","Louisa_County","Lunenburg_County","Lynchburg_City","Madison_County","Manassas_City","Manassas_Park_City","Martinsville_City","Mathews_County","Mecklenburg_County","Middlesex_County","Montgomery_County","Nelson_County","New_Kent_County","Newport_News_City","Norfolk_City","Northampton_County","Northumberland_County","Norton_City","Nottoway_County","Orange_County","Page_County","Patrick_County","Petersburg_City","Pittsylvania_County","Poquoson_City","Portsmouth_City","Powhatan_County","Prince_Edward_County","Prince_George_County","Prince_William_County","Pulaski_County","Radford_City","Rappahannock_County","Richmond_City","Richmond_County","Roanoke_City","Roanoke_County","Rockbridge_County","Rockingham_County","Russell_County","Salem_City","Scott_County","Shenandoah_County","Smyth_County","Southampton_County","Spotsylvania_County","Stafford_County","Staunton_City","Suffolk_City","Surry_County","Sussex_County","Tazewell_County","Virginia_Beach_City","Warren_County","Washington_County","Waynesboro_City","Westmoreland_County","Williamsburg_City","Winchester_City","Wise_County","Wythe_County","York_County","Out_of_State","Unknown","Total")),
            plotOutput("fatalitiesPlot")
          )
        )),
      
      #Insert VA heat tiles/chloropeth map to show all the counties
      #Counties with higher opioid death rates will be colored darker
      #Hovering over the county's outline will show you the county's number of deaths (as per the data set)
      #Infographic to the right of the heat tiles/chloropeth map?
      #Insert text box suggesting a link between drug use and poverty/median income
      #Insert ggplot trend line graph comparing county income vs. opioid use/death rates
      
      tabItem(
        tabName = "datasourcesTab",
        h1(strong("Data Sources and Further Information")),
        br(),
        a(
          "VIRGINIA'S OPIOID STATISTICS BY COUNTY",
          href = "https://www.vdh.virginia.gov/medical-examiner/forensic-epidemiology/",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "VIRGINIA'S MEDIAN HOUSEHOLD INCOME",
          href = "https://fred.stlouisfed.org/release/tables?eid=268980&rid=175",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "STATES' DRUG OVERDOSE REPORTING RATES AND QUALITY LEVELS",
          href = "https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "STATES' TOTAL DRUG OVERDOES DEATHS FROM 2019",
          href = "https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "THE SURVEILLANCE OF EMERGENCY ROOM VISITS INVOLVING DRUG OVERDOSES",
          href = "https://www.cdc.gov/drugoverdose/nonfatal/all-drugs.html",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "PROVISIONAL DRUG OVERDOES DEATH COUNTS",
          href = "https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "OVERDOSE-RELATED DEATHS FROM 1999 to 2019",
          href = "https://www.drugabuse.gov/drug-topics/trends-statistics/overdose-death-rates",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "MAJOR CITIES' SUBSTANCE USE ESTIMATES",
          href = "https://americanaddictioncenters.org/learn/substance-abuse-by-city/",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        )
      )
    )
  )

)