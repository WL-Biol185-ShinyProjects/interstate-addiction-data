library(leaflet)

majorCities <- data.frame( lat = c(35.0844, 32.7357, 33.7490, 30.2672, 39.2904, 42.3601, 35.2271,
                                   41.8781, 38.8339, 39.9612, 32.7767, 39.7392, 42.3314, 31.7619,
                                   32.7555, 36.7378, 29.7604, 39.7684, 30.3322, 39.0997, 36.1699,
                                   33.7701, 34.0522, 35.1495, 33.4152, 25.7617)
                          , lon = c(-106.6504, -97.1081, -84.3880, -97.7431, -76.6122, -71.0589,
                                    -80.8431, -87.6298, -104.8214, -82.9988, -96.7970, -104.9903,
                                    -83.0458, -106.4850, -97.3308, -119.7871, -95.3698, -86.1581,
                                    -81.6557, -94.5786, -115.1398, -118.1937, -118.2437, -90.0490,
                                    -111.8315, -80.1918)
                          , place = c("Albuquerque, NM", "Arlington, TX", "Atlanta, GA", "Austin, TX",
                                      "Baltimore, MD", "Boston, MA", "Charlotte, NC", "Chicago, IL",
                                      "Colorado Springs, CO", "Columbus, OH", "Dallas, TX", "Denver, CO",
                                      "Detroit, MI", "El Paso, TX", "Fort Worth, TX", "Fresno, CA",
                                      "Houston, TX", "Indianapolis, IN", "Jacksonville, FL", "Kansas City, MO",
                                      "Las Vegas, NV", "Long Beach, CA", "Los Angeles, CA", "Memphis, TN",
                                      "Mesa, AZ", "Miami, FL")
                          , stringsAsFactors = FALSE
)

#stopped inputting city coordinates at Miami

leaflet(data= majorCities) %>%
  addTiles() %>%
  addMarkers(popup = ~place)