/* ============================================================================
PROJECT: Chinook Music Store Analytics
FILE: 03_sales_trends.sql
DESCRIPTION: Time-series analysis to track monthly revenue growth 
             and seasonal sales performance.
============================================================================
*/

-- 1. MONTHLY REVENUE GROWTH (Year-over-Month)
-- Uses DATE_FORMAT for MySQL and the LAG() window function.
WITH monthly_totals AS (
    SELECT 
        DATE_FORMAT(invoice_date, '%Y-%m') AS sale_month,
        SUM(total) AS revenue,
        COUNT(invoice_id) AS transaction_count
    FROM invoice
    GROUP BY sale_month
)
SELECT 
    sale_month,
    revenue,
    -- Looks at the previous row's revenue to compare
    LAG(revenue) OVER (ORDER BY sale_month) AS last_month_revenue,
    -- Calculates the percentage increase or decrease
    ROUND(((revenue - LAG(revenue) OVER (ORDER BY sale_month)) / 
           LAG(revenue) OVER (ORDER BY sale_month)) * 100, 2) AS growth_rate_pct
FROM monthly_totals;

-- 2. SALES BY GEOGRAPHY (Market Share)
-- Identify which countries are driving the most revenue for the store.
SELECT 
    billing_country,
    SUM(total) AS total_revenue,
    COUNT(invoice_id) AS number_of_orders,
    ROUND(AVG(total), 2) AS average_order_value
FROM invoice
GROUP BY billing_country
ORDER BY total_revenue DESC;

-- 3. PEAK SALES HOURS (Hourly Engagement)
-- Helpful for determining when to run server maintenance or promotions.
SELECT 
    HOUR(invoice_date) AS hour_of_day,
    COUNT(invoice_id) AS order_volume,
    SUM(total) AS hourly_revenue
FROM invoice
GROUP BY hour_of_day
ORDER BY hour_of_day;
