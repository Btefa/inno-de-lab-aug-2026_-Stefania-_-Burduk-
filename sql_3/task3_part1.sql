SELECT country,
COUNT(*) AS customers_amount
FROM Customers
GROUP BY country;