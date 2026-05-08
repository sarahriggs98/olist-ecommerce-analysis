-- Total revenue by month
-- Initial look at growth trend, with date range from 2016-2018

SELECT 
    DATE_TRUNC('month', order_purchase_timestamp::date) AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY 1;

-- Revenue by product category
-- Analyzing which product categories are driving the most revenue and orders

SELECT 
    p.product_category_name AS category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price)::numeric, 2) AS total_revenue,
    ROUND(AVG(oi.price)::numeric, 2) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
GROUP BY 1
ORDER BY total_revenue DESC
LIMIT 10;

-- Repeat customers vs one time customers
-- Identifying customer behavior and loyalty

SELECT
    CASE 
        WHEN order_count = 1 THEN 'One Time Customer'
        WHEN order_count = 2 THEN 'Repeat Customer'
        ELSE 'Loyal Customer'
    END AS customer_type,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM (
    SELECT 
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders
    WHERE order_status = 'delivered'
    GROUP BY 1
) subquery
GROUP BY 1
ORDER BY total_customers DESC;

-- Found only one time customers, QC stop to check if any customers placed more than one order

SELECT 
    customer_id,
    COUNT(order_id) AS order_count
FROM orders
WHERE order_status = 'delivered'
GROUP BY 1
ORDER BY order_count DESC
LIMIT 10;

-- Average delivery time vs review score
-- How delivery time impacts customer satisfaction and review scores

SELECT 
    r.review_score,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(
        DATE_PART('day', o.order_delivered_customer_date::timestamp - 
        o.order_purchase_timestamp::timestamp)
    )::numeric, 1) AS avg_delivery_days
FROM orders o
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL
GROUP BY 1
ORDER BY 1;