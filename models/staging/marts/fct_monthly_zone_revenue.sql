with trips as (

    select *
    from {{ ref('fact_trips') }}

)

select 
    trip_type,
    pickup_zone,

    extract(year from pickup_datetime) as year,
    extract(month from pickup_datetime) as month,

    count(*) as total_monthly_trips,
    sum(total_amount) as revenue_monthly_total_amount
    

from trips
group by
    trip_type,
    pickup_zone,
    year,
    month


