library(tidyverse)
library(ggplot2)
library(leaflet)
#make sure to set working directory to source file location first

collisions <- read.csv("../data/SDOT_collisions.csv", stringsAsFactors = FALSE)
joined <- read.csv("../data/seattle_collisions_weather_lat_long.csv", stringsAsFactors = FALSE)
#View(joined)

wrangle_data <- function(joined) {
  #select variables - incdate, lat,long, location, underinfl
  new_df <- joined %>% 
    select(Incident.Key, Date, Location, DUI, Latitude, Longitude) %>%
    filter(DUI == "Y") %>% # filter for DUIs (after 2010)
    arrange(desc(Date)) #arrange by date
  return(new_df)
}
DUI_collisions <- wrangle_data(joined)
#View(DUI_collisions)

num_DUI <- DUI_collisions %>% # locations by number of DUIs
  count(Location) %>%
  arrange(-n)
#View(num_DUI)

six_DUIs <- num_DUI %>%
  filter(n >= 6)
#View(six_DUIs)

six_DUI_collisions <- left_join(six_DUIs, DUI_collisions, by = "Location") %>%
  filter(!str_detect(Location, "BATTERY ST TUNNEL")) # this road no longer exists
#View(six_DUI_collisions)

getColor <- function(six_DUI_collisions) {
  sapply(six_DUI_collisions$n, function(n) {
    if(n == 6) {
      "orange"
    } else if(n <= 8) {
      "red"
    } else {
      "darkred"
    } })
}

DUI_map <- leaflet(data = six_DUI_collisions) %>%
  addProviderTiles("CartoDB.Positron") %>% # can also use OpenStreetMap
  setView(lng = -122.33, lat = 47.60, zoom = 10) %>%
  addCircles(
    lat = ~Latitude,
    lng = ~Longitude,
    label = ~n,
    radius = 20,
    color = ~getColor(six_DUI_collisions)
  ) 
#DUI_map

# if i can get color palette working
# %>%
#  addLegend(
#    position = "bottomright",
#    title = "Seattle DUI Collisions",
#    pal = color_palette,
#    values = ~n,
#    opacity = 1
#  )

