library(leaflet)

geo <-  rgdal::readOGR("counties.json")

leaflet(geo) %>%
  setView(lng = -78.024902, lat = 37.926868, zoom = 6) %>%
  addPolygons()

