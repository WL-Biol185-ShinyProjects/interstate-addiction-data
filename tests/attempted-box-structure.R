#    fluidRow(
#      box(title = "Box title", "Box content"),
#      box()),

#    fluidRow(
#      box(title = "Title 1", width = 4, solidHeader = TRUE, status = "primary", "Box content"),
#      box(title = "Title 2", width = 4, solidHeader = TRUE, "Box content"),
#      box(title = "Title 3", width = 4, solidHeader = TRUE, status = "warning", "Box content")),

#    fluidRow(
#      box(width = 4, background = "black", "A box with a solid black background"),
#      box(title = "Title 5", width = 4, background = "light-blue", "A box with a solid light-blue background"),
#      box(title = "Title 6", width = 4, background = "maroon", "A box with a solid maroon background")),


#        h4("Addiction is a common problem in several of the United States' major cities. Survey data was sourced from the American Addiction Center, based on the percentage of users per city population surveyed.")
#        box(
#          selectizeInput(
#            "select",
#            label = NULL,
#            choices = c(
#              "Select category...",
#              "Top 5 Cities with Marijuana Use",
#              "Top 5 Cities with Cocaine Use",
#              "Top 5 Cities with Heroin Use",
#              "Top 5 Cities with Meth Use"
#            ),
#            selected = "Select category...",
#            multiple = FALSE,
#            options = majorCities
#          )
#        ),
#        leafletOutput(CityLatLon)
),

#CityLatLon <- read.csv("Dataset-CSV-files/CityLatLon", header = TRUE)