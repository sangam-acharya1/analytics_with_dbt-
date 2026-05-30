-- Using the fct_monthly_zone_revenue table, find the pickup zone with the highest total revenue (revenue_monthly_total_amount) for Green taxi trips in 2020.
select 
    pickup_zone,
    sum(revenue_monthly_total_amount) as total_revenue
from {{ ref('fct_monthly_zone_revenue') }}
where trip_type = 2        -- green taxis
  and year = 2020
group by pickup_zone
order by total_revenue desc
limit 5
