CREATE DATABASE `minions`;
USE `minions`;

CREATE TABLE `minions` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL,
    `age` INT
);

CREATE TABLE `towns` (
    `town_id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(255) NOT NULL
);

ALTER TABLE `towns`
RENAME COLUMN `id` TO `town_id`;

ALTER TABLE `towns`
CHANGE COLUMN `town_id` `id` INT AUTO_INCREMENT;

ALTER TABLE `minions`
ADD COLUMN `town_id` INT NOT NULL,
ADD CONSTRAINT `fk_minions_towns`
FOREIGN KEY (`town_id`)
REFERENCES `towns` (`id`);

INSERT INTO `towns`(`name`, `id`)
VALUES
("Sofia", 1),
("Plovdiv", 2),
("Varna", 3);

INSERT INTO `minions`(`id`, `name`, `age`, `town_id`)
VALUES
(1, "Kevin", 22, 1),
(2, "Bob", 15, 3),
(3, "Steward",NULL, 2);

TRUNCATE TABLE `minions`;

DROP TABLE `minions`;
DROP TABLE `towns`;

CREATE TABLE `people` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(200) NOT NULL,
    `picture` BLOB,
    `height` DOUBLE(3 , 2 ),
    `weight` DOUBLE(5 , 2 ),
    `gender` ENUM('m', 'f') NOT NULL,
    `birthdate` DATE NOT NULL,
    `biography` TEXT
);

INSERT INTO `people`(`id`, `name`, `height`, `weight`, `gender`, `birthdate`, `biography`)
VALUES
(1, "Kevin", 1.55, 100.55, 'm', '2022-08-31', 'dsvdvdfvfvdxbvdfbvxzv'),
(2, "Kevin", 1.55, 100.55, 'm', '2022-08-31', 'dsvdvdfvfvdxbvdfbvxzv'),
(3, "Kevin", 1.55, 100.55, 'm', '2022-08-31', 'dsvdvdfvfvdxbvdfbvxzv'),
(4, "Kevin", 1.55, 100.55, 'm', '2022-08-31', 'dsvdvdfvfvdxbvdfbvxzv'),
(5, "Kevin", 1.55, 100.55, 'm', '2022-08-31', 'dsvdvdfvfvdxbvdfbvxzv');

CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(30) NOT NULL,
    `password` VARCHAR(26) NOT NULL,
    `profile_picture` BLOB,
    `last_login_time` DATETIME,
    `is_deleted` BOOLEAN
);

INSERT INTO `users`(`id`, `username`, `password`)
VALUES
(1, "Kevin", 'dsvdvdfvfvdxbvdfbvxzv'),
(2, "Kevin", 'dsvdvdfvfvdxbvdfbvxzv'),
(3, "Kevin", 'dsvdvdfvfvdxbvdfbvxzv'),
(4, "Kevin", 'dsvdvdfvfvdxbvdfbvxzv'),
(5, "Kevin", 'dsvdvdfvfvdxbvdfbvxzv');

ALTER TABLE `users`
MODIFY COLUMN `id` INT NOT NULL,
DROP PRIMARY KEY,
ADD CONSTRAINT `pk_users`
PRIMARY KEY (`id`, `username`);

ALTER TABLE `users`
MODIFY COLUMN `last_login_time` DATETIME DEFAULT NOW();

ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT `pk_users`
PRIMARY KEY (`id`);
ALTER TABLE `users`
ADD CONSTRAINT `uq_username` UNIQUE (`username`);

CREATE DATABASE `movies`;
USE `movies`;

CREATE TABLE `directors` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `director_name` VARCHAR(200) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `genres` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `genre_name` VARCHAR(200) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `categories` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `category_name` VARCHAR(200) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `movies` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `title` VARCHAR(200) NOT NULL,
    `director_id` INT,
    `copyright_year` DATE,
    `length` TIME,
    `genre_id` INT,
    `category_id` INT,
    `rating` DOUBLE(4 , 2 ),
    `notes` TEXT
);

ALTER TABLE `movies`
ADD CONSTRAINT `fk_movies_directors`
FOREIGN KEY (`director_id`)
REFERENCES `directors`(`id`);

ALTER TABLE `movies`
ADD CONSTRAINT `fk_movies_genres`
FOREIGN KEY (`genre_id`)
REFERENCES `genres`(`id`);

ALTER TABLE `movies`
ADD CONSTRAINT `fk_movies_categories`
FOREIGN KEY (`category_id`)
REFERENCES `categories`(`id`);

INSERT INTO `directors`(`id`, `director_name`) 
VALUES(1, "Kevin Kevin"),
(2, "Robert Robert"),
(3, "Julia Julia"),
(4, "Graig Graig"),
(5, "Mark Mark");

INSERT INTO `genres`(`id`, `genre_name`) 
VALUES(1, "Horror"),
(2, "Fantastic"),
(3, "Comedy"),
(4, "Romantic"),
(5, "Anime");

INSERT INTO `categories`(`id`, `category_name`) 
VALUES(1, "Horror1"),
(2, "Fantastic2"),
(3, "Comedy3"),
(4, "Romantic4"),
(5, "Anime5");

INSERT INTO `movies`(`id`, `title`, `director_id`, `copyright_year`, `length`, `genre_id`, `category_id`, `rating`) 
VALUES(1, "Horror1234", 1, '2022-01-22', '02:45', 1, 1, 5.21),
(2, "Fantastic2345", 2, '2022-01-22', '02:45', 1, 1, 5.21),
(3, "Comedy3456", 3, '2022-01-22', '02:45', 1, 1, 5.21),
(4, "Romantic4567", 4, '2022-01-22', '02:45', 1, 1, 5.21),
(5, "Anime5678", 5, '2022-01-22', '02:45', 1, 1, 5.21 );

CREATE DATABASE `car_rental`;
USE `car_rental`;

CREATE TABLE `categories` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `category` VARCHAR(200) NOT NULL,
    `daily_rate` DOUBLE(10, 2),
    `weekly_rate` DOUBLE(10, 2),
    `monthly_rate` DOUBLE(10, 2),
    `weekend_rate` DOUBLE(10, 2)
);

CREATE TABLE `cars` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `plate_number` VARCHAR(200) NOT NULL UNIQUE,
    `make` VARCHAR(200) NOT NULL,
    `model` VARCHAR(200) NOT NULL,
    `car_year` YEAR NOT NULL,
    `category_id` INT NOT NULL,
    `doors` INT NOT NULL,
    `picture` BLOB,
    `car_condition` TEXT,
    `available` BOOLEAN NOT NULL
);

CREATE TABLE `employees` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(200) NOT NULL,
    `last_name` VARCHAR(200) NOT NULL,
    `title` VARCHAR(200) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `customers` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `driver_licence_number` VARCHAR(200) NOT NULL UNIQUE,
    `full_name` VARCHAR(200) NOT NULL,
    `address` VARCHAR(200) NOT NULL,
    `city` VARCHAR(200) NOT NULL,
    `zip_code` VARCHAR(200) NOT NULL,
    `notes` TEXT
);

CREATE TABLE `rental_orders` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `employee_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `car_id` INT NOT NULL,
    `car_condition` TEXT NOT NULL,
    `tank_level` VARCHAR(200) NOT NULL,
    `kilometrage_start` INT NOT NULL,
    `kilometrage_end` INT NOT NULL,
    `total_kilometrage` INT NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `total_days` INT NOT NULL,
    `rate_applied` DOUBLE(5, 2) NOT NULL,
    `tax_rate` DOUBLE(5, 2) NOT NULL,
    `order_status` VARCHAR(200) NOT NULL,
    `notes` TEXT
);

