-- =========================================================
-- 03_Product_Analysis.sql
-- Maven Fuzzy Factory - Product Analysis
-- =========================================================


-- 1. Product Revenue, Profit and Margin
-- Shows total orders, revenue, cost, profit and profit margin by product

SELECT
    p.product_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.price_usd) AS revenue,
    SUM(oi.cogs_usd) AS cost,
    SUM(oi.price_usd - oi.cogs_usd) AS profit,
    SUM(oi.price_usd - oi.cogs_usd) * 100.0
        / SUM(oi.price_usd) AS profit_margin
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_name
ORDER BY
    revenue DESC;


-- 2. Product Revenue Ranking
-- Ranks products based on revenue

SELECT
    p.product_name,
    SUM(oi.price_usd) AS revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(oi.price_usd) DESC
    ) AS revenue_rank
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_name
ORDER BY
    revenue_rank;


-- 3. Product Profit Ranking
-- Ranks products based on profit

SELECT
    p.product_name,
    SUM(oi.price_usd - oi.cogs_usd) AS profit,
    DENSE_RANK() OVER (
        ORDER BY SUM(oi.price_usd - oi.cogs_usd) DESC
    ) AS profit_rank
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_name
ORDER BY
    profit_rank;


-- 4. Product Refund Analysis
-- Shows refunds by product

SELECT
    p.product_name,
    COUNT(DISTINCT oir.order_item_refund_id) AS refund_count,
    SUM(oir.refund_amount_usd) AS total_refunds
FROM order_item_refunds oir
JOIN order_items oi
    ON oir.order_item_id = oi.order_item_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    p.product_name
ORDER BY
    total_refunds DESC;


-- 5. Product Sales by Month
-- Shows monthly product performance

SELECT
    YEAR(oi.created_at) AS year,
    MONTH(oi.created_at) AS month,
    p.product_name,
    COUNT(DISTINCT oi.order_id) AS orders,
    SUM(oi.price_usd) AS revenue,
    SUM(oi.price_usd - oi.cogs_usd) AS profit
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY
    YEAR(oi.created_at),
    MONTH(oi.created_at),
    p.product_name
ORDER BY
    year,
    month,
    revenue DESC;


-- 6. Product Combinations
-- Identifies products frequently purchased together

SELECT
    p1.product_name AS product_1,
    p2.product_name AS product_2,
    COUNT(DISTINCT oi1.order_id) AS times_purchased_together
FROM order_items oi1
JOIN order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.product_id < oi2.product_id
JOIN products p1
    ON oi1.product_id = p1.product_id
JOIN products p2
    ON oi2.product_id = p2.product_id
GROUP BY
    p1.product_name,
    p2.product_name
ORDER BY
    times_purchased_together DESC;
