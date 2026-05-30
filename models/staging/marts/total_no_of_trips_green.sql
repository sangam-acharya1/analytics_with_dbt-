-- Using the fct_monthly_zone_revenue table, what is the total number of trips (total_monthly_trips) for Green taxis in October 2019?
select 
    sum(total_monthly_trips) as total_trips
from {{ ref('fct_monthly_zone_revenue') }}
where trip_type = 2       
  and year = 2019
  and month = 10           