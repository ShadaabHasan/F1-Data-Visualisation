# Formula 1 Data Visualisation

## Introduction
With the 2025 F1 season less than a week away, this project aims to explore historical Formula 1 data through statistical analysis and visualizations. Using various datasets related to races, drivers, teams, and results, we derive insights into performance trends, top drivers, and points distribution across seasons.

## Objectives
- Analyze F1 race data to identify patterns in performance.
- Visualize driver standings, constructor results, and race statistics.
- Use SQL-based queries in R to extract meaningful insights.
- Present findings using `ggplot2` for enhanced data storytelling.

## Datasets Used
The project utilizes multiple datasets, including:
- `races.csv`: Contains details of all races, including location and dates.
- `results.csv`: Records race outcomes, including points scored by drivers.
- `drivers.csv`: Information on F1 drivers, including their names and IDs.
- `constructors.csv`: Details about F1 teams (constructors).
- `lap_times.csv`: Stores lap-by-lap timing data.
- `qualifying.csv`: Records qualifying session results.

## Key Features & Analysis
1. **Top 10 Drivers by Total Points:**
   - Uses SQL (`sqldf`) to aggregate driver points and rank them.
   - Displays results in a horizontal bar chart with `ggplot2`.

2. **Top 10 Drivers by Total Wins:**
   - Uses SQL (`sqldf`) to aggregate driver wins and rank them.
   - Displays results in a horizontal bar chart with `ggplot2`.
  
3. **Distribution of points over the seasons:**
   - Track how the maximum points awarded to race winners have evolved over different seasons.
   - Uses SQL (`sqldf`) to find the maximum points given to a winner.
   
4. **Historical Trends in number of races per Year:**
   - Identifies the total number of races in each season.
   - Gives insight on the increasing number of races every year
   - Uses `ggplot2` to create a bar graph showing distribution over time.
   

5. **Fastest Lap at Each Circuit:**  
   - Identifies the fastest lap time set at each circuit in the 2025 calendar by a driver.  
   - Highlights performance trends across different tracks over time.  
   - Provides insight into car advancements and driver capabilities in Formula 1.

   
6. **Circuit Performance Analysis:**
   - Extracts race winners by circuit and visualizes dominance trends.
   - Color coded each bar to each driver for clear differentiation and better visual analysis

7. **Visualizing the 2021 F1 Season:**
   - Plotted driver points as a scatterplot to track their progression over the 2021 season.
   - Connected race points with lines to show how each driver’s performance evolved across different races.
   - Assigned unique colors to each driver for clear differentiation and better visual analysis.  

  
## Plots Gallery
Click on the plots to zoom in for a clearer view.
   <p align="center"><img src="https://github.com/user-attachments/assets/d17455eb-01b9-4b8b-a7a3-b3cbf8eeb1ea" width="32%" />
   <img src="https://github.com/user-attachments/assets/02d19c12-3a86-41a8-8924-d6b6e15cfb67" width="32%" />
   <img src="https://github.com/user-attachments/assets/b8b29693-db4c-4537-8d5c-14348efea5d7" width="32%"/>
   <img src="https://github.com/user-attachments/assets/c9eeac74-1fea-48ba-b5ae-1fe40e223f8a" width="32%" />
   <img src="https://github.com/user-attachments/assets/195769ab-b107-4eb0-b8db-07d3f9766b5e" width="32%" />
   <img src="https://github.com/user-attachments/assets/8cac5a4f-4354-48f8-8b38-d38a7d3a1dce" width="32%"/>
   <img src="https://github.com/user-attachments/assets/5ca131c8-2191-49df-aeda-22ba087bb01b" width="32%"/></p>




## Future Improvements
- Incorporate machine learning models for predictive analysis.
- Create an interactive dashboard for real-time analytics.
- Expand analysis to include weather and track conditions.

## Conclusion
This project provides valuable insights into F1 history and race performance through data-driven approaches. With further refinements, it can serve as a comprehensive tool for analyzing F1 statistics.

