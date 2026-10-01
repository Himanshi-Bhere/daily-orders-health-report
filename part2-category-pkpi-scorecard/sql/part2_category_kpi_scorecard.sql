/*
===========================================================
PROJECT: Olist E-Commerce Analytics
PART 2: Category KPI Scorecard
===========================================================

BUSINESS QUESTION:
How does revenue performance vary across product categories
and months when considering revenue, orders, AOV, review score,
and cancellation rate?

KEY SQL CONCEPTS:
- JOIN
- GROUP BY
- CTE
- CASE WHEN
- COUNT(DISTINCT)
- HAVING
- ROW_NUMBER()
- NULLIF()
- Aggregate functions

FINAL DELIVERABLES:
1. Monthly Category KPI Scorecard
2. Revenue Band Classification
3. Top-10 / Bottom-10 Category Ranking
===========================================================
*/


USE OlistAnalytics;
GO

-- step 2  Tables/columns verified
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN
(
    'olist_orders_dataset',
    'olist_order_items_dataset',
    'olist_products_dataset',
    'olist_order_reviews_dataset'
)
ORDER BY
    TABLE_NAME,
    ORDINAL_POSITION;

-- step 3 JOIN validation

SELECT TOP 20
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    oi.product_id,
    oi.price,
    p.product_category_name
FROM dbo.olist_orders_dataset AS o
INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id;

--step 4 build the dataset
SELECT TOP 20
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    oi.product_id,
    p.product_category_name,
    oi.price
FROM dbo.olist_orders_dataset AS o
INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id
ORDER BY o.order_purchase_timestamp;

-- Step 5 Total revenue
SELECT
    SUM(oi.price) AS total_revenue
FROM dbo.olist_orders_dataset AS o
INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id;

-- step 6 Revenue by product 
SELECT
    p.product_category_name,
    SUM(oi.price) AS total_revenue
FROM dbo.olist_orders_dataset AS o
INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id
GROUP BY 
    p.product_category_name
ORDER BY
    total_revenue DESC;

-- step 7   Revenue by month + category 
SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    MONTH(o.order_purchase_timestamp) AS order_month,
    DATENAME(MONTH, o.order_purchase_timestamp) AS month_name,
    p.product_category_name,
    SUM(oi.price) AS total_revenue
FROM dbo.olist_orders_dataset AS o
INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id
GROUP BY 
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp),
    DATENAME(MONTH, o.order_purchase_timestamp),
    p.product_category_name
ORDER BY
    order_year,
    order_month,
    total_revenue DESC;

 -- Step 8 total unique orders 
 SELECT
    COUNT(DISTINCT o.order_id) AS total_orders
FROM dbo.olist_orders_dataset AS o
INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id;

-- orders by category 
SELECT
    p.product_category_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM dbo.olist_orders_dataset AS o
INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
ORDER BY
    total_orders DESC;

-- STEP 9: Orders by month and category

SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    MONTH(o.order_purchase_timestamp) AS order_month,
    DATENAME(MONTH, o.order_purchase_timestamp) AS month_name,
    p.product_category_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM dbo.olist_orders_dataset AS o
INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id
GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp),
    DATENAME(MONTH, o.order_purchase_timestamp),
    p.product_category_name
ORDER BY
    order_year,
    order_month,
    total_orders DESC;

-- STEP 10: Category revenue baseline

SELECT
    p.product_category_name,
    SUM(oi.price) AS total_revenue
FROM dbo.olist_orders_dataset AS o
INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_category_name
ORDER BY
    total_revenue DESC;

-- STEP 11: Category Revenue Classification

WITH category_revenue AS
(
    SELECT
        p.product_category_name,
        SUM(oi.price) AS total_revenue
    FROM dbo.olist_orders_dataset AS o

    INNER JOIN dbo.olist_order_items_dataset AS oi
        ON o.order_id = oi.order_id

    INNER JOIN dbo.olist_products_dataset AS p
        ON oi.product_id = p.product_id

    GROUP BY
        p.product_category_name
)

SELECT
    product_category_name,
    total_revenue,

    CASE
        WHEN total_revenue >= 1000000 THEN 'Star'
        WHEN total_revenue >= 700000 THEN 'Watch'
        ELSE 'Fix'
    END AS revenue_band

FROM category_revenue

ORDER BY
    total_revenue DESC;

 -- STEP 12: Monthly Category AOV

SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    MONTH(o.order_purchase_timestamp) AS order_month,
    p.product_category_name,

    SUM(oi.price) AS total_revenue,

    COUNT(DISTINCT o.order_id) AS total_orders,

    CAST(
        SUM(oi.price) / NULLIF(COUNT(DISTINCT o.order_id), 0)
        AS DECIMAL(12,2)
    ) AS AOV

FROM dbo.olist_orders_dataset AS o

INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id

INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id

GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp),
    p.product_category_name

