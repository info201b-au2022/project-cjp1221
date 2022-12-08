library(rsconnect)
library(ggplot2)
library(shiny)
library(dplyr)
library(plotly)
SDOT_Collisions <- read.csv("../data/SDOT_collisions.csv", stringsAsFactors=FALSE)
Collision_Data <- SDOT_Collisions %>%
  select(ROADCOND, PEDCOUNT, PEDCYLCOUNT) %>% 
  na.omit() %>% 
  filter(ROADCOND == "Dry" | ROADCOND == "Wet" | ROADCOND == "Ice")

#chart <- ggplot(Collision_Data)+
#  geom_col(aes(x=ROADCOND, y=PEDCOUNT))+
#  labs(title = "Seattle Collisions Involving Pedestrians", x = "Road Conditions", y = "# of Pedestrians")+
#  theme_classic()

#Bike_Collision_Data <- SDOT_Collisions %>% 
#  select(ROADCOND, PEDCYLCOUNT) %>% 
#  filter(ROADCOND == "Dry" | ROADCOND == "Wet" | ROADCOND == "Ice")

#chart2 <- ggplot(Collision_Data)+
#  geom_col(aes(x=ROADCOND, y=PEDCYLCOUNT)) +
#  labs(title = "Seattle Collisions Involving Cyclists", x = "Road Conditions", y = "# of Cyclists")+
#  theme_classic()

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
