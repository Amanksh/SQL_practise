-- =====================================================
-- SQL Practice Questions 71-80
-- PostgreSQL/pgAdmin4 Compatible
-- =====================================================

-- =====================================================
-- QUESTION 71: Exchange Rates
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- Create customers table
CREATE TABLE customers (
    id INT PRIMARY KEY,
    customer_name VARCHAR(30)
);

-- Create orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_type VARCHAR(5),
    order_amount DECIMAL(18,2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Insert data into customers
INSERT INTO customers (id, customer_name) VALUES
(401, 'Hubert Keesler'),
(402, 'Devin Vert'),
(403, 'Lashawna Bowerman'),
(404, 'Brigid Wellborn'),
(405, 'Josefine Perl');

-- Insert data into orders
INSERT INTO orders (order_id, customer_id, order_type, order_amount) VALUES
(4361, 401, 'Sell', 912.77),
(3478, 405, 'Sell', 741.69),
(7292, 405, 'Sell', 436.05),
(5833, 405, 'Sell', 231.30),
(3472, 402, 'Buy', 950.92),
(4472, 401, 'Sell', 367.70),
(2624, 404, 'Buy', 218.15),
(7198, 405, 'Buy', 797.29),
(7660, 403, 'Buy', 131.18),
(5192, 401, 'Buy', 362.44),
(5260, 402, 'Buy', 636.26),
(2726, 403, 'Sell', 138.15),
(6594, 401, 'Buy', 234.51),
(4657, 404, 'Buy', 427.30),
(9744, 402, 'Sell', 623.36);

-- Your query here:
-- Write a query to calculate the total fees paid by each customer
-- Buy order fee: 0.1% of order amount
-- Sell order fee: 0.15% of order amount
-- Round the total fees to 2 decimal places
-- Order by customer name

/*
Expected Output:
customer_name    total_fees
Brigid Wellborn  0.65
Devin Vert       2.52
Hubert Keesler   2.52
Josefine Perl    2.91
Lashawna Bowerman 0.34
*/

-- =====================================================
-- QUESTION 72: Credit Dues
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS credit_holders;

-- Create credit_holders table
CREATE TABLE credit_holders (
    id INT PRIMARY KEY,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    interest_rate INT
);

-- Create transactions table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    credit_holder_id INT,
    amount DECIMAL(18,2),
    FOREIGN KEY (credit_holder_id) REFERENCES credit_holders(id)
);

-- Insert data into credit_holders
INSERT INTO credit_holders (id, first_name, last_name, interest_rate) VALUES
(101, 'Clemencia', 'Hutsell', 12),
(102, 'Susannah', 'Ismail', 18),
(103, 'Sixta', 'Hagy', 18),
(104, 'Otto', 'Izquierdo', 18),
(105, 'Anita', 'Degroot', 15);

-- Insert data into transactions
INSERT INTO transactions (transaction_id, credit_holder_id, amount) VALUES
(4361, 101, 65.22),
(3478, 104, 51.85),
(7292, 104, 64.60),
(5833, 105, 72.15),
(3472, 102, 96.28),
(4472, 101, 80.06),
(2624, 101, 85.27),
(7198, 104, 23.73),
(7660, 103, 81.86),
(5192, 101, 69.64),
(5260, 101, 71.72),
(2726, 102, 57.66),
(6594, 103, 23.23),
(4657, 101, 81.68),
(9744, 104, 99.57),
(2054, 103, 51.13),
(7156, 105, 12.78),
(3273, 105, 36.15),
(9756, 101, 45.41),
(9702, 105, 69.75);

-- Your query here:
-- Write a query to calculate the amount due for each customer with interest rate > 12%
-- Amount due = total transaction amount + (total transaction amount * interest_rate/100)
-- Round the amount to 2 decimal places
-- Order by amount due in descending order

/*
Expected Output:
full_name       dues
Otto Izquierdo  282.91
Anita Degroot   219.45
Sixta Hagy      184.34
Susannah Ismail 181.65
*/

-- =====================================================
-- QUESTION 73: Interest Earned
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS accounts;

-- Create accounts table
CREATE TABLE accounts (
    id INT PRIMARY KEY,
    account_holder VARCHAR(30),
    amount VARCHAR(10)
);

-- Insert data into accounts
INSERT INTO accounts (id, account_holder, amount) VALUES
(1, 'Ellis Beane', '$5582.03'),
(2, 'Drew Nolf', '$2470.3'),
(3, 'Jordan Chatmon', '$6211.52'),
(4, 'Robin Hansard', '$8133.31'),
(5, 'Spencer Days', '$5273.81'),
(6, 'Morgan Criss', '$3741.85'),
(7, 'Wesley Waugh', '$7056.14'),
(8, 'Alex Canty', '$2590.45'),
(9, 'Blake Hawbaker', '$3987.27'),
(10, 'Taylor Blackston', '$8351.98');

-- Your query here:
-- Write a query to calculate the interest earned in 1 year at 5% interest rate
-- The amount field is a string with a currency symbol as first character
-- The interest should be shown with the same currency symbol, rounded to 2 decimals
-- Order by interest in descending order

/*
Expected Output:
account_holder    interest
Taylor Blackston  $417.60
Wesley Waugh      $352.81
Jordan Chatmon    $310.58
Robin Hansard     $406.67
Alex Canty        $129.52
Drew Nolf         $123.52
Blake Hawbaker    $199.36
Spencer Days      $263.69
Ellis Beane       $279.10
Morgan Criss      $187.09
*/

-- =====================================================
-- QUESTION 74: Monthly Revenue
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS transactions;

-- Create transactions table
CREATE TABLE transactions (
    transaction_id VARCHAR(10) PRIMARY KEY,
    amount DECIMAL(18,2)
);

