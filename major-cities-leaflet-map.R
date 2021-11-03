library(leaflet)

majorCities <- data.frame( lat = c(35.0844, 32.7357, 33.7490, 30.2672, 39.2904, 42.3601, 35.2271,
                                   41.8781, 38.8339, 39.9612, 32.7767, 39.7392, 42.3314, 31.7619,
                                   32.7555, 36.7378, 29.7604, 39.7684, 30.3322, 39.0997, 36.1699,
                                   33.7701, 34.0522, 35.1495, 33.4152, 25.7617, 43.0389, 44.9778,
                                   36.1627, 29.9511, 40.7128, 37.8044, 35.4676, 41.2565, 39.9526,
                                   33.4484, 45.5152, 35.7796, 38.5816, 29.4241, 32.7157, 37.7749,
                                   37.3382, 47.6062, 32.2226, 36.1540, 36.8529, 38.9072, 37.6872)
                          , lon = c(-106.6504, -97.1081, -84.3880, -97.7431, -76.6122, -71.0589,
                                    -80.8431, -87.6298, -104.8214, -82.9988, -96.7970, -104.9903,
                                    -83.0458, -106.4850, -97.3308, -119.7871, -95.3698, -86.1581,
                                    -81.6557, -94.5786, -115.1398, -118.1937, -118.2437, -90.0490,
                                    -111.8315, -80.1918, -87.9065, -93.2650, -86.7816, -90.0715,
                                    -74.0060, -122.2712, -97.5164, -95.9345, -75.1652, -112.0740,
                                    -122.6784, -78.6382, -121.4944, -98.4936, -117.1611, -122.4194,
                                    -121.8863, -122.3321, -110.9747, -95.9928, -75.9780, -77.0369,
                                    -97.3301)
                          , place = c("Albuquerque, NM", "Arlington, TX", "Atlanta, GA", "Austin, TX",
                                      "Baltimore, MD", "Boston, MA", "Charlotte, NC", "Chicago, IL",
                                      "Colorado Springs, CO", "Columbus, OH", "Dallas, TX", "Denver, CO",
                                      "Detroit, MI", "El Paso, TX", "Fort Worth, TX", "Fresno, CA",
                                      "Houston, TX", "Indianapolis, IN", "Jacksonville, FL", "Kansas City, MO",
                                      "Las Vegas, NV", "Long Beach, CA", "Los Angeles, CA", "Memphis, TN",
                                      "Mesa, AZ", "Miami, FL", "Milwaukee, WI", "Minneapolis, MN",
                                      "Nashville, TN", "New Orleans, LA", "New York, NY", "Oakland, CA",
                                      "Oklahoma City, OK", "Omaha, NE", "Philadelphia, PA", "Phoenix, AZ",
                                      "Portland, OR", "Raleigh, NC", "Sacramento, CA", "San Antonio, TX",
                                      "San Diego, CA", "San Francisco, CA", "San Jose, CA", "Seattle, WA",
                                      "Tucson, AZ", "Tulsa, OK", "Virginia Beach, VA", "Washington, D.C.",
                                      "Wichita, KS")
                          , stringsAsFactors = FALSE
)

#stopped inputting city coordinates at Miami

leaflet(data = majorCities) %>%
  addTiles() %>%
  addMarkers(popup = ~place)