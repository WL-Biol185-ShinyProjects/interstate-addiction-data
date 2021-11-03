library(leaflet)

VA_County_Statistics <- data.frame(lat = c(37.7063, 38.0334722, 37.8532, 37.3213, 37.5588, 37.4025)
                                 , long = c(-75.8069, -78.5497361, -80.0535, -77.9739, -79.1097, -78.7930)
                                 , place = c("Accomack County", "Albemarle County", "Alleghany County", "Amelia County", "Amherst County", "Appomattox County")
                                 , deaths = c(4, 14, 4, 3, 5, 3)
                                 , stringsAsFactors = FALSE)

leaflet(data = VA_County_Statistics) %>%
  setView(lng = -78.024902, lat = 37.926868, zoom = 6) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addMarkers(popup = ~place)

