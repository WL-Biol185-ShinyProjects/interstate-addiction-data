# ui.R

library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)
library(tidyverse)
library(tidyr)

# Files sourced

source("datasets.R")

# Dashboard page

dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Addiction Statistics", titleWidth = 300),
  dashboardSidebar(
    width = 250,

    # Sidebar - options to go to different pages (US, VA, types of drugs, etc.)

    sidebarMenu(
      menuItem("Background", tabName = "backgroundTab", icon = icon("info")),
      menuItem("United States", tabName = "unitedstatesTab", icon = icon("map-marker-alt")),
      menuItem("Virginia", tabName = "virginiaTab", icon = icon("map-marked")),
      menuItem("About", tabName = "datasourcesTab", icon = icon("server"))
    )
  ),

  # Dashboard - main info and data

  dashboardBody(
    tabItems(
      tabItem(
        tabName = "backgroundTab",
        h1(strong("BACKGROUND INFORMATION")),
        h4("Our project seeks to analyze the relationships between drug use and various factors (income, location, drug type, etc.) within the United States and
           within the state of Virginia.", style = "font-size:20px"),
        br(),
        
        # need to format these 2 pictures so they fit to the box's width, regardless of browser/page size when looking at the app
        
        fluidRow(
          box(
            width = 4,
            img(src = "Illicit Users 2018.png", height = 250, width = 330)
          ),
          valueBoxOutput("reasoning"),
          box(
            width = 4,
            img(src = "Drug Use Bar Graph.jpeg", height = 250, width = 330)
          )
        ),
        fluidRow(
          valueBoxOutput("averageUse"),
          box(
            icon("tablets", class = NULL, lib = "font-awesome"),
            background = "purple",
            width = 4,
            height = 125,
            status = "primary",
            style = "font-size:18px;",
            "The drugs most commonly associated with overdose include: heroin, cocaine, opioids/fentanyl, and methamphetamine."
          ),
          valueBoxOutput("drugCosts")
        )
      ),
      
      tabItem(
        tabName = "unitedstatesTab",
        h1(strong("ADDICTION IN THE UNITED STATES")),
        h4("Addiction is a common problem in several of the United States' major cities. Check out the interactives below to see addiction trends and drug use
           within the United States' major cities.", style = "font-size:20px"),
        h6("**It is important to note that in some surveys, certain states either did not take part in reporting services or did not submit data for certain months/years.**"),
        fluidRow(
          box(
            icon = NULL,
            width = 6,
            status = "primary",
            style = "font-size:16px;",
            selectInput(
              inputId = "topFiveCategory",
              label = "Compare US cities to see which cities use different drugs the most (reported as percentages)",
              choices = c("Select a category...", "Top 5 Marijuana Use", "Top 5 Cocaine Use", "Top 5 Heroin Use", "Top 5 Meth Use"),
              selected = "Select a category..",
              multiple = FALSE,
              selectize = FALSE,
              size = NULL
            ),
            leafletOutput("topFiveMap")
          ),
          box(
            width = 6,
            icon = NULL,
            status = "primary",
            selectInput(
              inputId = "city_state",
              label = "Choose a city in the US to view the percent of the population that used these substances in 2019...",
              choices = unique(substanceUseEstimatesByCityTidy$City_State),
              selected = "Albuquerque, NM",
              multiple = FALSE
            ),
            plotOutput(outputId = "substanceUseGraph")
          )
        ),
        br(),
        fluidRow(
          box(
            width = 12,
            icon = NULL,
            status = "primary",
            style = "font-size:16px;",
            selectInput(
              inputId = "location",
              label = "Compare how many ER visits there were for overdoses from January/Year to February/NextYear",
              
                # checking data set to find the time frame for years label
              
              choices = unique(surveyERTrendsTidy$stateAbbrev),
              selected = "AK",
              multiple = TRUE,
              width = 500,
              size = NULL
            ),
            selectInput(
              inputId = "months",
              label = "Select a month...",
              choices = unique(surveyERTrendsTidy$Month),
              selected = "Jan",
              multiple = FALSE,
              width = 500,
              size = NULL
            ),
            plotOutput("drugUseTrendsPlot")
          ),
          box(
            width = 12,
            icon = NULL,
            status = "primary",
            style = "font-size:16px;",
            selectInput(
              inputId = "statename",
              label = "Drug-related deaths in each US state in 2019",
              choices = unique(overdosesByState2019$State),
              selected = "AK",
              multiple = TRUE,
              size = NULL
            ),
            plotOutput("overdosesByStateDeathsPlot")
          )
        ),
        br(),
        fluidRow(
          box(
            icon = NULL,
            width = 8,
            status = "primary",
            style = "font-size:16px;",
            selectInput(
            inputId = "area",
            label = "Compare each states' monthly reporting compliance rates regarding drug overdoses over the past 6 years (2015-2021)",
            choices = unique(reportingRates$State),
            selected = "AK",
            multiple = TRUE
            ),
            selectInput(
              inputId = "monthOfYear",
              label = "Choose a month...",
              choices = unique(reportingRates$Month),
              selected = "January",
              multiple = FALSE
            )
          ),
          # plotOutput(outputId = reportingRatesPlot),
          box(
            title = strong("What are reporting rates?"),
            style = "font-size:16px;",
            icon("chart-line", class = NULL, lib = "font-awesome"),
            width = 4,
            height = 530,
            status= "primary",
            "Each year, a national survey is conducted concerning each state's compliance regarding accurate reporting of drug use and deaths. These reporting rates
              can be further broken down into the percent of reports completed, the percent of reports pending further investigation, and the percent of reports that
              actually specified which drugs were used in each case. We chose to focus on the percent of drugs specified, as there is a wide range of reporting among
              states. While it is important that each state accurately reports their annual drug use, it is equally important that they accurately report each case's
              drug used. In order to battle the national drug use crisis, states must begin to address the types of drugs used, not just the fact that people are using them."
            )
            )
            ),

      # reporting rates line graph - percentSpecified data - ggplot + geom_line()
          # x-axis: each month, from Jan2015 to Feb2021 in chronological order (not default alphabetical) - may do average of each 6 years instead to keep it from getting crammed
          # y-axis: percentages from 0 to 100 (may make range narrower if the minimum value is higher, like 40-100 or something)
      # multi-select option for states - can compare multiple lines at once on the graph


      tabItem(
        tabName = "virginiaTab",
        h1(strong("ADDICTION IN VIRGINIA")),
        fluidRow(
          box(
            width = 8,
            status = "primary",
            selectInput(
              inputId = "locality",
              label = "Select a locality in Virginia to view the number of opioid related deaths for 2007-Q1 2021...",
              choices = unique(vaStatisticsTidy$Locality),
              multiple = FALSE,
              selected = "Accomack County"
            ),
            plotOutput(outputId = "virginiaDeathsPlot")
          ),
          box(
            title = strong("Why Virginia?"),
            style = "font-size:16px;",
            icon("question-circle-o", class = NULL, lib = "font-awesome"),
            width = 4,
            height = 530,
            status = "primary",
            "We chose to focus on opioid-related deaths in particular, due to the fact that opioids were involved in 70% of overdose deaths in 2018. As native Virginians,
              we chose to focus on this increasingly prevalent opioid crisis within our home state of Virginia. While Virginia pales in comparison to national averages of
              opioid-related overdoses and deaths, it still contributes to the opioid crisis, including in ways you wouldn't expect. For example, in 2018, Virginian physicians
              wrote 44.8 opioid prescriptions per 100 people. While this is lower than the national average of 51.4 prescriptions per 100 people, it is still cause for concern.
              Opioids, and their even deadlier derivatives like heroin, morphine, and fentanyl, are very easy to access due to their prevalence in healthcare. As such, opioids
              have helped lead people towards further addiction to stronger substances, and it is our goal to understand where, and eventually why, this is happening in Virginia."
          )
        ),
        fluidRow(
          box(
            width = 8,
            status = "primary",
            selectInput(
              inputId = "place",
              label = "Select localities in Virginia to compare average income to average deaths related to opioids for 2014-2018...",
              choices = unique(vaCompleteTable$Locality),
              multiple = TRUE,
              selected = "Accomack County"
            ),
            plotOutput(outputId = "virginiaIncomePlot")
          ),
          box(
            title = strong("Are poverty and drug use related?"),
            style = "font-size:16px;",
            icon("credit-card", class = NULL, lib = "font-awesome"),
            width = 4,
            height = 530,
            status= "primary",
            "Poverty is an intersectional issue that can be affected by race, class, sex, and several other social determinants of health. Unfortunately, Americans with
              lower incomes are at a greater risk of developing drug addictions. While several social factors can influence said predispositions, household income is one of
              the greatest. For example, poverty often causes various types of stress, which is a prominent reason people turn to drug use. As such, we aimed to understand the
              influence of poverty, or lack thereof, on drug use among Virginia's localities. For example, northern Virginia has several localities whose median household income
              is far above the national average, whereas southwestern Virginia has several localities whose median household income is below the national average. By visualizing
              these income disparities alongside opioid-involved death counts, we aim to understand any relationships between Virginians' incomes and opioid/drug use."
          )
        )
      ),

      tabItem(
        tabName = "datasourcesTab",
        h1(strong("FURTHER INFORMATION")),
        br(),
        fluidRow(
          div(class = "page-section",
              fluidRow(
                h2(class = "title", icon("users"), "About Us", align = "center")
              ),
              fluidRow(class = "cards-container",
                       
                  # trying to get the pictures to be equidistant from the page's borders so that it looks better
                  # trying to get our info blurbs to be centered underneath our pictures, not centered in the middle of the whole page
                       
                       column(8, class = "cards",
                              div(class = "card",
                                  img(src = "Sophia.jpg", alt = "Avatar", height = 700, style = "width:50%", ),
                                  div(class = "container",
                                      h4(class = "name", strong("Sophia Roché")),
                                      p(class = "year", "Class of 2023"),
                                      p(strong("Major:"), "Biology (pre-med)")
                                  )),
                              div(class = "card",
                                  img(src = "", alt = "Avatar", height = 700, style = "width:50%"),
                                  div(class = "container",
                                      h4(class = "name", strong("Cecily Stern")),
                                      p(class = "year", "Class of 2023"),
                                      p(strong("Major:"), " ")
                                  ))
                       )
              )
          )
        ),
        br(),
        h2(strong("SOURCES:")),
        
        # trying to get it so the big font SOURCES is on the same line as the smaller font Below... line
        
        h4("Below, you will find hyperlinks to our data sources if you wish to further investigate drug addiction in the United States."),
        a(
          "Virginia's opioid statistics by county",
          href = "https://www.vdh.virginia.gov/medical-examiner/forensic-epidemiology/",
          target = "_blank",
          style = "color: #9C77FF; font-size: 22px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "Virginia's median household income",
          href = "https://fred.stlouisfed.org/release/tables?eid=268980&rid=175",
          target = "_blank",
          style = "color: #9C77FF; font-size: 22px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "States' drug overdose reporting rates and quailty levels",
          href = "https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm",
          target = "_blank",
          style = "color: #9C77FF; font-size: 22px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "States' total drug overdose deaths from 2019",
          href = "https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm",
          target = "_blank",
          style = "color: #9C77FF; font-size: 22px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "The surveillance of emergency room visits involving drug overdoses",
          href = "https://www.cdc.gov/drugoverdose/nonfatal/all-drugs.html",
          target = "_blank",
          style = "color: #9C77FF; font-size: 22px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "Provisional drug overdose death counts",
          href = "https://www.cdc.gov/nchs/nvss/vsrr/drug-overdose-data.htm",
          target = "_blank",
          style = "color: #9C77FF; font-size: 22px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "Overdose-related deaths from 1999-2019",
          href = "https://www.drugabuse.gov/drug-topics/trends-statistics/overdose-death-rates",
          target = "_blank",
          style = "color: #9C77FF; font-size: 22px; text-align: center; font-weight: bold"
        ),
        br(),
        a(
          "Major cities' substance use estimates",
          href = "https://americanaddictioncenters.org/learn/substance-abuse-by-city/",
          target = "_blank",
          style = "color: #9C77FF; font-size: 22px; text-align: center; font-weight: bold"
        )
      )
    )
  )
)
