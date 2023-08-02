{{ config(schema='transaction') }}

WITH orders AS (
SELECT
 sa.orders_id
 ,sa.date_date
 ,SUM(sa.turnover) AS turnover
 ,SUM(sa.purchase_cost) AS purchase_cost
 ,SUM(sa.product_margin) AS product_margin
 ,SUM(sa.purchase_price) AS purchase_price
FROM {{ref('sales')}} sa
GROUP BY orders_id, date_date
),
orders_ship AS (
SELECT
 o.orders_id
 ,o.date_date
 ,o.turnover
 ,o.purchase_cost
 ,o.product_margin
 ,o.purchase_price
 ,sh.shipping_fee
 ,sh.log_cost
 ,sh.ship_cost
FROM orders o
LEFT JOIN {{ref('stg_ship')}}  sh
USING (orders_id) 
)
SELECT
 os.*
 ,product_margin + shipping_fee - ship_cost - log_cost AS operational_margin
FROM orders_ship os