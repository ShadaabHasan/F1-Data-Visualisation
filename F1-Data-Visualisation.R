library(tidyverse)
library(sqldf)
library(ggplot2)
circuits <- read_csv("F1 data/circuits.csv")
drivers <- read_csv("F1 data/drivers.csv")
results <- read_csv("F1 data/results.csv")
view(circuits)
view(results)
view(drivers)
#creating a data frame Data_Drivers_Points_Total that contains the top 10 drivers with the highest total points
Data_Drivers_Points_Total <- data.frame(sqldf("select a.driverRef as Driver, sum(b.points) as Points_Total 
         from results b left join drivers a on a.driverId = b.driverId
         group by driverRef
         order by -Points_Total
         limit 10"))
view(Data_Drivers_Points_Total)

ggplot(Data_Drivers_Points_Total, aes(x = Driver, y = Points_Total)) +
  geom_bar(stat = "identity", fill = "blue") +
  coord_flip() +
  labs(title = "Top 10 F1 Drivers by Total Points", x = "Driver", y = "Total Points")

#Reordering the graph in descending order of points
ggplot(Data_Drivers_Points_Total, aes(x = reorder(Driver,Points_Total), y = Points_Total)) +
  geom_bar(stat = "identity", fill = "blue") +
  coord_flip() +
  labs(title = "Top 10 F1 Drivers by Total Points", x = "Driver", y = "Total Points")

ggsave()
