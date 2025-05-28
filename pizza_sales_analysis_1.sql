CREATE DATABASE pizza_sales;

CREATE TABLE orders(
    order_id INTEGER NOT NULL PRIMARY KEY,
	order_date DATE NOT NULL,
    order_time TIME NOT NULL
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE order_details(
	order_detail_id INTEGER NOT NULL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    pizza_id TEXT NOT NULL,
	quantity INTEGER NOT NULL
);

LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/order_details.csv'
INTO TABLE order_details
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



SELECT * FROM pizza_types;
