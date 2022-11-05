CREATE DATABASE `restaurant`;
USE `restaurant`;

CREATE TABLE `products`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL UNIQUE,
    `type` VARCHAR(30) NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL
);

CREATE TABLE `clients`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `birthdate` DATE NOT NULL,
    `card` VARCHAR(50),
    `review` TEXT
);

CREATE TABLE `tables`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `floor` INT NOT NULL,
    `reserved` TINYINT,
    `capacity` INT NOT NULL
);

CREATE TABLE `waiters`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(50) NOT NULL,
    `phone` VARCHAR(50),
    `salary` DECIMAL(10,2)
);

CREATE TABLE `orders`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `table_id` INT NOT NULL,
    `waiter_id` INT NOT NULL,
    `order_time` TIME NOT NULL,
    `payed_status` BOOLEAN,
    CONSTRAINT fk_orders_tables
    FOREIGN KEY (`table_id`)
    REFERENCES `tables` (`id`),
    CONSTRAINT fk_orders_waiters
    FOREIGN KEY (`waiter_id`)
    REFERENCES `waiters` (`id`)    
);

CREATE TABLE `orders_clients`(
	`order_id` INT,
    `client_id` INT,
    CONSTRAINT fk_orders_clients_orders
    FOREIGN KEY (`order_id`)
    REFERENCES `orders` (`id`),
    CONSTRAINT fk_orders_clients_clients
    FOREIGN KEY (`client_id`)
    REFERENCES `clients` (`id`)    
);

CREATE TABLE `orders_products`(
	`order_id` INT,
    `product_id` INT,
    CONSTRAINT fk_orders_products_orders
    FOREIGN KEY (`order_id`)
    REFERENCES `orders` (`id`),
    CONSTRAINT fk_orders_products_products
    FOREIGN KEY (`product_id`)
    REFERENCES `products` (`id`)    
);

INSERT INTO `products`(`name`, `type`, `price`)
SELECT (CONCAT(w.`last_name`, ' ', 'specialty')),'Cocktail', (CEIL(w.`salary` * 0.01)) FROM `waiters` AS w
WHERE w.`id` > 6;

UPDATE `orders` AS o
SET o.`table_id` = o.`table_id` - 1
WHERE o.`id` BETWEEN 12 AND 23;

DELETE w FROM `waiters` AS w 
LEFT JOIN `orders` AS o
ON w.`id` =  o.`waiter_id`
WHERE o.`waiter_id` IS NULL;

SELECT `id`, `first_name`, `last_name`, `birthdate`, `card`, `review` FROM `clients`
ORDER BY `birthdate` DESC;

SELECT `first_name`, `last_name`, `birthdate`, `review` FROM `clients`
WHERE `card` IS NULL AND YEAR(`birthdate`) BETWEEN 1978 AND 1993
ORDER BY `last_name` DESC, `id`
LIMIT 5;

SELECT CONCAT(`last_name`, `first_name`, CHAR_LENGTH(`first_name`), 'Restaurant') AS 'username', REVERSE(SUBSTRING(`email`, 2, 12)) AS 'password' FROM `waiters`
WHERE `salary` IS NOT NULL
ORDER BY `password` DESC;

SELECT p.`id`, p.`name`, COUNT(op.`product_id`) AS `count` FROM `products` AS p
LEFT JOIN `orders_products` AS op ON p.`id` = op.`product_id`
GROUP BY p.`id`
HAVING `count` >= 5
ORDER BY `count` DESC, p.`name`;

SELECT o.`table_id`, t.`capacity`, COUNT(c.`id`) AS count_clients, (CASE
            WHEN COUNT(c.`id`) < t.`capacity` THEN 'Free seats'
            WHEN COUNT(c.`id`) = t.`capacity` THEN 'Full'
            WHEN COUNT(c.`id`) > t.`capacity` THEN 'Extra seats'
        END) AS 'availability' FROM `tables` AS t
JOIN `orders` AS o ON t.`id` = o.`table_id`
JOIN `orders_clients` AS oc ON o.`id` = oc.`order_id`
JOIN `clients` AS c ON oc.`client_id` = c.`id`
WHERE t.`floor` = 1
GROUP BY o.`table_id`
ORDER BY o.`table_id` DESC;

DELIMITER $$
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50))
RETURNS DECIMAL(19, 2)
DETERMINISTIC
BEGIN
    DECLARE sum_price DECIMAL(19, 2);
    SET sum_price := (
    SELECT SUM(p.price)
        FROM products AS p
            JOIN orders_products AS op ON p.id = op.product_id
            JOIN orders AS o ON o.id = op.order_id
            JOIN orders_clients AS oc ON o.id = oc.order_id
            JOIN clients AS c ON c.id = oc.client_id
            WHERE CONCAT(c.first_name, ' ', c.last_name) = full_name
    );
	RETURN sum_price;
END$$ 

SELECT c.first_name,c.last_name, udf_client_bill('Silvio Blyth') as 'bill' FROM clients c
WHERE c.first_name = 'Silvio' AND c.last_name= 'Blyth';

DELIMITER $$
CREATE PROCEDURE udp_happy_hour(`type` VARCHAR(50))
BEGIN
    UPDATE products AS p
    SET p.price = p.price - (p.price * 0.2)
    WHERE p.type = `type` AND p.price >= 10;
END$$





