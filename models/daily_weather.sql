WITH daily_weather as (
select 
*
from
{{ source('demo', 'weather') }}
limit 10

)

select 
*
from daily_weather