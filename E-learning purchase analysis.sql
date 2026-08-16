CREATE DATABASE elearning_db;

USE elearning_db;
CREATE TABLE learners (
    learner_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);


CREATE TABLE purchases (
    purchase_id INT PRIMARY KEY,
    learner_id INT NOT NULL,
    course_id INT NOT NULL,
    quantity INT NOT NULL,
    purchase_date DATE NOT NULL,

    FOREIGN KEY (learner_id)
        REFERENCES learners(learner_id),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);
INSERT INTO learners
(learner_id, full_name, country)
VALUES
(1, 'Arun Kumar', 'India'),
(2, 'Priya Sharma', 'India'),
(3, 'John Smith', 'USA'),
(4, 'Maria Garcia', 'Spain'),
(5, 'David Lee', 'Singapore');

INSERT INTO courses
(course_id, course_name, category, unit_price)
VALUES
(101, 'Excel for Beginners', 'Beginner', 3000.00),
(102, 'Python for Data Analysis', 'Data Science', 6000.00),
(103, 'Advanced SQL', 'Database', 5000.00),
(104, 'Power BI Masterclass', 'Business Intelligence', 7500.00),
(105, 'Digital Marketing Basics', 'Marketing', 4000.00);

INSERT INTO purchases
(purchase_id, learner_id, course_id, quantity, purchase_date)
VALUES
(1001, 1, 102, 2, '2026-01-10'),
(1002, 1, 104, 2, '2026-01-15'),
(1003, 2, 101, 1, '2026-01-20'),
(1004, 2, 103, 2, '2026-02-05'),
(1005, 3, 104, 2, '2026-02-10'),
(1006, 3, 102, 1, '2026-02-15'),
(1007, 4, 105, 3, '2026-03-01'),
(1008, 5, 103, 2, '2026-03-10');

select* from learners;
select* from courses;
select* from purchases;


SELECT
    p.purchase_id AS 'Purchase ID',
    l.full_name AS 'Learner Name',
    c.course_name AS 'Course Name',
    c.category AS 'Category',
    p.quantity AS 'Quantity',
    FORMAT(p.quantity * c.unit_price, 2) AS 'Total Amount',
    p.purchase_date AS 'Purchase Date'
FROM purchases p
INNER JOIN learners l
    ON p.learner_id = l.learner_id
INNER JOIN courses c
    ON p.course_id = c.course_id
ORDER BY (p.quantity * c.unit_price) DESC;
SELECT
    l.full_name AS 'Learner Name',
    c.course_name AS 'Course Name',
    c.category AS 'Category',
    p.quantity AS 'Quantity',
    FORMAT(p.quantity * c.unit_price, 2) AS 'Total Amount',
    p.purchase_date AS 'Purchase Date'
FROM learners l
LEFT JOIN purchases p
    ON l.learner_id = p.learner_id
LEFT JOIN courses c
    ON p.course_id = c.course_id
ORDER BY (p.quantity * c.unit_price) DESC;


SELECT
    l.full_name AS 'Learner Name',
    c.course_name AS 'Course Name',
    c.category AS 'Category',
    p.quantity AS 'Quantity',
    FORMAT(p.quantity * c.unit_price, 2) AS 'Total Amount',
    p.purchase_date AS 'Purchase Date'
FROM purchases p
RIGHT JOIN courses c
    ON p.course_id = c.course_id
LEFT JOIN learners l
    ON p.learner_id = l.learner_id
ORDER BY (p.quantity * c.unit_price) DESC;

## Each learner's total spending with country

SELECT
    l.learner_id AS 'Learner ID',
    l.full_name AS 'Learner Name',
    l.country AS 'Country',
    FORMAT(
        COALESCE(SUM(p.quantity * c.unit_price), 0),
        2
    ) AS 'Total Spending'
FROM learners l
LEFT JOIN purchases p
    ON l.learner_id = p.learner_id
LEFT JOIN courses c
    ON p.course_id = c.course_id
GROUP BY
    l.learner_id,
    l.full_name,
    l.country
ORDER BY
    SUM(p.quantity * c.unit_price) DEsC;
    
   ## Top 3 most purchased courses by quantity

SELECT
    c.course_id AS 'Course ID',
    c.course_name AS 'Course Name',
    SUM(p.quantity) AS 'Total Quantity Purchased'
FROM courses c
INNER JOIN purchases p
    ON c.course_id = p.course_id
GROUP BY
    c.course_id,
    c.course_name
ORDER BY
    SUM(p.quantity) DESC
LIMIT 3;

##Category-wise revenue and unique learners

SELECT
    c.category AS 'Category',
    FORMAT(
        SUM(p.quantity * c.unit_price),2)AS 'Total Revenue',
    COUNT(DISTINCT p.learner_id) AS 'Unique Learners'
FROM courses c
INNER JOIN purchases p
    ON c.course_id = p.course_id
GROUP BY
    c.category
ORDER BY
    SUM(p.quantity * c.unit_price) DESC;
    
##Learners who purchased from more than one category

SELECT
    l.learner_id AS 'Learner ID',
    l.full_name AS 'Learner Name',
   count(DISTINCT c.category) AS 'Number of Categories'
