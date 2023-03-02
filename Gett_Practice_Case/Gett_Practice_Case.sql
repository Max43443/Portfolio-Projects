/*
SELECT *
FROM gett_data_offers;

SELECT *
FROM gett_data_orders;
*/
/*
Gett has requested we investigate some matching metrics for ride orders that were not completed successfully. They have given us the following tasks:
1. Build a distribution of orders according to reason for failure: cancellations before and after driver assigned and reasons for order rejection.
2. Plot distribution of failed orders by hours.
3. Plot the average time to cancellation with and without a driver, by the hour. Remove any outliers.
4. Plot the distribution of average ETA by hours.

We will first explore these questions with SQL before moving on to Tableau to plot the data and results visually. 
*/

/*
Question 1
- Count of orders that were cancelled before and after driver assignment. 0 = no driver and 1 = a driver was assigned.
- Combine with reasons for rejection, so this would be either order_status_key 4 or 9. 4 =  cancelled by client, 9 = cancelled by system.
*/

SELECT is_driver_assigned_key,
	   COUNT(*) AS driver_assigned_count
FROM gett_data_orders
GROUP BY is_driver_assigned_key;

SELECT order_status_key,
	   COUNT(*) AS status_count 
FROM gett_data_orders
GROUP BY order_status_key;


SELECT COUNT(*) AS total_order_count
FROM gett_data_orders;

/*
At first glance, the majority of rides were cancelled before a driver was assigned and cancelled by the client. But lets confirm this.
The first query breaks down the rides that did not have an assigned driver by cancellation reason and the second query breaks down rides
that did have an assigned driver by cancellation reason. Which confirms the category with the most cancellations was rides with no driver and 
cancelled by the client. 
*/

SELECT order_status_key,
	   COUNT(*) AS order_count
FROM gett_data_orders
WHERE is_driver_assigned_key = 0
GROUP BY order_status_key;

SELECT order_status_key,
	   COUNT(*) AS order_count
FROM gett_data_orders
WHERE is_driver_assigned_key = 1
GROUP BY order_status_key;


/*
Question 2
Build a distribution of failed orders by hour.

- I will need to extract and group by the hour of the day from the order_datetime column for this question.
*/

WITH sub AS (
	SELECT COUNT(*) AS order_count,
		   DATEPART(HOUR, order_datetime) AS hour_of_day
	FROM gett_data_orders
	GROUP BY order_datetime
	)
SELECT hour_of_day,
	   COUNT(*) AS order_count
FROM sub
GROUP BY hour_of_day
ORDER BY hour_of_day ASC;

/* 
I can also order by order_count DESC to show the hours of the day with the most cancellations. Looks like 8 am and then 10pm -12am are the top 5 hours with 
the most cancellations. 
*/

WITH sub AS (
	SELECT COUNT(*) AS order_count,
		   DATEPART(HOUR, order_datetime) AS hour_of_day
	FROM gett_data_orders
	GROUP BY order_datetime
	)
SELECT hour_of_day,
	   COUNT(*) AS order_count
FROM sub
GROUP BY hour_of_day
ORDER BY order_count DESC;


/*
Question 3
Plot the average time to cancellation with and without a driver, by the hour. Remove any outliers.
- get average time for orders with and without a driver
- group by hour, order DESC
- remove outliers, probably using some kind of WHERE statement
*/

WITH sub AS (
	SELECT DATEPART(HOUR, order_datetime) AS hour_of_day,
		   is_driver_assigned_key,
		   cancellations_time_in_seconds
	FROM gett_data_orders
	)
SELECT hour_of_day,
	   is_driver_assigned_key,
	   ROUND(AVG(cancellations_time_in_seconds), 2) AS average_time_in_sec
FROM sub
GROUP BY is_driver_assigned_key, hour_of_day
ORDER BY hour_of_day ASC;

/* 
I think a window function could possible work here too? this CTE is fine for now though.
*/


/*
Question 4 
Plot the distribution of average ETA by hours.
This will be kind of similar to the last solution. Find the average m_order_eta and group by the hour extracted from order_datetime.
*/

WITH sub AS (
	SELECT DATEPART(HOUR, order_datetime) AS hour_of_day,
		   m_order_eta
	FROM gett_data_orders
	)
SELECT hour_of_day,
	   ROUND(AVG(m_order_eta), 2) average_eta
FROM sub
GROUP BY hour_of_day
ORDER BY hour_of_day ASC;