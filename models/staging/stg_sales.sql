SELECT
  date_date
  ,orders_id
  ,pdt_id AS products_id
  ,revenue AS turnover
  ,quantity AS qty
FROM `gz_raw_data.raw_gz_sales`
WHERE revenue > 0