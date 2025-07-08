WITH CTE AS (
select
to_timestamp(STARTED_AT) as STARTED_AT,
date(to_timestamp(STARTED_AT)) as DATE_STARTED_AT,
hour(to_timestamp(STARTED_AT)) as HOUR_STARTED_AT,
CASE 
WHEN DAYNAME(to_timestamp(STARTED_AT)) in ('Sat','Sun')
THEN 'WEEKEND'
ELSE 'BUSINESSDAY'
END AS DAY_TYPE,
Month(to_timestamp(STARTED_AT)) as MONTH_STARTED_AT,

CASE 
WHEN Month(to_timestamp(STARTED_AT)) IN (12,1,2)
THEN 'WINTER'
WHEN Month(to_timestamp(STARTED_AT)) IN (3,4,5)
THEN 'SPRING'
WHEN Month(to_timestamp(STARTED_AT)) IN (6,7,8)
THEN 'SUMMER'
ELSE 'AUTUMN'
END AS STATION_OF_YEAR



 from 
 {{ source('demo', 'bike') }}

where STARTED_AT != 'STARTED_AT'

)

select * from CTE