#install packages
install.packages("dplyr")
library("dplyr")

#laoding files into data frames
seattle_weather <- read.csv("Documents/info201/project-cjp1221/data/seattleWeather_1948-2017.csv")
seattle_collisions <- read.csv("Documents/info201/project-cjp1221/data/SDOT_Collisions_-_All_Years.csv")

#checking each data frame
View(seattle_weather)
View(seattle_collisions)

#simplifying data frame by wanted columns 
seattle_collisions <- select(seattle_collisions, INCDATE, WEATHER, LIGHTCOND, ROADCOND, LOCATION)

#convert date column values to be handled as dates in each data frame
seattle_collisions$INCDATE <- as.Date(seattle_collisions$INCDATE)
seattle_weather$DATE <- as.Date(seattle_weather$DATE)

#sort the data by the date starting on the 1st of Jan 2004 
seattle_weather <- seattle_weather %>%
  filter(DATE >= "2004-01-01")

#sort the data by the date starting on the 1st of Jan 2004
seattle_collisions <- seattle_collisions %>%
  filter(INCDATE >= "2004-01-01")
  arrange(INCDATE)

#renaming the date column in seattle_collisions to match the date column in seattle_weather  
seattle_collisions <- rename(seattle_collisions, DATE = INCDATE)   
 
#joining the data frames by the date  
seattle_weather_vs_collisions <- left_join(seattle_weather, seattle_collisions, by = "DATE")
View(seattle_weather_vs_collisions)