-- Insert data into transactions
INSERT INTO transactions (transaction_id, amount) VALUES
('19SEP2187', 785.72),
('19OCT4361', 752.64),
('19APR3478', 197.92),
('19SEP7292', 910.26),
('21MAR5833', 344.70),
('20MAY3472', 939.61),
('20DEC4472', 154.98),
('20DEC2624', 935.44),
('21JUN7198', 309.81),
('19APR7660', 528.10),
('20MAR5192', 995.22),
('19OCT5260', 861.11),
('21JUN2726', 611.94),
('19OCT6594', 478.54),
('19APR4657', 183.20);

-- Your query here:
-- Extract year, month and calculate total transactions per month
-- The transaction_id contains the date in format YYMMMDD
-- Order by year and month in ascending order

/*
Expected Output:
year month total_transactions
19   APR   909.22
19   OCT   2092.29
19   SEP   1695.98
20   DEC   1090.42
20   MAR   995.22
20   MAY   939.61
21   JUN   921.75
21   MAR   344.70
*/

-- =====================================================
-- QUESTION 75: Final Result
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS results;

-- Create results table
CREATE TABLE results (
    id INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    cgpa_first_year FLOAT,
    cgpa_second_year FLOAT,
    cgpa_third_year FLOAT,
    cgpa_fourth_year FLOAT
);

-- Insert data into results
INSERT INTO results (id, first_name, last_name, cgpa_first_year, cgpa_second_year, cgpa_third_year, cgpa_fourth_year) VALUES
(1, 'Pearlene', 'Beane', 7.0, 5.1, 8.4, 8.9),
(2, 'Franklin', 'Nolf', 7.7, 7.2, 5.2, 8.3),
(3, 'Bell', 'Chatmon', 7.3, 8.4, 8.9, 10.0),
(4, 'Belva', 'Hansard', 6.2, 9.2, 5.8, 6.7),
(5, 'Missy', 'Days', 8.3, 10.0, 7.3, 6.7),
(6, 'Vicenta', 'Criss', 5.4, 9.5, 6.1, 9.0),
(7, 'Annelle', 'Waugh', 6.5, 7.9, 9.6, 9.3),
(8, 'Darby', 'Canty', 5.5, 9.0, 8.6, 5.9),
(9, 'Ka', 'Hawbaker', 5.7, 6.4, 5.2, 6.8),
(10, 'Alease', 'Blackston', 5.3, 7.5, 9.3, 6.0);

-- Your query here:
-- Calculate the average CGPA over 4 years for each student
-- Round to 1 decimal place
-- Order by average CGPA in descending order
-- Include full name (first_name + space + last_name) as full_name

/*
Expected Output:
full_name          average_gpa
Bell Chatmon       8.6
Annelle Waugh      8.3
Missy Days         8.1
Vicenta Criss      7.5
Pearlene Beane     7.3
Darby Canty        7.3
Franklin Nolf      7.1
Belva Hansard      7.0
Alease Blackston   7.0
Ka Hawbaker        6.0
*/

-- =====================================================
-- QUESTION 76: Mutual Funds
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS funds;

-- Create funds table
CREATE TABLE funds (
    id INT PRIMARY KEY,
    order_date DATE,
    fund_name VARCHAR(50),
    order_amount INT
);

-- Insert data into funds
INSERT INTO funds (id, order_date, fund_name, order_amount) VALUES
(1, '2021-09-05', 'Mid-Cap', 151),
(2, '2020-11-27', 'Small-Cap', 784),
(3, '2020-11-22', 'Multi-Cap', 761),
(4, '2020-02-26', 'Large-Cap', 778),
(5, '2020-01-04', 'Mid-Cap', 949),
(6, '2020-02-01', 'Large-Cap', 392),
(7, '2020-02-07', 'Mid-Cap', 629),
(8, '2020-06-01', 'Mid-Cap', 529),
(9, '2020-08-05', 'Large-Cap', 258),
(10, '2021-09-23', 'Mid-Cap', 739),
(11, '2020-02-14', 'Large-Cap', 563),
(12, '2021-09-29', 'Small-Cap', 817),
(13, '2020-05-11', 'Large-Cap', 121),
(14, '2021-09-18', 'Mid-Cap', 341),
(15, '2021-09-07', 'Large-Cap', 260),
(16, '2021-10-11', 'Small-Cap', 102);

-- Your query here:
-- For each month and fund, calculate the total investments
-- Extract month from order_date
-- Order by month and fund_name

/*
Expected Output:
month fund_name total_investments
1     Mid-Cap   949
1     Small-Cap 767
2     Large-Cap 1733
2     Mid-Cap   629
3     Small-Cap 733
4     Small-Cap 920
5     Large-Cap 121
6     Mid-Cap   1025
6     Small-Cap 668
7     Multi-Cap 321
8     Large-Cap 258
9     Large-Cap 260
9     Mid-Cap   1231
9     Multi-Cap 938
9     Small-Cap 817
10    Small-Cap 102
11    Multi-Cap 761
11    Small-Cap 1273
*/

-- =====================================================
-- QUESTION 77: DPI Software Protocols Report
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS traffic;

-- Create traffic table
CREATE TABLE traffic (
    client VARCHAR(17),
    protocol VARCHAR(64),
    traffic_in INT,
    traffic_out INT,
    frequency VARCHAR(10)
);

