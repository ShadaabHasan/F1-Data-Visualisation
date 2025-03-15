library(tidyverse)
library(sqldf)
library(ggplot2)
library(lubridate)
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
  geom_bar(stat = "identity", fill="blue") +
  coord_flip() +
  labs(title = "Top 10 F1 Drivers by Total Points", x = "Driver", y = "Total Points")

#Reordering the graph in descending order of points
ggplot(Data_Drivers_Points_Total, aes(x = reorder(Driver,Points_Total), y = Points_Total)) +
  geom_bar(stat = "identity", fill = "blue") +
  coord_flip() +
  labs(title = "Top 10 F1 Drivers by Total Points", x = "Driver", y = "Total Points")

races <- read_csv("F1 data/races.csv", col_types = cols(date = col_date(format = "%Y-%m-%d")))
view(races)
str(races)

#Plotting top 10 Drivers by Most number of wins in f1
Most_wins <- data.frame(sqldf("select b.driverID as DriverId,  c.driverRef as Driver,
                                        sum(Position) as Total_wins 
                                        from results b 
                                        left join drivers c on b.driverId=c.driverId
                                        WHERE Position=1
                                        group by Driver
                                        order by Total_wins DESC
                                        LIMIT 10"))
view(Most_wins)
ggplot(Most_wins, aes(x=reorder(Driver, Total_wins), y=Total_wins))+
  geom_histogram(stat="identity")+coord_flip()+ labs(x="Driver", y="Number of Wins", title= "Top 10 drivers by most number of wins")

#Plotting the number of races in each year
  race_per_year <- races %>% count(year)
  view(race_per_year)
  ggplot(race_per_year, aes(x=year, y=n))+geom_bar(stat="identity")+
    labs(title="Number of Races Per Year in Formula 1",x="Year", y="Number of Races")


#Plotting the fastest laptimes on each circuit geom_point()#Plotting the fastest laptimes on each circuit 
  lap_times <- read_csv("F1 data/lap_times.csv")
  lap_times <- lap_times %>%
    mutate(milliseconds = hour(time) * 60000 + minute(time)*1000, #since the time format is in hms instead of msms
           minutes = milliseconds %/% 60000,       # Extract minutes
           seconds = (milliseconds %% 60000) %/% 1000,  # Extract seconds
           milliseconds = milliseconds %% 1000,    # Extract milliseconds
           
           formatted_time = sprintf("%02d:%02d:%02d", minutes, seconds, milliseconds))    # Convert seconds to ms
  view(lap_times)
  laptime_distribution <- data.frame(sqldf("select a.driverId, a.driverRef as Driver, b.name as RaceName, 
                                           b.circuitId as CircuitId, c.formatted_time as LapTime, b.date as Date,
                                           MIN(c.formatted_time) AS Fastest_LapTime
                                           from lap_times c
                                           left join drivers a on a.driverId = c.driverId
                                           left join races b on b.raceId=c.raceId
                                           group by circuitId
                                           order by Fastest_LapTime Asc
                                           "))  
  
  laptime_distribution$Date <- as.Date(laptime_distribution$Date)
  laptime_distribution_final<- laptime_distribution[-(1:4),]
  
  view(laptime_distribution_final)  
  ggplot(laptime_distribution_final, aes(x=RaceName, y=Fastest_LapTime, label=Driver, color=Driver))+
    geom_point()+ theme(axis.text.x = element_text(angle = 55, hjust = 1))+ 
    labs(x="Circuit", y="Fastest Lap")
  
  #Circuit Dominance
  circuit_dominance <- data.frame(sqldf("select a.circuitId as CircuitId, a.raceId as RaceId, b.driverID as DriverId,  c.driverRef as Driver,
                                        b.position as Position,a.year as Year, sum(Position) as Total_wins from races a
                                        left join results b on a.raceId=b.raceId
                                        left join drivers c on b.driverId=c.driverId
                                        WHERE Position=1
                                        group by Driver
                                        order by Position ASC
                                        "))
view(circuit_dominance)  
