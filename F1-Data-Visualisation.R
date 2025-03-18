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
  geom_histogram(stat="identity")+coord_flip()+ 
  labs(x="Driver", y="Number of Wins", title= "Top 10 drivers by most number of wins")

#Here we notice the the top 10 drivers by most number of wins is not the same as
#Top 10 drivers by total points
#We can use the data we have to figure out why there is a difference in the same
#Plotting the number of races in each year
  race_per_year <- races %>% count(year)
  view(race_per_year)
  ggplot(race_per_year, aes(x=year, y=n))+geom_bar(stat="identity")+
    labs(title="Number of Races Per Year in Formula 1",x="Year", y="Number of Races")
  
#Plotting total number of points per season
  max_points <- data.frame(sqldf("select a.year as Year, a.raceId as RaceId, 
                                   max(b.points) as Points, sum(b.points) as Total_points
                                   from races a
                                   left join results b on a.raceId=b.raceId
                                   group by year"))
  view(max_points)
  ggplot(total_points, aes(x=Year,y=Points))+geom_histogram(stat="identity")+
    labs(title="Maximum Points awarded to the Winner each season")
  
#We can see that there were 3 instances where the max points awarded to the drivers
#was changed, 1st in 1991 from 9 points to 10 points, 2nd in 2010 from 10 points to 25 points,
#then in 2019 from 25 points to 26 points
  
#Plotting the fastest lap times on each circuit 
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
  
  #Finding Drivers dominance over tracks based on the circuits in the 2025 race calendar
  circuit_wins <- data.frame(sqldf("select a.circuitId as CircuitId, b.driverID as DriverId,  c.driverRef as Driver,
                                        d.circuitRef as Circuit_Name,
                                        count(*) as Total_wins 
                                        from races a
                                        left join results b on a.raceId=b.raceId
                                        left join drivers c on b.driverId=c.driverId
                                        left join circuits d on d.circuitId=a.circuitId
                                        WHERE Position=1
                                        group by d.circuitId, b.driverId
                                        order by total_wins DESC
                                        "))
  view(circuit_wins)  
  str(circuit_wins)

  max_wins <- data.frame(sqldf("select a.CircuitId, a.Driver
                               ,a.Circuit_Name,max(a.Total_wins) as MaxWin
                               from circuit_wins a
                               where a.circuitId IN (1,17,22,3,77,79,21,6,4,7,70,9,13,11,39,14,73,15,69,32,18,80,78,24)
                               group by a.circuitId"))
  view(max_wins)
  ggplot(max_wins, aes(x=Circuit_Name, y=MaxWin, label=Driver, fill=Driver))+
    geom_bar(stat = "identity")+scale_fill_brewer(palette = "Set1")+
    theme(axis.text.x = element_text(angle = 90))
  
  
  