-- Insert data into traffic
INSERT INTO traffic (client, protocol, traffic_in, traffic_out, frequency) VALUES
('02-E1-80-76-EC-4B', 'BGP', 0, 234737, 'seldom'),
('43-15-AA-26-0F-A4', 'BGP', 402860, 606565, 'monthly'),
('90-E7-B0-14-7E-8C', 'BGP', 840772, 988197, 'seldom'),
('FB-60-23-C1-5E-D6', 'DNS', 341155, 356569, 'seldom'),
('4D-6D-7F-62-F4-00', 'FTP', 8346, 413322, 'weekly'),
('09-89-26-46-C4-21', 'FTP', 210656, 470568, 'monthly'),
('B1-6A-35-2F-1A-C2', 'FTP', 897097, 161083, 'seldom'),
('0C-CA-68-2D-4B-F5', 'HTTP', 918793, 550403, 'seldom'),
('A4-C6-52-10-2E-9C', 'HTTPS', 520856, 185387, 'seldom'),
('95-B8-7D-78-06-42', 'POP', 150880, 423073, 'weekly'),
('B9-C1-1B-32-55-95', 'POP', 862946, 979544, 'seldom'),
('14-FD-21-F6-5E-67', 'SMTP', 139389, 280646, 'seldom'),
('70-E1-2D-B1-B2-9B', 'SMTP', 163986, 450401, 'monthly'),
('C6-61-59-FF-5D-BE', 'SMTP', 271295, 878246, 'seldom'),
('62-01-CF-AD-32-A7', 'SMTP', 388933, 81625, 'seldom'),
('41-80-FB-86-D1-93', 'SMTP', 752842, 253981, 'seldom'),
('93-33-01-57-5F-4A', 'SSH', 496717, 599280, 'weekly'),
('52-F2-BF-45-84-74', 'SSH', 632534, 128765, 'seldom'),
('87-66-B5-A5-2F-7B', 'SSH', 835441, 354950, 'monthly'),
('CE-0C-80-FF-3F-95', 'UDP', 903443, 120298, 'seldom');

-- Your query here:
-- List all protocols where incoming traffic is higher than outgoing
-- Show protocol, traffic_in, traffic_out
-- Sort by protocol in ascending order

/*
Expected Output:
protocol traffic_in traffic_out
FTP      1116099    1044973
HTTP     918793     550403
HTTPS    520856     185387
SSH      1964692    1082995
UDP      903443     120298
*/

-- =====================================================
-- QUESTION 78: Advertising System Failures Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS campaigns;
DROP TABLE IF EXISTS customers;

-- Create customers table
CREATE TABLE customers (
    id SMALLINT PRIMARY KEY,
    first_name VARCHAR(64),
    last_name VARCHAR(64)
);