ALTER TABLE `cars`
ADD CONSTRAINT `fk_cars_categories`
FOREIGN KEY (`category_id`)
REFERENCES `categories`(`id`);

ALTER TABLE `rental_orders`
ADD CONSTRAINT `fk_rental_orders`
FOREIGN KEY (`employee_id`)
REFERENCES `employees`(`id`);

ALTER TABLE `rental_orders`
ADD CONSTRAINT `fk_rental_orders_customers`
FOREIGN KEY (`customer_id`)
REFERENCES `customers`(`id`);

ALTER TABLE `rental_orders`
ADD CONSTRAINT `fk_rental_orders_cars`
FOREIGN KEY (`car_id`)
REFERENCES `cars`(`id`);


INSERT INTO `categories`(`id`, `category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`) 
VALUES
(1, "Horror1234", 1.1, 2.2, 3.3, 4.4),
(2, "Horror12345", 2.1, 3.2, 4.3, 5.4),
(3, "Horror123456", 3.1, 4.2, 5.3, 6.4);

INSERT INTO `cars`(`id`, `plate_number`, `make`, `model`, `car_year`, `category_id`, `doors`) 
VALUES
(1, 'YFWFSJISJSIDVJMD', "Audi", 'A8', '2022', 1, 5),
(2, 'DEFBFGNFHFD', "Audi", 'A8', '2021', 2, 3),
(3, 'SWHDGDFHHHYHTFR', "Audi", 'A8', '2020', 3, 7);

INSERT INTO `employees`(`id`, `first_name`, `last_name`, `title`) 
VALUES
(1, 'Mark', "Frederick", 'Manager'),
(2, 'Rich', "Jepson", 'IT'),
(3, 'Simon', "Zhekov", 'Cloud Engineer');

INSERT INTO `customers`(`id`, `driver_licence_number`, `full_name`, `address`, `city`, `zip_code`) 
VALUES
(1, '1GERG15484547654464', "Paul Fredie", 'USA', 'RI', '7RI-70185'),
(2, '1GERG15484YGTE566647654464', "Neil Johnston", 'UK', 'London', '7L-704785185'),
(3, '1GERG1548YNCXE457855454547654464', "Alex Waters", 'UK', 'London', '7RI-701855');

INSERT INTO `rental_orders`(`id`, `employee_id`, `customer_id`, `car_id`, `car_condition`, `tank_level`, `kilometrage_start`,
    `kilometrage_end`, `total_kilometrage`, `start_date`, `end_date`, `total_days`, `rate_applied`, `tax_rate`, `order_status`) 
VALUES
(1, 1, 1, 1, 'New', 'Full', 100500, 100900, 400, '2022-01-01', '2022-02-02', 32, 1.1, 2.2, 'Processed'),
(2, 1, 1, 1, 'New', 'Full', 100500, 101000, 500, '2022-02-02', '2022-03-03', 32, 1.1, 2.2, 'Accepted'),
(3, 1, 1, 1, 'New', 'Full', 100500, 101100, 600, '2022-03-03', '2022-04-04', 32, 1.1, 2.2, 'Refused');

CREATE DATABASE `soft_uni`;
USE `soft_uni`;

CREATE TABLE `towns`(
`id` INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(200) NOT NULL
);

