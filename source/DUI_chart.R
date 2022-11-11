library("tidyverse")

collisions <- read.csv("../data/SDOT_Collisions.csv", stringsAsFactors = FALSE)
view(collision)

wrangle_data <- function(collisions) {
  #select specific variables - incdate, x,y, location, underinfl
  new_df <- collisions %>% 
    select(X, Y, INCDATE, LOCATION, UNDERINFL) %>%
    rename(
      lat = X,
      long = Y,
      street = LOCATION,
      DUI = UNDERINFL,
      date = INCDATE
    ) %>%
    filter(!is.na(DUI)) %>% ########### why is this not working? ###########
    mutate(date = as.Date(date)) %>%
    arrange(desc(date)) #arrange by date
  return(new_df)
}
DUI_collisions <- wrangle_data(collisions)
View(DUI_collisions)

# import seattle map?
## currently map of US
state_shape <- map_data("state")

# Create a map of the continental U.S.
seattle_map <- ggplot(state_shape) +
  geom_polygon( 
    mapping = aes(x = long, y= lat, group = group),
    fill = "grey",
    color = "black",
    size  = .1, 
  ) + 
  geom_point(  # map collisions by long and lat
    data = DUI_collisions, 
    mapping = aes(x=lon, y=lat),
    color = "red"
  ) +
  coord_map()

seattle_map


