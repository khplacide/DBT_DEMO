WITH CTE AS (
select
to_timestamp(STARTED_AT) as STARTED_AT,
date(to_timestamp(STARTED_AT)) as DATE_STARTED_AT,
hour(to_timestamp(STARTED_AT)) as HOUR_STARTED_AT,

{{day_type('STARTED_AT')}} AS DAY_TYPE,

{{get_season('STARTED_AT')}} as STATION_OF_YEAR

 from 
 {{ source('demo', 'bike') }}

where STARTED_AT != 'STARTED_AT'

)

select * from CTE