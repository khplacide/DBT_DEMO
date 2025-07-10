{% macro get_season(x) %}

CASE 
WHEN Month(to_timestamp({{x}})) IN (12,1,2)
THEN 'WINTER'
WHEN Month(to_timestamp({{x}})) IN (3,4,5)
THEN 'SPRING'
WHEN Month(to_timestamp({{x}})) IN (6,7,8)
THEN 'SUMMER'
ELSE 'AUTUMN'
END
{% endmacro %}

{% macro day_type(x) %}
CASE
WHEN DAYNAME(to_timestamp({{x}})) in ('Sat','Sun')
THEN 'WEEKEND'
ELSE 'BUSINESSDAY'
END 

{% endmacro %}