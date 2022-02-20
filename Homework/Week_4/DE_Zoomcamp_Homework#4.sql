--Question 1: What is the count of records in the model fact_trips after running all models with the test run variable 
--disabled and filtering for 2019 and 2020 data only (pickup datetime) *
--Answer: 61635151

--Question 2: What is the distribution between service type filtering by years 2019 and 2020 data as done in the videos . (Yellow/Green) *
--Answer: 89.9/10.1

--Question 3: What is the count of records in the model stg_fhv_tripdata after running all models with the test run variable disabled *
--Answer: 42084899

--Question 4: What is the count of records in the model fact_fhv_trips after running all dependencies with the test run variable disabled *
--Answer: 22676253

--Question 5: What will be the best partitioning or clustering strategy when filtering on dispatching_base_num and SR_Flag *
--Answer: Cluster by dispatching_base_num and SR_Flag

--Question 6: What improvements can be seen by partitioning and clustering for data size less than 1 GB *
--Answer: Huge improvement in data processed
--Answer: Huge improvement in query performance
