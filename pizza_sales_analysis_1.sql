CREATE DATABASE pizza_sales;

CREATE TABLE orders(
    order_id INTEGER NOT NULL PRIMARY KEY,
	order_date DATE NOT NULL,
    order_time TIME NOT NULL
);

CREATE TABLE order_details(
	order_detail_id INTEGER NOT NULL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    pizza_id TEXT NOT NULL,
	quantity INTEGER NOT NULL
);

SELECT * FROM pizza_types;