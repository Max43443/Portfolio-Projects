/* This is the query written to help answer the questions posed by the marketing team in the readme.
*/

/*
COPY public."pet_sales" 
FROM 'C:\Users\Public\pet_sales_cleaned.csv'
DELIMITER ','
CSV HEADER; 
*/

SELECT *
FROM pet_sales;


/* 1. How many products are being purchased more than once? */

SELECT re_buy, COUNT(*)
FROM pet_sales
GROUP BY re_buy;


/* 2. Do the products being purchased again have better sales than others? */

SELECT re_buy, SUM(sales)
FROM pet_sales
GROUP BY re_buy;


/* 3. What products are more likely to be purchased again for different types of pets? */ 


SELECT DISTINCT product_category, pet_type, COUNT(*)
FROM pet_sales
WHERE re_buy = 1
GROUP BY product_category, pet_type
ORDER BY pet_type;

