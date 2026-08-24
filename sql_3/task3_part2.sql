SELECT
    item,
    AVG(amount) AS avg_amount
FROM Orders
GROUP BY item;