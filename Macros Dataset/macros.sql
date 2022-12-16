/*
COPY public."macros" 
FROM 'C:\Users\Public\macros_dataset.csv'
DELIMITER ','
CSV HEADER;
*/


SELECT * 
FROM macros;



/*
Which foods have the highest protein content?
*/

SELECT food_name, proteins_100g, category_name, diet_type
FROM macros
ORDER BY proteins_100g DESC;


/*
top 5 foods with highest protein count per diet type.
*/

SELECT *
FROM ( SELECT
	     ROW_NUMBER() OVER (PARTITION BY diet_type ORDER BY proteins_100g DESC) AS rank,
	   	 food_name, 
	   	 proteins_100g,
	  	 diet_type
	   FROM macros) AS subquery
WHERE rank <= 5;


/* 
top 5 foods with the highest protein count per food category.
*/

SELECT *
FROM ( SELECT
	     ROW_NUMBER() OVER (PARTITION BY category_name ORDER BY proteins_100g DESC) AS rank,
	   	 food_name, 
	   	 proteins_100g,
	  	 category_name
	   FROM macros) AS subquery
WHERE rank <= 5;


/*
Which foods have a high protein count but also below average counts of carbs and fat?
*/

WITH subquery AS (
	SELECT AVG(carbs_100g) AS avg_carbs,
		   AVG(fat_100g) AS avg_fat
	FROM macros
	)
	
SELECT food_name, 
	   proteins_100g, 
	   carbs_100g, 
	   fat_100g
FROM macros
WHERE carbs_100g < (SELECT avg_carbs FROM subquery) AND
	  fat_100g < (SELECT avg_fat FROM subquery)
ORDER BY proteins_100g DESC;
	   
	   
	   




	   
