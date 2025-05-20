-- Retrieve the total number of orders placed.
SELECT COUNT(*) AS total_orders FROM orders;

-- Calculate the total revenue generated from pizza sales.
SELECT ROUND(SUM(price*quantity),2) AS total_revenue FROM pizzas
INNER JOIN order_details 
ON pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza.
SELECT * FROM pizzas
WHERE price = (SELECT max(price) FROM pizzas);

-- Identify the most common pizza size ordered.
SELECT size, SUM(quantity) AS total_orders FROM pizzas p 
INNER JOIN order_details AS o
ON p.pizza_id = o.pizza_id
GROUP BY size
ORDER BY total_orders DESC
LIMIT 1;


-- List the top 5 most ordered pizza types along with their quantities.
SELECT name, SUM(quantity) AS pizza_order_qty FROM pizzas AS p
INNER JOIN pizza_types AS pt
ON p.pizza_type_id = pt.pizza_type_id
INNER JOIN order_details AS od
ON p.pizza_id = od.pizza_id
GROUP BY name
ORDER BY pizza_order_qty DESC
LIMIT 5;
