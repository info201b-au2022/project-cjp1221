library(tidyverse)
library(ggplot2)
library(lubridate)

seattle_weather <- read.csv("../data/seattleWeather_1948-2017.csv")
seattle_collisions <- read.csv("../data/SDOT_Collisions.csv")


seattle_collisions <- seattle_collisions %>%
  select(-c(SEGLANEKEY, EXCEPTRSNDESC, EXCEPTRSNCODE, COLDETKEY, SDOT_COLCODE, 
            ADDRTYPE, INCKEY, INATTENTIONIND, INCDTTM, INTKEY, JUNCTIONTYPE,
            PEDROWNOTGRNT, REPORTNO, SDOTCOLNUM, SEVERITYCODE, ST_COLCODE, STATUS,
            VEHCOUNT, CROSSWALKKEY, HITPARKEDCAR, SEVERITYDESC, ST_COLDESC,
            PERSONCOUNT, OBJECTID, COLLISIONTYPE, SDOT_COLDESC))

#restructure collisions data set's date column 
seattle_collisions$INCDATE <- as.Date(seattle_collisions$INCDATE)
seattle_weather$DATE <- as.Date(seattle_weather$DATE)

#filter data for only 2004 and beyond 
seattle_collisions <- seattle_collisions %>%
  filter(INCDATE >= "2004-01-01") %>%
  arrange(INCDATE)

seattle_weather <- seattle_weather %>%
  filter(DATE >= "2004-01-01")


#renaming the date column in seattle_collisions to match the date column in seattle_weather  
seattle_collisions <- rename(seattle_collisions, DATE = INCDATE)   


#joining the data frames by the date  
seattle_weather_vs_collisions <- left_join(seattle_weather, seattle_collisions, by = "DATE")
View(seattle_weather_vs_collisions)


#renaming columns for readability
seattle_weather_vs_collisions <- seattle_weather_vs_collisions %>%
  rename(
    "Date" = DATE,
    "Precipitation (inches)" = PRCP,
    "Maximum Temperature (F)"= TMAX,
    "Minimum Temperature (F)" = TMIN,
    "Raining" = RAIN,
    "Longitude" = X,
    "Latitude" = Y,
    "Fatalities" = FATALITIES,
    "Injuries" = INJURIES,
    "Light Conditions" = LIGHTCOND,
    "Location" = LOCATION,
    "Pedestrians Involved" = PEDCOUNT,
    "Cyclists Involved" = PEDCYLCOUNT,
    "Road Conditions" = ROADCOND,
    "Serious Injuries" = SERIOUSINJURIES,
    "Driver Speeding" = SPEEDING,
    "DUI" = UNDERINFL,
    "Forecast" = WEATHER
  )

#reorganizing columns for flow
temp <- seattle_weather_vs_collisions[, c(1, 7, 6, 11, 18, 5, 2, 4, 3, 10, 14, 9, 15, 8, 12, 13, 16, 17)]
seattle_weather_vs_collisions <- temp

#check data frame
View(seattle_weather_vs_collisions)


# num of columns of data set
num_columns <- ncol(seattle_weather_vs_collisions)

# num of rows of data set
num_rows <- nrow(seattle_weather_vs_collisions)

#names of a few column headers
accident_details <- colnames(seattle_weather_vs_collisions)

#first date
first_date <- seattle_weather_vs_collisions[1, "Date"]

#last date
last_date <- seattle_weather_vs_collisions[num_rows, "Date"]
