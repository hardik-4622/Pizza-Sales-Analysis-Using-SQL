-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT category, SUM(quantity) AS total_qty FROM pizzas AS p
INNER JOIN pizza_types AS pt
ON p.pizza_type_id = pt.pizza_type_id
INNER JOIN order_details AS od
ON p.pizza_id = od.pizza_id
GROUP BY category;

-- Determine the distribution of orders by hour of the day.
SELECT HOUR(order_time) hour_of_day, COUNT(order_id) no_of_orders
FROM orders
GROUP BY hour_of_day;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT category, COUNT(name) AS distribution FROM pizzas AS p
INNER JOIN pizza_types AS pt
ON p.pizza_type_id = pt.pizza_type_id
INNER JOIN order_details AS od
ON p.pizza_id = od.pizza_id
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
WITH pizza_orders AS(
SELECT o.order_date odate, SUM(od.quantity) sum_qty FROM orders o
INNER JOIN order_details od
ON o.order_id = od.order_id
GROUP BY odate)
SELECT ROUND(AVG(sum_qty)) avg_pizzas_per_day from pizza_orders;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT pt.name, pt.pizza_type_id, SUM(p.price * od.quantity) total_revenue FROM pizzas p
INNER JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
INNER JOIN order_details od
ON p.pizza_id = od.pizza_id
GROUP BY pt.pizza_type_id, pt.name
ORDER BY total_revenue DESC
LIMIT 3;

-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT pt.category, 
ROUND((SUM(p.price * od.quantity) / (SELECT SUM(p.price * od.quantity) 
								FROM pizzas p 
                                INNER JOIN order_details od 
                                ON p.pizza_id = od.pizza_id))*100,2) 
AS revenue_percent
FROM pizzas p 
INNER JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
INNER JOIN order_details od
ON p.pizza_id = od.pizza_id
GROUP BY pt.category;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT pt.pizza_type_id , pt.category, SUM(p.price * od.quantity) revenue FROM pizzas p
INNER JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
INNER JOIN order_details od
ON p.pizza_id = od.pizza_id
GROUP BY pt.pizza_type_id , pt.category
ORDER BY pt.category ASC, revenue DESC;