This dataset was taken from StrataScratch.com. They provide practice projects to users. This is a practice project from Doordash for the date range Jan. 21st 2015 - Feb. 18th 2015,
The location is not given. They wanted the user to determine the total delivery time for an order. I answered this question as well as explored some of my own questions I came up with while exploring the dataset.
The dataset consists of the following columns:

- market_id: A city/region in which DoorDash operates, e.g., Los Angeles, given in the data as an id
- created_at: Timestamp in UTC when the order was submitted by the consumer to DoorDash. (Note this timestamp is in UTC, but in case you need it, the actual timezone of the region was US/Pacific)
- actual_delivery_time: Timestamp in UTC when the order was delivered to the consumer
- store_id: an id representing the restaurant the order was submitted for
- store_primary_category: cuisine category of the restaurant, e.g., italian, asian
- order_protocol: a store can receive orders from DoorDash through many modes. This field represents an id denoting the protocol
- total_items: total number of items in the order
- subtotal: total value of the order submitted (in cents)
- num_distinct_items: number of distinct items included in the order
- min_item_price: price of the item with the least cost in the order (in cents)
- max_item_price: price of the item with the highest cost in the order (in cents)
- total_onshift_dashers: Number of available dashers who are within 10 miles of the store at the time of order creation
- total_busy_dashers: Subset of above total_onshift_dashers who are currently working on an order
- total_outstanding_orders: Number of orders within 10 miles of this order that are currently being processed.
- estimated_order_place_duration: Estimated time for the restaurant to receive the order from DoorDash (in seconds)
- estimated_store_to_consumer_driving_duration: Estimated travel time between store and consumer (in seconds)

I began by uploading the CSV to excel to clean the data. The columns subtotal, min_item_price and max_item_price were all obviously dollar amounts, 
however they were listed without any decimal points. I multiplied them by .01 and changed their number format to currency so they would have decimal points
in the correct spot and still show zeros where appropriate. I also replaced all "NA" values in the numeric/integer columns with null. Lastly, there was one outlier 
order where an order was placed in October and not completed until January. I deemed this as an error and did not include it to maintain accuracy of the dataset.

I then uploaded the cleaned CSV to PostgreSQL to learn more about the dataset. I found the range of dates the dataset covers, average time of order, 
orders by store category and more. Lastly, I uploaded the cleaned CSV to Tableau to create a dashboard, which includes average busy and onshift dashers by weekday,
order subtotal by food category and more. 