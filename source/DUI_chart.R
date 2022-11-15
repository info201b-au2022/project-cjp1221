library(tidyverse)
library(ggplot2)
library(leaflet)
#make sure to set working directory to source file location first

collisions <- read.csv("../data/SDOT_Collisions.csv", stringsAsFactors = FALSE)
# rename incident key for joining, remove some unused columns
collisions <- collisions %>%
  rename(collision_incident_key = INCKEY) %>%
  select(-c(SEGLANEKEY, EXCEPTRSNDESC, EXCEPTRSNCODE, COLDETKEY, SDOT_COLCODE))

lat_lon <- read.csv("../data/SDOT_other.csv", stringsAsFactors = FALSE)
#select lat, long, and incident key for joining
lat_lon <- lat_lon %>%
  select(collision_incident_key, collision_lat, collision_long)

#View(collisions)
#View(lat_lon)

joined <- left_join(collisions, lat_lon, by = "collision_incident_key") %>%
  filter(!is.na(collision_lat)) # rows with lat/long data
#View(joined)
# write.csv(joined,"../data/SDOT_collisions_lat_long.csv", row.names = FALSE)

wrangle_data <- function(joined) {
  #select variables - incdate, lat,long, location, underinfl
  new_df <- joined %>% 
    select(collision_incident_key, INCDATE, LOCATION, UNDERINFL, collision_lat, collision_long) %>%
    rename(
      location = LOCATION,
      DUI = UNDERINFL,
      date = INCDATE,
      lat = collision_lat,
      long = collision_long
    ) %>%
    filter(DUI == "Y") %>% #filter for DUIs (after 2010)
    mutate(date = as.Date(date)) %>%
    arrange(desc(date)) #arrange by date
  return(new_df)
}
DUI_collisions <- wrangle_data(joined)
#View(DUI_collisions)

num_DUI <- DUI_collisions %>% # locations by number of DUIs
  count(location) %>%
  arrange(-n)
#View(num_DUI)

six_DUIs <- num_DUI %>%
  filter(n >= 6)
#View(six_DUIs)

six_DUI_collisions <- left_join(six_DUIs, DUI_collisions, by = "location") %>%
  filter(!str_detect(location, "BATTERY ST TUNNEL")) # this road no longer exists
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
    lat = ~lat,
    lng = ~long,
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

