library(rsconnect)
library(ggplot2)
library(shiny)
library(dplyr)
library(plotly)
SDOT_Collisions <- read.csv("data/SDOT_collisions.csv", stringsAsFactors=FALSE)
Collision_Data <- SDOT_Collisions %>%
  select(ROADCOND, PEDCOUNT, PEDCYLCOUNT) %>% 
  na.omit() %>% 
  filter(ROADCOND == "Dry" | ROADCOND == "Wet" | ROADCOND == "Ice")

chart <- function(Collision_data, ped_or_cycl) {
  if (ped_or_cycl == "Pedestrian") {
    title = "Pedestrians"
    yvar = "PEDCOUNT"
  } else {
    title = "Cyclists"
    yvar = "PEDCYLCOUNT"
  }
  
  ggplot(Collision_Data)+
    geom_col(aes(x=ROADCOND, y=yvar))+
    labs(title = paste("Seattle Collisions Involving ", title), 
         x = "Road Conditions", 
         y = paste("# of ", title)
         ) +
    theme_classic()
}
