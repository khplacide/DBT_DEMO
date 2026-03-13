SELECT DISTINCT
    t1.ind_id,
    {{ safe_to_date_from_yyyymmdd('t1.car1_buy_date') }} AS buy_date,
    t1.car1_response_date::date AS response_date_cars
FROM {{ source('cds_owner', 'cds_selectiontool_individuals') }} t1
WHERE t1.car1_buy_date IS NOT NULL
  AND t1.car1_buy_date <> '0'
