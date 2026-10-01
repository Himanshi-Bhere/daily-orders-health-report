USE OlistAnalytics;
GO

-- TOTAL ORDERS --
SELECT
      COUNT(*) AS total_orders
      FROM olist_orders_dataset;

-- HOW MANY ORDERS BELONGS TO EACH ORDER STATUS --
SELECT 
      order_status,
      COUNT(*) AS order_count      
FROM olist_orders_dataset
GROUP BY order_status;

-- FIND THE DATA RANGE--
SELECT 
      MIN(order_purchase_timestamp) AS first_order,
      MAX(order_purchase_timestamp) AS last_order
      FROM olist_orders_dataset;

-- FIND LAST 90 DAYS OF DATA 
SELECT 
     DATEADD(DAY, -90, MAX(order_purchase_timestamp)) AS start_date,
     MAX(order_purchase_timestamp) AS end_date
     FROM olist_orders_dataset;

-- ORDERS PLACES IN THE LAST 90 DAYS 
SELECT 
      COUNT(*) AS ORDERS_PLACED
      FROM olist_orders_dataset
      WHERE order_purchase_timestamp >= '2018-07-19 17:30:18.000'
      AND order_purchase_timestamp <= '2018-10-17 17:30:18' ;

-- DELIVERED ORDERS IN LAST 90 DAYS 
SELECT 
     COUNT(*) AS ORDER_DELIVERED
     FROM olist_orders_dataset
     WHERE order_purchase_timestamp >= '2018-07-19 17:30:18.000'
      AND order_purchase_timestamp <= '2018-10-17 17:30:18' 
      AND order_status = 'delivered'

-- CANCELED ORDERS IN LAST 90 DAYS
SELECT 
     COUNT(*) AS ORDER_CANCELED
     FROM olist_orders_dataset
     WHERE order_purchase_timestamp >= '2018-07-19 17:30:18.000'
      AND order_purchase_timestamp <= '2018-10-17 17:30:18' 
      AND order_status = 'canceled';

-- LATE DELIVERIED IN LAST 90 DAYS 
SELECT 
     COUNT(*) AS LATE_DELIVERED
     FROM olist_orders_dataset
     WHERE order_purchase_timestamp >= '2018-07-19 17:30:18.000'
      AND order_purchase_timestamp <= '2018-10-17 17:30:18' 
      AND order_status = 'delivered'
      AND order_delivered_customer_date > order_estimated_delivery_date ;

-- AVERAGE DELIVERIES DAYS IN LAST 90 DAYS
SELECT 
      AVG(
          CAST(
               DATEDIFF(
                         DAY, 
                         order_purchase_timestamp,
                         order_delivered_customer_date
                         ) AS FLOAT
                         )
                         ) AS average_delivery_days
        FROM olist_orders_dataset
     WHERE order_purchase_timestamp >= '2018-07-19 17:30:18.000'
      AND order_purchase_timestamp <= '2018-10-17 17:30:18' 
      AND order_status = 'delivered'

 -- 10. DAILY ORDERS PLACED

SELECT
    CAST(order_purchase_timestamp AS DATE) AS order_date,
    COUNT(*) AS orders_placed
FROM olist_orders_dataset
WHERE order_purchase_timestamp >= '2018-07-19 17:30:18.000'
  AND order_purchase_timestamp <= '2018-10-17 17:30:18'
GROUP BY CAST(order_purchase_timestamp AS DATE)
ORDER BY order_date;


-- 11. DAILY ORDERS DELIVERED
SELECT 
     CAST(order_delivered_customer_date AS DATE) AS delivery_date,
     COUNT(*) AS orders_delivered
FROM olist_orders_dataset
WHERE order_purchase_timestamp >= '2018-07-19 17:30:18.000'
  AND order_purchase_timestamp <= '2018-10-17 17:30:18'
  AND order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL 
GROUP BY CAST(order_delivered_customer_date AS DATE)
ORDER BY delivery_date ;


-- 12. DAILY CANCELLED ORDERS
SELECT
    CAST(order_purchase_timestamp AS DATE) AS order_date,
    COUNT(*) AS orders_cancelled
FROM dbo.olist_orders_dataset
WHERE order_purchase_timestamp >= '2018-07-19 17:30:18.000'
  AND order_purchase_timestamp <= '2018-10-17 17:30:18'
  AND order_status = 'canceled'
GROUP BY CAST(order_purchase_timestamp AS DATE)
ORDER BY order_date;


-- 13. DAILY LATE DELIVERIES
SELECT 
     CAST(order_delivered_customer_date AS DATE) AS delivery_date,
     COUNT(*) AS late_deliveries 
FROM olist_orders_dataset
WHERE order_purchase_timestamp >= '2018-07-19 17:30:18.000'
  AND order_purchase_timestamp <= '2018-10-17 17:30:18'
  AND order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL 
  AND order_delivered_customer_date > order_estimated_delivery_date
GROUP BY CAST(order_delivered_customer_date AS DATE)
ORDER BY delivery_date ;


-- 14. DAILY AVERAGE DELIVERY DAYS

SELECT
    CAST(order_delivered_customer_date AS DATE) AS delivery_date,
    AVG(
        CAST(
            DATEDIFF(
                DAY,
                order_purchase_timestamp,
                order_delivered_customer_date
            ) AS FLOAT
        )
    ) AS average_delivery_days
FROM dbo.olist_orders_dataset
WHERE order_purchase_timestamp >= '2018-07-19 17:30:18.000'
  AND order_purchase_timestamp <= '2018-10-17 17:30:18'
  AND order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
GROUP BY CAST(order_delivered_customer_date AS DATE)
ORDER BY delivery_date;


-- 15. FINAL DAILY ORDERS HEALTH REPORT
SELECT
    CAST(order_purchase_timestamp AS DATE) AS order_date,

    -- Total orders placed on that day
    COUNT(*) AS orders_placed,

    -- Orders from that day's cohort that were delivered
    SUM(
        CASE 
            WHEN order_status = 'delivered' THEN 1
            ELSE 0
        END
    ) AS orders_delivered,

    -- Orders from that day's cohort that were cancelled
    SUM(
        CASE 
            WHEN order_status = 'canceled' THEN 1
            ELSE 0
        END
    ) AS orders_cancelled,

    -- Delivered orders that arrived after estimated delivery date
    SUM(
        CASE 
            WHEN order_status = 'delivered'
                 AND order_delivered_customer_date IS NOT NULL
                 AND order_estimated_delivery_date IS NOT NULL
                 AND order_delivered_customer_date > order_estimated_delivery_date
            THEN 1
            ELSE 0
        END
    ) AS late_deliveries,

    -- Average delivery time for delivered orders
    AVG(
        CASE
            WHEN order_status = 'delivered'
                 AND order_delivered_customer_date IS NOT NULL
            THEN CAST(
                DATEDIFF(
                    DAY,
                    order_purchase_timestamp,
                    order_delivered_customer_date
                ) AS FLOAT
            )
        END
    ) AS average_delivery_days

FROM dbo.olist_orders_dataset

WHERE order_purchase_timestamp >= '2018-07-19 17:30:18.000'
  AND order_purchase_timestamp <= '2018-10-17 17:30:18'

GROUP BY CAST(order_purchase_timestamp AS DATE)

ORDER BY order_date;