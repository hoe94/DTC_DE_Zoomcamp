CREATE OR REPLACE EXTERNAL TABLE `dtc-de-course-hoe.trips_data_all.fhv_trips`
OPTIONS (
  format = 'Parquet',
  uris = ['gs://dtc_data_lake_dtc-de-course-hoe/raw/fhv_output_2019-*.parquet']
);

--Question 1: What is count for fhv vehicles data for year 2019 *
select count(*) from `dtc-de-course-hoe.trips_data_all.fhv_trips`

--Question 2: How many distinct dispatching_base_num we have in fhv for 2019 *
select count(distinct(dispatching_base_num)) from `dtc-de-course-hoe.trips_data_all.fhv_trips`

--Question 3: Best strategy to optimise if query always filter by dropoff_datetime and order by dispatching_base_num *
--Answer: Partition by dropoff_datetime and cluster by dispatching_base_num

--Question 4: What is the count, estimated and actual data processed for query which counts trip between 2019/01/01 and 2019/03/31 for dispatching_base_num B00987, B02060, B02279 *
CREATE OR REPLACE TABLE dtc-de-course-hoe.trips_data_all.fhv_trips_partitoned_clustered
PARTITION BY DATE(dropoff_datetime	)
CLUSTER BY dispatching_base_num AS
select * from `dtc-de-course-hoe.trips_data_all.fhv_trips`
where dropoff_datetime between  '2019-01-01' and '2019-03-31'
and dispatching_base_num in ('B00987', 'B02060', 'B02279');

select count(dispatching_base_num) from dtc-de-course-hoe.trips_data_all.fhv_trips_partitoned_clustered

--Answer: Count: 26558, Estimated data processed: 155 MB, Actual data processed: 400 MB

--Question 5: What will be the best partitioning or clustering strategy when filtering on dispatching_base_num and SR_Flag *
--Answer: Cluster by dispatching_base_num and SR_Flag

--Question 6: What improvements can be seen by partitioning and clustering for data size less than 1 GB *
--Answer: Huge improvement in data processed
--Answer: Huge improvement in query performance
