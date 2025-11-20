-- PHASE 1: Foundation & Inspection
SELECT * FROM order_details LIMIT 5;
SELECT * FROM orders LIMIT 5;
SELECT * FROM pizza_types LIMIT 5;
SELECT * FROM pizzas LIMIT 5;

-- Q2. List all unique pizza categories
SELECT DISTINCT category FROM pizza_types;

-- Q3. Display pizza_type_id, name, and ingredients (handling NULLs)
SELECT pizza_type_id, name, COALESCE(ingredients, 'Missing Data') AS ingredients 
FROM pizza_types 
LIMIT 5;

-- Q4. Check for pizzas missing a price
SELECT * FROM pizzas WHERE price IS NULL;


-- PHASE 2: Filtering & Exploration

-- Q1. Orders placed on '2015-01-01'
SELECT * FROM orders WHERE date = '2015-01-01';

-- Q2. List pizzas with price descending
SELECT * FROM pizzas ORDER BY price DESC;

-- Q3. Pizzas sold in sizes 'L' or 'XL'
SELECT * FROM pizzas WHERE size IN ('L', 'XL');

-- Q4. Pizzas priced between $15.00 and $17.00
SELECT * FROM pizzas WHERE price BETWEEN 15.00 AND 17.00;

-- Q5. Pizzas with "Chicken" in the name
SELECT * FROM pizza_types WHERE name LIKE '%Chicken%';

-- Q6. Orders on '2015-02-15' or placed after 8 PM
SELECT * FROM orders WHERE date = '2015-02-15' OR time > '20:00:00';


-- PHASE 3: Sales Performance

-- Q1. Total quantity of pizzas sold
SELECT SUM(quantity) AS total_quantity FROM order_details;

-- Q2. Average pizza price
SELECT AVG(price) AS average_price FROM pizzas;

-- Q3. Total order value per order
SELECT od.order_id, SUM(od.quantity * p.price) AS total_order_value 
FROM order_details od 
JOIN pizzas p ON od.pizza_id = p.pizza_id 
GROUP BY od.order_id;

-- Q4. Total quantity sold per pizza category
SELECT pt.category, SUM(od.quantity) AS total_quantity 
FROM pizza_types pt 
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id 
JOIN order_details od ON p.pizza_id = od.pizza_id 
GROUP BY pt.category;

-- Q5. Categories with more than 5,000 pizzas sold
SELECT pt.category, SUM(od.quantity) AS total_quantity 
FROM pizza_types pt 
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id 
JOIN order_details od ON p.pizza_id = od.pizza_id 
GROUP BY pt.category 
HAVING SUM(od.quantity) > 5000;

-- Q6. Pizzas never ordered
SELECT p.pizza_id 
FROM pizzas p 
LEFT JOIN order_details od ON p.pizza_id = od.pizza_id 
WHERE od.order_details_id IS NULL;

-- Q7. Price differences between different sizes of the same pizza
SELECT p1.pizza_type_id, p1.size AS size_1, p2.size AS size_2, 
(p1.price - p2.price) AS price_diff 
FROM pizzas p1 
JOIN pizzas p2 ON p1.pizza_type_id = p2.pizza_type_id 
WHERE p1.pizza_id != p2.pizza_id;