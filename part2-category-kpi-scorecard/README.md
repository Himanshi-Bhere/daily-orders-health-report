# Part 2 — Category KPI Scorecard

This module contains category-level commercial KPI analysis for the Olist dataset.

## Contents

- SQL script: [`sql/part2_category_kpi_scorecard.sql`](sql/part2_category_kpi_scorecard.sql)
- Excel folder: [`excel/`](excel/) (placeholder maintained with `.gitkeep`)
- Screenshots:
  - [`screenshots/part2_category_pivot.png`](screenshots/part2_category_pivot.png)
  - [`screenshots/part2_summary.png`](screenshots/part2_summary.png)
  - [`screenshots/part2_findings.png`](screenshots/part2_findings.png)
  - [`screenshots/part2_sparkline.png`](screenshots/part2_sparkline.png)

## SQL analysis scope

`part2_category_kpi_scorecard.sql` analyzes category performance using:

- `olist_orders_dataset`
- `olist_order_items_dataset`
- `olist_products_dataset`
- `olist_order_reviews_dataset`

The script builds monthly and category-level outputs for:

- Total revenue
- Total orders (distinct)
- Average order value (AOV)
- Average review score
- Cancelled orders and cancellation rate
- Revenue band classification (`Star`, `Watch`, `Fix`)
- Top-10 and Bottom-10 category rankings

## Outputs supported by the script

1. Monthly Category KPI scorecard
2. Revenue band classification by category revenue
3. Top/Bottom category ranking summary

## Preview

![Part 2 Category Pivot](screenshots/part2_category_pivot.png)
![Part 2 Summary](screenshots/part2_summary.png)
![Part 2 Findings](screenshots/part2_findings.png)
![Part 2 Sparkline](screenshots/part2_sparkline.png)
