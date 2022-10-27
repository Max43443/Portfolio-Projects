--Exploring the changes and relationships of gold and silver prices from 1791 to 2020.

--How have gold prices changed year over year?

SELECT "Year", "Gold_Price",
	"Gold_Price" - LAG("Gold_Price") OVER (ORDER BY "Year") AS Gold_YOY_Change
FROM gold_silver;

--How have silver prices changed year over year?

SELECT "Year", "Silver_Price",
	"Silver_Price"::numeric - LAG("Silver_Price"::numeric) OVER (ORDER BY "Year") AS Silver_YOY_Change
FROM gold_silver;

--Is there a correlation between gold and silver prices?

SELECT CORR("Gold_Price", "Silver_Price") AS Correlation
FROM gold_silver;