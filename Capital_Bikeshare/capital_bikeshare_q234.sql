/* This query will compare the data between the Q1, Q2, Q3 and Q4 bikeshare tables to see if there are any changes over the year in the bikeshare program usage. 
*/

/*
COPY public."q2_bikeshare" 
FROM 'C:\Users\Public\cleaned_2017Q2-capitalbikeshare-tripdata.csv'
DELIMITER ','
CSV HEADER;
*/

/*
COPY public."q3_bikeshare" 
FROM 'C:\Users\Public\cleaned_2017Q3-capitalbikeshare-tripdata.csv'
DELIMITER ','
CSV HEADER;
*/

/*
COPY public."q4_bikeshare" 
FROM 'C:\Users\Public\cleaned_2017Q4-capitalbikeshare-tripdata.csv'
DELIMITER ','
CSV HEADER;
*/

SELECT *
FROM q4_bikeshare;



--Ride duration for each quarter. 

SELECT 
	   ROUND(AVG(q1.duration) / 60, 2) AS q1_duration_avg_mins, 
	   ROUND(AVG(q2.duration) / 60, 2) AS q2_duration_avg_mins,
	   ROUND(AVG(q3.duration) / 60, 2) AS q3_duration_avg_mins,
	   ROUND(AVG(q4.duration) / 60, 2) AS q4_duration_avg_mins
FROM q1_bikeshare AS q1
INNER JOIN q2_bikeshare AS q2
ON q1.row_num = q2.row_num
INNER JOIN q3_bikeshare AS q3
ON q1.row_num = q3.row_num
INNER JOIN q4_bikeshare AS q4
ON q1.row_num = q4.row_num;



/*
Percentage change of ride count by member from quarter to quarter. Looks like Capital Bikeshare saw a decrease in member usage over the first 3 quarters.
*/

WITH subquery AS (
	SELECT COUNT(q1.member_type) FILTER(WHERE q1.member_type = 'Member')::numeric AS q1_member_count,
 	   	   COUNT(q2.member_type) FILTER(WHERE q2.member_type = 'Member')::numeric AS q2_member_count,
	       COUNT(q3.member_type) FILTER(WHERE q3.member_type = 'Member')::numeric AS q3_member_count,
 	       COUNT(q4.member_type) FILTER(WHERE q4.member_type = 'Member')::numeric AS q4_member_count
	FROM q1_bikeshare AS q1
	INNER JOIN q2_bikeshare AS q2
	ON q1.row_num = q2.row_num
	INNER JOIN q3_bikeshare AS q3
	ON q1.row_num = q3.row_num
	INNER JOIN q4_bikeshare AS q4
	ON q1.row_num = q4.row_num
)
SELECT TO_CHAR(((q2_member_count - q1_member_count) / q2_member_count) * 100, 'fm99D00%') AS q1_q2_p_change,
	   TO_CHAR(((q3_member_count - q2_member_count) / q3_member_count) * 100, 'fm99D00%') AS q2_q3_p_change,
	   TO_CHAR(((q4_member_count - q3_member_count) / q4_member_count) * 100, 'fm99D00%') AS q3_q4_p_change
FROM subquery;


/*
Percentage change of ride count by casual from quarter to quarter. This shows the opposite changes compared to the member % changes above. Casual users increased in the first 3 quarters but decreased
significantly towards the end of the year. 
*/ 

WITH subquery AS (
	SELECT COUNT(q1.member_type) FILTER(WHERE q1.member_type = 'Casual')::numeric AS q1_casual_count,
 	   	   COUNT(q2.member_type) FILTER(WHERE q2.member_type = 'Casual')::numeric AS q2_casual_count,
	       COUNT(q3.member_type) FILTER(WHERE q3.member_type = 'Casual')::numeric AS q3_casual_count,
 	       COUNT(q4.member_type) FILTER(WHERE q4.member_type = 'Casual')::numeric AS q4_casual_count
	FROM q1_bikeshare AS q1
	INNER JOIN q2_bikeshare AS q2
	ON q1.row_num = q2.row_num
	INNER JOIN q3_bikeshare AS q3
	ON q1.row_num = q3.row_num
	INNER JOIN q4_bikeshare AS q4
	ON q1.row_num = q4.row_num
)
SELECT TO_CHAR(((q2_casual_count - q1_casual_count) / q2_casual_count) * 100, 'fm99D00%') AS q1_q2_p_change,
	   TO_CHAR(((q3_casual_count - q2_casual_count) / q3_casual_count) * 100, 'fm99D00%') AS q2_q3_p_change,
	   TO_CHAR(((q4_casual_count - q3_casual_count) / q4_casual_count) * 100, 'fm99D00%') AS q3_q4_p_change
FROM subquery;


	









