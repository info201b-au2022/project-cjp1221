library(ggmap)
library(tidyverse)
library(ggplot2)

#make sure to set working directory to source file location
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
  filter(!is.na(collision_lat))
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
    filter(DUI == "Y") %>% #filter for DUIs
    mutate(date = as.Date(date)) %>%
    arrange(desc(date)) #arrange by date
  return(new_df)
}
DUI_collisions <- wrangle_data(joined)
View(DUI_collisions)

# map of washington
washington <- map_data("state") %>%
  subset(region == "washington") 
View(washington)

long_max <- max(DUI_collisions$long, na.rm = T)
long_min <- min(DUI_collisions$long, na.rm = T)
lat_max <- max(DUI_collisions$lat, na.rm = T)
lat_min <- min(DUI_collisions$lat, na.rm = T)


seattle_map <- ggplot(washington) +
  geom_polygon( 
    mapping = aes(x = long, y= lat, group = group),
    fill = "grey",
    color = "black",
    size  = .1, 
  ) + 
  geom_point(  # map collisions by long and lat
    data = DUI_collisions, 
    mapping = aes(x=long, y=lat),
    color = "red"
  ) +
  coord_fixed( #set long/lat limits to zoom in on the Seattle data
    xlim = c(-122.45, -122.2),
    ylim = c(47.45, 47.75),
    ratio = 1.3
  )

seattle_map