-- Create campaigns table
CREATE TABLE campaigns (
    id SMALLINT PRIMARY KEY,
    customer_id SMALLINT,
    name VARCHAR(64),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- Create events table
CREATE TABLE events (
    dt VARCHAR(19),
    campaign_id SMALLINT,
    status VARCHAR(64),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(id)
);

-- Insert data into customers
INSERT INTO customers (id, first_name, last_name) VALUES
(1, 'Whitney', 'Ferrero'),
(2, 'Dickie', 'Romera');

-- Insert data into campaigns
INSERT INTO campaigns (id, customer_id, name) VALUES
(1, 1, 'Upton Group'),
(2, 1, 'Roob, Hudson and Rippin'),
(3, 1, 'McCullough, Rempel and Larson'),
(4, 1, 'Lang and Sons'),
(5, 2, 'Ruecker, Hand and Haley');

-- Insert data into events
INSERT INTO events (dt, campaign_id, status) VALUES
('2021-12-02 13:52:00', 1, 'failure'),
('2021-12-02 08:17:48', 2, 'failure'),
('2021-12-02 08:18:17', 2, 'failure'),
('2021-12-01 11:55:32', 3, 'failure'),
('2021-12-01 06:53:16', 4, 'failure'),
('2021-12-02 04:51:09', 4, 'failure'),
('2021-12-01 06:34:04', 5, 'failure'),
('2021-12-02 03:21:18', 5, 'failure'),
('2021-12-01 03:18:24', 5, 'failure'),
('2021-12-02 15:32:37', 1, 'success'),
('2021-12-01 04:23:20', 1, 'success'),
('2021-12-02 06:53:24', 1, 'success'),
('2021-12-02 08:01:02', 2, 'success'),
('2021-12-01 15:57:19', 2, 'success'),
('2021-12-02 16:14:34', 3, 'success'),
('2021-12-02 21:56:38', 3, 'success'),
('2021-12-01 05:54:43', 4, 'success'),
('2021-12-02 17:56:45', 4, 'success'),
('2021-12-02 11:56:50', 4, 'success'),
('2021-12-02 06:08:20', 5, 'success');

-- Your query here:
-- Find customers with more than 3 failure events across their campaigns
-- Show customer full name and failure count
-- Order doesn't matter

/*
Expected Output:
customer        failures
Whitney Ferrero 6
*/

-- =====================================================
-- QUESTION 79: Election Exit Poll Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS results;
DROP TABLE IF EXISTS candidates;

-- Create candidates table
CREATE TABLE candidates (
    id SMALLINT PRIMARY KEY,
    first_name VARCHAR(64),
    last_name VARCHAR(64)
);

-- Create results table
CREATE TABLE results (
    candidate_id SMALLINT,
    vote_at VARCHAR(19),
    FOREIGN KEY (candidate_id) REFERENCES candidates(id)
);

-- Insert data into candidates
INSERT INTO candidates (id, first_name, last_name) VALUES
(1, 'Xavier', 'Ping'),
(2, 'Westley', 'Drewell'),
(3, 'Dominick', 'Scoble');

-- Insert data into results
INSERT INTO results (candidate_id, vote_at) VALUES
(0, '2021-12-01 14:15:52'),
(1, '2021-12-01 03:55:23'),
(1, '2021-12-01 21:53:26'),
(1, '2021-12-02 07:57:40'),
(1, '2021-12-02 13:56:06'),
(2, '2021-12-01 11:46:40'),
(2, '2021-12-01 14:56:05'),
(2, '2021-12-01 21:54:50'),
(2, '2021-12-02 00:43:18'),
(2, '2021-12-02 06:59:33'),
(2, '2021-12-02 08:36:35'),
(2, '2021-12-02 10:20:33'),
(2, '2021-12-02 14:02:38'),
(3, '2021-12-01 05:18:34'),
(3, '2021-12-02 03:55:37'),
(3, '2021-12-02 05:30:24'),
(3, '2021-12-02 08:32:06'),
(4, '2021-12-02 05:05:55'),
(5, '2021-12-02 15:50:50'),
(5, '2021-12-02 20:45:08');

-- Your query here:
-- Count votes for each candidate
-- Show candidate full name and vote count
-- Order by vote count descending, then by candidate name ascending
-- Ignore votes that don't match any candidate (candidate_id not in candidates table)

/*
Expected Output:
candidate       votes
Westley Drewell 8
Xavier Ping     4
Dominick Scoble 4
*/

-- =====================================================
-- QUESTION 80: Billing Analytics Customer Report
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS events;

-- Create events table
CREATE TABLE events (
    dt VARCHAR(19),
    customer VARCHAR(64),
    amount DECIMAL(5,2)
);

-- Insert data into events
INSERT INTO events (dt, customer, amount) VALUES
('2021-11-22 06:41:01', 'Donaugh Furneaux', 0.89),
('2021-12-22 20:07:04', 'Donaugh Furneaux', 10.51),
('2021-12-31 05:22:11', 'Donaugh Furneaux', 55.92),
('2021-12-12 21:26:42', 'Harley Lyddiard', 37.68),
('2021-11-22 21:24:30', 'Kippy Jelly', 85.87),
('2021-11-25 07:00:29', 'Kippy Jelly', 7.25),
('2021-12-16 16:48:32', 'Kippy Jelly', 65.49),
('2021-11-22 23:30:55', 'Latrina Jackman', 93.49),
('2021-11-24 19:38:52', 'Latrina Jackman', 82.28),
('2021-11-30 22:59:33', 'Latrina Jackman', 96.87),
('2021-12-30 13:05:34', 'Latrina Jackman', 88.19),
('2021-11-22 02:08:02', 'Maribel Braim', 20.19),
('2021-12-13 00:14:58', 'Maribel Braim', 97.99),
('2021-12-26 13:22:20', 'Maribel Braim', 57.06),
('2021-12-29 00:20:27', 'Maribel Braim', 24.35),
('2021-11-25 14:29:29', 'Orrin Curley', 6.69),
('2021-12-08 06:22:16', 'Orrin Curley', 36.85),
('2021-12-09 15:32:16', 'Orrin Curley', 11.04),
('2021-11-28 00:15:20', 'Rasla Venny', 14.59),
('2021-12-25 09:58:23', 'Rasla Venny', 6.41);

-- Your query here:
-- Find customers with 3 or more transactions in December 2021
-- Show customer name, transaction count, and total amount
-- Sort by customer name in ascending order

/*
Expected Output:
customer        transactions total
Maribel Braim   3            179.40
*/

-- =====================================================
-- End of Questions 71-80
-- =====================================================

-- =====================================================
-- QUESTION 81: Aggregate Marks
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS marks;

-- Create marks table
CREATE TABLE marks (
    student_id INT,
    marks INT
);

-- Insert data into marks
INSERT INTO marks (student_id, marks) VALUES
(1, 450),
(2, 200),
(3, 260),
(2, 300),
(3, 250),
(3, 510),
(2, 500);

-- Your query here:
-- Retrieve records of students who have a sum of marks >= 500
-- Sort by student_id in descending order

/*
Expected Output:
STUDENT_ID SUM_OF_MARKS
3          1020
2          1000
*/

-- =====================================================
-- QUESTION 82: Trip Query
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS families;
DROP TABLE IF EXISTS countries;

-- Create families table
CREATE TABLE families (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    family_size INT
);

-- Create countries table
CREATE TABLE countries (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    min_size INT
);

-- Insert data into families
INSERT INTO families (id, name, family_size) VALUES
('c00dac11bde74750b4d207b9c182a85f', 'Alex Thomas', 9),
('eb6f2d3426694667ae3e79d6274114a4', 'Chris Gray', 2);

-- Insert data into countries
INSERT INTO countries (id, name, min_size) VALUES
('023fd23615bd4ff4b2ae0a13ed7efec9', 'Bolivia', 2),
('be247f73de0f4b2d810367cb26941fb9', 'Cook Islands', 4),
('3e85ab80a6f84ef3b9068b21dbcc54b3', 'Brazil', 4);

-- Your query here:
-- Print the maximum number of discounted tours any 1 family can choose from
-- A family can choose a tour if their family_size >= min_size

/*
Expected Output:
max_tours
3
*/

-- =====================================================
-- QUESTION 83: Activity Query
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS friends;
DROP TABLE IF EXISTS activities;

-- Create friends table
CREATE TABLE friends (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    activity VARCHAR(100)
);

-- Create activities table
CREATE TABLE activities (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Insert data into friends
INSERT INTO friends (id, name, activity) VALUES
(1, 'James Smith', 'Horse Riding'),
(2, 'Eric Jenkins', 'Eating'),
(3, 'Sean Cox', 'Eating'),
(4, 'Eric Schmidt', 'Horse Riding'),
(5, 'Chris Evans', 'Eating'),
(6, 'Jessica Breeds', 'Playing');

-- Insert data into activities
INSERT INTO activities (id, name) VALUES
(1, 'Horse Riding'),
(2, 'Eating'),
(3, 'Playing');

-- Your query here:
-- Print names of activities with neither max nor min participants
-- Sort by activity name

/*
Expected Output:
name
Horse Riding
*/

-- =====================================================
-- QUESTION 84: Restaurant's Growth
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS customers;

-- Create customers table
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    visited_on DATE,
    amount INT
);

-- Insert data into customers
INSERT INTO customers (id, name, phone, visited_on, amount) VALUES
(1, 'Julia', '1234567890', '2015-05-01', 100),
(2, 'Samantha', '1234567890', '2015-05-02', 200),
(3, 'Julia-Samantha', '1234567890', '2015-05-03', 300);

-- Your query here:
-- Compute moving average of customer spending over 7 days
-- Show visited_on, amount, and average_amount (rounded to 2 decimals)
-- Order by visited_on

/*
Expected Output:
visited_on  amount  avg_amount
2015-05-01  100     100.00
2015-05-02  200     150.00
2015-05-03  300     200.00
*/

-- =====================================================
-- QUESTION 85: Examination Data Management
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS examination;
DROP TABLE IF EXISTS student;

-- Create student table
CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Create examination table
CREATE TABLE examination (
    student_id INT,
    subject VARCHAR(100),
    FOREIGN KEY (student_id) REFERENCES student(id)
);

-- Insert data into student
INSERT INTO student (id, name) VALUES
(1, 'Taylor'),
(2, 'Wesley'),
(3, 'Jordan'),
(4, 'Robin'),
(5, 'Alex');

-- Insert data into examination
INSERT INTO examination (student_id, subject) VALUES
(1, 'Biology'),
(1, 'Physics'),
(3, 'History'),
(4, 'Geography'),
(4, 'Geography');

-- Your query here:
-- For each student and subject, count how many times they appeared in the examination
-- Show student ID, subject, and count of appearances
-- Order doesn't matter

/*
Expected Output:
ID SUBJECT  NUMBER_OF_TIMES
1  Biology  1
1  Physics  1
3  History  1
4  Geography 2
*/

-- =====================================================
-- QUESTION 86: The Perfect Arrangement
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS customer;

-- Create customer table
CREATE TABLE customer (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country VARCHAR(50),
    credit_limit FLOAT
);

-- Insert data into customer
INSERT INTO customer (id, first_name, last_name, country, credit_limit) VALUES
(1, 'Alex', 'White', 'USA', 200350.54),
(2, 'Tyler', 'Hanson', 'UK', 15354.23),
(3, 'Jordan', 'Fernandez', 'France', 359200.67),
(4, 'Drew', 'Bradley', 'Albania', 1060.57),
(5, 'Blake', 'Fuller', 'USA', 14789.00),
(6, 'Spencer', 'Johnston', 'China', 100243.35),
(7, 'Ellis', 'Gutierrez', 'USA', 998999.20),
(8, 'Morgan', 'Thomas', 'Canada', 500500.23),
(9, 'Riley', 'Garza', 'UK', 18782.44),
(10, 'Peyton', 'Harris', 'USA', 158367.00);

-- Your query here:
-- Return customer ID, first_name, and last_name
-- Only include customers where first_name + last_name is less than 12 characters
-- Sort by combined name length, then alphabetically by combined name, then by ID
-- All sorts are ascending

/*
Expected Output:
ID FIRST_NAME LAST_NAME
1  Alex       White
9  Riley      Garza
5  Blake      Fuller
4  Drew       Bradley
2  Tyler      Hanson
*/

-- =====================================================
-- QUESTION 87: Students Score
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS student;

-- Create student table
CREATE TABLE student (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    score FLOAT
);

-- Insert data into student
INSERT INTO student (id, name, score) VALUES
(1, 'Bob', 50),
(2, 'John', 65.5),
(3, 'Harry', 45),
(4, 'Dick', 85),
(5, 'Dev', 25),
(6, 'Sid', 98),
(7, 'Tom', 90),
(8, 'Julia', 70.5),
(9, 'Erica', 81),
(10, 'Jerry', 85);

-- Your query here:
-- Print IDs and names of students who scored higher than the average score
-- Sort by student ID in ascending order

/*
Expected Output:
ID NAME
4  Dick
6  Sid
7  Tom
8  Julia
9  Erica
10 Jerry
*/

-- =====================================================
-- QUESTION 88: The First Orders
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS orders;

-- Create orders table
CREATE TABLE orders (
    id INT PRIMARY KEY,
    order_date DATE,
    status VARCHAR(50),
    customer_id INT
);

-- Insert data into orders
INSERT INTO orders (id, order_date, status, customer_id) VALUES
(10100, '2003-01-06', 'PLACED', 363),
(10101, '2003-01-06', 'PLACED', 128),
(10102, '2003-01-06', 'IN TRANSIT', 181),
(10103, '2003-01-06', 'DELIVERED', 121),
(10104, '2003-01-07', 'DELIVERED', 114),
(10106, '2003-01-07', 'IN TRANSIT', 278),
(10120, '2003-01-07', 'PLACED', 114),
(10122, '2003-05-05', 'IN TRANSIT', 350),
(10123, '2003-05-05', 'DELIVERED', 103);

-- Your query here:
-- Print details of the first 5 orders (by order_date) that are not delivered
-- If there are more than 5, choose those with lowest order ID
-- Show ID, ORDER_DATE, STATUS, CUSTOMER_ID
-- Sort by order ID

/*
Expected Output:
ID      ORDER_DATE  STATUS      CUSTOMER_ID
10100   2003-01-06  PLACED      363
10101   2003-01-06  PLACED      128
10102   2003-01-06  IN TRANSIT  181
10106   2003-01-07  IN TRANSIT  278
10120   2003-01-07  PLACED      114
*/

-- =====================================================
-- QUESTION 89: Customers Credit Limit
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS customer;

-- Create customer table
CREATE TABLE customer (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50),
    credits INT
);

