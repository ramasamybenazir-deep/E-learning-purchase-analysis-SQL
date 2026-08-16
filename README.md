# E-learning-purchase-analysis-SQL
E-Learning Purchase Analysis – MySQL
📌 Project Overview

This project is a MySQL-based E-Learning Purchase Analysis developed to analyze course purchase data from an online learning platform.

The objective is to design a relational database, insert sample data, and use SQL queries to derive meaningful insights related to:

📈 Sales trends
👨‍🎓 Learner purchasing behavior
📚 Popular course categories
💰 Learner spending
🌍 Country-wise learner analysis
🛒 Course purchase patterns
🗂️ Database Structure

The database contains three main tables:

1. learners


2. courses


3. purchases


🔗 Database Relationships
learners
   |
   | 1
   |
   | *
purchases
   |
   | *
   |
   | 1
courses
Relationships
learners.learner_id → purchases.learner_id
courses.course_id → purchases.course_id

This creates a relational structure where:

One learner can make multiple purchases.
One course can be purchased by multiple learners.
Each purchase belongs to one learner and one course.
🛠️ Technologies Used
MySQL
MySQL Workbench
SQL
Relational Database Management System (RDBMS)
📊 SQL Concepts Covered

This project demonstrates the following SQL concepts:

Database & Table Creation
CREATE DATABASE
CREATE TABLE
Primary Keys
Foreign Keys
Data Types
Constraints
Data Manipulation
INSERT INTO
Joins
INNER JOIN
LEFT JOIN
RIGHT JOIN
Aggregations
SUM()
COUNT()
COUNT(DISTINCT)
AVG()
Filtering & Grouping
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
Advanced SQL
Subqueries
Correlated Subqueries
Common Table Expressions (CTE)
CASE
COALESCE()
IFNULL()
SQL Views
📋 Analytical Queries

The project contains the following analysis:

Query	Analysis
Q1	Each learner's total spending with country
Q2	Top 3 most purchased courses by quantity
Q3	Category-wise revenue and unique learners
Q4	Learners who purchased from multiple categories
Q5	Courses that were never purchased
Q6	Learners spending above average learner spending
Q7	Courses with prices higher than Beginner courses
Q8	Learners spending above their country's average
Q9	Learners spending above 10,000 using CTE
Q10	Learner classification using CASE
Q11	NULL handling for courses with no purchases
Q12	Category performance analysis using a View
💡 Key Business Questions

The SQL analysis answers questions such as:

Which learners spend the most?
Which courses are purchased most frequently?
Which course categories generate the highest revenue?
Which learners purchase courses from multiple categories?
Are there courses that have never been purchased?
Which learners spend more than the average learner?
Which learners spend more than the average spending in their country?
How can learners be classified based on their spending?
Which categories have the best purchase performance?
👥 Sample Dataset

The project uses sample data consisting of:

5 learners
6 courses
8 purchase transactions

The sample data represents learners from different countries and courses across different categories.

📁 Repository Structure
E-Learning-Purchase-Analysis/
│
├── E_Learning_Purchase_Analysis.sql
│
└── README.md
E_Learning_Purchase_Analysis.sql

Contains:

Database creation
Table creation
Sample data insertion
JOIN queries
Q1–Q12 analytical queries
CTE
CASE expression
NULL handling
View creation
README.md

Project documentation containing:

Project overview
Database structure
Relationships
SQL concepts
Analytical queries
Business questions
Repository structure
🚀 How to Run the Project
Step 1: Install MySQL

Install MySQL Server and MySQL Workbench.

Step 2: Open MySQL Workbench

Open MySQL Workbench and connect to your MySQL server.

Step 3: Open the SQL File

Open:

E_Learning_Purchase_Analysis.sql
Step 4: Execute the Script

Run the SQL script from beginning to end.

The script will:

Create the database.
Create the three tables.
Define primary and foreign keys.
Insert sample records.
Execute analytical queries.
Create the category_performance_view.
Step 5: Verify the View

Run:

SELECT *
FROM category_performance_view;
🎯 Learning Outcomes

Through this project, I practiced:

Relational database design
Creating tables with primary and foreign keys
Data insertion using SQL
Joining multiple tables
Aggregating business data
Writing subqueries
Using correlated subqueries
Creating and using CTEs
Applying conditional logic with CASE
Handling NULL values
Creating SQL Views
Translating business questions into SQL queries
👤 Author



Aspiring Data Analyst | SQL | MySQL | Power BI | Excel | Python

⭐ Project Purpose

This project was created as part of SQL/MySQL learning and hands-on data analytics practice to demonstrate the ability to design relational databases and extract business insights using SQL.

If you find this project useful, feel free to ⭐ the repository.
