select 
    -- identifiers
    cast(dispatching_base_num as varchar) as dispatching_base_num,
    cast(PUlocationID as int) as pu_location_id,
    cast(DOlocationID as int) as do_location_id,
    cast(Affiliated_base_number as varchar) as affiliated_base_number,

    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropoff_datetime,

    -- trip info
    cast(SR_Flag as int) as sr_flag

from  {{ source('raw_data', 'fhv_tripdata') }}
