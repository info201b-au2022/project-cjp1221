library("tidyverse")

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
write.csv(joined,"../data/SDOT_collisions_lat_long.csv", row.names = FALSE)

wrangle_data <- function(joined) {
  #select specific variables - incdate, lat,long, location, underinfl
  new_df <- joined %>% 
    select(collision_incident_key, INCDATE, LOCATION, UNDERINFL, collision_lat, collision_long) %>%
    rename(
      location = LOCATION,
      DUI = UNDERINFL,
      date = INCDATE,
      lat = collision_lat,
      long = collision_long
    ) %>%
    filter(!is.na(DUI)) %>% ##why is na DUI not working?
    mutate(date = as.Date(date)) %>%
    arrange(desc(date)) #arrange by date
  return(new_df)
}
DUI_collisions <- wrangle_data(joined)
View(DUI_collisions)

# import seattle map?
## currently map of US
state_shape <- map_data("state")
View(state_shape)

# Create a map of the continental U.S. and map longs/lats
seattle_map <- ggplot(state_shape) +
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
  coord_map()

seattle_map