-- Insert data into customer
INSERT INTO customer (id, name, country, credits) VALUES
(1, 'Frances White', 'USA', 200350),
(2, 'Carolyn Bradley', 'UK', 15354),
(3, 'Annie Fernandez', 'France', 359200),
(4, 'Ruth Hanson', 'Albania', 1060),
(5, 'Paula Fuller', 'USA', 14789),
(6, 'Bonnie Johnston', 'China', 100243),
(7, 'Ruth Gutierrez', 'USA', 998999),
(8, 'Ernest Thomas', 'Canada', 500500),
(9, 'Joe Garza', 'UK', 18782),
(10, 'Anne Harris', 'USA', 158367);

-- Your query here:
-- Print IDs and names of customers from USA with credit limit > 100000
-- Sort by ID in ascending order

/*
Expected Output:
ID  NAME
1   Frances White
7   Ruth Gutierrez
10  Anne Harris
*/

-- =====================================================
-- QUESTION 90: The Beautiful Collection
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS collection;

-- Create collection table
CREATE TABLE collection (
    red INT,
    green INT,
    blue INT
);

-- Insert data into collection
INSERT INTO collection (red, green, blue) VALUES
(65, 65, 87),
(50, 50, 50),
(30, 50, 100),
(40, 50, 90),
(92, 50, 50);

