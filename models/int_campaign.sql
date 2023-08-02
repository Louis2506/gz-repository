{{ config( 
    materialized='table' 
    ,partition_by={ 
        "field":"date_date" 
        ,"data_type":"date" 
        ,"granularity":"day"
        }
    
        )}}

WITH union_ads AS (
    SELECT * FROM {{ref('stg_adwords')}}
    UNION ALL
    SELECT * FROM {{ref('stg_bing')}}
    UNION ALL
    SELECT * FROM {{ref('stg_criteo')}}
    UNION ALL
    SELECT * FROM {{ref('stg_facebook')}}
)
SELECT
 campaign_name
 ,paid_source
 ,date_date
 ,SUM(ads_cost) AS ads_cost_total
 ,SUM(click) AS click_total
 ,SUM(impression) AS impression_total
 ,ROW_NUMBER() OVER(ORDER BY campaign_name) AS campaign_nb
FROM union_ads
GROUP BY campaign_name, date_date, paid_source