SELECT o.order_id, o.item, o.amount, c.first_name, c.last_name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;