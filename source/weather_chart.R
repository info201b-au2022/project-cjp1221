# Weather vs. Collisions
library(tidyverse)
library(ggplot2)
library(lubridate)

# Initializing datasets from "../data"
weather <- read.csv("../data/seattleWeather_1948-2017.csv", stringsAsFactors = FALSE)
collisions <- read.csv("../data/SDOT_Collisions.csv", stringsAsFactors = FALSE)

# Setting date column for collisions dataset as date objects
collisions$INCDATE <- as.Date(collisions$INCDATE, format = "%Y/%m/%d")

# Renaming column for incident dates, arranged dates in descending order, and 
# filtered dates to fit the scope of the weather data set
collisions <- collisions %>%
  rename(DATE = INCDATE) %>%
  arrange(desc(DATE)) %>%
  filter(DATE <= ymd(20171214))

collisions_by_date <- collisions %>%
  group_by(DATE) %>%
  summarize(
    total_accidents = length(DATE), 
    total_injuries = sum(INJURIES), 
    total_fatalities = sum(FATALITIES))

# Setting date column for weather dataset as date objects
weather$DATE <- as.Date(weather$DATE, format = "%Y-%m-%d")

# Joining weather and collision data
weather_vs_collisions <- inner_join(weather, collisions_by_date, by = "DATE")

# Total collisions, injuries, and fatalities vs rainy forecast
collisions_is_raining <- weather_vs_collisions %>%
  group_by(is_raining = RAIN == "TRUE") %>%
  summarize(total_accidents = sum(total_accidents, na.rm = T),
            total_fatalities = sum(total_fatalities, na.rm = T),
            total_injuries = sum(total_injuries), na.rm = T) %>%
  na.omit()
  
# Total collisions, injuries, and fatalities vs amount of precipitation
collisions_rain_amount <- weather_vs_collisions %>%
  filter(PRCP > 0) %>%
  group_by(PRCP) %>%
  summarize(total_accidents = sum(total_accidents, na.rm = T), 
            total_fatalities = sum(total_fatalities, na.rm = T), 
            total_injuries = sum(total_injuries, na.rm = T))

# Bar chart of collisions vs rain
#raining_chart <- 
#  ggplot(collisions_is_raining, 
#         aes(x = is_raining, y = total_accidents)) + 
#  geom_col(fill = "#0073C2FF") +
#  geom_text(aes(label = total_accidents), vjust = -0.2, color = "black") +
#  labs(y = "# of Accidents", x = "Rainy Weather Forecast")

# Scatterplot of total collisions, injuries, and fatalities vs amount of precipitation
#precipitation_chart <-
#  ggplot(collisions_rain_amount, aes(x = PRCP, y = value)) + 
#  geom_point(aes(y = total_accidents, col = "Total Accidents")) +
#  geom_point(aes(y = total_fatalities, col = "Total Fatalities")) +
#  geom_point(aes(y = total_injuries, col = "Total Injuries")) +
#  labs(y = "", x = "Amount of Precipitation (in)") +
#  ggtitle("Precipitation vs Collisions")

# Create Scatterplot function
create_scatterplot <- function(weather_vs_collisions, min, max, checkbox, incident_type) {
  if (incident_type == "total_accidents") {
    string = "Accidents"
    yvar = "total_accidents"
  }
  if (incident_type == "total_injuries") {
    string = "Injuries"
    yvar = "total_injuries"
  }
  if (incident_type == "total_fatalities") {
    string = "Fatalities"
    yvar = "total_fatalities"
  }
  if (checkbox == TRUE) {
    collisions_is_raining$is_raining <- 
      ifelse(collisions_is_raining$is_raining == "TRUE", "With Rain", "No Rain")
    
    if_rain_chart <- 
      ggplot(collisions_is_raining, 
             aes(x = is_raining, y = !!sym(yvar))) + 
      geom_col(fill = "#0073C2FF") +
      geom_text(aes(label = !!sym(yvar)), vjust = -1) +
      labs(title = paste(string, "Involved With and Without Precipitation"),
           y = paste("Number of ", string), 
           x = "Rainy Weather Forecast") + 
      scale_y_continuous(expand=c(0, 0), limits=c(0, 120000))
      
    return(if_rain_chart)
  } else {
    chart_data <- collisions_rain_amount %>%
      filter(PRCP >= min, PRCP <= max)
    
    rain_chart <- ggplot(chart_data, aes(x = PRCP, y = !!sym(yvar))) + 
      geom_point(aes(y = !!sym(yvar)), color = "#0073C2FF") +
      labs(title = paste(string, "Involved with Precipitation"), 
           y = paste("Number of ", string), 
           x = "Amount of Precipitation (in) [Note: exludes 0 inches]")
    return(rain_chart)
  }
}