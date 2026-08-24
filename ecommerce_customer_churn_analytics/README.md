# E-Commerce Customer Churn & Revenue Analytics

## Project Overview

An end-to-end Data Analyst portfolio project that analyzes customer revenue, purchasing behavior, engagement, and churn for an e-commerce business.

The project uses **SQL Server, Python (Pandas), and Power BI** to transform raw customer/order/engagement data into business insights and actionable customer-retention recommendations.

## Business Problem

The company is growing revenue but wants to understand:

- Which customer segments generate the most revenue?
- Which acquisition channels have the highest churn?
- How is revenue changing month over month?
- Which products contribute most to revenue?
- What customer behaviors are associated with churn?
- Which customers should the retention team prioritize?

## Objectives

1. Analyze revenue performance.
2. Calculate customer churn rate.
3. Identify high-risk customer segments.
4. Compare acquisition channels.
5. Analyze product-level revenue.
6. Create a customer-risk shortlist.
7. Build an executive Power BI dashboard.

## Dataset

The project contains three CSV files:

### customers.csv
Customer master data:
- customer_id
- segment
- region
- acquisition_channel
- plan
- signup_date
- status
- churn_date
- churn_reason

### orders.csv
Transaction data:
- order_id
- customer_id
- order_date
- product_category
- gross_amount
- discount_pct
- net_amount
- order_status

### customer_engagement.csv
Monthly engagement:
- customer_id
- month
- sessions
- support_tickets
- active_flag

## Tools & Skills Demonstrated

### SQL
- SELECT / WHERE
- GROUP BY / HAVING
- CASE WHEN
- JOINs
- CTEs
- Aggregate functions
- Date functions
- Customer segmentation
- Churn analysis

### Python
- Pandas
- Data cleaning
- Groupby / aggregation
- KPI calculations
- Basic visualization
- Risk scoring
- CSV output

### Power BI
- Data modeling
- Relationships
- DAX measures
- KPI cards
- Slicers
- Trend analysis
- Drill-down analysis
- Customer risk dashboard

## Key Business KPIs

- Total Revenue
- Completed Orders
- Total Customers
- Churned Customers
- Churn Rate
- Average Order Value
- Revenue by Segment
- Revenue by Product
- Revenue by Acquisition Channel

## Suggested Dashboard

### Page 1 — Executive Overview
Show:
- Total Revenue
- Total Customers
- Churn Rate
- Average Order Value
- Monthly Revenue Trend
- Revenue by Segment

### Page 2 — Customer & Churn
Show:
- Churn Rate by Segment
- Churn Rate by Acquisition Channel
- Churn Reasons
- Churn Trend
- Region and Plan filters

### Page 3 — Revenue Analysis
Show:
- Revenue by Product Category
- Revenue by Customer Segment
- Top 10 Customers
- Monthly Revenue

### Page 4 — Customer Risk
Create a table with:
- Customer
- Segment
- Plan
- Status
- Average Sessions
- Support Tickets
- Risk Score

## Business Recommendations

After completing the analysis, recommendations should be based on the actual findings. Examples of the type of recommendation expected:

- Prioritize retention campaigns for high-churn segments.
- Investigate acquisition channels with high churn despite strong customer acquisition.
- Offer targeted retention incentives to high-value customers showing declining engagement.
- Investigate products/categories with strong sales but high return rates.
- Use engagement and support-ticket trends as early-warning indicators.

## Interview Explanation

A concise way to explain the project:

> "I built an end-to-end customer churn and revenue analytics project using SQL, Python and Power BI. I analyzed transaction and engagement data to calculate revenue and churn KPIs, identify high-risk customer segments, and create a customer risk score. I then designed a Power BI dashboard for executive and retention-team analysis. The project helped translate raw transactional data into actionable customer-retention insights."

## Project Structure

```text
ecommerce-customer-churn-analytics/
│
├── data/
│   ├── customers.csv
│   ├── orders.csv
│   └── customer_engagement.csv
│
├── sql/
│   ├── schema.sql
│   └── analysis_queries.sql
│
├── python/
│   └── analysis.py
│
├── powerbi/
│   └── dashboard_plan.txt
│
└── README.md
```

## How to Run

### SQL Server
1. Create a database.
2. Run `sql/schema.sql`.
3. Import the three CSV files.
4. Run queries from `sql/analysis_queries.sql`.

### Python
Install:

```bash
pip install pandas matplotlib
```

Then:

```bash
cd python
python analysis.py
```

### Power BI
1. Import the three CSV files.
2. Create relationships using `customer_id`.
3. Create the DAX measures listed in `powerbi/dashboard_plan.txt`.
4. Build the four suggested dashboard pages.

## Portfolio Value

This project demonstrates the complete Data Analyst workflow:

**Raw Data → Data Cleaning → SQL Analysis → Python Analysis → KPI Development → Dashboard → Business Recommendations**

It is designed to be discussed in Data Analyst interviews as a practical business analytics case study.
