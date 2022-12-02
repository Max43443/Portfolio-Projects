/* 
This query will explore the data provided by bike share company Capital Bikeshare for the year 2017. There are 4 tables that reflect the ride data for each quarter 
of the year 2017. Each table has the following columns: duration (seconds), start date, end date, start station number,
start station name, end station number, end station name, bike number and member type. 
A column called row_num was added to each table in order to join them more easily.
*/

/*
COPY public."q1_bikeshare" 
FROM 'C:\Users\Public\cleaned_2017Q1-capitalbikeshare-tripdata.csv'
DELIMITER ','
CSV HEADER;
*/

SELECT *
FROM q1_bikeshare;

--count of bikes in use.

SELECT COUNT(DISTINCT bike_number) AS bike_count
FROM q1_bikeshare;


--average ride duration in minutes and average ride duration split between member type. Surprisingly, casual users have a higher average ride time than members. 

SELECT ROUND(AVG(duration) / 60, 2) AS duration_avg_mins
FROM q1_bikeshare;


SELECT member_type, ROUND(AVG(duration) / 60, 2) AS duration_avg_mins
FROM q1_bikeshare
GROUP BY member_type;


/*
Start and end stations with the highest average ride durations in minutes.
*/

SELECT start_station,
	   ROUND(AVG(duration) / 60, 2) AS avg_duration_mins
FROM q1_bikeshare
GROUP BY start_station
ORDER BY avg_duration_mins DESC;



--finding the most popular start stations. 

SELECT start_station, COUNT(start_station) AS start_station_count
FROM q1_bikeshare
GROUP BY start_station
ORDER BY start_station_count DESC
LIMIT 25;


--Most popular end stations. 

SELECT end_station, COUNT(end_station) AS end_station_count
FROM q1_bikeshare
GROUP BY end_station
ORDER BY end_station_count DESC
LIMIT 25;


/* ranking both of the above quieries joined together for direct comparison. The top 5 stations to start and end at are the same, which would make sense as they are probably popular destinations in the city. 
after the top 5 though the lists begin to differ.
*/
SELECT *
FROM (
	SELECT RANK() OVER (ORDER BY COUNT(start_station) DESC) AS start_rank,
	   start_station, 
	   COUNT(start_station) AS start_station_count
	FROM q1_bikeshare
	GROUP BY start_station
	LIMIT 25) AS s
INNER JOIN 
	(SELECT RANK() OVER (ORDER BY COUNT(end_station) DESC) AS end_rank,
	   end_station, 
	   COUNT(end_station) AS end_station_count
	FROM q1_bikeshare
	GROUP BY end_station
	LIMIT 25) AS e
ON s.start_rank = e.end_rank;


--Are the majority of rides made by members or casual users? 

SELECT COUNT(member_type) FILTER(WHERE member_type = 'Member') AS member_count,
	   COUNT(member_type) FILTER(WHERE member_type = 'Casual') AS casual_count
FROM q1_bikeshare;


--Using a CTE to display total ride count, ride count for members and casual users along side their percentage of the total.

WITH subquery AS (
	SELECT COUNT(*)::numeric AS q1_ride_count,
		   COUNT(member_type) FILTER(WHERE member_type = 'Member') AS member_count,
	   	   COUNT(member_type) FILTER(WHERE member_type = 'Casual') AS casual_count
	FROM q1_bikeshare
)
SELECT q1_ride_count,
	   member_count,
	   TO_CHAR((member_count / q1_ride_count) * 100, 'fm99D00%') AS member_p,
	   casual_count,
	   TO_CHAR((casual_count / q1_ride_count) * 100, 'fm99D00%') AS casual_p
FROM subquery;



