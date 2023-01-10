/*
COPY public."daily_listens" 
FROM 'C:\Users\Public\Cleaned - Apple Music - Play History Daily Tracks.csv'
DELIMITER ','
CSV HEADER;
*/

SELECT *
FROM daily_listens;


/*
List of all artists listened to from 2018 - 2022. 
*/


SELECT DISTINCT artist
FROM daily_listens;


/*
Date range of the data set.
*/

SELECT MIN(date_played) AS start_date,
	   MAX(date_played) AS end_date
FROM daily_listens;



/*
Number of times a song by an artist was played. 
*/

SELECT DISTINCT artist,
	   SUM(play_count) AS play_counts
FROM daily_listens
GROUP BY artist
ORDER BY play_counts DESC;


/*
Most played songs by play count.
*/

SELECT DISTINCT song,
	   SUM(play_count) as counts
FROM daily_listens
GROUP BY song
ORDER BY counts DESC;

/*
Different sources used to listen to music.
*/

SELECT DISTINCT source_type
FROM daily_listens;


/*
total listening time per year in HH:MM:SS format.
*/

WITH subquery AS (
		SELECT (SUM(play_duration_ms)) / 1000 total_s,
			   year_played
		FROM daily_listens
		GROUP BY year_played
	)
SELECT TO_CHAR((total_s || ' second')::interval, 'HH24:MI:SS') AS total_play_time,
	   year_played
FROM subquery
ORDER BY year_played;

/*
Total play time for each source type.
*/

WITH subquery AS (
		SELECT DISTINCT source_type,
		(SUM(play_duration_ms)) / 1000 total_s
		FROM daily_listens
		GROUP BY source_type
	)
SELECT DISTINCT source_type,
	   TO_CHAR((total_s || ' second')::interval, 'HH24:MI:SS') AS total_play_time
FROM subquery
ORDER BY source_type;

/*
artists by total play time in HH:MM:SS.
*/

WITH sub AS (
		SELECT DISTINCT artist,
		(SUM(play_duration_ms)) / 1000 total_s
		FROM daily_listens
		GROUP BY artist
	)
SELECT DISTINCT artist,
	   TO_CHAR((total_s || ' second')::interval, 'HH24:MI:SS') AS total_play_time
FROM sub
ORDER BY total_play_time DESC;









