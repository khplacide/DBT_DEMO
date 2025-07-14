WITH CTE AS(
    select 
    t.*,
    w.*

    from {{ ref('trip_fact') }} t 
    left join {{ ref('daily_weather') }} w 
    on t.date_trip = w.daily_weather

)

select *
from CTE