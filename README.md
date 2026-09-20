# Maven Fuzzy Factory – E-Commerce Data Analysis

## Project Overview

Maven Fuzzy Factory is an e-commerce data analysis project focused on understanding website performance, customer behavior, marketing effectiveness, product performance, and revenue trends.

The project uses SQL Server and Power BI to transform raw e-commerce data into meaningful business insights and an interactive analytical dashboard.

---

## Business Objective

The objective of this project is to analyze the e-commerce business and answer key questions such as:

- How is website traffic changing over time?
- How effectively are website sessions converting into orders?
- Which marketing sources generate the most revenue?
- How do desktop and mobile users perform?
- Which products generate the highest revenue and profit?
- Which landing pages have the highest conversion rates?
- How are refunds affecting product performance?
- How do revenue and orders change month over month?

---

## Dataset

The project uses the Maven Fuzzy Factory e-commerce dataset containing information about:

- Website sessions
- Website pageviews
- Orders
- Order items
- Product information
- Order item refunds

### Main Tables

| Table | Description |
|---|---|
| `website_sessions` | Website traffic and session information |
| `website_pageviews` | Pages viewed during website sessions |
| `orders` | Customer order information |
| `order_items` | Products purchased within orders |
| `order_item_refunds` | Refund information |
| `products` | Product details |

---

## Tools & Technologies

- **SQL Server**
- **SQL**
- **Power BI**
- **Power Query**
- **DAX**
- **Data Modeling**
- **Excel**
- **GitHub**

---

## SQL Analysis

SQL was used for data exploration, transformation, aggregation, and business analysis.

### Analysis performed

1. Data Exploration
2. Conversion Analysis
3. Product Analysis
4. Marketing Analysis
5. Monthly Performance Analysis

### SQL Concepts Used

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- JOINs
- LEFT JOIN
- CTEs
- Window Functions
- `ROW_NUMBER()`
- Aggregations
- Date Functions
- Conditional Logic
- Conversion Rate Calculations

---

## Power BI Dashboard

The Power BI report contains three analytical sections.

### 1. E-Commerce Performance

Key metrics include:

- Total Revenue
- Total Profit
- Total Orders
- Total Sessions
- Conversion Rate
- Revenue per Session
- Monthly Revenue & Orders
- Marketing Source Performance
- Device Performance

### 2. Product Analysis

The product analysis includes:

- Revenue by Product
- Profit by Product
- Profit Margin
- Refund Analysis
- Product Performance
- Product Combinations

### 3. Website Analysis

The website analysis includes:

- Landing Page Performance
- Landing Page Conversion Rate
- Website Sessions
- Pageviews
- Pages per Session
- New vs Repeat Sessions
- Device Performance

---

## Key DAX Measures

Some of the main measures created in Power BI include:

DAX
Total Revenue =
SUM(orders[price_usd])
Total Sessions =
DISTINCTCOUNT(website_sessions[website_session_id])
Total Orders =
DISTINCTCOUNT(orders[order_id])
Conversion Rate =
DIVIDE(
    [Total Orders],
    [Total Sessions],
    0
)
Revenue per Session =
DIVIDE(
    [Total Revenue],
    [Total Sessions],
    0
)
Total Profit =
SUM(order_items[price_usd]) -
SUM(order_items[cogs_usd])
Profit Margin =
DIVIDE(
    [Total Profit],
    [Total Revenue],
    0
)
Key Business Insights
Revenue & Orders

The analysis shows strong growth in website activity, orders, and revenue over the analysis period.

Conversion

The overall conversion rate improved significantly over time, indicating improved ability to convert website visitors into customers.

Marketing

Marketing sources showed different levels of traffic, conversion, and revenue performance. Evaluating both traffic volume and conversion rate helps identify higher-quality acquisition channels.

Product Performance

Product-level analysis identified differences in revenue, cost, profit, and refund performance.

Website Performance

Landing pages and device types showed different levels of user engagement and conversion, providing opportunities for website optimization.
