WITH TRIPS as (
select 
RIDE_ID,
--RIDEABLE_TYPE,
DATE(TO_TIMESTAMP(STARTED_AT)) AS date_trip,
start_statio_id as start_station_id,
END_STATION_ID,
MEMBER_CSUAL AS MEMBER_CASUAL,
timestampdiff(SECOND,TO_TIMESTAMP(STARTED_AT), TO_TIMESTAMP(STARTED_AT)) AS TRIP_DURATION_SEONDS

from {{ ref('stg_bike') }}
where RIDE_ID != '"ride_id"' and RIDE_ID != 'bikeid'

)

select
*
from TRIPS