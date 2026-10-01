# Daily Orders Health Report

Professional SQL Server and Excel analytics project based on the Olist Brazilian E-Commerce dataset.

## Project overview

This repository is organized into two focused analysis modules:

1. **Part 1 — Daily Order Health**
   - Operational daily KPI monitoring (orders, deliveries, cancellations, late deliveries, delivery duration)
   - Includes SQL, Excel report, and supporting screenshots

2. **Part 2 — Category KPI Scorecard**
   - Category-level business performance analysis (revenue, orders, AOV, reviews, cancellation rate)
   - Includes SQL and supporting screenshots

## Repository structure

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
└── README.md
```

## Module documentation

- Part 1 docs: [`part1-order-health/README.md`](part1-order-health/README.md)
- Part 2 docs: [`part2-category-kpi-scorecard/README.md`](part2-category-kpi-scorecard/README.md)

## Data source

- [Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

## Tech stack

- SQL Server / T-SQL
- Microsoft Excel
- GitHub
