This project folder contains the SQL code file, CSV and Tableau workbook file for my Apple Music daily listening data. The CSV contains data on my 
daily listening habits by artist and song from April 2018 to December 2022. 

I first uploaded this CSV to google sheets to clean and organize the data. 
I began by extracting the artist name and song title from the track description column. I also had to further clean some of the artist names because
a few of their extracted texts from the track description included multiple artist names in the follwing formart: "artist 1, artist 2 & artist 3". These had to be 
replaced with only the "artist 1" name to ensure accurate counting. Lastly, I extracted the year from date_played to make querying the data by year easier in PostgreSQL.  

Through SQL, I explored the most popular songs and artists, as well as converted the listening time provided in milliseconds to HH:MM:SS format for easier reading. 
Then I displayed the listening time for the top artists, songs, source type and years. 

The Tableau workbook contains a dashboard I created that consists of a top 10 artists by total minutes, top 10 songs by total minutes, total 
minutes spent listening to music by weekday and total minutes spent listening to music by month. There is a drop down filter so that the user may
pick which years are displayed on the dashboard at any time, or if they wish to view all 4 years at once. 
