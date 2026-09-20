-- 1. Sessions and Orders by Traffic Source

SELECT
    ws.utm_source,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.order_id) * 100.0
        / COUNT(DISTINCT ws.website_session_id) AS conversion_rate
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY
    ws.utm_source
ORDER BY
    sessions DESC;


-- 2. Revenue and Profit by Traffic Source

SELECT
    ws.utm_source,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    SUM(o.price_usd) AS revenue,
    SUM(o.cogs_usd) AS cogs,
    SUM(o.price_usd - o.cogs_usd) AS profit
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY
    ws.utm_source
ORDER BY
    revenue DESC;


-- 3. Revenue per Session by Traffic Source

SELECT
    ws.utm_source,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    SUM(o.price_usd) AS revenue,
    SUM(o.price_usd)
        / COUNT(DISTINCT ws.website_session_id) AS revenue_per_session
FROM website_sessions ws
LEFT JOIN orders o
    ON ws.website_session_id = o.website_session_id
GROUP BY
    ws.utm_source
ORDER BY
    revenue_per_session DESC;


-- 4. Device Performance

SELECT
    ws.device_type,
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
    ws.device_type
ORDER BY
    sessions DESC;


-- 5. Landing Page Performance

SELECT
    wp.pageview_url AS landing_page,
    COUNT(DISTINCT wp.website_session_id) AS sessions
FROM website_pageviews wp
WHERE wp.pageview_url IN (
    '/home',
    '/lander-1',
    '/lander-2',
    '/lander-3',
    '/lander-4',
    '/lander-5'
)
GROUP BY
    wp.pageview_url
ORDER BY
    sessions DESC;


-- 6. True Landing Page Performance
-- Identifies the first pageview for each website session

WITH first_pageview AS (
    SELECT
        website_session_id,
        pageview_url,
        ROW_NUMBER() OVER (
            PARTITION BY website_session_id
            ORDER BY website_pageview_id
        ) AS pageview_rank
    FROM website_pageviews
)

SELECT
    fp.pageview_url AS landing_page,
    COUNT(DISTINCT fp.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    COUNT(DISTINCT o.order_id) * 100.0
        / COUNT(DISTINCT fp.website_session_id) AS conversion_rate,
    SUM(o.price_usd) AS revenue
FROM first_pageview fp
LEFT JOIN orders o
    ON fp.website_session_id = o.website_session_id
WHERE fp.pageview_rank = 1
GROUP BY
    fp.pageview_url
ORDER BY
    conversion_rate DESC;
