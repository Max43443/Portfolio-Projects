This dataset is from Capital Bikeshare, a bike share company based in the Metro DC area. They provide
data for each year on their website for free. The first SQL code file explores data from Q1 of 2017.
I mainly explored how the use of the bikeshare program changes throughout the year for both member and casual users, 
as well as the change in the number of users that are either casual or members.
Some skills showcased are averages to find average ride times for member and casual users,
finding the most popular start and end stations and ranking them using window functions, then joining these two 
results to compare, and using a CTE to display total ride count for both members and casual users
as well as their percentage of the total. 

The second SQL code file uses joins, CTEs and subqueries to compare the data in all four quarters of 2017. 
I started here with finding the average ride duration for each quarter and converting them from seconds to minutes. 
I also compared the percentage change in ride count for members and casual users quarter to quarter. These results were 
formatted to two decimal places and added a % for easier reading. 

Also in this folder are 3 JPG files for previewing the Tableau dashboard I created for this dataset. The dashboard displays
two bar charts, containing the top and bottom 10 stations. A line chart displaying change in total users month-to-month by casual
and member users. As well as a line chart displaying change in average ride duration month-to-month by casual and member users.
The second page contains the follow metrics: user count broken down by member and casual users, total bike count and total station count. 
There is also a map containing every station location. This page can be filtered for the entire year or individual months.
Lastly, the third page is a heat map showing where the most popular stations are and can also be filtered on the entire year or individual months.
