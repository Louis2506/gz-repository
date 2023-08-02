SELECT
 orders_id
 ,shipping_fee
 ,logCost AS log_cost
 ,CAST(ship_cost AS FLOAT64) AS ship_cost
FROM `gz_raw_data.raw_gz_ship`