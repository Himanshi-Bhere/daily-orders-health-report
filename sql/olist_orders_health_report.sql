USE OlistAnalytics;
GO

SET NOCOUNT ON;

DECLARE @analysis_start_datetime DATETIME2(3) = '2018-07-19 17:30:18.000';
DECLARE @analysis_end_datetime DATETIME2(3) = '2018-10-17 17:30:18.000';

IF DB_ID(N'OlistAnalytics') IS NULL
BEGIN
    THROW 50001, 'Database OlistAnalytics does not exist.', 1;
END;

IF OBJECT_ID(N'dbo.olist_orders_dataset', N'U') IS NULL
BEGIN
    THROW 50002, 'Table dbo.olist_orders_dataset does not exist.', 1;
END;

IF OBJECT_ID('tempdb..#filtered_orders', N'U') IS NOT NULL
BEGIN
    DROP TABLE #filtered_orders;
END;

SELECT
    order_purchase_timestamp,
    order_status,
    order_delivered_customer_date,
    order_estimated_delivery_date
INTO #filtered_orders
FROM dbo.olist_orders_dataset
WHERE order_purchase_timestamp >= @analysis_start_datetime
  AND order_purchase_timestamp <= @analysis_end_datetime;

/* ===========================================
   1) DATASET PROFILE QUERIES
   =========================================== */

-- Total orders in source table.
SELECT
    COUNT(*) AS total_orders
FROM dbo.olist_orders_dataset;

-- Orders by status in source table.
SELECT
    order_status,
    COUNT(*) AS order_count
FROM dbo.olist_orders_dataset
GROUP BY order_status;

-- Full date range in source table.
SELECT
    MIN(order_purchase_timestamp) AS first_order,
    MAX(order_purchase_timestamp) AS last_order
FROM dbo.olist_orders_dataset;

-- Last 90 days anchor based on max purchase timestamp.
SELECT
    DATEADD(DAY, -90, MAX(order_purchase_timestamp)) AS start_date,
    MAX(order_purchase_timestamp) AS end_date
FROM dbo.olist_orders_dataset;

/* ===========================================
   2) 90-DAY KPI QUERIES
   =========================================== */

-- Orders placed in the configured analysis window.
SELECT
    COUNT(*) AS orders_placed
FROM #filtered_orders;

-- Delivered orders in the configured analysis window.
SELECT
    COUNT(*) AS orders_delivered
FROM #filtered_orders
WHERE order_status = 'delivered';

-- Cancelled orders in the configured analysis window.
SELECT
    COUNT(*) AS orders_canceled
FROM #filtered_orders
WHERE order_status = 'canceled';

-- Late delivered orders in the configured analysis window.
SELECT
    COUNT(*) AS late_delivered
FROM #filtered_orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
  AND order_delivered_customer_date > order_estimated_delivery_date;

-- Average delivery days in the configured analysis window.
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
FROM #filtered_orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL;

/* ===========================================
   3) DAILY METRIC QUERIES
   =========================================== */

-- Daily orders placed.
SELECT
    CAST(order_purchase_timestamp AS DATE) AS order_date,
    COUNT(*) AS orders_placed
FROM #filtered_orders
GROUP BY CAST(order_purchase_timestamp AS DATE)
ORDER BY order_date;


-- Daily orders delivered.
SELECT
    CAST(order_delivered_customer_date AS DATE) AS delivery_date,
    COUNT(*) AS orders_delivered
FROM #filtered_orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
GROUP BY CAST(order_delivered_customer_date AS DATE)
ORDER BY delivery_date;

-- Daily cancelled orders.
SELECT
    CAST(order_purchase_timestamp AS DATE) AS order_date,
    COUNT(*) AS orders_cancelled
FROM #filtered_orders
WHERE order_status = 'canceled'
GROUP BY CAST(order_purchase_timestamp AS DATE)
ORDER BY order_date;

-- Daily late deliveries.
SELECT
    CAST(order_delivered_customer_date AS DATE) AS delivery_date,
    COUNT(*) AS late_deliveries
FROM #filtered_orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
  AND order_delivered_customer_date > order_estimated_delivery_date
GROUP BY CAST(order_delivered_customer_date AS DATE)
ORDER BY delivery_date;

-- Daily average delivery days.
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
FROM #filtered_orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
GROUP BY CAST(order_delivered_customer_date AS DATE)
ORDER BY delivery_date;

/* ===========================================
   4) FINAL DAILY ORDERS HEALTH REPORT
   =========================================== */

SELECT
    CAST(order_purchase_timestamp AS DATE) AS order_date,
    COUNT(*) AS orders_placed,
    SUM(
        CASE
            WHEN order_status = 'delivered' THEN 1
            ELSE 0
        END
    ) AS orders_delivered,
    SUM(
        CASE
            WHEN order_status = 'canceled' THEN 1
            ELSE 0
        END
    ) AS orders_cancelled,
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
FROM #filtered_orders
GROUP BY CAST(order_purchase_timestamp AS DATE)
ORDER BY order_date;
