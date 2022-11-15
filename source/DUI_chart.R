library(ggmap)
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

View(collisions)
View(lat_lon)

joined <- left_join(collisions, lat_lon, by = "collision_incident_key") %>%
  filter(!is.na(collision_lat)) # rows with lat/long data
View(joined)
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
View(DUI_collisions)

num_DUI <- DUI_collisions %>% # order locations by number of DUIs
  count(location) %>%
  arrange(-n)
View(num_DUI)

six_DUIs <- num_DUI %>%
  filter(n >= 6)
View(six_DUIs)

six_DUI_collisions <- left_join(six_DUIs, DUI_collisions, by = "location") %>%
  filter(!str_detect(location, "BATTERY ST TUNNEL")) # this road no longer exists
View(six_DUI_collisions)

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

leaflet(data = six_DUI_collisions) %>%
  addProviderTiles("CartoDB.Positron") %>% # can also use OpenStreetMap
  setView(lng = -122.33, lat = 47.60, zoom = 10) %>%
  addCircles(
    lat = ~lat,
    lng = ~long,
    label = ~n,
    radius = 20,
    color = ~getColor(six_DUI_collisions)
  ) 

# if i can get color palette working
# %>%
  addLegend(
    position = "bottomright",
    title = "Seattle DUI Collisions",
    pal = color_palette,
    values = ~n,
    opacity = 1
  )

## Unused code
# map of washington
washington <- map_data("state") %>%
  subset(region == "washington") 
View(washington)

long_max <- max(DUI_collisions$long, na.rm = T)
long_min <- min(DUI_collisions$long, na.rm = T)
lat_max <- max(DUI_collisions$lat, na.rm = T)
lat_min <- min(DUI_collisions$lat, na.rm = T)

blank_theme <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank()
)

seattle_map <- ggplot(washington) +
  geom_polygon( 
    mapping = aes(x = long, y= lat, group = group),
    fill = "grey",
    color = "black",
    size  = .1, 
  ) + 
  geom_point( # map collisions by long and lat
    data = seven_DUI_collisions, 
    mapping = aes(x=long, y=lat, color = n),
    alpha = .3
  ) +
  coord_fixed( #set long/lat limits to zoom in on the Seattle data
    xlim = c(-122.42, -122.24),
    ylim = c(47.51, 47.74)
  ) 
#blank_theme
seattle_map