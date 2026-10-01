# Daily Orders Health Report

<p align="center">
  <strong>Operational Intelligence for E-Commerce Order, Delivery, and Category Performance</strong>
</p>

<p align="center">
  A SQL Server and Microsoft Excel analytics project that transforms raw Olist marketplace data into practical daily health monitoring, operational KPIs, category scorecards, and business recommendations.
</p>

<p align="center">
  <a href="https://github.com/Himanshi-Bhere/daily-orders-health-report">
    <img src="https://img.shields.io/badge/Project-Business%20Analytics-2563EB?style=for-the-badge" alt="Business Analytics">
  </a>
  <a href="https://www.microsoft.com/sql-server">
    <img src="https://img.shields.io/badge/SQL%20Server-T--SQL-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white" alt="SQL Server">
  </a>
  <a href="https://www.microsoft.com/microsoft-365/excel">
    <img src="https://img.shields.io/badge/Microsoft%20Excel-Reporting-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white" alt="Microsoft Excel">
  </a>
  <a href="https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce">
    <img src="https://img.shields.io/badge/Dataset-Olist%20E--Commerce-0F766E?style=for-the-badge" alt="Olist Dataset">
  </a>
</p>

---

## Executive Summary

The **Daily Orders Health Report** is an end-to-end business intelligence project built using **SQL Server, T-SQL, and Microsoft Excel**.

The project analyzes approximately 100,000 Brazilian e-commerce orders to answer two practical business questions:

1. **Is daily order and delivery performance operating within acceptable limits?**
2. **Which product categories are driving revenue, customer satisfaction, and operational risk?**

The solution is organized into two complementary analytical workstreams:

- **Part 1 — Daily Order Health:** Operational monitoring of order volume, deliveries, cancellations, late deliveries, and delivery duration.
- **Part 2 — Category KPI Scorecard:** Commercial and customer-experience analysis by product category and month.

The result is a repeatable analytics workflow that connects raw transactional data to measurable business performance and decision-ready recommendations.

---

## Business Value

This project demonstrates how analytics can support operational and commercial decision-making by helping teams:

- Monitor daily order activity
- Identify delivery performance deterioration
- Track cancellation and late-delivery risk
- Evaluate category-level revenue contribution
- Compare customer review performance
- Identify high-performing and underperforming categories
- Prioritize dates and categories requiring investigation
- Convert SQL outputs into clear Excel reporting
- Build a foundation for future automated monitoring

---

## Project Highlights

| Area | What This Project Demonstrates |
|---|---|
| **Data Preparation** | Joining and preparing multiple relational e-commerce datasets |
| **Operational Analytics** | Daily order, delivery, cancellation, and late-delivery monitoring |
| **Commercial Analytics** | Category revenue, order volume, AOV, and ranking analysis |
| **Customer Experience** | Review-score and category-level satisfaction analysis |
| **Risk Monitoring** | Cancellation-rate and late-delivery-rate evaluation |
| **Business Reporting** | Excel dashboards, summaries, charts, scorecards, and findings |
| **SQL Capability** | CTEs, conditional aggregation, window functions, date logic, and KPI calculations |
| **Communication** | Translating analytical results into business-focused insights |

---

## Analytical Workstreams

### Part 1 — Daily Order Health

The first workstream evaluates operational performance during a selected 90-day reporting period.

#### Core questions

- How many orders were placed each day?
- How many orders were successfully delivered?
- How many orders were cancelled?
- How frequently did late deliveries occur?
- What was the average delivery duration?
- Which dates required operational attention?
- Did delivery issues represent a larger risk than cancellations?

#### Metrics produced

- Daily order volume
- Delivered orders
- Cancelled orders
- Late deliveries
- Average delivery time
- Cancellation rate
- Late-delivery rate
- Operational health flags
- Threshold-based monitoring indicators

#### Reporting period

```text
July 19, 2018 through October 17, 2018
```

