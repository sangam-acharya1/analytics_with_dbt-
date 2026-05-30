
with trips as (

    select *
    from {{ ref('int_trips_unioned') }}
),
zones as (
    select *
    from {{ ref('dim_zones') }}
),
joined as (
    select 
        t.*,
        pickup.borough as pickup_borough,
        pickup.zone as pickup_zone,
        pickup.service_zone as pickup_service_zone,

        dropoff.borough as dropoff_borough,
        dropoff.zone as dropoff_zone,
        dropoff.service_zone as dropoff_service_zone
    from trips t

    left join zones as pickup
        on t.pu_location_id = pickup.location_id

    left join zones as dropoff
        on t.do_location_id = dropoff.location_id
),
final as (
    select {{ dbt_utils.generate_surrogate_key([
        'pu_location_id', 
        'do_location_id', 
        'vendor_id', 
        'pickup_datetime', 
        'trip_distance'
        ]) }} as trip_id, 
        *
        from joined

)

select 
    *
from final
where extract(year from pickup_datetime) in (2019, 2020)

    
    
