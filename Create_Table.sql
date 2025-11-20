-- 1. Create the pizza_types table
CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    ingredients TEXT
);

-- 2. Create the pizzas table
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50), 
    size VARCHAR(10),
    price NUMERIC(5, 2)
);

-- 3. Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE,
    time TIME WITHOUT TIME ZONE
);

-- 4. Create the order_details table
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    pizza_id VARCHAR(50),
    quantity INT
);