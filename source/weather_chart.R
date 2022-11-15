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
number_of_collisions <- nrow(collisions)
total_of_collisions_in_weather <-sum(weather_collisions_rain_amount$total_accidents)

# Total number of accidents to each month from 2004-2017
collisions_by_month <- weather_vs_collisions %>%
  group_by(months = floor_date(DATE, 'month')) %>%
  summarize(total_accidents = sum(total_accidents))
  
# Total collisions during freezing temperatures
weather_collisions_is_freezing <- weather_vs_collisions %>%
  group_by(is_freezing = TMIN <= 32) %>%
  summarize(total_accidents = sum(total_accidents)) %>%
  na.omit()

# Total collisions during rainy forecast
weather_collisions_is_raining <- weather_vs_collisions %>%
  group_by(is_raining = RAIN == "TRUE") %>%
  summarize(total_accidents = sum(total_accidents)) %>%
  na.omit()
  
# Total collisions, injuries, and fatalities vs amount of precipitation
weather_collisions_rain_amount <- weather_vs_collisions %>%
  filter(PRCP > 1) %>%
  group_by(PRCP) %>%
  summarize(total_accidents = sum(total_accidents), 
            total_fatalities = sum(total_fatalities), 
            total_injuries = sum(total_injuries)) %>%
  na.omit()

# Bar chart of collisions vs freezing temperatures
freezing_chart <- 
  ggplot(weather_collisions_is_freezing, 
         aes(x = is_freezing, y = total_accidents)) + 
  geom_col(fill = "#0073C2FF") +
  geom_text(aes(label = total_accidents), vjust = -0.2, color = "black") +
  labs(y = "# of Accidents", x = "Freezing Temperatures")

# Bar chart of collisions vs rain
raining_chart <- 
  ggplot(weather_collisions_is_raining, 
         aes(x = is_raining, y = total_accidents)) + 
  geom_col(fill = "#0073C2FF") +
  geom_text(aes(label = total_accidents), vjust = -0.2, color = "black") +
  labs(y = "# of Accidents", x = "Rainy Weather Forecast")

# Scatterplot of total collisions, injuries, and fatalities vs amount of precipitation
precipitation_chart <-
  ggplot(weather_collisions_rain_amount, aes(x = PRCP, y = value)) + 
  geom_point(aes(y = total_accidents, col = "Total Accidents")) +
  geom_point(aes(y = total_fatalities, col = "Total Fatalities")) +
  geom_point(aes(y = total_injuries, col = "Total Injuries")) +
  labs(y = "", x = "Amount of Precipitation (in)") +
  ggtitle("Precipitation vs Collisions")

  