ORDER BY
    order_year,
    order_month,
    AOV DESC;

-- Average review score 
SELECT TOP 20
    o.order_id,
    p.product_category_name,
    r.review_score
FROM dbo.olist_orders_dataset AS o

INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id

INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id

INNER JOIN dbo.olist_order_reviews_dataset AS r
    ON o.order_id = r.order_id;

-- STEP 13.2: Average Review Score by Category

SELECT
    p.product_category_name,
    AVG(CAST(r.review_score AS DECIMAL(10,2))) AS avg_review_score

FROM dbo.olist_orders_dataset AS o

INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id

INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id

INNER JOIN dbo.olist_order_reviews_dataset AS r
    ON o.order_id = r.order_id

GROUP BY
    p.product_category_name

ORDER BY
    avg_review_score DESC;

-- STEP 13.3: Monthly Category Average Review Score

SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    MONTH(o.order_purchase_timestamp) AS order_month,
    DATENAME(MONTH, o.order_purchase_timestamp) AS month_name,
    p.product_category_name,

    AVG(CAST(r.review_score AS DECIMAL(10,2))) AS avg_review_score

FROM dbo.olist_orders_dataset AS o

INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id

INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id

INNER JOIN dbo.olist_order_reviews_dataset AS r
    ON o.order_id = r.order_id

GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp),
    DATENAME(MONTH, o.order_purchase_timestamp),
    p.product_category_name

ORDER BY
    order_year,
    order_month,
    avg_review_score DESC;

-- STEP 14.1: Total Cancelled Orders

SELECT
    COUNT(*) AS cancelled_orders

FROM dbo.olist_orders_dataset

WHERE order_status = 'canceled';

-- STEP 14.2: Total Orders vs Cancelled Orders

