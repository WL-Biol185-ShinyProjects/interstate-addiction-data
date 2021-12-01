# ui.R #

library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)

# files sourced

source("virginiaStatisticsScript.R")

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
      tabItem(
        # Idea - add box with reason we chose this topic, define drug addiction, types of drugs, etc.
        tabName = "backgroundTab",
        h1(strong("BACKGROUND INFORMATION")),
        h4("Our project seeks to analyze the relationships between drug use and various factors (income, location, drug type, etc.) within the United States and within the state of Virginia.", style = "font-size:20px"),
        br(),
        fluidRow(
          box(
            icon("prescription-bottle", class = NULL, lib = "font-awesome"),
            width = 4,
            height = 160,
            status = "primary",
            style = "font-size:20px;",
            "On average, 38% of US adults battle an illegal drug use disorder each year."
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
            "The drugs most commonly associated with overdose include: heroin, cocaine, opioids/fentanyl, and methamphetamine."
          )
        ),
        br(),
        fluidRow(
          box(
            width = 4,
            img(src = "Common-Drugs.png", height = 250, width = 330)
          ),
          box(
            title = "Drug Use Trends from xYear to xYear",
            width = 4,
            solidHeader = TRUE
            # "ggplot trend line showing increase in drug use over the last 50 years"
            # ggplot(virginiaStatistics),
            # might end up removing this box and reformatting to fit page
          ),
          box(
            title = "% Addicts receiving treatment",
            width = 4,
            solidHeader = 4,
            "ggplot percent of addicts receiving treatment vs. admitted to ER?"
            # might end up removing this box and adding a blurb with the reason we chose this topic
          )
        )
      ),

      tabItem(
        tabName = "unitedstatesTab",
        h1(strong("ADDICTION IN THE UNITED STATES")),
        h4("Addiction is a common problem in several of the United States' major cities. Check out the interactives below to see addiction trends and drug use within the United States' major cities.", style = "font-size:20px"),
        br(),
        fluidRow(
          box(
            icon = NULL,
            # width = 8,
            # height = 110,
            status = "primary",
            style = "font-size:16px;",
            selectInput(
              inputId = "topFiveCategory",
              label = "Compare US cities to see which cities use different drugs the most",
              choices = c("Select a category...", "Top 5 Marijuana Use", "Top 5 Cocaine Use", "Top 5 Heroin Use", "Top 5 Meth Use"),
              selected = NULL,
              multiple = FALSE,
              selectize = FALSE,
              width = 500,
              size = NULL
            )
          ),

          ## This is a sample of using the merged data for the top five meth cities. Need to make a server function
          ## which takes the selectInput and produces an output of the leaflet for the specific data selected.

          leafletOutput("topFiveMap")
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
              inputId = "drugUseTrends",
              label = "Compare drug use trends within each of the 50 US states",
              choices = c("Select a state...", state.name),
              multiple = FALSE,
              selectize = FALSE,
              width = 500,
              size = NULL
            ),

            # "plotOutput() - insert ggplot line graph that will plot the selected state's yearly drug use vs. the MonthYear"
            # drug overdose deaths per state data set and VSRR provisional drug overdose data set

            # Neeed to create a server function that will create the data for the ggplot output.
            plotOutput("drugUseTrendsPlot")
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
              size = NULL
            ),
            "insert ggplot scatterplot that will plot state abbrev. vs. number of 2019 deaths (y-axis); goal is to hover over a data point and have a pop-up text box tell you the exact number of deaths"
            #2019 drug overdose deaths per state data set
          ),
          box(
            icon = NULL,
            width = 4,
            height = 110,
            status = "primary",
            style = "font-size:16px;",
            "make this box data-dependent, where based on the state's data, it'll say '[state's name] has seen a significant incr/significant decr/no changes in drug use over X years'"
            #surveillance of ER visit trends data set
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
              label = "Compare each states' monthly reporting compliance rates regarding drug overdoses over the past 6 years",
              choices = c("Select a state...", "United States", state.name),
              selected = NULL,
              multiple = FALSE,
              selectize = FALSE,
              width = 500,
              size = NULL),
            "plotOutput() - insert ggplot trendline graph that shows MonthYear vs. % reported"
            #reporting rates and quality per states data set
          # insert ggplot TRI-BAR GRAPH here where you can select and see percentReported vs. percentPending vs. precentSpecified for each state
            # have option for each monthYear for each state, same data set
          )
        )
        # h4("Survey data was sourced from the American Addiction Center, based on the percentage of drug users per city population surveyed.", style = "font-size:15px;", align = "center")
      ),
      
      tabItem(
        tabName = "virginiaTab",
        h1(strong("ADDICTION IN VIRGINIA")),
        fluidRow(
          box(
            width = 8,
            status = "primary",
            selectInput(
              inputId = "locality",
              label = "Select a locality in Virginia...",
              choices = unique(vaStatisticsTidy$Locality),
              multiple = FALSE,
              selected = "Accomack County"
            ),
            plotOutput(outputId = "virginiaDeathsPlot")
          ),

            ## Need a server function to show the opioid deaths per year for the selected locality.

          box(
            title = strong("Why Virginia?"), style = "font-size:18px;",
            icon("question-circle-o", class = NULL, lib = "font-awesome"),
            width = 4,
            height = 530,
            status = "primary",
            style = "font-size:16px;",
            "We chose to focus on opioid-related deaths in particular, due to the fact that opioids were involved in 70% of overdose deaths in 2018.
            As native Virginians, we chose to focus on this increasingly prevalent opioid crisis within our home state of Virginia. While Virginia pales
            in comparison to national averages of opioid-related overdoses and deaths, it still contributes to the opioid crisis, including in ways you
            wouldn't expect. For example, in 2018, Virginian physicians wrote 44.8 opioid prescriptions per 100 people. While this is lower than the national
            average of 51.4 prescriptions per 100 people, it is still cause for concern. Opioids, and their even deadlier derivatives like heroin, morphine, and
            fentanyl, are very easy to access due to their prevalence in healthcare. As such, opioids have helped lead people towards further addiction to
            stronger substances, and it is our goal to understand where, and eventually why, this is happening in Virginia."
          )
        ),
        fluidRow(
          box(
            width = 8,
            status = "primary" #,
            # selectInput(
              # inputId = "",
              # label = "Select a Virginia locality to view its household median income",
              # choices = c(colnames(), selected = NULL, multiple = FALSE, width = 500, size = NULL)
            ),
          box(
            title = strong("Are poverty and drug use related?"), style = "font-size:18px;",
            icon("credit-card", class = NULL, lib = "font-awesome"),
            width = 4,
            height = 530,
            status= "primary",
            style = "font-size:16px;",
            "Poverty is an intersectional issue that can be affected by race, class, sex, and several other social determinants of health. Unfortunately, Americans with lower incomes are at a greater risk of developing drug addictions. While several social factors can influence said predispositions, household income is one of the greatest. For example, poverty often causes various types of stress, which is a prominent reason people turn to drug use. As such, we aimed to understand the influence of poverty, or lack thereof, on drug use among Virginia's localities. For example, northern Virginia has several localities whose median household income is far above the national average, whereas southwestern Virginia has several localities whose median household income is below the national average. By visualizing these income disparities alongside opioid-involved death counts, we aim to understand any relationships between Virginians' incomes and opioid/drug use."#,
            # selectInput(inputId = "locality")
          )
        )
      ),
            
      # Insert VA heat tiles/chloropeth map to show all the counties
      # Counties with higher opioid death rates will be colored darker
      # Hovering over the county's outline will show you the county's number of deaths (as per the data set)
      # Infographic to the right of the heat tiles/chloropeth map?
      # Insert text box suggesting a link between drug use and poverty/median income
      # Insert ggplot trend line graph comparing county income vs. opioid use/death rates


      tabItem(
        tabName = "datasourcesTab",
        align = "center",
        h1(strong("Data Sources and Further Information")),
        br(),
        br(),
        a(
          "VIRGINIA'S OPIOID STATISTICS BY COUNTY",
          href = "https://www.vdh.virginia.gov/medical-examiner/forensic-epidemiology/",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        br(),
        a(
          "VIRGINIA'S MEDIAN HOUSEHOLD INCOME",
          href = "https://fred.stlouisfed.org/release/tables?eid=268980&rid=175",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        br(),
        a(
          "STATES' DRUG OVERDOSE REPORTING RATES AND QUALITY LEVELS",
          href = "https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        br(),
        a(
          "STATES' TOTAL DRUG OVERDOES DEATHS FROM 2019",
          href = "https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        br(),
        a(
          "THE SURVEILLANCE OF EMERGENCY ROOM VISITS INVOLVING DRUG OVERDOSES",
          href = "https://www.cdc.gov/drugoverdose/nonfatal/all-drugs.html",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        br(),
        a(
          "PROVISIONAL DRUG OVERDOES DEATH COUNTS",
          href = "https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
        br(),
        a(
          "OVERDOSE-RELATED DEATHS FROM 1999 to 2019",
          href = "https://www.drugabuse.gov/drug-topics/trends-statistics/overdose-death-rates",
          target = "_blank",
          style = "color: #9C77FF; font-size: 25px; text-align: center; font-weight: bold"
        ),
        br(),
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