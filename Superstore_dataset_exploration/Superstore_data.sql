--Exploration of a superstore company's store locations, products, sales and their profits. 

SELECT *
FROM superstore_data;


--list of locations by city and state.

SELECT DISTINCT "state", 
	   "city", 
	   "region"
FROM superstore_data
ORDER BY "state", "region";

--count of stores per region.

SELECT "region", 
		COUNT(DISTINCT "city") AS "num_stores_per_region"
FROM superstore_data
GROUP BY "region"
ORDER BY "num_stores_per_region" DESC;

--list of categories and their subcategories

SELECT DISTINCT "category", 
	   "sub_category"
FROM superstore_data
GROUP BY "category", "sub_category";


--List of states from most to least profitable.

SELECT DISTINCT "state", 
	   SUM("profit")::money AS total_profit
FROM superstore_data
GROUP BY "state"
ORDER BY total_profit DESC;


--top 5 most profitable and 5 least profitable states. 

SELECT *
FROM 
	(SELECT DISTINCT "state", SUM("profit")::money AS city_profit
	 FROM superstore_data
 	 GROUP BY "state"
	 ORDER BY city_profit DESC
	 LIMIT 5
	 ) AS subquery1
UNION 
SELECT *
FROM 
	(SELECT DISTINCT "state", SUM("profit")::money AS city_profit
	 FROM superstore_data
	 GROUP BY "state"
	 ORDER BY city_profit ASC
	 LIMIT 5
	 ) AS subquery2
ORDER BY city_profit DESC;


--Which categories and subcategories have the most and least sales? 

SELECT DISTINCT "category", 
	   "sub_category", 
	   SUM(sales)::money AS total_sales
FROM superstore_data
GROUP BY "category", "sub_category"
ORDER BY "total_sales" DESC;


--categories broken down into subcategories with totals for each sub-category and a running total for each category. 
SELECT *, 
	   SUM("sub_totals") 
	   OVER (PARTITION BY "category" ORDER BY "total_profit_per_sub_category"
			ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "category_totals"
FROM (
	  SELECT DISTINCT "category", 
	   	"sub_category",
		 SUM("profit"::money) OVER(PARTITION BY "sub_category") AS sub_totals
	  FROM superstore_data) AS total_profit_per_sub_category;

--locations with the highest losses broken down to specific city/state along with the specific sub-category that has the highest loss there. 
--It appears tech/machines are the leading losers in the sub-categories across the country. 


SELECT "city", 
	   "state", 
	   "category", 
	   "sub_category", 
	   SUM("profit"::money) AS total_loss
FROM superstore_data
GROUP BY "city", "profit", "state", "category", "sub_category"
HAVING "profit" < 0
ORDER BY "total_loss" ASC
LIMIT 10;


--Lets see which city/states and sub-categories are the highest earners.
--It appears tech/copiers are responsible for the highest profits. 


SELECT "city", 
	   "state", 
	   "category", 
	   "sub_category", 
	   SUM("profit"::money) AS total_profit
FROM superstore_data
GROUP BY "city", "profit", "state", "category", "sub_category"
HAVING "profit" > 0
ORDER BY "total_profit" DESC
LIMIT 10;