SELECT
    COUNT(*) AS total_orders,

    SUM(
        CASE
            WHEN order_status = 'canceled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders

FROM dbo.olist_orders_dataset;

-- STEP 14.3: Overall Cancellation Rate

SELECT
    COUNT(*) AS total_orders,

    SUM(
        CASE
            WHEN order_status = 'canceled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,

    CAST(
        100.0 * SUM(
            CASE
                WHEN order_status = 'canceled' THEN 1
                ELSE 0
            END
        ) / COUNT(*) AS DECIMAL(10,2)
    ) AS cancellation_rate

FROM dbo.olist_orders_dataset;

-- STEP 14.4: Monthly Category Cancellation Rate

SELECT
    YEAR(o.order_purchase_timestamp) AS order_year,
    MONTH(o.order_purchase_timestamp) AS order_month,
    DATENAME(MONTH, o.order_purchase_timestamp) AS month_name,
    p.product_category_name,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COUNT(DISTINCT
        CASE
            WHEN o.order_status = 'canceled'
            THEN o.order_id
        END
    ) AS cancelled_orders,

    CAST(
        100.0 *
        COUNT(DISTINCT
            CASE
                WHEN o.order_status = 'canceled'
                THEN o.order_id
            END
        )
        / NULLIF(COUNT(DISTINCT o.order_id), 0)
        AS DECIMAL(10,2)
    ) AS cancellation_rate

FROM dbo.olist_orders_dataset AS o

INNER JOIN dbo.olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id

INNER JOIN dbo.olist_products_dataset AS p
    ON oi.product_id = p.product_id

GROUP BY
    YEAR(o.order_purchase_timestamp),
    MONTH(o.order_purchase_timestamp),
    DATENAME(MONTH, o.order_purchase_timestamp),
    p.product_category_name

ORDER BY
    order_year,
    order_month,
    cancellation_rate DESC;


-- Step 15 FINAL KPI scorecard
WITH order_category AS
(
    -- One row per Order + Category
    SELECT DISTINCT
        o.order_id,
        YEAR(o.order_purchase_timestamp) AS order_year,
        MONTH(o.order_purchase_timestamp) AS order_month,
        DATENAME(MONTH, o.order_purchase_timestamp) AS month_name,
        p.product_category_name
    FROM dbo.olist_orders_dataset AS o

    INNER JOIN dbo.olist_order_items_dataset AS oi
        ON o.order_id = oi.order_id

    INNER JOIN dbo.olist_products_dataset AS p
        ON oi.product_id = p.product_id
),

category_sales AS
(
    -- Revenue and orders calculated directly from order items
    SELECT
        YEAR(o.order_purchase_timestamp) AS order_year,
        MONTH(o.order_purchase_timestamp) AS order_month,
        DATENAME(MONTH, o.order_purchase_timestamp) AS month_name,
        p.product_category_name,

        SUM(oi.price) AS total_revenue,

        COUNT(DISTINCT o.order_id) AS total_orders,

        CAST(
            SUM(oi.price) /
            NULLIF(COUNT(DISTINCT o.order_id), 0)
            AS DECIMAL(12,2)
        ) AS AOV

    FROM dbo.olist_orders_dataset AS o

    INNER JOIN dbo.olist_order_items_dataset AS oi
        ON o.order_id = oi.order_id

    INNER JOIN dbo.olist_products_dataset AS p
        ON oi.product_id = p.product_id

    GROUP BY
        YEAR(o.order_purchase_timestamp),
        MONTH(o.order_purchase_timestamp),
        DATENAME(MONTH, o.order_purchase_timestamp),
        p.product_category_name
),

order_review AS
(
    -- One review score per order
    SELECT
        order_id,
        AVG(
            CAST(review_score AS DECIMAL(10,2))
        ) AS review_score
    FROM dbo.olist_order_reviews_dataset
    GROUP BY order_id
),

category_review AS
(
    -- Average review score by Month + Category
    SELECT
        oc.order_year,
        oc.order_month,
        oc.month_name,
        oc.product_category_name,

        AVG(orv.review_score) AS avg_review_score

    FROM order_category AS oc

    INNER JOIN order_review AS orv
        ON oc.order_id = orv.order_id

    GROUP BY
        oc.order_year,
        oc.order_month,
        oc.month_name,
        oc.product_category_name
),

category_cancellation AS
(
    -- Cancellation rate by Month + Category
    SELECT
        oc.order_year,
        oc.order_month,
        oc.month_name,
        oc.product_category_name,

        COUNT(DISTINCT
            CASE
                WHEN o.order_status = 'canceled'
                THEN oc.order_id
            END
        ) AS cancelled_orders,

        CAST(
            100.0 *
            COUNT(DISTINCT
                CASE
                    WHEN o.order_status = 'canceled'
                    THEN oc.order_id
                END
            )
            /
            NULLIF(COUNT(DISTINCT oc.order_id), 0)
            AS DECIMAL(10,2)
        ) AS cancellation_rate

    FROM order_category AS oc

    INNER JOIN dbo.olist_orders_dataset AS o
        ON oc.order_id = o.order_id

    GROUP BY
        oc.order_year,
        oc.order_month,
        oc.month_name,
        oc.product_category_name
)

SELECT
    cs.order_year,
    cs.order_month,
    cs.month_name,
    cs.product_category_name,

    cs.total_revenue,
    cs.total_orders,
    cs.AOV,

    cr.avg_review_score,

    cc.cancelled_orders,
    cc.cancellation_rate,

    CASE
        WHEN cs.total_revenue >= 1000000 THEN 'Star'
        WHEN cs.total_revenue >= 700000 THEN 'Watch'
        ELSE 'Fix'
    END AS revenue_band

FROM category_sales AS cs

LEFT JOIN category_review AS cr
    ON cs.order_year = cr.order_year
    AND cs.order_month = cr.order_month
    AND cs.product_category_name = cr.product_category_name

LEFT JOIN category_cancellation AS cc
    ON cs.order_year = cc.order_year
    AND cs.order_month = cc.order_month
    AND cs.product_category_name = cc.product_category_name

ORDER BY
    cs.order_year,
    cs.order_month,
    cs.total_revenue DESC;

-- STEP 16 top10 and bottom 10 category rnking 
WITH category_metrics AS
(
    SELECT
        p.product_category_name,

        SUM(oi.price) AS total_revenue,

        COUNT(DISTINCT o.order_id) AS total_orders,

        CAST(
            SUM(oi.price) /
            NULLIF(COUNT(DISTINCT o.order_id), 0)
            AS DECIMAL(12,2)
        ) AS AOV

    FROM dbo.olist_orders_dataset AS o

    INNER JOIN dbo.olist_order_items_dataset AS oi
        ON o.order_id = oi.order_id

    INNER JOIN dbo.olist_products_dataset AS p
        ON oi.product_id = p.product_id

    GROUP BY
        p.product_category_name

    HAVING
        COUNT(DISTINCT o.order_id) >= 100
),

top_categories AS
(
    SELECT TOP 10
        product_category_name,
        total_revenue,
        total_orders,
        AOV,
        ROW_NUMBER() OVER (
            ORDER BY total_revenue DESC
        ) AS ranking,
        'Top 10' AS ranking_type

    FROM category_metrics

    ORDER BY
        total_revenue DESC
),

bottom_categories AS
(
    SELECT TOP 10
        product_category_name,
        total_revenue,
        total_orders,
        AOV,
        ROW_NUMBER() OVER (
            ORDER BY total_revenue ASC
        ) AS ranking,
        'Bottom 10' AS ranking_type

    FROM category_metrics

    ORDER BY
        total_revenue ASC
)

SELECT
    ranking_type,
    ranking,
    product_category_name,
    total_revenue,
    total_orders,
    AOV
FROM top_categories

UNION ALL

SELECT
    ranking_type,
    ranking,
    product_category_name,
    total_revenue,
    total_orders,
    AOV
FROM bottom_categories

ORDER BY
    ranking_type,
    ranking;