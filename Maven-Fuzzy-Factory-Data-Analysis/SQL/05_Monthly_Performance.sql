
-- 1. Monthly Website Performance
-- Sessions, orders, conversion rate, revenue and revenue per session

SELECT
    YEAR(ws.created_at) AS year,
    MONTH(ws.created_at) AS month,

    COUNT(DISTINCT ws.website_session_id) AS sessions,

    COUNT(DISTINCT o.order_id) AS orders,

    COUNT(DISTINCT o.order_id) * 100.0
        / COUNT(DISTINCT ws.website_session_id) AS conversion_rate,

    SUM(o.price_usd) AS revenue,

    SUM(o.price_usd)
        / COUNT(DISTINCT ws.website_session_id) AS revenue_per_session

FROM website_sessions ws

LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id

GROUP BY
    YEAR(ws.created_at),
    MONTH(ws.created_at)

ORDER BY
    year,
    month;


-- 2. Monthly Product Performance
-- Revenue and profit by month and product

SELECT
    YEAR(oi.created_at) AS year,
    MONTH(oi.created_at) AS month,
    p.product_name,

    COUNT(DISTINCT oi.order_id) AS orders,

    SUM(oi.price_usd) AS revenue,

    SUM(oi.cogs_usd) AS cost,

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


-- 3. Monthly Device Performance
-- Compare desktop and mobile performance over time

SELECT
    YEAR(ws.created_at) AS year,
    MONTH(ws.created_at) AS month,
    ws.device_type,

    COUNT(DISTINCT ws.website_session_id) AS sessions,

    COUNT(DISTINCT o.order_id) AS orders,

    COUNT(DISTINCT o.order_id) * 100.0
        / COUNT(DISTINCT ws.website_session_id) AS conversion_rate,

    SUM(o.price_usd) AS revenue

FROM website_sessions ws

LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id

GROUP BY
    YEAR(ws.created_at),
    MONTH(ws.created_at),
    ws.device_type

ORDER BY
    year,
    month,
    device_type;


-- 4. Monthly Marketing Source Performance
-- Analyze traffic source performance over time

SELECT
    YEAR(ws.created_at) AS year,
    MONTH(ws.created_at) AS month,
    ws.utm_source,

    COUNT(DISTINCT ws.website_session_id) AS sessions,

    COUNT(DISTINCT o.order_id) AS orders,

    COUNT(DISTINCT o.order_id) * 100.0
        / COUNT(DISTINCT ws.website_session_id) AS conversion_rate,

    SUM(o.price_usd) AS revenue

FROM website_sessions ws

LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id

GROUP BY
    YEAR(ws.created_at),
    MONTH(ws.created_at),
    ws.utm_source

ORDER BY
    year,
    month,
    revenue DESC;