[View Part 1 Documentation](part1-order-health/README.md)  
[View Part 1 SQL Script](part1-order-health/sql/part1_daily_orders_health.sql)  
[View Part 1 Excel Report](part1-order-health/excel/daily_orders_health_report.xlsx)

---

### Part 2 — Category KPI Scorecard

The second workstream evaluates category performance across revenue, orders, customer reviews, and cancellation risk.

#### Core questions

- Which categories generated the most revenue?
- Which categories received the strongest customer ratings?
- Which categories had the highest order volume?
- Which categories showed elevated cancellation risk?
- How does category performance change by month?
- Which categories belong in the top and bottom performance groups?

#### Metrics produced

- Total revenue
- Unique orders
- Average order value
- Average customer review score
- Cancelled orders
- Cancellation rate
- Revenue-band classification
- Category ranking
- Top-10 categories
- Bottom-10 categories
- Monthly category performance
- Category-level business findings

[View Part 2 Documentation](part2-category-kpi-scorecard/README.md)  
[View Part 2 SQL Script](part2-category-kpi-scorecard/sql/part2_category_kpi_scorecard.sql)

---

## Part 1 — Operational KPI Snapshot

The selected 90-day analysis produced the following results:

| KPI | Result |
|---|---:|
| Orders placed | **9,529** |
| Orders delivered | **9,284** |
| Orders cancelled | **124** |
| Late deliveries | **815** |
| Average delivery time | **7.86 days** |
| Cancellation rate | **1.30%** |
| Late-delivery rate | **8.78%** |

### Executive interpretation

The results indicate that **delivery timeliness was a more significant operational concern than cancellations** during the analyzed period.

While the cancellation rate remained relatively low at **1.30%**, the late-delivery rate reached **8.78%**. This suggests that operational improvement efforts should prioritize:

- Delivery reliability
- Logistics coordination
- Estimated-date accuracy
- Carrier and seller performance monitoring
- Early identification of dates with unusual late-delivery activity

---

## KPI Framework

### Operational Health KPIs

| KPI | Business Purpose |
|---|---|
| Total orders | Measures overall demand and workload |
| Daily order volume | Identifies demand patterns and unusual activity |
| Delivered orders | Measures successful order completion |
| Cancelled orders | Indicates fulfillment or customer-retention risk |
| Late deliveries | Measures service-level performance |
| Average delivery time | Tracks delivery efficiency |
| Cancellation rate | Normalizes cancellation activity |
| Late-delivery rate | Measures delivery reliability |

### Category Performance KPIs

| KPI | Business Purpose |
|---|---|
| Total revenue | Measures category commercial contribution |
| Unique orders | Measures category demand |
| Average order value | Measures average customer spend |
| Average review score | Measures customer satisfaction |
| Cancelled orders | Identifies fulfillment risk |
| Cancellation rate | Enables fair category comparison |
| Revenue band | Classifies category scale |
| Category ranking | Supports prioritization and benchmarking |

---

## End-to-End Analytics Workflow

```text
Raw Olist e-commerce dataset
            ↓
SQL Server data loading
            ↓
Data validation and table inspection
            ↓
Relational joins and data preparation
            ↓
KPI calculation and business rules
            ↓
Daily operational monitoring
            ↓
Category performance scorecard
            ↓
Excel reporting and visualization
            ↓
Business findings and recommendations
```

---

## Data Model

The analysis uses the following core Olist tables:

```text
olist_orders_dataset
olist_order_items_dataset
olist_products_dataset
olist_order_reviews_dataset
```

### Important fields

```text
order_id
order_status
order_purchase_timestamp
order_delivered_customer_date
order_estimated_delivery_date
product_id
product_category_name
price
review_score
```

### Analytical relationships

```text
Orders
  ├── Order Items
  │     └── Products
  └── Order Reviews
```

This structure enables the analysis to connect:

- Order lifecycle information
- Product and category details
- Order-item revenue
- Customer review outcomes
- Actual versus estimated delivery dates

---

## Technology Stack

