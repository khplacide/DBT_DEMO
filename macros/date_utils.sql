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

{#
  safe_to_date_from_yyyymmdd: safely converts a YYYYMMDD-formatted string column
  to a PostgreSQL date, returning NULL when the date is invalid (e.g. month 00,
  day 00, month > 12, day out of range for given month) instead of raising an error.
#}
{% macro safe_to_date_from_yyyymmdd(date_col) %}
    CASE
        WHEN {{ date_col }} IS NOT NULL
            AND length({{ date_col }}) = 8
            AND {{ date_col }} ~ '^\d{8}$'
            AND substr({{ date_col }}, 5, 2)::int BETWEEN 1 AND 12
            AND substr({{ date_col }}, 7, 2)::int BETWEEN 1 AND 31
            AND NOT (
                substr({{ date_col }}, 5, 2)::int IN (4, 6, 9, 11)
                AND substr({{ date_col }}, 7, 2)::int > 30
            )
            AND NOT (
                substr({{ date_col }}, 5, 2)::int = 2
                AND substr({{ date_col }}, 7, 2)::int > 29
            )
            AND NOT (
                substr({{ date_col }}, 5, 2)::int = 2
                AND substr({{ date_col }}, 7, 2)::int = 29
                AND NOT (
                    substr({{ date_col }}, 1, 4)::int % 4 = 0
                    AND (
                        substr({{ date_col }}, 1, 4)::int % 100 != 0
                        OR substr({{ date_col }}, 1, 4)::int % 400 = 0
                    )
                )
            )
        THEN to_date(
            concat_ws('/',
                substr({{ date_col }}, 1, 4),
                substr({{ date_col }}, 5, 2),
                substr({{ date_col }}, 7, 2)
            ),
            'YYYY/MM/DD'
        )
        ELSE NULL
    END
{% endmacro %}