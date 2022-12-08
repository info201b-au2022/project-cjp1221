library(rsconnect)
library(ggplot2)
library(shiny)
library(dplyr)
library(plotly)
SDOT_Collisions <- read.csv("../data/SDOT_collisions.csv", stringsAsFactors=FALSE)
Collision_Data <- SDOT_Collisions  
Collision_Data <- SDOT_Collisions %>%
  select("ROADCOND", "PEDCOUNT") %>% 
  na.omit() %>% 
  filter(ROADCOND == "Dry" | ROADCOND == "Wet" | ROADCOND == "Ice")

chart <- ggplot(Collision_Data)+
  geom_col(aes(x=ROADCOND, y=PEDCOUNT))+
  labs(title = "Seattle Collisions Involving Pedestrians", x = "Road Conditions", y = "# of Pedestrians")+
  theme_classic()

Bike_Collision_Data <- SDOT_Collisions %>% 
  select(ROADCOND, PEDCYLCOUNT) %>% 
  filter(ROADCOND == "Dry" | ROADCOND == "Wet" | ROADCOND == "Ice")
chart2 <- ggplot(Bike_Collision_Data)+
  geom_col(aes(x=ROADCOND, y=PEDCYLCOUNT)) +
  labs(title = "Seattle Collisions Involving Cyclists", x = "Road Conditions", y = "# of Cyclists")+
  theme_classic()
