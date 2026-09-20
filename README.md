# Daily Orders Health Report — Olist E-Commerce

## Project Overview

This project analyzes order and delivery performance using the Olist Brazilian E-Commerce dataset.

The objective was to create a daily operational health report that helps identify order volume, delivery performance, cancellations, late deliveries, and changes in average delivery time.

The analysis was performed using SQL Server and Excel, following a workflow similar to a real-world data analyst reporting process.

---

## Business Problem

E-commerce operations teams need to monitor order activity and delivery performance regularly.

The key questions addressed in this project are:

- How many orders were placed?
- How many orders were delivered?
- How many orders were cancelled?
- How many deliveries were late?
- What was the average delivery time?
- Which dates showed potential operational issues?

---

## Dataset

**Dataset:** Olist Brazilian E-Commerce Public Dataset

The dataset contains approximately 100,000 orders from the Brazilian e-commerce marketplace Olist.

The order data covers:

**September 2016 – October 2018**

For this analysis, the final 90-day period available in the dataset was used:

**19 July 2018 – 17 October 2018**

The final daily report contains 59 dates with recorded orders within this analysis window.

---

## Tools Used

- SQL Server
- SQL Server Management Studio (SSMS)
- Microsoft Excel
- GitHub
- VS Code

---

## SQL Analysis

The analysis was performed in SQL Server.

Key SQL concepts used:

- `SELECT`
- `WHERE`
- `COUNT`
- `SUM`
- `AVG`
- `MIN`
- `MAX`
- `GROUP BY`
- `ORDER BY`
- `CAST`
- `DATEDIFF`
- `DATEADD`
- `CASE WHEN`
- Conditional aggregation

The SQL analysis was used to create a daily analytical dataset containing:

- Order date
- Orders placed
- Orders delivered
- Orders cancelled
- Late deliveries
- Average delivery days

---

## Key KPIs

| KPI | Result |
|---|---:|
| Orders Placed | 9,529 |
| Orders Delivered | 9,284 |
| Orders Cancelled | 124 |
| Late Deliveries | 815 |
| Average Delivery Time | 7.86 days |
| Cancellation Rate | 1.30% |
| Late Delivery Rate | 8.78% |

The late-delivery rate is calculated as:

`Late Deliveries / Delivered Orders × 100`

The cancellation rate is calculated as:

`Cancelled Orders / Orders Placed × 100`

---

## Excel Report

The Excel report contains three main sections:

### 1. Daily Health Report

A daily-level dataset showing:

- Orders placed
- Orders delivered
- Orders cancelled
- Late deliveries
- Average delivery days

### 2. Operational Health Flags

Three monitoring flags were created:

| Metric | Alert Threshold |
|---|---:|
| Cancelled Orders | > 3 |
| Late Deliveries | > 10 |
| Average Delivery Days | > 8 |

These thresholds were defined specifically for this analytical exercise to identify dates that may require further investigation.

### 3. Summary & Findings

The Summary sheet provides the overall KPIs, while the Findings sheet translates the numerical results into business observations.

---

## Key Findings

### 1. Order Volume

9,529 orders were placed during the 90-day analysis period, providing a broad view of order volume and operational performance.

### 2. Delivery Performance

9,284 orders were delivered, while 815 deliveries were classified as late. This represents a late-delivery rate of approximately 8.78% among delivered orders.

### 3. Cancellation & Operational Risk

124 orders were cancelled, representing approximately 1.30% of orders placed.

Daily monitoring also identified multiple dates where cancellations, late deliveries, or average delivery time exceeded the defined alert thresholds.

### Overall Observation

The analysis indicates that delivery timeliness is a more prominent operational issue than cancellations during the analyzed period.

The daily health flags provide a simple monitoring mechanism for identifying dates that may require further investigation.

---

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
