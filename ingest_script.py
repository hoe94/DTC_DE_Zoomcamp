import os

from time import time
from sqlalchemy import create_engine
import pandas as pd



#def ingest_callable(user, password, host, port, db, table_name, csv_file):
def ingest_callable(table_name, csv_file):
    print(table_name, csv_file)
    user = 'root'
    password = 'root'
    host = 'postgres_db'
    port = 5432
    db = 'ny_taxi'
    #port = int(5432 if port is None else port)
    #table_name = params.table_name
    #csv_file = 'output.csv'
    
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    engine.connect()
    print('connection established successfully, inserting data...')
    
    t_start = time()
    df_iter = pd.read_csv(csv_file, iterator = True, chunksize = 100000)
    df = next(df_iter)
    
    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
    
    df.head(n = 0).to_sql(name = table_name, con = engine, if_exists = 'replace')
    df.to_sql(name = table_name, con = engine, if_exists = 'append')
    t_end = time()
    print('inserted the first chunk..., took %.3f second' % (t_end - t_start))
    
    while True:
        t_start = time()
    
        df = next(df_iter)
    
        df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
        df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
    
        df.to_sql(name = table_name, con = engine, if_exists = 'append')
    
        t_end = time()
    
        print('inserted another chunk..., took %.3f second' % (t_end - t_start))

#if __name__ == '__main__':
#    ingest_callable('root','root','localhost',5431, 'ny_taxi', 'yellow_taxi_trips', 'C:/Users/Hoe/Desktop/Learning/DataTalksClub_DE_ZoomCamp/output.csv')