FROM learners l
INNER JOIN purchases p
    ON l.learner_id = p.learner_id
INNER JOIN courses c
    ON p.course_id = c.course_id
GROUP BY
    l.learner_id,
    l.full_name
HAVING count(DISTINCT c.category) > 1;

###Identify courses never purchased

SELECT
    c.course_id AS 'Course ID',
    c.course_name AS 'Course Name',
    c.category AS 'Category',
    format(c.unit_price, 2) AS 'Unit Price'
FROM courses c
LEFT JOIN purchases p
    ON c.course_id = p.course_id
WHERE p.purchase_id IS NULL;

##Learners whose spending is above average learner spending
SELECT
    l.learner_id AS 'Learner ID',
    l.full_name AS 'Learner Name',
    FORMAT(SUM(p.quantity * c.unit_price), 2) AS 'Total Spending'
FROM learners l
INNER JOIN purchases p
    ON l.learner_id = p.learner_id
INNER JOIN courses c
    ON p.course_id = c.course_id
GROUP BY
    l.learner_id,
    l.full_name
HAVING SUM(p.quantity * c.unit_price) >
(
    SELECT AVG(learner_spending)
    FROM
    (
        SELECT
            p2.learner_id,
            SUM(p2.quantity * c2.unit_price)  learner_spending
        FROM purchases p2
        INNER JOIN courses c2
            ON p2.course_id = c2.course_id
        GROUP BY p2.learner_id
    ) AS spending_table
);

##Courses whose price is higher than any course in Beginner category
SELECT
    course_id AS 'Course ID',
    course_name AS 'Course Name',
    category AS 'Category',
    FORMAT(unit_price, 2) AS 'Unit Price'
FROM courses
WHERE unit_price > any
(
    SELECT unit_price
    FROM courses
    WHERE category ='Beginner'
);

##Learners who spent more than the average spending in their country
SELECT
    l.learner_id AS 'Learner ID',
    l.full_name AS 'Learner Name',
    l.country AS 'Country',
    FORMAT(
        SUM(p.quantity * c.unit_price),
        2
    ) AS 'Total Spending'
FROM learners l
INNER JOIN purchases p
    ON l.learner_id = p.learner_id
INNER JOIN courses c
    ON p.course_id = c.course_id
GROUP BY
    l.learner_id,
    l.full_name,
    l.country
HAVING sum(p.quantity * c.unit_price) >
(
    SELECT AVG(country_spending)
    FROM
    (
        SELECT
            l2.learner_id,
            SUM(p2.quantity * c2.unit_price) AS country_spending
        FROM learners l2
        INNER JOIN purchases p2
            ON l2.learner_id = p2.learner_id
        INNER JOIN courses c2
            ON p2.course_id = c2.course_id
        WHERE l2.country = l.country
        GROUP BY l2.learner_id
    ) AS country_average
);

##CASE Expression — Learner classification

SELECT
    l.learner_id AS 'Learner ID',
    l.full_name AS 'Learner Name',
    FORMAT(
        COALESCE(SUM(p.quantity * c.unit_price), 0),
        2
    ) AS 'Total Spending',

    CASE
        WHEN COALESCE(SUM(p.quantity * c.unit_price), 0) > 15000
            THEN 'High Value'

        WHEN COALESCE(SUM(p.quantity * c.unit_price), 0)
             BETWEEN 8000 AND 15000
            THEN 'Medium Value'

        ELSE 'Low Value'
    END AS 'Learner Classification'

FROM learners l
LEFT JOIN purchases p
    ON l.learner_id = p.learner_id
LEFT JOIN courses c
    ON p.course_id = c.course_id

GROUP BY
    l.learner_id,
    l.full_name

ORDER BY
    sum(p.quantity * c.unit_price) DESC;
    
    ##NULL Handling — Courses with zero purchase count
    
    SELECT
    c.course_id AS 'Course ID',
    c.course_name AS 'Course Name',
    c.category AS 'Category',
    FORMAT(c.unit_price, 2) AS 'Unit Price',

    COALESCE(
        SUM(p.quantity),
        0
    ) AS 'Purchase Count'

FROM courses c
LEFT JOIN purchases p
    ON c.course_id = p.course_id

GROUP BY
    c.course_id,
    c.course_name,
    c.category,
    c.unit_price

ORDER BY
    COALESCE(SUM(p.quantity), 0) DESC;
##Create category_performance_view

CREATE VIEW category_performance_view AS

SELECT
    c.category AS 'Category',

    SUM(p.quantity * c.unit_price)
        AS 'Total Revenue',

    COUNT(p.purchase_id)
        AS 'Number of Purchases',

    SUM(p.quantity * c.unit_price)
        / COUNT(p.purchase_id)
        AS 'Average Revenue Per Purchase'

FROM courses c
INNER JOIN purchases p
    ON c.course_id = p.course_id

GROUP BY
    c.category;
    
    
    
    
    
SELECT
    Category,
    FORMAT(`Total Revenue`, 2) AS 'Total Revenue',
    `Number of Purchases`,
    FORMAT(`Average Revenue Per Purchase`, 2)
        AS 'Average Revenue Per Purchase'
FROM category_performance_view
ORDER BY `Total Revenue` DESC;