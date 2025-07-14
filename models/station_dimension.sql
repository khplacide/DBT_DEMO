WITH BIKE as (
select 
distinct
start_statio_id as start_station_id,
start_station_name,
start_lat,
start_lng
from {{ ref('stg_bike') }}
where RIDE_ID != 'ride_id'

)

select
*
from BIKE