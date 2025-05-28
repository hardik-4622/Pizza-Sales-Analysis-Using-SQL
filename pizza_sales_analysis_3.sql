-- Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category , sum(order_details.quantity) as quantity2
from pizzas join pizza_types
on pizzas.pizza_type_id=pizza_types.pizza_type_id
join order_details
on pizzas.pizza_id=order_details.pizza_id 
group by pizza_types.category order by quantity2 desc ;

-- Determine the distribution of orders by hour of the day.
SELECT HOUR(order_time)as hour_of_day, COUNT(order_id) no_of_orders
FROM orders
GROUP BY hour_of_day;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT category, COUNT(name) AS distribution FROM pizzas 
JOIN pizza_types 
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
INNER JOIN order_details 
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(quantity4)) from 
(select orders.order_date , sum(order_details.quantity) as quantity4 
from orders join order_details on orders.order_id=order_details.order_id 
group by order_date )as newtable;


-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    category,
   ( revenue / total_revenue ) * 100 AS revenue_share
FROM (
    SELECT 
        pizza_types.category, 
        SUM(pizzas.price * order_details.quantity) AS revenue
    FROM pizzas
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
    JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
    GROUP BY pizza_types.category
) AS category_revenue
 JOIN (
    SELECT 
        SUM(pizzas.price * order_details.quantity) AS total_revenue
    FROM pizzas
    JOIN pizza_types ON pizzas.pizza_type_id = pizza_types.pizza_type_id
    JOIN order_details ON pizzas.pizza_id = order_details.pizza_id
) AS total;


-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select category , name , revenue  from
(select category ,  name , revenue ,
rank() over( partition by category order by revenue desc) as rn from
(select pizza_types.name, pizza_types.category , sum( pizzas.price*order_details.quantity) as revenue from pizza_types join pizzas 
on pizza_types.pizza_type_id=pizzas.pizza_type_id 
join order_details on order_details.pizza_id=pizzas.pizza_id 
group by pizza_types.category , pizza_types.name ) as table4) as table5
where rn <= 3;