| Technology | Application |
|---|---|
| **SQL Server** | Data preparation, joins, validation, and analytical queries |
| **T-SQL** | KPI calculations, classifications, rankings, and date-based analysis |
| **SQL Server Management Studio** | Query execution and result validation |
| **Microsoft Excel** | Dashboards, charts, scorecards, summaries, and findings |
| **GitHub** | Version control, project documentation, and portfolio presentation |

---

## SQL Techniques Demonstrated

This project demonstrates practical SQL Server techniques used in real-world analytics workflows:

- `INNER JOIN`
- `LEFT JOIN`
- `GROUP BY`
- `ORDER BY`
- `COUNT`
- `COUNT(DISTINCT)`
- `SUM`
- `AVG`
- `MIN`
- `MAX`
- `CASE WHEN`
- Conditional aggregation
- Common table expressions
- `DATEADD`
- `DATEDIFF`
- `CAST`
- `DATENAME`
- `YEAR`
- `MONTH`
- `NULLIF`
- `ROW_NUMBER`
- `HAVING`
- Date-level aggregation
- Null handling
- KPI classification
- Ranking logic
- Rate calculations
- Business-rule implementation

---

## Report Previews

### Daily Order Health Report

![Daily Health Report](part1-order-health/screenshots/daily_health_report.png)

### Daily Orders Trend

![Daily Orders Trend](part1-order-health/screenshots/daily_orders_chart.png)

### Operational Summary

![Operational Summary](part1-order-health/screenshots/summary.png)

### Operational Findings

![Operational Findings](part1-order-health/screenshots/findings.png)

### Category KPI Scorecard

![Category KPI Scorecard](part2-category-kpi-scorecard/screenshots/part2_category_pivot.png)

### Category Summary

![Category Summary](part2-category-kpi-scorecard/screenshots/part2_summary.png)

### Category Findings

![Category Findings](part2-category-kpi-scorecard/screenshots/part2_findings.png)

### Category Performance Sparklines

![Category Sparklines](part2-category-kpi-scorecard/screenshots/part2_sparkline.png)

---

## Repository Structure

```text
.
├── part1-order-health/
│   ├── excel/
│   │   └── daily_orders_health_report.xlsx
│   ├── sql/
│   │   └── part1_daily_orders_health.sql
│   ├── screenshots/
│   │   ├── daily_health_report.png
│   │   ├── daily_orders_chart.png
│   │   ├── findings.png
│   │   └── summary.png
│   └── README.md
│
├── part2-category-kpi-scorecard/
│   ├── excel/
│   │   └── .gitkeep
│   ├── sql/
│   │   └── part2_category_kpi_scorecard.sql
│   ├── screenshots/
│   │   ├── part2_category_pivot.png
│   │   ├── part2_findings.png
│   │   ├── part2_sparkline.png
│   │   └── part2_summary.png
│   └── README.md
│
└── README.md
```

---

## How to Reproduce the Analysis

### Prerequisites

- Microsoft SQL Server
- SQL Server Management Studio
- Microsoft Excel
- Olist Brazilian E-Commerce Public Dataset

### Database setup

1. Download the Olist Brazilian E-Commerce Public Dataset.
2. Create a SQL Server database named:

```sql
OlistAnalytics
```

3. Load the required Olist tables into the database.
4. Confirm that the following tables are available:

```text
olist_orders_dataset
olist_order_items_dataset
olist_products_dataset
olist_order_reviews_dataset
```

5. Open the relevant SQL script in SQL Server Management Studio.
6. Execute the queries and validate the results.
7. Export or transfer the result sets into Excel.
8. Use the Excel workbooks and screenshots as reporting outputs.

### Project files

#### Part 1 SQL script

```text
part1-order-health/sql/part1_daily_orders_health.sql
```

#### Part 1 Excel workbook

```text
part1-order-health/excel/daily_orders_health_report.xlsx
```

#### Part 2 SQL script

```text
part2-category-kpi-scorecard/sql/part2_category_kpi_scorecard.sql
```

