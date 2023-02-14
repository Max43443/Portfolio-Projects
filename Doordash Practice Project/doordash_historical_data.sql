/*
COPY public."doordash" 
FROM 'C:\Users\Public\doordash_historical_data_cleaned.csv'
DELIMITER ','
CSV HEADER;
*/

SELECT *
FROM doordash;

/*
Date range of dataset.
*/

SELECT MIN(created_at) AS start_datetime,
	   MAX(created_at) AS end_datetime
FROM doordash;

/*
Average time from creation of order to delivery to consumer
*/

SELECT AVG(actual_delivery_time - created_at) AS average_time_to_delivery
FROM doordash;


/*
Average time from creation of order to delivery to consumer by month.
*/

SELECT EXTRACT(MONTH FROM created_at) AS month_of_order,
		AVG(actual_delivery_time - created_at) AS average_time_to_delivery
FROM doordash
GROUP BY month_of_order;




/*
Number of orders by store category
*/

SELECT DISTINCT store_primary_category,
	   COUNT(*) AS order_count
FROM doordash
GROUP BY store_primary_category
ORDER BY order_count DESC;


/*
Average order total by category.
*/

SELECT DISTINCT store_primary_category,
	   ROUND(AVG(subtotal), 2)::money AS order_average
FROM doordash
GROUP BY store_primary_category
ORDER BY order_average DESC;


/*
when orders were created and their Number of orders, average onshift dashers, average busy dashers and average outstanding orders by early morning (3am - 6am), morning(6am - 12pm), afternoon(12pm - 6pm),
evening (6pm - 9pm), night (9pm - 12am) and late night (12am - 3am).
*/

WITH SUB AS (
SELECT 	CASE 
		WHEN EXTRACT(HOUR FROM created_at) >= 03 AND EXTRACT(HOUR FROM created_at) < 06 THEN 'Early Morning'
		WHEN EXTRACT(HOUR FROM created_at) >= 06 AND EXTRACT(HOUR FROM created_at) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM created_at) >= 12 AND EXTRACT(HOUR FROM created_at) < 17 THEN 'Afternoon'
		WHEN EXTRACT(HOUR FROM created_at) >= 17 AND EXTRACT(HOUR FROM created_at) < 21 THEN 'Evening'
		WHEN EXTRACT(HOUR FROM created_at) >= 21 AND EXTRACT(HOUR FROM created_at) <= 24 THEN 'Night'
		WHEN EXTRACT(HOUR FROM created_at) >= 00 AND EXTRACT(HOUR FROM created_at) < 03 THEN 'Late Night'
		END time_of_day,
		COUNT(*) AS total_orders,
		ROUND(AVG(total_onshift_dashers), 0) AS average_onshift_dashers,
		ROUND(AVG(total_busy_dashers), 0) AS average_busy_dashers,
		ROUND(AVG(total_outstanding_orders), 0) AS average_outstanding_orders
FROM doordash
GROUP BY CASE 
		WHEN EXTRACT(HOUR FROM created_at) >= 03 AND EXTRACT(HOUR FROM created_at) < 06 THEN 'Early Morning'
		WHEN EXTRACT(HOUR FROM created_at) >= 06 AND EXTRACT(HOUR FROM created_at) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM created_at) >= 12 AND EXTRACT(HOUR FROM created_at) < 17 THEN 'Afternoon'
		WHEN EXTRACT(HOUR FROM created_at) >= 17 AND EXTRACT(HOUR FROM created_at) < 21 THEN 'Evening'
		WHEN EXTRACT(HOUR FROM created_at) >= 21 AND EXTRACT(HOUR FROM created_at) <= 24 THEN 'Night'
		WHEN EXTRACT(HOUR FROM created_at) >= 00 AND EXTRACT(HOUR FROM created_at) < 03 THEN 'Late Night'
		END
	)
SELECT *
FROM sub
ORDER BY CASE 
		WHEN time_of_day = 'Early Morning' THEN 1
		WHEN time_of_day = 'Morning' THEN 2
		WHEN time_of_day = 'Afternoon' THEN 3
		WHEN time_of_day = 'Evening' THEN 4
		WHEN time_of_day = 'Night' THEN 5
		WHEN time_of_day = 'Late Night' THEN 6
		END

