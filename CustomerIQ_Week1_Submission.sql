USE customeriq;
SHOW TABLES;

SELECT COUNT(*) AS customer_count
FROM customers;
SELECT COUNT(*) AS transaction_count
FROM transactions;
USE customeriq;

DROP TABLE IF EXISTS customer_aggregated_week1;

CREATE TABLE customer_aggregated_week1 AS
SELECT
    c.customer_id,
    c.customer_name,
    c.gender,
    c.age,
    c.city,
    c.signup_date,
    COUNT(t.transaction_id) AS total_purchases,
    COALESCE(SUM(t.total_amount), 0) AS total_spent,
    COALESCE(ROUND(AVG(t.total_amount), 2), 0) AS average_purchase_value,
    MIN(t.transaction_date) AS first_purchase_date,
    MAX(t.transaction_date) AS last_purchase_date
FROM customers c
LEFT JOIN transactions t
    ON c.customer_id = t.customer_id
GROUP BY
    c.customer_id,
    c.customer_name,
    c.gender,
    c.age,
    c.city,
    c.signup_date;
    USE customeriq;

SELECT * FROM customer_aggregated_week1
LIMIT 10;