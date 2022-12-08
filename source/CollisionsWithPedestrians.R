library(rsconnect)
library(ggplot2)
library(shiny)
library(dplyr)
library(plotly)
SDOT_Collisions <- read.csv("~/info201/Assignments/project-cjp1221/data/SDOT_Collisions.csv", stringsAsFactors=FALSE)
Collision_Data <- SDOT_Collisions  
Collision_Data <- SDOT_Collisions %>%
  select("ROADCOND", "PEDCOUNT") %>% 
  na.omit() %>% 
  filter(ROADCOND == "Dry" | ROADCOND == "Wet" | ROADCOND == "Ice")

chart <- ggplot(Collision_Data)+
  geom_col(aes(x=ROADCOND, y=PEDCOUNT))+
  labs(title = "Seattle Collisions Involving Pedestrians", x = "Road Conditions", y = "# of Pedestrians")+
  theme_classic()
ggplotly(chart)

Bike_Collision_Data <- SDOT_Collisions %>% 
  select(ROADCOND, PEDCYLCOUNT) %>% 
  filter(ROADCOND == "Dry" | ROADCOND == "Wet" | ROADCOND == "Ice")
chart2 <- ggplot(Bike_Collision_Data)+
  geom_col(aes(x=ROADCOND, y=PEDCYLCOUNT)) +
  labs(title = "Seattle Collisions Involving Cyclists", x = "Road Conditions", y = "# of Cyclists")+
  theme_classic()
ggplotly(chart2)