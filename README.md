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
     ![image](https://github.com/user-attachments/assets/117b17e9-80b7-4112-ac98-821b907d1b7c)



2. **Historical Trends in number of races per Year:**
   - Identifies the total number of races in each season.
   - Gives insight on the increasing number of races every year
   - Uses `ggplot2` to create a bar graph showing distribution over time.
     ![image](https://github.com/user-attachments/assets/8ddb575c-2881-4b9a-8b4f-a7a58db0844e)


3. **Circuit Performance Analysis:**
   - Extracts race winners by circuit and visualizes dominance trends.

## Future Improvements
- Incorporate machine learning models for predictive analysis.
- Create an interactive dashboard for real-time analytics.
- Expand analysis to include weather and track conditions.

## Conclusion
This project provides valuable insights into F1 history and race performance through data-driven approaches. With further refinements, it can serve as a comprehensive tool for analyzing F1 statistics.

