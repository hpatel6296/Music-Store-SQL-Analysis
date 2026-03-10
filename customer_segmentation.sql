/* ============================================================================
PROJECT: Chinook Music Store Analytics
FILE: 02_customer_segmentation.sql
DESCRIPTION: Advanced SQL queries using CTEs and Window Functions 
             to segment users and rank products by performance.
============================================================================
*/

-- 1. CUSTOMER LIFETIME VALUE (LTV) SEGMENTATION
-- Uses a CTE to calculate totals and a CASE statement to create loyalty tiers.
WITH customer_spending AS (
    SELECT 
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        c.country,
        SUM(i.total) AS total_spent,
        COUNT(i.invoice_id) AS order_count
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id, customer_name, c.country
)
SELECT 
    customer_name,
    total_spent,
    CASE 
        WHEN total_spent > 45 THEN 'Platinum (High Value)'
        WHEN total_spent BETWEEN 30 AND 45 THEN 'Gold (Mid Value)'
        ELSE 'Silver (Standard)'
    END AS customer_tier
FROM customer_spending
ORDER BY total_spent DESC;

-- 2. GENRE POPULARITY RANKING
-- Uses the RANK() window function to find the top-selling track per genre.
WITH genre_ranking AS (
    SELECT 
        g.name AS genre_name,
        t.name AS track_name,
        SUM(il.unit_price * il.quantity) AS revenue,
        RANK() OVER (PARTITION BY g.name ORDER BY SUM(il.unit_price * il.quantity) DESC) AS sales_rank
    FROM genre g
    JOIN track t ON g.genre_id = t.genre_id
    JOIN invoice_line il ON t.track_id = il.track_id
    GROUP BY g.name, t.name
)
SELECT 
    genre_name,
    track_name,
    revenue
FROM genre_ranking
WHERE sales_rank = 1
ORDER BY revenue DESC;

-- 3. ARTIST REVENUE PERCENTILE
-- Uses PERCENT_RANK() to identify which artists are in the top 10% of sales.
WITH artist_sales AS (
    SELECT 
        ar.name AS artist_name,
        SUM(il.unit_price * il.quantity) AS total_revenue
    FROM artist ar
    JOIN album al ON ar.artist_id = al.artist_id
    JOIN track t ON al.album_id = t.album_id
    JOIN invoice_line il ON t.track_id = il.track_id
    GROUP BY ar.artist_id, ar.name
)
SELECT 
    artist_name,
    total_revenue,
    ROUND(PERCENT_RANK() OVER (ORDER BY total_revenue DESC) * 100, 2) AS revenue_percentile
FROM artist_sales
ORDER BY total_revenue DESC;