---

## Data Quality and Interpretation Notes

- Part 1 uses a fixed reporting window from **July 19, 2018 through October 17, 2018**.
- The reporting period should be updated when applying the analysis to a different time range.
- Delivery metrics depend on the availability of actual delivery timestamps.
- A delivery is classified as late when the actual delivery date is later than the estimated delivery date.
- Daily operational metrics are grouped by order purchase date unless otherwise specified.
- Category revenue is calculated using order-item prices.
- Average order value is calculated as total revenue divided by distinct orders.
- Review scores are aggregated before category-level analysis.
- Revenue bands are analytical classifications created for this project.
- Operational thresholds should be calibrated using historical performance or formal service-level agreements.
- Results may change if the source data is cleaned, deduplicated, transformed, or loaded into a different schema.
- The dataset is historical and should be interpreted as an analytical case study rather than a live operational feed.

---

## Recommended Business Actions

Based on the operational results, the following actions would be appropriate for further investigation:

### 1. Prioritize delivery reliability

The late-delivery rate is materially higher than the cancellation rate. Delivery performance should therefore be treated as a primary operational improvement area.

### 2. Investigate high-risk dates

Dates with unusual late-delivery volume or low delivery performance should be reviewed for:

- Logistics disruptions
- Seller delays
- Carrier capacity constraints
- Incorrect delivery estimates
- Regional fulfillment issues

### 3. Segment category performance

Categories should be evaluated using multiple dimensions rather than revenue alone:

- Revenue contribution
- Order volume
- Average order value
- Customer review score
- Cancellation rate

### 4. Calibrate operational thresholds

Monitoring thresholds should be based on historical baselines, business expectations, and agreed service-level targets.

### 5. Automate the reporting workflow

The project can be extended into a recurring operational monitoring solution with scheduled SQL execution, automated Excel refreshes, Power BI dashboards, and alert notifications.

---

## Potential Enhancements

Future versions of this project could include:

- Dynamic date parameters
- Automated SQL-to-Excel refresh workflows
- Power BI dashboard publication
- Regional and state-level analysis
- Seller-level performance analysis
- Product-level performance analysis
- Freight-cost analysis
- Shipping-time analysis
- Week-over-week comparisons
- Month-over-month comparisons
- Rolling averages
- Seasonality-adjusted thresholds
- Automated email alerts
- Duplicate-order detection
- Missing-date monitoring
- Data-quality validation checks
- Incremental reporting workflows
- Forecasting and anomaly detection
- Executive KPI summary pages

---

## Project Outcomes

This project demonstrates the ability to:

- Translate business questions into analytical requirements
- Work with normalized relational datasets
- Build repeatable SQL-based KPI calculations
- Monitor operational performance over time
- Compare actual and estimated delivery dates
- Analyze category-level commercial performance
- Combine revenue, order, review, and cancellation metrics
- Use rankings and classifications to support prioritization
- Build Excel-based analytical reporting
- Communicate findings through business-oriented documentation
- Design a foundation for future BI automation

---

## Dataset Attribution

This project uses the **Olist Brazilian E-Commerce Public Dataset**, a publicly available dataset containing information about approximately 100,000 orders from a Brazilian online marketplace.

The dataset includes information about:

- Orders
- Order status
- Order items
- Products
- Product categories
- Customer reviews
- Product prices
- Delivery dates
- Estimated delivery dates

Dataset source:

[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

---

## Author

### Himanshi Bhere

This repository is part of an analytics portfolio focused on:

- SQL Server
- T-SQL
- Business intelligence
- Operational performance monitoring
- E-commerce analytics
- Excel reporting
- KPI development
- Data-driven decision support

---

## License and Attribution

This repository is an analytical portfolio project.

The underlying data is provided by the **Olist Brazilian E-Commerce Public Dataset** and is available through Kaggle.

All analytical logic, SQL scripts, Excel reporting, visualizations, and documentation in this repository were created for educational and portfolio purposes.