CREATE TABLE `addresses`(
`id` INT AUTO_INCREMENT PRIMARY KEY,
`address_text` VARCHAR(200) NOT NULL,
`town_id` INT
);

ALTER TABLE `addresses`
ADD CONSTRAINT `fk_addresses_towns`
FOREIGN KEY (`town_id`)
REFERENCES `towns`(`id`);

CREATE TABLE `departments`(
`id` INT AUTO_INCREMENT PRIMARY KEY,
`name` VARCHAR(200) NOT NULL
);


CREATE TABLE `employees`(
`id` INT AUTO_INCREMENT PRIMARY KEY,
`first_name` VARCHAR(200) NOT NULL,
`middle_name` VARCHAR(200) NOT NULL,
`last_name` VARCHAR(200) NOT NULL,
`job_title` VARCHAR(200) NOT NULL,
`department_id` INT NOT NULL,
`hire_date` DATE,
`salary` DOUBLE,
`address_id` INT NOT NULL
);

ALTER TABLE `employees`
ADD CONSTRAINT `fk_employees_departments`
FOREIGN KEY (`department_id`)
REFERENCES `departments`(`id`);

ALTER TABLE `employees`
ADD CONSTRAINT `fk_employees_addresses`
FOREIGN KEY (`address_id`)
REFERENCES `addresses`(`id`);

INSERT INTO `towns`(`id`, `name`) 
VALUES
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna'),
(4, 'Burgas');

