# Daily Orders Health Report (Olist E-Commerce)

## Purpose

This repository contains a SQL Server-based daily operations health report for the Olist Brazilian e-commerce dataset.

It answers core operational questions for a fixed analysis window:

- How many orders were placed, delivered, and cancelled each day?
- How many delivered orders were late?
- What was the average delivery time?

## Repository Structure

```text
.
├── sql/
│   └── olist_orders_health_report.sql
├── excel/
│   └── daily_orders_health_report.xlsx
└── screenshorts/
    ├── daily_health_report.png
    ├── daily_orders_chart.png
    ├── findings .png
    └── summary.png
```

## Prerequisites

- Microsoft SQL Server (T-SQL compatible)
- SQL client such as SQL Server Management Studio (SSMS) or Azure Data Studio
- Database with table `dbo.olist_orders_dataset`

## Data Assumptions

The SQL script is written for the existing dataset structure and does not create or modify schema objects.

Expected columns used by the report:

- `order_purchase_timestamp`
- `order_status`
- `order_delivered_customer_date`
- `order_estimated_delivery_date`

Business definitions used:

- **Delivered order:** `order_status = 'delivered'`
- **Cancelled order:** `order_status = 'canceled'`
- **Late delivery:** delivered order where `order_delivered_customer_date > order_estimated_delivery_date`

## Setup and Usage

1. Load the Olist orders data into `dbo.olist_orders_dataset` in SQL Server.
2. Open `sql/olist_orders_health_report.sql`.
3. Update the database name and analysis date parameters if needed.
4. Run the script in SSMS.

The script returns:

1. Dataset profile checks (counts/status/date range)
2. 90-day aggregate KPI queries
3. Daily operational metric queries
4. Final daily health report query (single-table output for downstream reporting)

## Output Example (Final Daily Report)

| order_date | orders_placed | orders_delivered | orders_cancelled | late_deliveries | average_delivery_days |
|---|---:|---:|---:|---:|---:|
| 2018-07-19 | ... | ... | ... | ... | ... |
| 2018-07-20 | ... | ... | ... | ... | ... |

## Key KPI Snapshot (Current README Baseline)

| KPI | Result |
|---|---:|
| Orders Placed | 9,529 |
| Orders Delivered | 9,284 |
| Orders Cancelled | 124 |
| Late Deliveries | 815 |
| Average Delivery Time | 7.86 days |
| Cancellation Rate | 1.30% |
| Late Delivery Rate | 8.78% |

Formulas:

- `Late Delivery Rate = Late Deliveries / Delivered Orders × 100`
- `Cancellation Rate = Cancelled Orders / Orders Placed × 100`

## Troubleshooting

- **`Invalid object name 'dbo.olist_orders_dataset'`**
  Confirm the table exists in the selected database and schema.
- **No rows in final report**
  Check the configured analysis start/end timestamps and data availability.
- **Unexpected KPI changes**
  Verify status values (`delivered`, `canceled`) and timestamp timezone/source consistency in the imported dataset.

## Validation

Recommended lightweight checks after SQL changes:

- Run the script end-to-end in SQL Server.
- Confirm `orders_delivered <= orders_placed` for each `order_date`.
- Confirm `late_deliveries <= orders_delivered` for each `order_date`.
- Spot-check that average delivery days is only computed for delivered orders with non-null delivery timestamps.

## Contribution Guidance

When contributing:

- Keep SQL Server T-SQL compatibility.
- Preserve the intent of daily operational reporting.
- Prefer behavior-preserving refactors (readability, safety, and maintainability).
- Document any assumption changes in this README.

## Project Workflow

```text
Olist Dataset
      ↓
SQL Server
      ↓
Data Profiling
      ↓
90-Day Analysis
      ↓
Daily Aggregation
      ↓
Operational Health Flags
      ↓
Excel Summary
      ↓
Business Findings
```
