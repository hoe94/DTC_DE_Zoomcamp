-- Question 3. Count Records
-- How many taxi trips were there on January 15? Consider only trips that started on January 15.
-- Answer:
SELECT count(*)
FROM yellow_taxi_trips t JOIN zones zpu ON t."PULocationID" = zpu."LocationID" JOIN zones zdo ON t."DOLocationID" = zdo."LocationID"
WHERE tpep_pickup_datetime between '2021-01-15' and '2021-01-16'


-- Question 4. Largest tip for each day
-- Find the largest tip for each day. 
-- On which day it was the largest tip in January? 
-- Use the pick up time for your calculations. (note: it's not a typo, it's "tip", not "trip")
-- Answer:
SELECT CAST(tpep_pickup_datetime as DATE) as "Date", MAX(tip_amount) as "tip_amount"
FROM yellow_taxi_trips t JOIN zones zpu ON t."PULocationID" = zpu."LocationID" JOIN zones zdo ON t."DOLocationID" = zdo."LocationID"
group by CAST(tpep_pickup_datetime as DATE)
order by "tip_amount" desc

-- Question 5. Most popular destination
-- What was the most popular destination for passengers picked up in central park on January 14?
-- Use the pick up time for your calculations.
-- Enter the zone name (not id). If the zone name is unknown (missing), write "Unknown"
-- Answer:
SELECT "Zone", count(*) AS "count"
FROM yellow_taxi_trips t JOIN zones zdo ON t."DOLocationID" = zdo."LocationID"
WHERE CAST(tpep_pickup_datetime as DATE) = '2021-01-14' AND "PULocationID" = 43
GROUP BY "Zone"
ORDER BY "count" desc

-- Question 6. Most expensive locations
-- What's the pickup-dropoff pair with the largest average price for a ride (calculated based on total_amount)?
-- Enter two zone names separated by a slash
-- For example: "Jamaica Bay / Clinton East"
-- If any of the zone names are unknown (missing), write "Unknown". For example, "Unknown / Clinton East".
--Answer:
select CONCAT(zpu."Zone" , ' / ' , zdo."Zone") AS "location", AVG(total_amount) as "avg_total_amount"
FROM yellow_taxi_trips t JOIN zones zpu ON t."PULocationID" = zpu."LocationID" JOIN zones zdo ON t."DOLocationID" = zdo."LocationID"
GROUP BY CONCAT(zpu."Zone" , ' / ' , zdo."Zone")
ORDER BY "avg_total_amount" desc

select CONCAT(zpu."Zone" , ' / ' , coalesce(zdo."Zone", 'Unknown')) AS "location", AVG(total_amount) as "avg_total_amount"
FROM yellow_taxi_trips t JOIN zones zpu ON t."PULocationID" = zpu."LocationID" JOIN zones zdo ON t."DOLocationID" = zdo."LocationID"
GROUP BY CONCAT(zpu."Zone" , ' / ' , coalesce(zdo."Zone", 'Unknown'))
ORDER BY "avg_total_amount" desc