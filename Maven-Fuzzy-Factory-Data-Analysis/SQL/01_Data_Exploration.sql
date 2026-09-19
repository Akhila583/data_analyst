SELECT 'website_sessions' AS table_name, COUNT(*) AS row_count
FROM website_sessions

UNION ALL

SELECT 'website_pageviews', COUNT(*)
FROM website_pageviews

UNION ALL

SELECT 'orders', COUNT(*)
FROM orders

UNION ALL

SELECT 'order_items', COUNT(*)
FROM order_items

UNION ALL

SELECT 'products', COUNT(*)
FROM products

UNION ALL

SELECT 'order_item_refunds', COUNT(*)
FROM order_item_refunds;
