{{ config(schema='finance') }}

WITH int_campaign AS (
    SELECT 
     date_date
     ,SUM(ads_cost_total) AS ads_cost_total
    FROM {{ref('int_campaign')}}
    GROUP BY date_date
),
orders AS (
    SELECT
     date_date
     ,SUM(operational_margin) AS operational_margin
    FROM {{ref('orders')}}
    GROUP BY date_date
)
SELECT
 o.date_date
 ,ROUND(o.operational_margin - i.ads_cost_total,2) AS ads_margin
FROM orders o 
LEFT JOIN int_campaign i 
USING(date_date)