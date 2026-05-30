select 
-- identifiers 
cast(vendorID as int) as vendor_id,
cast(RatecodeID as int) as rate_code_id,
cast(puLocationID as int) as pu_location_id,
cast(doLocationID as int) as do_location_id,

--timestamps 
cast(tpep_pickup_datetime as timestamp) as pickup_datetime,
cast(tpep_dropoff_datetime as timestamp) as dropoff_datetime,

--trip info 
store_and_fwd_flag as store_and_fwd_flag,
cast(passenger_count as int) as passenger_count,
cast(trip_distance as float) as trip_distance,
1 as trip_type, -- fixing trip type to 1 for yellow taxi data, as it is not provided in the source data

--payment info
cast(fare_amount as numeric) as fare_amount,
cast(extra as numeric) as extra,
cast(mta_tax as numeric) as mta_tax,
cast(tip_amount as numeric) as tip_amount,
cast(tolls_amount as numeric) as tolls_amount,
0 as ehail_fee,  -- fixing ehail fee to 0 for yellow taxi data, as it is not provided in the source data
cast(improvement_surcharge as numeric) as improvement_surcharge,
cast(total_amount as numeric) as total_amount,
cast(payment_type as int) as payment_type,


from {{ source('raw_data', 'yellow_tripdata') }}