-- Your query here:
-- For each row, determine the type of collection:
-- GOOD: All three colors have equal count
-- BAD: Exactly two colors have equal count
-- WORSE: All three colors have different counts
-- Sort by type in alphabetical order

/*
Expected Output:
type
BAD
GOOD
WORSE
WORSE
BAD
*/

-- =====================================================
-- End of Questions 81-90
-- =====================================================

-- =====================================================
-- QUESTION 91: Big Companies
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS salary;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS company;

-- Create employee table
CREATE TABLE employee (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Create company table
CREATE TABLE company (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Create salary table
CREATE TABLE salary (
    employee_id INT,
    company_id INT,
    salary INT,
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (company_id) REFERENCES company(id)
);

-- Insert data into employee
INSERT INTO employee (id, name) VALUES
(1, 'Frances White'),
(2, 'Carolyn Bradley'),
(3, 'Annie Fernandez'),
(4, 'Ruth Hanson'),
(5, 'Paula Fuller'),
(6, 'Bonnie Johnston'),
(7, 'Ruth Gutierrez'),
(8, 'Ernest Thomas'),
(9, 'Joe Garza'),
(10, 'Anne Harris');

-- Insert data into company
INSERT INTO company (id, name) VALUES
(1, 'PeopleSoft Inc'),
(2, 'Baker Hughes Incorporated'),
(3, 'MDU Resources Group Inc.'),
(4, 'DST Systems, Inc.'),
(5, 'Williams Companies Inc'),
(6, 'Fisher Scientific International Inc.'),
(7, 'Emcor Group Inc.'),
(8, 'Genuine Parts Company'),
(9, 'MPS Group Inc.'),
(10, 'Novellus Systems Inc');

-- Insert data into salary
INSERT INTO salary (employee_id, company_id, salary) VALUES
(2, 4, 27779),
(2, 9, 36330),
(3, 9, 71466),
(3, 10, 22804),
(5, 5, 49892),
(6, 4, 31493),
(6, 10, 26888),
(7, 3, 87118),
(7, 7, 70767),
(7, 9, 39929);

-- Your query here:
-- Print names of companies where average salary > 40000
-- Format: COMPANY.NAME

/*
Expected Output:
MDU Resources Group Inc.
Williams Companies Inc
Emcor Group Inc.
MPS Group Inc.
*/

-- =====================================================
-- QUESTION 92: Scheduling Errors
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS schedule;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS professor;

-- Create department table
CREATE TABLE department (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Create professor table
CREATE TABLE professor (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

-- Create course table
CREATE TABLE course (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    credits INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

-- Create schedule table
CREATE TABLE schedule (
    professor_id INT,
    course_id INT,
    semester INT,
    year INT,
    FOREIGN KEY (professor_id) REFERENCES professor(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
);

-- Insert data into department
INSERT INTO department (id, name) VALUES
(1, 'Physical Sciences'),
(2, 'Clinical Medicine'),
(3, 'Biological Sciences'),
(4, 'Arts and Humanities'),
(5, 'Technology'),
(6, 'Humanities & Social Sciences');

-- Insert data into professor
INSERT INTO professor (id, name, department_id, salary) VALUES
(1, 'Alex Daniels', 4, 7169),
(2, 'Drew Knight', 1, 9793),
(3, 'Jordan Myers', 4, 25194),
(4, 'Tyler Rodriguez', 3, 9686),
(5, 'Blake Gomez', 2, 30860),
(6, 'Spencer George', 5, 10487),
(7, 'Ellis Vasquez', 4, 6353),
(8, 'Morgan Flores', 1, 25796),
(9, 'Riley Gilbert', 5, 35678),
(10, 'Peyton Stevens', 2, 26648);

-- Insert data into course
INSERT INTO course (id, name, department_id, credits) VALUES
(1, 'Pure Mathematics and Mathematical Statistics', 1, 3),
(2, 'Applied Mathematics and Theoretical Physics', 1, 5),
(3, 'Earth Science', 1, 7),
(4, 'Astronomy', 1, 6),
(5, 'Physics', 1, 8),
(6, 'Geography', 1, 7),
(7, 'Materials Science and Metallurgy', 1, 5),
(8, 'Chemistry', 1, 1),
(9, 'Clinical Biochemistry', 2, 3),
(10, 'Clinical Neuroscience', 2, 5);

-- Insert data into schedule
INSERT INTO schedule (professor_id, course_id, semester, year) VALUES
(4, 4, 3, 2003),
(3, 3, 1, 2011),
(1, 7, 5, 2011),
(7, 7, 1, 2010),
(4, 6, 1, 2001),
(9, 3, 1, 2012),
(10, 2, 4, 2009),
(1, 1, 3, 2014),
(1, 2, 3, 2008),
(1, 7, 5, 2007);

-- Your query here:
-- Find professors teaching courses outside their department
-- Show professor name and course name
-- No duplicates, any order

/*
Expected Output:
Tyler Rodriguez Astronomy
Jordan Myers Earth Science
Alex Daniels Materials Science and Metallurgy
Ellis Vasquez Materials Science and Metallurgy
Tyler Rodriguez Geography
Riley Gilbert Earth Science
Peyton Stevens Applied Mathematics and Theoretical Physics
Alex Daniels Pure Mathematics and Mathematical Statistics
Alex Daniels Applied Mathematics and Theoretical Physics
Alex Daniels Materials Science and Metallurgy
*/

-- =====================================================
-- QUESTION 93: List the Course Names
-- =====================================================

-- Drop tables if they exist (reusing tables from Q92)
DROP TABLE IF EXISTS schedule;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS department;
DROP TABLE IF EXISTS professor;

-- Create department table
CREATE TABLE department (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Create professor table
CREATE TABLE professor (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

-- Create course table
CREATE TABLE course (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    credits INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

-- Create schedule table
CREATE TABLE schedule (
    professor_id INT,
    course_id INT,
    semester INT,
    year INT,
    FOREIGN KEY (professor_id) REFERENCES professor(id),
    FOREIGN KEY (course_id) REFERENCES course(id)
);

-- Insert data into department
INSERT INTO department (id, name) VALUES
(1, 'Physical Sciences'),
(2, 'Clinical Medicine'),
(3, 'Biological Sciences'),
(4, 'Arts and Humanities'),
(5, 'Technology'),
(6, 'Humanities & Social Sciences');

-- Insert data into professor
INSERT INTO professor (id, name, department_id, salary) VALUES
(1, 'Alex Burton', 5, 7340),
(2, 'Tyler Matthews', 2, 14521),
(3, 'Spencer Peters', 1, 10487),
(4, 'Ellis Marshall', 3, 6353),
(5, 'Riley Peterson', 1, 35678),
(6, 'Peyton Fields', 5, 26648),
(7, 'Morgan Lee', 2, 25796),
(8, 'Jordan Diaz', 1, 17221),
(9, 'Drew Hicks', 5, 16613),
(10, 'Blake Foster', 4, 28526);

-- Insert data into course
INSERT INTO course (id, name, department_id, credits) VALUES
(1, 'Pure Mathematics and Mathematical Statistics', 1, 3),
(2, 'Applied Mathematics and Theoretical Physics', 1, 5),
(3, 'Earth Science', 1, 7),
(4, 'Astronomy', 1, 6),
(5, 'Physics', 1, 8),
(6, 'Geography', 1, 7),
(7, 'Materials Science and Metallurgy', 1, 5),
(8, 'Chemistry', 1, 1),
(9, 'Clinical Biochemistry', 2, 3),
(10, 'Clinical Neuroscience', 2, 5);

-- Insert data into schedule
INSERT INTO schedule (professor_id, course_id, semester, year) VALUES
(5, 3, 6, 2012),
(7, 3, 1, 2013),
(5, 7, 6, 2010),
(2, 10, 2, 2004),
(5, 1, 1, 2011),
(2, 9, 4, 2005),
(7, 10, 6, 2009),
(5, 6, 4, 2007),
(7, 9, 1, 2014),
(9, 9, 5, 2011);

-- Your query here:
-- List professor names and their associated courses
-- No duplicates, any order

/*
Expected Output:
Tyler Matthews Clinical Biochemistry
Tyler Matthews Clinical Neuroscience
Drew Hicks Clinical Biochemistry
Morgan Lee Clinical Biochemistry
Morgan Lee Clinical Neuroscience
Morgan Lee Earth Science
Riley Peterson Earth Science
Riley Peterson Geography
Riley Peterson Materials Science and Metallurgy
Riley Peterson Pure Mathematics and Mathematical Statistics
*/

-- =====================================================
-- QUESTION 94: Professor Names and Salaries
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS department;

-- Create department table
CREATE TABLE department (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

-- Create professor table
CREATE TABLE professor (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);

-- Insert data into department
INSERT INTO department (id, name) VALUES
(1, 'Physical Sciences'),
(2, 'Clinical Medicine'),
(3, 'Biological Sciences'),
(4, 'Arts and Humanities'),
(5, 'Technology'),
(6, 'Humanities & Social Sciences');

-- Insert data into professor
INSERT INTO professor (id, name, department_id, salary) VALUES
(1, 'Shauna Rivera', 1, 22606),
(2, 'Craig Elliott', 5, 27524),
(3, 'Nancy Russell', 2, 7076),
(4, 'Clarence Johnson', 1, 7249),
(5, 'Terri Thompson', 3, 28432),
(6, 'Keith Gilbert', 5, 12610),
(7, 'Louis Schmidt', 1, 13437),
(8, 'Ruth Price', 3, 9287),
(9, 'Julie Gonzalez', 4, 18870),
(10, 'Scott Butler', 1, 26200);

-- Your query here:
-- Find professors not in Arts and Humanities with salary > min salary in Arts and Humanities
-- Show name and salary
-- Order doesn't matter

/*
Expected Output:
Shauna Rivera 22606
Craig Elliott 27524
Terri Thompson 28432
Scott Butler 26200
*/

-- =====================================================
-- QUESTION 95: Student's Major
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS register;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS majors;

-- Create students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    student_age INT
);

-- Create majors table
CREATE TABLE majors (
    major_id INT PRIMARY KEY,
    major_name VARCHAR(100)
);

-- Create register table
CREATE TABLE register (
    student_id INT,
    major_id INT,
    PRIMARY KEY (student_id, major_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (major_id) REFERENCES majors(major_id)
);

-- Insert data into students
INSERT INTO students (student_id, student_name, student_age) VALUES
(1, 'John', 20),
(2, 'Masie', 21),
(3, 'Harry', 21);

-- Insert data into majors
INSERT INTO majors (major_id, major_name) VALUES
(1000, 'Computer Science'),
(2000, 'Biology'),
(3000, 'Physics');

-- Insert data into register
INSERT INTO register (student_id, major_id) VALUES
(2, 1000),  -- Masie - Computer Science
(3, 3000),  -- Harry - Physics
(1, 2000);  -- John - Biology

-- Your query here:
-- List student names and their major names
-- Sort by student_id
-- Limit to first 20 records

/*
Expected Output:
student_name major_name
John        Biology
Masie       Computer Science
Harry       Physics
*/

-- =====================================================
-- QUESTION 96: Student Rank
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS student;

-- Create student table
CREATE TABLE student (
    id INT PRIMARY KEY,
    age INT,
    score INT
);

-- Insert data into student
INSERT INTO student (id, age, score) VALUES
(1, 19, 91),
(2, 20, 90),
(3, 20, 87),
(4, 21, 72),
(5, 19, 98),
(6, 20, 50);

-- Your query here:
-- Find the 4th highest score (for the actual question, find 213th highest)
-- For this sample, we'll find the 4th highest

/*
Expected Output for sample (4th highest):
score
87
*/

-- For the actual question, you would find the 213th highest score
-- The solution approach would be the same, just change the offset

-- =====================================================
-- QUESTION 97: Clumsy Administrator
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS employee;

-- Create employee table
CREATE TABLE employee (
    name VARCHAR(100),
    phone VARCHAR(20),
    age INT
);

-- Insert data into employee
INSERT INTO employee (name, phone, age) VALUES
('Sam', '1000040000', 30),
('Alex', '1000020000', 60),
('Alex', '1000020012', 65),  -- Different phone number, not a duplicate
('Sam', '1000040000', 30),   -- Exact duplicate
('Chris', '1000012000', 34),
('Chris', '1000012000', 34); -- Exact duplicate

-- Your query here:
-- Find names of employees with duplicate records (all columns match)
-- Each name should appear only once in results
-- Order doesn't matter

/*
Expected Output:
name
Sam
Chris
*/

-- =====================================================
-- QUESTION 98: Accounting Software Balance Report
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS transactions;

-- Create transactions table
CREATE TABLE transactions (
    dt VARCHAR(19),
    customer VARCHAR(64),
    debit DECIMAL(5,2),
    credit DECIMAL(5,2)
);

-- Insert data into transactions
INSERT INTO transactions (dt, customer, debit, credit) VALUES
('2021-11-30 12:48:22', 'Arney Cuff', 6.43, 16.12),
('2021-12-25 19:00:46', 'Arney Cuff', 97.78, 12.53),
('2021-11-27 21:34:24', 'Donaugh Furneaux', 89.71, 85.04),
('2021-11-25 07:31:37', 'Ferrell Brunn', 63.58, 28.58),
('2021-11-25 15:30:56', 'Gibbie Jurisic', 25.81, 13.75),
('2021-11-21 00:09:50', 'Harley Lyddiard', 57.49, 7.11),
('2021-12-01 07:37:42', 'Harley Lyddiard', 48.33, 82.35),
('2021-12-02 13:08:52', 'Harley Lyddiard', 12.13, 63.81),
('2021-11-24 03:51:13', 'Kippy Jelly', 50.34, 12.91),
('2021-12-04 10:11:40', 'Latrina Jackman', 10.73, 39.51),
('2021-12-12 13:02:50', 'Latrina Jackman', 5.35, 96.74),
('2021-12-20 17:31:44', 'Latrina Jackman', 54.99, 92.73),
('2021-12-30 13:40:43', 'Maribel Braim', 57.06, 21.37),
('2021-12-02 09:57:35', 'Orrin Curley', 65.44, 51.31),
('2021-12-14 19:57:25', 'Orrin Curley', 40.04, 96.44),
('2021-11-20 09:28:11', 'Rasla Venny', 80.33, 20.69),
('2021-12-08 03:31:31', 'Rasla Venny', 55.43, 99.04),
('2021-12-09 21:31:29', 'Rasla Venny', 87.96, 5.87),
('2021-12-11 13:02:54', 'Rasla Venny', 45.42, 55.81),
('2021-12-28 18:04:52', 'Rasla Venny', 68.17, 85.30);

-- Your query here:
-- For December 2021, calculate the balance change for each customer
-- Balance change = sum(debit) - sum(credit)
-- Show customer and balance (formatted to 2 decimal places)
-- Sort by customer name in ascending order

/*
Expected Output:
customer            balance
Arney Cuff         85.25
Harley Lyddiard    -85.70
Latrina Jackman    -157.91
Maribel Braim      35.69
Orrin Curley       -42.27
Rasla Venny        10.96
*/

-- =====================================================
-- End of Questions 91-100
-- =====================================================
