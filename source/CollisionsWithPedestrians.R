SDOT_Collisions <- read.csv("~/info201/Assignments/project-cjp1221/data/SDOT_Collisions.csv", stringsAsFactors=FALSE)
Collision_Data <- SDOT_Collisions %>% 
  select("ROADCOND", "PEDCOUNT", "PEDCYLCOUNT")
Collision_Data <- na.omit(Collision_Data)


DryData <- Collision_Data %>% filter(ROADCOND == "Dry")
WetData <- Collision_Data %>% filter(ROADCOND == "Wet")
PedTotal <- subset(DryData, PEDCOUNT > 0)
x <- PedTotal$PEDCOUNT
Dry_Ped_Totals <- (sum(PedTotal[, 'PEDCOUNT']))

PedTotal <- subset(DryData, PEDCYLCOUNT > 0)
y <- PedTotal$PEDCYLCOUNT
Dry_Bike_Totals <- (sum(PedTotal[, 'PEDCYLCOUNT']))

Road_Conditions <- c("Dry")
Dry_Bike_Collisions <- c(5212)
Dry_Ped_Collisions <- c(5998)
FinalTotals <- data.frame(Road_Conditions, Dry_Bike_Collisions, Dry_Ped_Collisions)

PedTotal2 <- subset(WetData, PEDCOUNT > 0)
x <- PedTotal2$PEDCOUNT
Wet_Ped_Totals <- (sum(PedTotal[, 'PEDCOUNT']))

PedTotal <- subset(WetData, PEDCYLCOUNT > 0)
y <- PedTotal2$PEDCYLCOUNT
Wet_Bike_Totals <- (sum(PedTotal[, 'PEDCYLCOUNT']))

Road_Conditions <- c("Wet")
Wet_Bike_Collisions <- c(1073)
Wet_Ped_Collisions <- c(94)
FinalTotalsWet <- data.frame(Road_Conditions, Wet_Bike_Collisions, Wet_Ped_Collisions)

Total_Collisions <- c(FinalTotals$Dry_Bike_Collisions, FinalTotals$Dry_Ped_Collisions, FinalTotalsWet$Wet_Bike_Collisions, FinalTotalsWet$Wet_Ped_Collisions) 
TotalCollisions <- as.data.frame(Total_Collisions)

FinalTotalsWet
Wet <- FinalTotalsWet$Road_Conditions
WetCollisions <- sum(1073 + 94)
DryCollisions <- sum(5212 + 5998)  
qplot(DryCollisions, WetCollisions, xlim = c(0, 12000), ylim = c(0, 12000), main = "Seattle Collisions Involving Pedestrian and Cyclists")


  
  

  