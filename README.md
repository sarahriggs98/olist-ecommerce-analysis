# Olist E-Commerce Analysis

## Overview
Analysis of Brazilian e-commerce platform Olist's sales data from 2016-2018 
using PostgreSQL and Python.

## Dataset
- Source: [Olist Brazilian E-Commerce Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- 99,441 orders across 8 related tables

## Tools Used
- PostgreSQL — data storage and analysis
- Python (pandas, sqlalchemy) — data ingestion
- pgAdmin 4 — query development

## Key Findings
1. **Revenue grew consistently** month over month from 2016 to 2018
2. **Health & Beauty** was the top revenue generating product category
3. **100% of customers were one time buyers** suggesting a retention problem
4. **Delivery time directly correlated with review scores** — longer delivery = lower ratings

## SQL Skills Demonstrated
- Multi-table JOINs
- Aggregations and GROUP BY
- Date casting and manipulation
- Subqueries
- CASE statements
- Window functions

## Files
- `load_data.py` — loads CSV data into PostgreSQL
- `queries.sql` — all analytical queries