drop database if exists flipkart_analysis
CREATE DATABASE flipkart_analysis;
USE flipkart_analysis;

CREATE TABLE flipkart_sales (
    order_id VARCHAR(20),
    order_date DATE,
    customer_name VARCHAR(100),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    brand VARCHAR(50),
    seller VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50),
    quantity INT,
    selling_price DECIMAL(10,2),
    discount DECIMAL(5,2),
    cost_price DECIMAL(10,2),
    profit DECIMAL(12,2),
    payment_method VARCHAR(50),
    delivery_status VARCHAR(50),
    rating INT,
    return_status VARCHAR(50)
);
USE flipkart_analysis;

-- Q1. What is the total number of orders?

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM flipkart_sales;


-- Q2. What is the total quantity of products sold?

SELECT SUM(quantity) AS total_quantity_sold
FROM flipkart_sales;


-- Q3. What is the total revenue generated from all sales?
-- Revenue = Selling Price × Quantity

SELECT 
    ROUND(SUM(selling_price * quantity), 2) AS total_revenue
FROM flipkart_sales;


-- Q4. What is the total profit generated from all sales?

SELECT 
    ROUND(SUM(profit), 2) AS total_profit
FROM flipkart_sales;


-- Q5. Which product category generates the highest revenue?

SELECT 
    product_category,
    ROUND(SUM(selling_price * quantity), 2) AS total_revenue
FROM flipkart_sales
GROUP BY product_category
ORDER BY total_revenue DESC;


-- Q6. Which product category generates the highest profit?

SELECT 
    product_category,
    ROUND(SUM(profit), 2) AS total_profit
FROM flipkart_sales
GROUP BY product_category
ORDER BY total_profit DESC;


-- Q7. Which brand generates the highest sales revenue?

SELECT 
    brand,
    ROUND(SUM(selling_price * quantity), 2) AS total_sales
FROM flipkart_sales
GROUP BY brand
ORDER BY total_sales DESC;


-- Q8. Which state generates the highest revenue?

SELECT 
    state,
    ROUND(SUM(selling_price * quantity), 2) AS total_revenue
FROM flipkart_sales
GROUP BY state
ORDER BY total_revenue DESC;


-- Q9. What is the average customer rating for each product category?

SELECT 
    product_category,
    ROUND(AVG(rating), 2) AS average_rating
FROM flipkart_sales
GROUP BY product_category
ORDER BY average_rating DESC;


-- Q10. Which payment method is used most frequently?

SELECT 
    payment_method,
    COUNT(*) AS total_orders
FROM flipkart_sales
GROUP BY payment_method
ORDER BY total_orders DESC;


-- Q11. What percentage of orders have been returned?

SELECT 
    ROUND(
        SUM(
            CASE 
                WHEN return_status = 'Returned' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS return_rate_percentage
FROM flipkart_sales;


-- Q12. Which product category has the highest return rate?

SELECT 
    product_category,
    COUNT(*) AS total_orders,
    SUM(
        CASE 
            WHEN return_status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS returned_orders,
    ROUND(
        SUM(
            CASE 
                WHEN return_status = 'Returned' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS return_rate_percentage
FROM flipkart_sales
GROUP BY product_category
ORDER BY return_rate_percentage DESC;


-- Q13. What is the distribution of orders by delivery status?

SELECT 
    delivery_status,
    COUNT(*) AS total_orders
FROM flipkart_sales
GROUP BY delivery_status
ORDER BY total_orders DESC;


-- Q14. Who are the top 10 sellers based on total profit?

SELECT 
    seller,
    ROUND(SUM(profit), 2) AS total_profit
FROM flipkart_sales
GROUP BY seller
ORDER BY total_profit DESC
LIMIT 10;


-- Q15. What are the monthly revenue and profit trends?

SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    ROUND(SUM(selling_price * quantity), 2) AS monthly_revenue,
    ROUND(SUM(profit), 2) AS monthly_profit
FROM flipkart_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;
-- KPI 1. What is the Average Order Value (AOV)?

SELECT 
    ROUND(
        SUM(selling_price * quantity) /
        COUNT(DISTINCT order_id),
        2
    ) AS average_order_value
FROM flipkart_sales;


-- KPI 2. What is the overall Profit Margin?

SELECT 
    ROUND(
        SUM(profit) /
        SUM(selling_price * quantity) * 100,
        2
    ) AS profit_margin_percentage
FROM flipkart_sales;


-- KPI 3. What is the average customer rating?

SELECT 
    ROUND(AVG(rating), 2) AS average_customer_rating
FROM flipkart_sales;


-- KPI 4. How many orders were successfully delivered?

SELECT 
    COUNT(*) AS delivered_orders
FROM flipkart_sales
WHERE delivery_status = 'Delivered';


-- KPI 5. What is the total number of returned orders?

SELECT 
    COUNT(*) AS returned_orders
FROM flipkart_sales
WHERE return_status = 'Returned';


-- KPI 6. What is the total number of cancelled orders?

SELECT 
    COUNT(*) AS cancelled_orders
FROM flipkart_sales
WHERE delivery_status = 'Cancelled';


-- KPI 7. What is the total number of unique customers?

SELECT 
    COUNT(DISTINCT customer_name) AS unique_customers
FROM flipkart_sales;


-- KPI 8. What is the average quantity per order?

SELECT 
    ROUND(
        SUM(quantity) / COUNT(DISTINCT order_id),
        2
    ) AS average_quantity_per_order
FROM flipkart_sales;


-- KPI 9. What is the total discount given?

SELECT 
    ROUND(SUM(discount), 2) AS total_discount
FROM flipkart_sales;


