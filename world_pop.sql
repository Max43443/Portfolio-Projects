--Exploring population data of the World's nations by year.

SELECT *
FROM world_population;


--Total world population for each year formatted with commas.

SELECT TO_CHAR(SUM("2022_population"), 'fm999G999G999G999') AS total_pop_2022, 
	   TO_CHAR(SUM("2020_population"), 'fm999G999G999G999') AS total_pop_2020, 
	   TO_CHAR(SUM("2015_population"), 'fm999G999G999G999') AS total_pop_2015, 
	   TO_CHAR(SUM("2010_population"), 'fm999G999G999G999') AS total_pop_2010, 
	   TO_CHAR(SUM("2000_population"), 'fm999G999G999G999') AS total_pop_2000,
	   TO_CHAR(SUM("1990_population"), 'fm999G999G999G999') AS total_pop_1990,
	   TO_CHAR(SUM("1980_population"), 'fm999G999G999G999') AS total_pop_1980, 
	   TO_CHAR(SUM("1970_population"), 'fm999G999G999G999') AS total_pop_1970
FROM world_population;


--Countries ranked by 2022 population

SELECT "rank", 
		"country_territory", 
		"2022_population"
FROM world_population
ORDER BY "rank";


--Top 5 most populous countries per year in dataset.

SELECT "rank", 
		"country_territory", 
		"2022_population", 
		"2020_population", 
		"2015_population", 
		"2010_population", 
		"2000_population",
		"1990_population", 
		"1980_population", 
		"1970_population"
FROM world_population
ORDER BY "rank"
LIMIT 5;


--change in population per country from 1970 to 2022 ordered in descending order from countries with the largest gains to largest losses.

SELECT "country_territory", 
		"2022_population", 
		"1970_population",
	    "2022_population" - "1970_population"  AS change_in_pop_1970_2022
FROM world_population
ORDER BY change_in_pop_1970_2022 DESC;


--change in population per country from 1970 to 2022 ordered in descending order from countries with the largest losses to largest gains.

SELECT "country_territory", 
		"2022_population", 
		"1970_population",
	    "2022_population" - "1970_population"  AS change_in_pop_1970_2022
FROM world_population
ORDER BY change_in_pop_1970_2022 ASC;


--year over year % change in population per country.
SELECT "country_territory",
			CONCAT(ROUND(("2022_population" - "2020_population") / "2020_population" * 100, 2), '%') AS "2022_2020_change",
			CONCAT(ROUND(("2020_population" - "2015_population") / "2015_population" * 100, 2), '%') AS "2020_2015_change",
			CONCAT(ROUND(("2015_population" - "2010_population") / "2010_population" * 100, 2), '%') AS "2015_2010_change",
			CONCAT(ROUND(("2010_population" - "2000_population") / "2000_population" * 100, 2), '%') AS "2010_2000_change",
			CONCAT(ROUND(("2000_population" - "1990_population") / "1990_population" * 100, 2), '%') AS "2000_1990_change",
			CONCAT(ROUND(("1990_population" - "1980_population") / "1980_population" * 100, 2), '%') AS "1990_1980_change",
			CONCAT(ROUND(("1980_population" - "1970_population") / "1970_population" * 100, 2), '%') AS "1980_1970_change"
FROM world_population
ORDER BY "country_territory";
	

--Current population size of the 10 countries with the highest area_sq_km.

SELECT "country_territory", 
		TO_CHAR("2022_population", 'fm999G999G999G999') AS current_pop, 
		TO_CHAR("area_sq_km", 'fm999G999G999G999') AS area_km
FROM world_population
ORDER BY "area_sq_km" DESC
LIMIT 10;

--Current population size of the 10 countries with the highest desnity_sq_km.

SELECT "country_territory", 
		TO_CHAR("2022_population", 'fm999G999G999G999') AS current_pop,
		TO_CHAR("density_sq_km", 'fm999G999G999G999') AS density_km
FROM world_population
ORDER BY "density_sq_km" DESC
LIMIT 10;


--Projected world population for 2023 using average global growth rate.
SELECT TO_CHAR(ROUND(avg_growth_rate * total_2022_pop, 2), 'fm999G999G999G999')  AS est_2023_pop
FROM
	(SELECT SUM("2022_population") AS world_pop_2022, AVG(growth_rate) AS avg_growth_rate
	 FROM world_population) AS subquery;
	 

