select 
    count(*) as total_fhv_trips
from {{ ref("stg_fhv_tripdata")}}