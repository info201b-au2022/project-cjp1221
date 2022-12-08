library(tidyverse)
library(ggplot2)
library(leaflet)

collisions <- read.csv("../data/SDOT_collisions.csv", stringsAsFactors = FALSE)
joined <- read.csv("../data/seattle_collisions_weather_lat_long.csv", stringsAsFactors = FALSE)

# account for some DUIs being labeled with 0/1 instead of N/Y
joined["DUI"][joined["DUI"] == 1] <- "Y"

wrangle_data <- function(joined) {
  #select variables - incdate, lat,long, location, underinfl
  new_df <- joined %>% 
    select(Incident.Key, Date, Location, DUI, Latitude, Longitude) %>%
    filter(DUI == "Y") %>% # filter for DUIs
    arrange(desc(Date)) #arrange by date
  return(new_df)
}
DUI_collisions <- wrangle_data(joined)

# locations by number of DUIs
DUI_by_num <- DUI_collisions %>%
  count(Location) %>%
  arrange(-n)

total_DUI_collisions <- left_join(DUI_by_num, DUI_collisions, by = "Location") %>%
  filter(!str_detect(Location, "BATTERY ST TUNNEL")) # this road no longer exists

# set color palette for map
pal <- colorNumeric(
  palette = c("orange", "red", "red4", "black"),
  domain = total_DUI_collisions$n)

# Generate color coded map of DUI collisions per location
DUI_map <- leaflet(data = total_DUI_collisions) %>%
  addProviderTiles("CartoDB.Positron") %>% 
  setView(lng = -122.33, lat = 47.60, zoom = 10) %>%
  addCircles(
    lat = ~Latitude,
    lng = ~Longitude,
    label = ~Location,
    radius = 200,
    color = ~pal(n),
    opacity = 0.5,
    stroke = FALSE
  )  %>%
  addLegend(
    position = "bottomright",
    title = "DUI Collisions",
    pal = pal,
    values = c(1:24),
    opacity = 0.75
  )


map_DUI <- function(total_DUI_collisions, num) {
  num_DUIs <- total_DUI_collisions %>%
    filter(n >= num)
  
  pal <- colorNumeric(
    palette = c("orange", "red", "red4", "#400000"),
    domain = c(1:24)) 
  
  
  DUI_map <- leaflet(data = num_DUIs) %>%
    addProviderTiles("CartoDB.Positron") %>% 
    setView(lng = -122.33, lat = 47.60, zoom = 10) %>%
    addCircles(
      lat = ~Latitude,
      lng = ~Longitude,
      label = ~Location,
      radius = 200,
      color = ~pal(n),
      opacity = 0.3,
      stroke = FALSE
    )  %>%
    addLegend(
      position = "bottomright",
      title = "DUI Collisions",
      pal = pal,
      values = c(num:24),
      opacity = 0.75
    )
}