INSERT INTO `departments`(`id`, `name`) 
VALUES
(1, 'Engineering'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Software Development'),
(5, 'Quality Assurance');

INSERT INTO `employees`(`id`, `first_name`, `middle_name`, `last_name`, `job_title`, `department_id`, `hire_date`, `salary`) 
VALUES
(1, 'Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
(2, 'Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
(3, 'Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
(4, 'Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
(5, 'Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

SELECT `name` FROM `towns`
ORDER BY `name`;
SELECT `name` FROM `departments`
ORDER BY `name`;
SELECT `first_name`, `last_name`, `job_title`, `salary` FROM `employees`
ORDER BY `salary` DESC;

UPDATE `employees`
SET `salary` = `salary` * 1.1;
SELECT `salary` FROM `employees`
ORDER BY `id`;
/*----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

USE `soft_uni`;
SELECT * FROM `departments`
ORDER BY `department_id`;

SELECT `name` FROM `departments`
ORDER BY `department_id`;

SELECT `first_name`, `last_name`, `salary` FROM `employees`
ORDER BY `employee_id`;

SELECT `first_name`, `middle_name`, `last_name`  FROM `employees`
ORDER BY `employee_id`;

SELECT CONCAT(`first_name`, '.', `last_name`, '@softuni.bg') AS `full_email_address`  FROM `employees`;

SELECT DISTINCT `salary` AS `Salary`  FROM `employees`;

SELECT * FROM `employees`;

SELECT `employee_id` AS `id`,
`first_name` AS `First Name`, 
`last_name` AS `Last Name`,
`middle_name` AS `Middle Name`,
`job_title` AS `Job Title`,
`department_id` AS `Dept ID`,
`manager_id` AS `Mngr ID`,
`hire_date` AS `Hire Date`,
`salary` AS `salary`,
`address_id` AS `address_id`
   FROM `employees`
   WHERE `job_title` = 'Sales Representative'
ORDER BY `employee_id`;

SELECT `first_name`, `last_name`,`job_title` FROM `employees`
WHERE `salary` BETWEEN 20000 AND 30000
ORDER BY `employee_id`;

SELECT CONCAT(`first_name`, ' ', `middle_name`, ' ', `last_name`) AS `Full Name` FROM `employees`
WHERE `salary` IN(25000, 14000, 12500, 23600);

SELECT `first_name`, `last_name` FROM `employees`
WHERE `manager_id` IS NULL;

SELECT `first_name`, `last_name`,`salary` FROM `employees`
WHERE `salary` > 50000
ORDER BY `salary` DESC;

SELECT `first_name`, `last_name` FROM `employees`
ORDER BY `salary` DESC
LIMIT 5;

SELECT `first_name`, `last_name` FROM `employees`
WHERE `department_id` != 4;

SELECT `employee_id` AS `id`,
`first_name` AS `First Name`, 
`last_name` AS `Last Name`,
`middle_name` AS `Middle Name`,
`job_title`,
`department_id` AS `Dept ID`,
`manager_id` AS `Mngr ID`,
`hire_date` AS `Hire Date`,
`salary` AS `salary`,
`address_id` AS `address_id`
   FROM `employees`
ORDER BY `salary` DESC, `first_name`, `last_name` DESC, `middle_name`, `employee_id`;

CREATE VIEW `v_employees_salaries` AS
SELECT `first_name`, `last_name`,`salary` FROM `employees`;

CREATE VIEW `v_employees_job_titles` AS
SELECT CONCAT_WS(' ', `first_name`, `middle_name`, `last_name`) AS `full_name`, `job_title` FROM `employees`;

SELECT * FROM `v_employees_job_titles` ;

SELECT DISTINCT `job_title` FROM `employees`
ORDER BY `job_title`;

SELECT `project_id` AS `id`, `name`, `description`, `start_date`, `end_date` FROM `projects`
ORDER BY `start_date`, `name`, `id`
LIMIT 10;

SELECT `first_name`, `last_name`, `hire_date` FROM `employees`
ORDER BY `hire_date` DESC
LIMIT 7;

SELECT * FROM `countries`;

UPDATE employees
SET `salary` = `salary` * 1.12
WHERE `department_id` IN(1, 2, 4, 11);
SELECT `salary` AS `Salary` FROM `employees`;

USE `geography`;
SELECT `peak_name` FROM `peaks`
ORDER BY `peak_name`;

SELECT `country_name`, `population` FROM `countries`
WHERE `continent_code` = 'EU'
ORDER BY `population` DESC, `country_name`
LIMIT 30;

SELECT `country_name`, `country_code`, 
IF(`currency_code` = 'EUR', 'Euro', 'Not Euro') AS `currency` FROM `countries`
ORDER BY `country_name`;

USE `diablo`;
SELECT `name` FROM `characters`
ORDER BY `name`;

USE `soft_uni`;

SELECT `first_name`, `last_name` FROM `employees`
WHERE `first_name` LIKE 'Sa%'
ORDER BY `employee_id`;

SELECT `first_name`, `last_name` FROM `employees`
WHERE `last_name` LIKE '%ei%'
ORDER BY `employee_id`;

SELECT `first_name` FROM `employees`
WHERE `department_id` IN(3, 10) AND YEAR(`hire_date`) >= 1995 AND YEAR(`hire_date`) <=2005
ORDER BY `employee_id`;

SELECT * FROM `employees`;

SELECT `first_name`, `last_name` FROM `employees`
WHERE `job_title` NOT LIKE '%ENGINEER%'
ORDER BY `employee_id`;

SELECT `name` FROM `towns`
WHERE char_length(`name`) IN(5, 6)
ORDER BY `name`;

SELECT `town_id`, `name` FROM `towns`
WHERE `name` LIKE 'M%' OR `name` LIKE 'K%' OR `name` LIKE 'B%' OR `name` LIKE 'E%'
ORDER BY `name`;

SELECT `town_id`, `name` FROM `towns`
WHERE `name` NOT LIKE 'R%' AND `name` NOT LIKE 'B%' AND `name` NOT LIKE 'D%'
ORDER BY `name`;

CREATE VIEW `v_employees_hired_after_2000` AS
SELECT `first_name`, `last_name` FROM `employees`
WHERE YEAR(`hire_date`) > 2000 ;
SELECT * FROM `v_employees_hired_after_2000`;

SELECT `first_name`, `last_name` FROM `employees`
WHERE char_length(`last_name`) = 5;

USE `geography`;
SELECT `country_name`, `iso_code` FROM `countries`
WHERE `country_name` LIKE '%a%a%a%'
ORDER BY `iso_code`;

SELECT `peak_name`, `river_name`, CONCAT(LOWER(`peak_name`), SUBSTRING(LOWER(`river_name`),2)) AS mix
FROM peaks, rivers
WHERE RIGHT(`peak_name`, 1) = LEFT(LOWER(`river_name`), 1)
ORDER BY mix;

USE `diablo`;

SELECT `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS `start` FROM `games`
WHERE YEAR(`start`) BETWEEN 2011 AND 2012
ORDER BY `start`, `name`
LIMIT 50;

SELECT `user_name`, SUBSTRING(`email`, locate('@', email) + 1) AS `email provider` from `users`
ORDER BY `email provider`, `user_name`;

SELECT `user_name`, `ip_address` FROM `users`
WHERE `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`;

SELECT `name` as 'game',
CASE
WHEN hour(`start`) < 12 THEN 'Morning'
WHEN hour(`start`) < 18 THEN 'Afternoon'
ELSE 'Evening'
END 
AS 'Part of the Day',
CASE
WHEN `duration` <= 3 THEN 'Extra Short'
WHEN `duration` <= 6 THEN 'Short'
WHEN `duration` <= 10 THEN 'Long'
ELSE 'Extra Long'
END 
AS 'Duration'
FROM `games`;

SELECT `product_name`, `order_date`,
adddate(`order_date`, interval 3 day) as pay_due, 
adddate(`order_date`, interval 1 month) as deliver_due
FROM `orders`;

SELECT COUNT(*) FROM `wizzard_deposits`;

SELECT MAX(`magic_wand_size`) AS `longest_magic_wand` FROM `wizzard_deposits`;

SELECT `deposit_group`, MAX(`magic_wand_size`) AS `longest_magic_wand` FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `longest_magic_wand`, `deposit_group`;

SELECT `deposit_group` FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY AVG(`magic_wand_size`)
LIMIT 1;

SELECT `deposit_group`, SUM(`deposit_amount`) AS `total_sum` FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `total_sum`;

SELECT `deposit_group`, SUM(`deposit_amount`) AS `total_sum` FROM `wizzard_deposits`
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
ORDER BY `deposit_group`;

SELECT `deposit_group`, SUM(`deposit_amount`) AS `total_sum` FROM `wizzard_deposits`
WHERE `magic_wand_creator` = 'Ollivander family' 
GROUP BY `deposit_group`
HAVING `total_sum` < 150000
ORDER BY `total_sum` DESC;

SELECT `deposit_group`, `magic_wand_creator`, MIN(`deposit_charge`) AS `min_deposit_charge` FROM `wizzard_deposits`
GROUP BY `deposit_group`, `magic_wand_creator`
ORDER BY `magic_wand_creator`, `deposit_group`;

SELECT (CASE
        WHEN `age` BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN `age` BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN `age` BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN `age` BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN `age` BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN `age` BETWEEN 51 AND 60 THEN '[51-60]'
        WHEN `age` >= 61 THEN '[61+]'
    END) AS `age_group`, COUNT(age) AS `wizard_count` FROM `wizzard_deposits`
    GROUP BY `age_group`
    ORDER BY `age_group`;

SELECT SUBSTRING(`first_name` FROM 1 FOR 1) AS `first_letter` FROM `wizzard_deposits`
WHERE `deposit_group` = 'Troll Chest'
GROUP BY `first_letter`
ORDER BY `first_letter`;

SELECT `deposit_group`, `is_deposit_expired`, AVG(`deposit_interest`) AS `average_interest` FROM `wizzard_deposits`
WHERE `deposit_start_date` > '1985-01-01'
GROUP BY `deposit_group`, `is_deposit_expired`
ORDER BY `deposit_group` DESC, `is_deposit_expired`;

USE `soft_uni`;

SELECT `department_id`, MIN(`salary`) AS `minimum_salary` FROM `employees`
WHERE `hire_date` > '2000-01-01'
GROUP BY `department_id`
HAVING `department_id` IN (2, 5, 7)
ORDER BY `department_id`;

CREATE TABLE `salary_more_than` AS
SELECT *
FROM `employees`
WHERE `salary` > 30000;
 
DELETE 
FROM `salary_more_than`
WHERE `manager_id` = 42;
 
UPDATE `salary_more_than`
SET `salary` = `salary` + 5000
WHERE `department_id` = 1;
 
SELECT `department_id`, avg(`salary`) AS `avg_salary`
FROM `salary_more_than`
GROUP BY `department_id`
ORDER BY `department_id`;
 
SELECT `department_id`, MAX(`salary`) AS `max_salary` FROM `employees`
GROUP BY `department_id`
HAVING `max_salary` NOT BETWEEN 30000 AND 70000
ORDER BY `department_id`;

SELECT COUNT(`employee_id`) AS 'count'
FROM `employees`
WHERE `manager_id` IS NULL;

SELECT DISTINCT `department_id`,
        (
        SELECT  DISTINCT `salary`
        FROM    `employees` e
        WHERE   e.`department_id` = `employees`.`department_id`
        ORDER BY `salary` DESC
        LIMIT 1 OFFSET 2
        ) AS `third_highest_salary`
FROM    `employees`
HAVING `third_highest_salary` IS NOT NULL
ORDER BY `department_id`;

SELECT `first_name`, `last_name`, `department_id`
FROM `employees` f
WHERE `salary` > (
    SELECT avg(`salary`)
    FROM `employees` e
    WHERE e.department_id = f.department_id
    )
ORDER BY `department_id`, `employee_id`
LIMIT 10;
 
SELECT `department_id`, SUM(`salary`) AS `total_salary`
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;

CREATE SCHEMA `relationships`;
USE `relationships`;

CREATE TABLE `passports`(
`passport_id` INT PRIMARY KEY AUTO_INCREMENT,
`passport_number` VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE `people`(
`person_id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(100) NOT NULL,
`salary` DECIMAL(9, 2),
`passport_id` INT UNIQUE,
CONSTRAINT `fk_people_passports`
FOREIGN KEY (`passport_id`)
REFERENCES `passports`(`passport_id`)
);

INSERT INTO `passports`(`passport_id`, `passport_number`)
VALUES
	(101, 'N34FG21B'), 
    (102, 'K65LO4R7'), 
    (103, 'ZE657QP2');

INSERT INTO `people` (`person_id`, `first_name`, `salary`, `passport_id`) 
VALUES 
    (1, 'Roberto', 43300.00, 102), 
    (2, 'Tom', 56100.00, 103), 
    (3, 'Yana', 60200.00, 101);

CREATE TABLE `manufacturers` (
   `manufacturer_id` INT PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(45) NOT NULL UNIQUE,
   `established_on` DATE
);
  
INSERT INTO `manufacturers` (`manufacturer_id`, `name`, `established_on`) 
VALUES 
    (1, 'BMW', '1916/03/01'), 
    (2, 'Tesla', '2003/01/01'), 
    (3, 'Lada', '1966/05/01');
 
CREATE TABLE `models` (
   `model_id` INT PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(45) NOT NULL,
   `manufacturer_id` INT,
CONSTRAINT fk_model_manufacturers
FOREIGN KEY (`manufacturer_id`)
REFERENCES `manufacturers`(`manufacturer_id`));
  
INSERT INTO `models` (`model_id`, `name`, `manufacturer_id`) 
VALUES 
    (101, 'X1', 1),
    (102, 'i6', 1),
    (103, 'Model S', 2),
    (104, 'Model X', 2),
    (105, 'Model 3', 2),
    (106, 'Nova', 3);

CREATE TABLE `students` (
   `student_id` INT PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(45) NOT NULL);
  
INSERT INTO `students` (`student_id`, `name`) 
VALUES 
    (1, 'Mila'), 
    (2, 'Toni'), 
    (3, 'Ron');
 
CREATE TABLE `exams` (
   `exam_id` INT PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(45) NOT NULL);
  
INSERT INTO `exams` (`exam_id`, `name`) 
VALUES 
    (101, 'Spring MVC'), 
    (102, 'Neo4j'), 
    (103, 'Oracle 11g');
 
CREATE TABLE `students_exams` (
   `student_id` INT NOT NULL,
   `exam_id` INT NOT NULL,
   CONSTRAINT pk
   PRIMARY KEY (`student_id`, `exam_id`),
   CONSTRAINT fk_this_student
   FOREIGN KEY (`student_id`)
   REFERENCES `students` (`student_id`), 
   CONSTRAINT fk_this_exams
   FOREIGN KEY (`exam_id`)
   REFERENCES `exams` (`exam_id`)
);
   
INSERT INTO `students_exams` (`student_id`, `exam_id`) 
VALUES 
    (1, 101),
    (1, 102),
    (2, 101),
    (3, 103),
    (2, 102),
    (2, 103);


 CREATE TABLE `teachers` (
   `teacher_id` INT PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(20) NOT NULL,
   `manager_id` INT);
                           
INSERT INTO `teachers` (`teacher_id`, `name`, `manager_id`) 
VALUES 
    (101, 'John', NULL),        
    (102, 'Maya', 106),
    (103, 'Silvia', 106),
    (104, 'Ted', 105),
    (105, 'Mark', 101),
    (106, 'Greta', 101);
                              
ALTER TABLE `teachers`
ADD CONSTRAINT fk
FOREIGN KEY (`manager_id`)
REFERENCES `teachers` (`teacher_id`); 
    
 
CREATE SCHEMA `online_store`;
    
CREATE TABLE `cities` (
    `city_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);
 
CREATE TABLE `item_types` (
    `item_type_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);
 
CREATE TABLE customers (
    `customer_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `birthday` DATE,
    `city_id` INT NULL,
    CONSTRAINT fk_customer_city
    FOREIGN KEY (`city_id`)
    REFERENCES `cities` (`city_id`)
);
 
CREATE TABLE `orders` (
    `order_id` INT PRIMARY KEY AUTO_INCREMENT,
    `customer_id` INT NOT NULL,
    CONSTRAINT fk_order_customer
    FOREIGN KEY (`customer_id`)
    REFERENCES `customers` (`customer_id`)
);
 
CREATE TABLE `items` (
    `item_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `item_type_id` INT NOT NULL,
    CONSTRAINT fk_items_type
    FOREIGN KEY (`item_type_id`)
    REFERENCES `item_types` (`item_type_id`)
);
 
CREATE TABLE `order_items` (
    `order_id` INT NOT NULL,
    `item_id` INT NOT NULL,
    CONSTRAINT pk
    PRIMARY KEY(`order_id`, `item_id`),
    CONSTRAINT fk_order
    FOREIGN KEY (`order_id`)
    REFERENCES `orders` (`order_id`), 
    CONSTRAINT fk_item
    FOREIGN KEY (`item_id`)
    REFERENCES `items` (`item_id`)
);    
    
CREATE SCHEMA `university`;

CREATE TABLE `subjects` (
    `subject_id` INT PRIMARY KEY AUTO_INCREMENT,
    `subject_name` VARCHAR(50) NOT NULL
);
 
CREATE TABLE `majors` (
    `major_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);
 
CREATE TABLE `students` (
    `student_id` INT PRIMARY KEY AUTO_INCREMENT,
    `student_number` VARCHAR(12) UNIQUE NOT NULL,
    `student_name` VARCHAR(50) NOT NULL,
    `major_id` INT NULL,
    CONSTRAINT fk_student_major
    FOREIGN KEY (`major_id`)
    REFERENCES `majors`(`major_id`)
);
 
CREATE TABLE `payments` (
    `payment_id` INT PRIMARY KEY AUTO_INCREMENT,
    `payment_date` DATE NOT NULL,
    `payment_amount` DECIMAL(8, 2),
    `student_id` INT NULL,
    CONSTRAINT fk_payment_student
    FOREIGN KEY (`student_id`)
    REFERENCES `students` (`student_id`)
);
 
CREATE TABLE `agenda` (
    `student_id` INT NOT NULL,
    `subject_id` INT NOT NULL,
    CONSTRAINT pk
    PRIMARY KEY(`student_id`, `subject_id`),
    CONSTRAINT fk_student
    FOREIGN KEY (`student_id`)
    REFERENCES `students` (`student_id`), 
    CONSTRAINT fk_item
    FOREIGN KEY (`subject_id`)
    REFERENCES `subjects` (`subject_id`)
);

SELECT m.`mountain_range`, p.`peak_name`, p.`elevation`
FROM `mountains` AS m
JOIN `peaks` AS p
ON p.`mountain_id` = m.`id`
WHERE m.`mountain_range` = "Rila"
ORDER BY p.`elevation` DESC;

SELECT e.`employee_id`, e.`job_title`, e.`address_id`, a.`address_text` FROM `employees` AS e
JOIN `addresses` AS a ON e.`address_id` = a.`address_id`
ORDER BY `address_id`
LIMIT 5;

SELECT e.`first_name`, e.`last_name`, t.`name` AS 'town', a.`address_text` FROM `employees` AS e
JOIN `addresses` AS a ON e.`address_id` = a.`address_id`
JOIN `towns` AS t ON a.`town_id` = t.`town_id`
ORDER BY `first_name`, `last_name`
LIMIT 5;

SELECT e.`employee_id`, e.`first_name`, e.`last_name`, d.`name` AS 'department_name' FROM `employees` AS e
JOIN `departments` AS d ON e.`department_id` = d.`department_id`
WHERE d.`name` = 'Sales'
ORDER BY `employee_id` DESC;

SELECT e.`employee_id`, e.`first_name`, e.`salary`, d.`name` AS 'department_name' FROM `employees` AS e
JOIN `departments` AS d ON e.`department_id` = d.`department_id`
WHERE e.`salary` > 15000
ORDER BY d.`department_id` DESC
LIMIT 5;

SELECT e.`employee_id`, e.`first_name` FROM `employees` AS e
LEFT JOIN `employees_projects` AS ep ON e.`employee_id` = ep.`employee_id`
WHERE ep.`project_id` IS NULL
ORDER BY e.`employee_id` DESC
LIMIT 3;

SELECT e.`first_name`, e.`last_name`, e.`hire_date`, d.`name` AS 'dept_name' FROM `employees` AS e
LEFT JOIN `departments` AS d ON e.`department_id` = d.`department_id`
WHERE e.`hire_date` > '1999-01-01' and d.`name` IN('Sales', 'Finance') 
ORDER BY e.`hire_date`;

SELECT e.`employee_id`, e.`first_name`, p.`name` AS 'project_name' FROM `employees` AS e
JOIN `employees_projects` AS ep ON e.`employee_id` = ep.`employee_id`
JOIN `projects` AS p ON ep.`project_id` = p.`project_id`
WHERE DATE(p.`start_date`) > '2002-08-13' AND p.`end_date` IS NULL
ORDER BY e.`first_name`, p.`name`
LIMIT 5;

SELECT e.`employee_id`, e.`first_name`, IF(YEAR(p.`start_date`) >= 2005, NULL, p.`name`) AS 'project_name' FROM `employees` AS e
JOIN `employees_projects` AS ep ON e.`employee_id` = ep.`employee_id`
JOIN `projects` AS p ON ep.`project_id` = p.`project_id`
WHERE e.`employee_id` = 24
ORDER BY p.`name`;

SELECT e.`employee_id`, e.`first_name`, e.`manager_id`, m.`first_name` AS 'manager_name' FROM `employees` AS e
JOIN `employees` AS m ON e.`manager_id` = m.`employee_id`
WHERE e.`manager_id` IN (3, 7)
ORDER BY e.`first_name`;

SELECT e.`employee_id`, CONCAT_WS(' ', e.`first_name`, e.`last_name`) AS 'employee_name', 
CONCAT_WS(' ', m.`first_name`, m.`last_name`) AS 'manager_name', 
d.`name` AS 'department_name' FROM `employees` AS e
JOIN `employees` AS m ON e.`manager_id` = m.`employee_id`
JOIN `departments` AS d ON e.`department_id` = d.`department_id`
WHERE e.`manager_id` IS NOT NULL
ORDER BY e.`employee_id`
LIMIT 5;

SELECT AVG(`salary`) AS 'min_average_salary' FROM `employees`
GROUP BY `department_id`
ORDER BY `min_average_salary`
LIMIT 1;

SELECT c.`country_code`, m.`mountain_range`, p.`peak_name`, p.`elevation` FROM `countries` AS c
JOIN `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
JOIN `mountains` AS m ON mc.`mountain_id` = m.`id`
JOIN `peaks` AS p ON m.`id` = p.`mountain_id`
WHERE c.`country_code` = 'BG' AND p.`elevation` > 2835
ORDER BY p.`elevation` DESC;

SELECT c.`country_code`, COUNT(m.`mountain_range`) AS `mountain_range` FROM `countries` AS c
JOIN `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
JOIN `mountains` AS m ON mc.`mountain_id` = m.`id`
WHERE c.`country_code` IN('BG', 'RU', 'US')
GROUP BY c.`country_code`
ORDER BY `mountain_range` DESC;

SELECT c.`country_name`, r.`river_name` FROM `countries` AS c
LEFT JOIN `countries_rivers` AS cr ON c.`country_code` = cr.`country_code`
LEFT JOIN `rivers` AS r ON cr.`river_id` = r.`id`
WHERE c.`continent_code` = 'AF'
ORDER BY c.`country_name`
LIMIT 5;

SELECT COUNT(c.`country_code`) AS 'country_count'
FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
LEFT JOIN `mountains` AS m ON mc.`mountain_id` = m.`id`
WHERE m.`id` IS NULL;

SELECT c.`country_name`, MAX(p.`elevation`) AS 'highest_peak_elevation',MAX(r.`length`) AS 'longest_river_length' FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc ON c.`country_code` = mc.`country_code`
LEFT JOIN `peaks` AS p ON mc.`mountain_id` = p.`mountain_id`
LEFT JOIN `countries_rivers` AS cr ON c.`country_code` = cr.`country_code`
LEFT JOIN `rivers` AS r ON cr.`river_id` = r.`id`
GROUP BY c.`country_name`
ORDER BY `highest_peak_elevation` DESC , `longest_river_length` DESC , c.`country_name`
LIMIT 5;

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
SELECT `first_name`, `last_name` FROM `employees`
WHERE `salary` > 35000
ORDER BY `first_name`, `last_name`, `employee_id`DESC;
END$$

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(`searched_salary` DECIMAL(19,4))
BEGIN
SELECT `first_name`, `last_name` FROM `employees`
WHERE `salary` >= `searched_salary`
ORDER BY `first_name`, `last_name`, `employee_id`;
END$$

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with (`searched_string` VARCHAR(50))
BEGIN
SELECT `name` AS `town_name` FROM `towns`
WHERE `name` LIKE concat(`searched_string`, '%')
ORDER BY `name`;
END$$

DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town (`searched_town` VARCHAR(50))
BEGIN
SELECT e.`first_name`, e.`last_name` FROM `employees` AS e
JOIN `addresses` AS a ON e.`address_id` = a.`address_id`
JOIN `towns` AS t ON a.`town_id` = t.`town_id`
WHERE t.`name` = `searched_town`
ORDER BY e.`first_name`, e.`last_name`, e.`employee_id` DESC;
END$$

DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(`searched_salary` DECIMAL(19, 4))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE salary_level VARCHAR(10);
    IF `searched_salary` < 30000 THEN SET salary_level := 'Low';
    ELSEIF `searched_salary` <= 50000 THEN SET salary_level := 'Average';
    ELSE SET salary_level := 'High';
    END IF;
    RETURN salary_level;
END$$ 

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(10)) 
BEGIN
    SELECT first_name, last_name
    FROM employees
    WHERE ufn_get_salary_level(`salary`) LIKE salary_level
    ORDER BY first_name DESC, last_name DESC;
END$$ 

DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN word REGEXP (CONCAT('^[', set_of_letters, ']+$'));
END$$
 
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name() 
BEGIN
  SELECT CONCAT(`first_name`, " ", `last_name`) AS `full_name`
  FROM `account_holders`
  ORDER BY `full_name`, `id`;
END$$
 
DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(`money` DECIMAL(12,4))
BEGIN
    SELECT `first_name`, `last_name`
    FROM `account_holders` as h
    LEFT JOIN `accounts` as a ON h.`id` = a.`account_holder_id`
    GROUP BY `first_name`, `last_name`
    HAVING SUM(a.`balance`) > `money`
    ORDER BY a.`account_holder_id`;
END$$
 
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19, 4), yearly_interest DOUBLE, years INT)
RETURNS DECIMAL(19, 4)
DETERMINISTIC
BEGIN
    DECLARE future_sum DECIMAL(19, 4);
    SET future_sum := sum * POW(1 + yearly_interest, years);
    RETURN future_sum;
END$$
 
DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(id INT, interest_rate DECIMAL(19,4))
BEGIN
    SELECT a.`id` AS 'account_id', ah.`first_name`, ah.`last_name`, 
    a.`balance` AS 'current_balance', ufn_calculate_future_value(a.balance, interest_rate, 5) AS 'balance_in_5_years'
    FROM `account_holders` AS ah
    JOIN `accounts` AS a ON a.`account_holder_id` = ah.`id`
    WHERE a.`id` = id;
END$$
 
DELIMITER $$
CREATE PROCEDURE usp_deposit_money(id INT, money_amount DECIMAL(19,4))
BEGIN
    START TRANSACTION;
    IF(money_amount <= 0 ) THEN
    ROLLBACK;
    ELSE
        UPDATE `accounts` AS ac SET ac.`balance` = ac.`balance` + money_amount
        WHERE ac.`id` = id;
    END IF; 
END$$
 
DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(id int, money_amount decimal(19,4))
BEGIN
    START TRANSACTION;
    IF (money_amount <= 0 OR (SELECT `balance` FROM accounts AS a WHERE a.`id` = id) < money_amount) THEN
    ROLLBACK;
    ELSE
        UPDATE accounts as ac SET ac.balance = ac.balance - money_amount
        WHERE ac.id = id;
        COMMIT;
    END IF; 
END$$
 
DELIMITER $$
CREATE PROCEDURE usp_transfer_money(fromID int, toID int,money_amount decimal(19,4))
BEGIN
    START TRANSACTION;
    IF(money_amount <= 0 OR (SELECT `balance` from `accounts` where `id` = fromID) < money_amount
    OR fromID = toID 
    OR (SELECT COUNT(id) FROM `accounts` WHERE `id` = fromID) <> 1
    OR (SELECT COUNT(id) FROM `accounts` WHERE `id` = toID) <> 1) 
    THEN ROLLBACK;
    ELSE
        UPDATE `accounts` SET `balance` = `balance` - money_amount
        WHERE `id` = fromID;
        UPDATE `accounts` SET `balance` = `balance` + money_amount
        WHERE `id` = toID;
        COMMIT;
    END IF; 
END$$
 
CREATE TABLE `logs`(
    `log_id` INT PRIMARY KEY AUTO_INCREMENT, 
    `account_id` INT NOT NULL,
    `old_sum` DECIMAL(19, 4) NOT NULL,
    `new_sum` DECIMAL(19, 4) NOT NULL
);
DELIMITER $$
CREATE TRIGGER tr_change_balance
AFTER UPDATE ON `accounts`
FOR EACH ROW
BEGIN
    INSERT INTO `logs`(`account_id`, `old_sum`, `new_sum`) 
    VALUES (OLD.id, OLD.balance, NEW.balance);
END$$
 

CREATE TABLE `notification_emails`(
    `id` INT PRIMARY KEY AUTO_INCREMENT, 
    `recipient` INT NOT NULL,
    `subject` TEXT,
    `body` TEXT
);
DELIMITER $$
CREATE TRIGGER tr_email_on_change_balance
AFTER INSERT
ON `logs`
FOR EACH ROW
BEGIN
    INSERT INTO `notification_emails`(`recipient`, `subject`, `body`)
    VALUES (NEW.`account_id`, concat_ws(' ', 'Balance change for account:', NEW.`account_id`), concat_ws(' ', 'On', NOW(), 'your balance was changed from', NEW.`old_sum`, 'to', NEW.`new_sum`, '.'));
END$$














