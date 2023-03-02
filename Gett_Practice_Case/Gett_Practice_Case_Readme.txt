The following project was taken from Stratascrach.com's free data projects section of their website. 

This dataset was a previous take-home assignment from Gett, previously known as GetTaxi, is an Israeli-developed technology 
platform solely focused on corporate Ground Transportation Management (GTM). They have an application where clients can order taxis, 
and drivers can accept their rides (offers). At the moment, when the client clicks the Order button in the application, the matching 
system searches for the most relevant drivers and offers them the order. In this task, they would like us to investigate some matching metrics 
for orders that did not completed successfully, i.e., the customer didn't end up getting a car. 


The following tasks were requested of us: 

1. Build up distribution of orders according to reasons for failure: cancellations before and after driver assignment, and reasons for order rejection. 
   Analyse the resulting plot. Which category has the highest number of orders?
2. Plot the distribution of failed orders by hours. Is there a trend that certain hours have an abnormally high proportion of one category or another? 
   What hours are the biggest fails? How can this be explained?
3. Plot the average time to cancellation with and without driver, by the hour. If there are any outliers in the data, it would be better to remove them. 
   Can we draw any conclusions from this plot?
4. Plot the distribution of average ETA by hours. How can this plot be explained?


Below is a description of the two CSV files provided.

We have two data sets: data_orders and data_offers, both being stored in a CSV format. The data_orders data set contains the following columns:

order_datetime - time of the order
origin_longitude - longitude of the order
origin_latitude - latitude of the order
m_order_eta - time before order arrival
order_gk - order number
order_status_key - status, an enumeration consisting of the following mapping:
4 - cancelled by client,
9 - cancelled by system, i.e., a reject
is_driver_assigned_key - whether a driver has been assigned
cancellation_time_in_seconds - how many seconds passed before cancellation
The data_offers data set is a simple map with 2 columns:

order_gk - order number, associated with the same column from the orders data set
offer_id - ID of an offer


Process: 

I first imported the data_orders file into Excel to clean the data. I decided to convert the is_driver_assigned_key from 1 or 0 to "yes" or "no" for it to be 
easier to understand for any user. I also checked for any missing order numbers but there were none. I had no issues with the way the data was
presented in data_offers and left it as is.

Then I created a database within Microsoft SQL Server Management Studio to explore the problems listed above. I mostly used a few aggregate functions
and CTEs to find the answers.
Lastly, the datasets were imported into Tableau Desktop so that I could create the visuals for each of these questions. I also created a map with the 
longitude and latitude given in the dataset. I created a duel bar chart for question 1, comparing cancellation reasons broken down by whether or not a driver was 
assigned. For question 2, I created a duel chart as well, broken by the cancellation reason. It shows the count of failed orders by hour of the day.
For question 3, I decided first to plot everything with box & whiskers charts to see if we had any outliers, which we did not. I settled with a duel line chart,
I think it gives a simple visual representation of the findings that orders with driver's already assigned as a whole had longer average cancellation times. 
Question 4 also got a line chart to show the change in the average ETA throughout the day. Lastly, I decided to also add a heatmap showing the number of orders
by longitude and latitude, there is also a filter to select which hours of the day you would like to view. 