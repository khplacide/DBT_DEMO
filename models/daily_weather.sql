WITH daily_weather as (

    select
    date(time) as daily_weather,
    Weather,
    temp as temperature,
    pressure,
    humidity,
    clouds
    from {{ source('demo', 'Weather') }}
 limit 10
),
daily_weather_agg as(
    select 
    daily_weather,
    Weather,
    round(avg(temperature),2) as avg_temp,
    round(avg(pressure),2) as avg_pressure,
    round(avg(humidity),2) as avg_humidity,
    round(avg(clouds),2) as avg_clouds
    from daily_weather
    group by 
    daily_weather,
    Weather

    qualify ROW_NUMBER() OVER (PARTITION BY daily_weather ORDER BY count(Weather) desc) = 1
)

select *
from daily_weather_agg