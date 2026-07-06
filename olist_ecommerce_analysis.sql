-- Olist E-Commerce Analytics Project
-- Business Analysis SQL Queries

-- 1. Total revenue
SELECT 
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM olist_order_payments_dataset;

-- 2. Total orders
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM olist_orders_dataset;

-- 3. Total customers
SELECT 
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM olist_customers_dataset;

-- 4. Orders by status
SELECT 
    order_status,
    COUNT(order_id) AS total_orders
FROM olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;

-- 5. Monthly revenue trend
SELECT 
    MONTH(o.order_purchase_timestamp) AS order_month,
    ROUND(SUM(p.payment_value), 2) AS total_revenue
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
    ON o.order_id = p.order_id
GROUP BY MONTH(o.order_purchase_timestamp)
ORDER BY order_month;

-- 6. Revenue by payment type
SELECT 
    payment_type,
    ROUND(SUM(payment_value), 2) AS total_revenue
FROM olist_order_payments_dataset
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- 7. Top 10 states by customers
SELECT 
    customer_state,
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY total_customers DESC
LIMIT 10;

-- 8. Top 10 cities by customers
SELECT 
    customer_city,
    COUNT(DISTINCT customer_unique_id) AS total_customers
FROM olist_customers_dataset
GROUP BY customer_city
ORDER BY total_customers DESC
LIMIT 10;

-- 9. Top 10 product categories by revenue
SELECT 
    pr.product_category_name,
    ROUND(SUM(oi.price), 2) AS product_revenue
FROM olist_order_items_dataset oi
JOIN olist_products_dataset pr
    ON oi.product_id = pr.product_id
WHERE pr.product_category_name IS NOT NULL
GROUP BY pr.product_category_name
ORDER BY product_revenue DESC
LIMIT 10;

-- 10. Top 10 products by revenue
SELECT 
    product_id,
    ROUND(SUM(price), 2) AS product_revenue
FROM olist_order_items_dataset
WHERE product_id IS NOT NULL
GROUP BY product_id
ORDER BY product_revenue DESC
LIMIT 10;

-- 11. Average review score
SELECT 
    ROUND(AVG(review_score), 2) AS average_review_score
FROM olist_order_reviews_dataset;

-- 12. Average delivery days
SELECT 
    ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)), 2) AS average_delivery_days
FROM olist_orders_dataset
WHERE order_delivered_customer_date IS NOT NULL;