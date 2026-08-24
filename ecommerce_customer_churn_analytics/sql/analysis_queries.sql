-- 1. Monthly revenue
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(net_amount) AS revenue
FROM orders
WHERE order_status = 'Completed'
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

-- 2. Revenue by customer segment
SELECT
    c.segment,
    SUM(o.net_amount) AS revenue,
    COUNT(DISTINCT o.customer_id) AS purchasing_customers
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.segment
ORDER BY revenue DESC;

-- 3. Churn rate by segment
SELECT
    segment,
    COUNT(*) AS customers,
    SUM(CASE WHEN status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    CAST(100.0 * SUM(CASE WHEN status = 'Churned' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(6,2)) AS churn_rate_pct
FROM customers
GROUP BY segment
ORDER BY churn_rate_pct DESC;

-- 4. Churn rate by acquisition channel
SELECT
    acquisition_channel,
    COUNT(*) AS customers,
    SUM(CASE WHEN status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    CAST(100.0 * SUM(CASE WHEN status = 'Churned' THEN 1 ELSE 0 END) / COUNT(*) AS DECIMAL(6,2)) AS churn_rate_pct
FROM customers
GROUP BY acquisition_channel
ORDER BY churn_rate_pct DESC;

-- 5. Top 10 customers by revenue
SELECT TOP 10
    c.customer_id,
    c.segment,
    c.plan,
    SUM(o.net_amount) AS lifetime_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.segment, c.plan
ORDER BY lifetime_revenue DESC;

-- 6. Customers at risk: churned OR low recent engagement
WITH recent_engagement AS (
    SELECT
        customer_id,
        AVG(CAST(sessions AS FLOAT)) AS avg_sessions,
        SUM(support_tickets) AS tickets
    FROM customer_engagement
    WHERE month >= DATEADD(MONTH, -3, '2026-06-30')
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.segment,
    c.plan,
    c.status,
    re.avg_sessions,
    re.tickets
FROM customers c
LEFT JOIN recent_engagement re ON c.customer_id = re.customer_id
WHERE c.status = 'Churned'
   OR ISNULL(re.avg_sessions, 0) < 3
ORDER BY re.avg_sessions;

-- 7. Monthly churn count
SELECT
    YEAR(churn_date) AS churn_year,
    MONTH(churn_date) AS churn_month,
    COUNT(*) AS churned_customers
FROM customers
WHERE status = 'Churned'
GROUP BY YEAR(churn_date), MONTH(churn_date)
ORDER BY churn_year, churn_month;

-- 8. Revenue by product category
SELECT
    product_category,
    SUM(net_amount) AS revenue,
    COUNT(*) AS completed_orders
FROM orders
WHERE order_status = 'Completed'
GROUP BY product_category
ORDER BY revenue DESC;
