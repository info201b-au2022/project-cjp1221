#install packages
install.packages("dplyr")
library("dplyr")

#loading files into data frames
seattle_weather <- read.csv("../data/seattleWeather_1948-2017.csv")
seattle_collisions <- read.csv("../data/SDOT_collisions.csv")
lat_lon <- read.csv("../data/SDOT_other.csv", stringsAsFactors = FALSE)

#checking each data frame
View(seattle_weather)
View(seattle_collisions)

#simplifying data frame by wanted columns, rename incident key for joining
seattle_collisions <- seattle_collisions %>%
  select(-c(SEGLANEKEY, EXCEPTRSNDESC, EXCEPTRSNCODE, COLDETKEY, SDOT_COLCODE, 
            ADDRTYPE, INATTENTIONIND, INCDTTM, INTKEY, JUNCTIONTYPE,
            PEDROWNOTGRNT, REPORTNO, SDOTCOLNUM, SEVERITYCODE, ST_COLCODE, STATUS,
            VEHCOUNT, CROSSWALKKEY, HITPARKEDCAR, SEVERITYDESC, ST_COLDESC,
            PERSONCOUNT, OBJECTID, COLLISIONTYPE, SDOT_COLDESC, X, Y)) %>%
  rename(collision_incident_key = INCKEY)

#select lat, long, and incident key for joining
lat_lon <- lat_lon %>%
  select(collision_incident_key, collision_lat, collision_long)

#convert date column values to be handled as dates in each data frame
seattle_collisions$INCDATE <- as.Date(seattle_collisions$INCDATE)
seattle_weather$DATE <- as.Date(seattle_weather$DATE)

#sort the data by the date starting on the 1st of Jan 2004 
seattle_weather <- seattle_weather %>%
  filter(DATE >= "2004-01-01")

#sort the data by the date starting on the 1st of Jan 2004
seattle_collisions <- seattle_collisions %>%
  filter(INCDATE >= "2004-01-01") %>%
  arrange(INCDATE)

#renaming the date column in seattle_collisions to match the date column in seattle_weather  
seattle_collisions <- rename(seattle_collisions, DATE = INCDATE)   
 
#joining the data frames by the date  
seattle_weather_vs_collisions <- left_join(seattle_weather, seattle_collisions, by = "DATE")
View(seattle_weather_vs_collisions)

#join by incident key for lat/long
seattle_collisions_weather_lat_long <- left_join(seattle_weather_vs_collisions, lat_lon, by = "collision_incident_key") %>%
  filter(!is.na(collision_lat))
View(seattle_collisions_weather_lat_long)

#renaming columns for readability
seattle_collisions_weather_lat_long <- seattle_collisions_weather_lat_long %>%
  rename(
    "Date" = DATE,
    "Precipitation (inches)" = PRCP,
    "Maximum Temperature (F)"= TMAX,
    "Minimum Temperature (F)" = TMIN,
    "Raining" = RAIN,
    "Longitude" = collision_long,
    "Latitude" = collision_lat,
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
    "Forecast" = WEATHER,
    "Incident Key" = collision_incident_key
  )

#reorganizing columns for flow
# temp <- seattle_collisions_weather_lat_long[, c(1, 7, 6, 11, 18, 5, 2, 4, 3, 10, 14, 9, 15, 8, 12, 13, 16, 17)]
# seattle_collisions_weather_lat_long <- temp
View(seattle_collisions_weather_lat_long)
# write.csv(seattle_collisions_weather_lat_long, "../data/seattle_collisions_weather_lat_long.csv", row.names = FALSE)

aggregate_table <- seattle_collisions_weather_lat_long %>%
  group_by(location) %>%
  summarize
