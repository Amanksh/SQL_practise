-- =====================================================
-- QUESTION 41: SQL: Expected Cash Flow Analysis
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS cash_flows;
DROP TABLE IF EXISTS investors;

-- Create investors table
CREATE TABLE investors (
    id INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE
);

-- Create cash_flows table
CREATE TABLE cash_flows (
    investor_id INT,
    expected_flow DECIMAL(8,2),
    FOREIGN KEY(investor_id) REFERENCES investors(id)
);

-- Insert data into investors
INSERT INTO investors (id, email) VALUES
(1, 'tdowner0@timesonline.co.uk'),
(2, 'cgarza1@opera.com'),
(3, 'nbarwise2@si.edu');

-- Insert data into cash_flows
INSERT INTO cash_flows (investor_id, expected_flow) VALUES
(1, 24923.83), (1, 30212.10), (1, 87126.50), (1, 56018.65), (1, 93357.47), (1, 55073.54), (1, 27095.07),
(2, 44165.12), (2, 43658.84), (2, 35835.34), (2, 12660.46), (2, 58676.60), (2, 95929.25), (2, 47161.23),
(2, 80283.91), (2, 54427.20), (2, 93223.98),
(3, 19741.35), (3, 12243.25), (3, 50470.06);

-- Write your query for Question 41 here:
-- Expected Output: email | investment_count | total_expected_flow | range_expected_flow
-- Sort by email in ascending order.
-- Only include investors with a sum of expected cash flows greater than 100,000.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 42: SQL: Online Store Coupon Codes Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS coupon_uses;
DROP TABLE IF EXISTS coupons;

-- Create coupons table
CREATE TABLE coupons (
    id INT PRIMARY KEY,
    coupon_code VARCHAR(255) UNIQUE,
    description VARCHAR(255),
    is_enabled SMALLINT
);

-- Create coupon_uses table
CREATE TABLE coupon_uses (
    coupon_id INT,
    amount DECIMAL(4,2),
    FOREIGN KEY(coupon_id) REFERENCES coupons(id)
);

-- Insert data into coupons
INSERT INTO coupons (id, coupon_code, description, is_enabled) VALUES
(1, 'COUPON123', 'nisi nam ultrices libero non', 0),
(2, 'SAVE20', 'ac est lacinia', 1),
(3, 'DISCOUNT50', 'quis odio consequat', 1);

-- Insert data into coupon_uses
INSERT INTO coupon_uses (coupon_id, amount) VALUES
(1, 36.68), (1, 3.56), (1, 2.10), (1, 39.58),
(2, 39.81), (2, 24.07), (2, 28.42), (2, 31.03), (2, 3.24), (2, 36.33),
(3, 8.89), (3, 30.44), (3, 36.94), (3, 42.65), (3, 33.61), (3, 41.92),
(3, 1.78), (3, 20.26), (3, 27.92), (3, 0.23);

-- Write your query for Question 42 here:
-- Expected Output: coupon_code | description | total_uses | min_discount | max_discount | avg_discount
-- Sort by coupon_code in ascending order.
-- Only include active coupons.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 43: SQL: Freelancer Platform Yearly Income Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS freelancers;
DROP TABLE IF EXISTS professions;

-- Create professions table
CREATE TABLE professions (
    id INT PRIMARY KEY,
    title VARCHAR(255) UNIQUE
);

-- Create freelancers table
CREATE TABLE freelancers (
    id INT PRIMARY KEY,
    profession_id INT,
    email VARCHAR(255) UNIQUE,
    FOREIGN KEY(profession_id) REFERENCES professions(id)
);

-- Create projects table
CREATE TABLE projects (
    id INT PRIMARY KEY,
    freelancer_id INT,
    status ENUM('Completed','Ongoing','Cancelled'),
    income DECIMAL(6,2),
    FOREIGN KEY(freelancer_id) REFERENCES freelancers(id)
);

-- Insert data into professions
INSERT INTO professions (id, title) VALUES
(1, 'Artificial Intelligence Engineer'),
(3, 'Game Developer'),
(2, 'Network Administrator');

-- Insert data into freelancers
INSERT INTO freelancers (id, profession_id, email) VALUES
(1, 1, 'lfernez0@microsoft.com'),
(3, 2, 'mbrydone2@delicious.com'),
(4, 2, 'jhamp3@4shared.com'),
(5, 3, 'cparfett4@twitter.com');

-- Insert data into projects
INSERT INTO projects (id, freelancer_id, status, income) VALUES
(5, 1, 'Completed', 8562.13), (11, 1, 'Completed', 6727.56),
(10, 3, 'Completed', 3753.46), (20, 3, 'Completed', 6659.39),
(6, 4, 'Completed', 8459.28), (13, 4, 'Completed', 5899.31), (16, 4, 'Completed', 2709.63),
(4, 5, 'Completed', 5029.44), (7, 5, 'Completed', 1763.94), (9, 5, 'Completed', 6988.36),
(8, 3, 'Cancelled', 8699.67), (1, 5, 'Cancelled', 5403.21),
(19, 3, 'Ongoing', 72.51), (3, 4, 'Ongoing', 8561.14),
(15, 4, 'Ongoing', 9235.78), (17, 4, 'Ongoing', 4307.76);

-- Write your query for Question 43 here:
-- Expected Output: title | total_projects | total_income | total_freelancers | average_income_per_freelancer
-- Sort by total_income in descending order.
-- Only include completed projects.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 44: SQL: Ecommerce Warehouse Stock Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;

-- Create categories table
CREATE TABLE categories (
    id INT PRIMARY KEY,
    title VARCHAR(255) UNIQUE
);

-- Create products table
CREATE TABLE products (
    id INT PRIMARY KEY,
    category_id INT,
    title VARCHAR(255),
    sku VARCHAR(255) UNIQUE,
    stock_number INT,
    FOREIGN KEY(category_id) REFERENCES categories(id)
);

-- Insert data into categories
INSERT INTO categories (id, title) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home & Kitchen');

-- Insert data into products
INSERT INTO products (id, category_id, title, sku, stock_number) VALUES
(11, 1, 'Elegant Gadget', 'EG-11', 4), (3, 1, 'Luxury Gizmo', 'LG-3', 10), (19, 1, 'Sleek Widget', 'SW-19', 8), (8, 1, 'Sleek Widget', 'SW-8', 8),
(14, 2, 'Elegant Gadget', 'EG-14', 2), (16, 2, 'Elegant Gadget', 'EG-16', 6), (10, 2, 'Elegant Gadget', 'EG-10', 10),
(7, 2, 'Luxury Gizmo', 'LG-7', 3), (2, 2, 'Luxury Gizmo', 'LG-2', 8), (18, 2, 'Luxury Gizmo', 'LG-18', 9),
(1, 2, 'Sleek Widget', 'SW-1', 3), (6, 2, 'Sleek Widget', 'SW-6', 7),
(20, 3, 'Elegant Gadget', 'EG-20', 10), (9, 3, 'Luxury Gizmo', 'LG-9', 4), (12, 3, 'Luxury Gizmo', 'LG-12', 5),
(13, 3, 'Luxury Gizmo', 'LG-13', 5), (5, 3, 'Luxury Gizmo', 'LG-5', 9), (4, 3, 'Sleek Widget', 'SW-4', 8),
(15, 3, 'Sleek Widget', 'SW-15', 9), (17, 3, 'Sleek Widget', 'SW-17', 9);

-- Write your query for Question 44 here:
-- Expected Output: category | title | total_stock
-- Sort by category ascending, then title ascending, then total_stock descending.
-- Only include products with a total stock of more than 10 items.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 45: SQL: Antivirus Database Quarantine Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS quarantine_urls;
DROP TABLE IF EXISTS threat_types;

-- Create threat_types table
CREATE TABLE threat_types (
    id INT PRIMARY KEY,
    threat_type VARCHAR(255)
);

-- Create quarantine_urls table
CREATE TABLE quarantine_urls (
    id INT PRIMARY KEY,
    threat_id INT,
    domain_name VARCHAR(255),
    status ENUM('Quarantined','Safe','Deleted'),
    users_affected INT,
    FOREIGN KEY(threat_id) REFERENCES threat_types(id)
);

-- Insert data into threat_types
INSERT INTO threat_types (id, threat_type) VALUES
(1, 'Phishing'),
(2, 'Rootkit'),
(3, 'Malware');

-- Insert data into quarantine_urls
INSERT INTO quarantine_urls (id, threat_id, domain_name, status, users_affected) VALUES
(17, 1, 'amazon.com', 'Quarantined', 862), (16, 1, 'google.com', 'Quarantined', 63), (9, 1, 'amazon.com', 'Quarantined', 41),
(18, 2, 'amazon.com', 'Quarantined', 149), (12, 2, 'yahoo.com', 'Quarantined', 967),
(4, 3, 'amazon.com', 'Quarantined', 377), (10, 3, 'yahoo.com', 'Quarantined', 721),
(11, 1, 'yahoo.com', 'Deleted', 551), (20, 1, 'amazon.com', 'Safe', 407), (19, 1, 'amazon.com', 'Deleted', 665),
(15, 1, 'facebook.com', 'Safe', 52), (2, 1, 'google.com', 'Safe', 309),
(1, 2, 'twitter.com', 'Safe', 562), (13, 2, 'facebook.com', 'Safe', 208), (14, 2, 'google.com', 'Deleted', 731),
(8, 2, 'twitter.com', 'Safe', 924), (7, 2, 'twitter.com', 'Safe', 982), (6, 2, 'google.com', 'Deleted', 864),
(3, 2, 'facebook.com', 'Safe', 136),
(5, 3, 'yahoo.com', 'Safe', 949);

-- Write your query for Question 45 here:
-- Expected Output: domain_name | threat_type | total_occurrences | total_users_affected
-- Sort by total_users_affected descending, then domain_name ascending.
-- Only include URLs with a status of "Quarantined".

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 46: SQL: Online Streaming Service Traffic Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS streams;
DROP TABLE IF EXISTS clients;

-- Create clients table
CREATE TABLE clients (
    id INT PRIMARY KEY,
    mac_address VARCHAR(255)
);

-- Create streams table
CREATE TABLE streams (
    client_id INT,
    title VARCHAR(255),
    quality ENUM('240p','360p','480p','720p','1080p','1440p','2160p'),
    traffic INT,
    FOREIGN KEY(client_id) REFERENCES clients(id)
);

-- Insert data into clients
INSERT INTO clients (id, mac_address) VALUES
(1, '2F-80-8E-F2-0E-4C'),
(2, 'A1-F7-D4-48-B9-E6'),
(3, '9F-72-DB-7C-73-FC');

-- Insert data into streams
INSERT INTO streams (client_id, title, quality, traffic) VALUES
(1, 'Monte Carlo', '360p', 71928308), (1, 'Separation, The (Sparation, La)', '480p', 35221785),
(1, 'Felidae', '480p', 54617023), (1, 'Dirty Dancing', '1440p', 56419563),
(1, 'Ragtime', '1440p', 12404457), (1, 'Oscar', '1440p', 49717246),
(1, 'Barb Wire', '2160p', 83761463), (1, 'Jason and the Argonauts', '2160p', 27364051),
(2, 'Carry on Cruising', '240p', 33226462), (2, 'Best of the Best', '240p', 62793858),
(2, 'Ecstasy (xtasis)', '240p', 73079415), (2, 'Go Go Tales', '480p', 48836837),
(2, 'Nights and Weekends', '1440p', 32708277),
(3, 'Coneheads', '480p', 92308213), (3, 'Silences of the Palace, The (Saimt el Qusur)', '480p', 52917945),
(3, 'Good Pick', '720p', 71890218), (3, 'Wuthering Heights', '720p', 19813053),
(3, 'Big Kahuna, The', '1080p', 28786846), (3, 'Work of Director Michel Gondry, The', '2160p', 18789351),
(3, 'My Best Friends', '2160p', 44347338);

-- Write your query for Question 46 here:
-- Expected Output: mac_address | streams | total_traffic
-- Sort by total_traffic in descending order.
-- Only include streams of "720p" quality or higher.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 47: SQL: Cloud Hosting Instances Performance Statistics
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS instances;
DROP TABLE IF EXISTS networks;

-- Create networks table
CREATE TABLE networks (
    id INT PRIMARY KEY,
    cidr VARCHAR(255)
);

-- Create instances table
CREATE TABLE instances (
    network_id INT,
    cpu_usage VARCHAR(255),
    memory_usage VARCHAR(255),
    network_usage VARCHAR(255),
    FOREIGN KEY (network_id) REFERENCES networks(id)
);

-- Insert data into networks
INSERT INTO networks (id, cidr) VALUES
(1, '24.77.36.156/9'),
(2, '74.213.138.70/7'),
(3, '167.244.163.58/29');

-- Insert data into instances
INSERT INTO instances (network_id, cpu_usage, memory_usage, network_usage) VALUES
(1, '20%', '74%', '74%'), (3, '26%', '9%', '99%'), (3, '2%', '21%', '97%'),
(1, '51%', '19%', '89%'), (2, '2%', '27%', '79%'), (3, '92%', '35%', '41%'),
(2, '27%', '5%', '44%'), (3, '67%', '47%', '79%'), (1, '14%', '28%', '43%'),
(3, '47%', '0%', '53%'), (1, '38%', '3%', '46%'), (2, '71%', '51%', '6%'),
(3, '77%', '74%', '53%'), (3, '31%', '48%', '80%'), (2, '31%', '42%', '24%'),
(1, '77%', '65%', '46%'), (2, '51%', '94%', '41%'), (3, '8%', '3%', '57%'),
(1, '1%', '56%', '62%'), (2, '15%', '66%', '65%');

-- Write your query for Question 47 here:
-- Expected Output: cidr | instances | avg_cpu_usage | avg_memory_usage | avg_network_usage
-- Sort by cidr in ascending order.
-- Only include networks with at least one instance having cpu_usage of 80% or greater.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 48: SQL: AI Video Processing Service Usage Time Calculation
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS processes;
DROP TABLE IF EXISTS tasks;

-- Create tasks table
CREATE TABLE tasks (
    id INT PRIMARY KEY,
    hash VARCHAR(255)
);

-- Create processes table
CREATE TABLE processes (
    task_id INT,
    start_dt VARCHAR(19),
    end_dt VARCHAR(19),
    FOREIGN KEY(task_id) REFERENCES tasks(id)
);

-- Insert data into tasks
INSERT INTO tasks (id, hash) VALUES
(1, '208f95e0fcff792f617ade3cebf33ad9'),
(2, '0f44a9ffead2f18a7f25425c1260fc74'),
(3, 'dbcf54e94395c32e01ec09a5db731912');

-- Insert data into processes
INSERT INTO processes (task_id, start_dt, end_dt) VALUES
(1, '2023-04-20 02:01:16', '2023-04-20 02:11:35'), (1, '2023-04-09 15:11:10', '2023-04-09 15:26:43'),
(1, '2023-04-07 23:41:49', '2023-04-08 00:34:10'), (2, '2023-04-07 23:05:47', '2023-04-08 00:00:05'),
(2, '2023-04-19 18:39:33', '2023-04-19 18:54:57'), (2, '2023-04-28 13:17:11', '2023-04-28 13:24:37'),
(2, '2023-04-16 00:13:06', '2023-04-16 01:02:39'), (2, '2023-04-16 15:02:26', '2023-04-16 15:58:14'),
(2, '2023-04-27 02:23:07', '2023-04-27 02:59:13'), (2, '2023-04-10 23:33:47', '2023-04-11 00:09:35'),
(2, '2023-04-16 17:29:51', '2023-04-16 18:10:22'), (2, '2023-04-23 12:16:01', '2023-04-23 12:48:07'),
(3, '2023-04-01 02:25:12', '2023-04-01 02:49:26'), (3, '2023-04-04 03:02:43', '2023-04-04 03:42:03'),
(3, '2023-04-10 22:42:26', '2023-04-10 23:14:42'), (3, '2023-04-09 17:46:12', '2023-04-09 18:10:19'),
(3, '2023-04-25 15:09:36', '2023-04-25 15:19:54'), (3, '2023-04-19 14:39:52', '2023-04-19 15:21:23'),
(3, '2023-04-12 04:22:29', '2023-04-12 04:25:10'), (3, '2023-04-25 07:40:26', '2023-04-25 08:01:30');

-- Write your query for Question 48 here:
-- Expected Output: hash | usage_time
-- Sort by usage_time in descending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 49: SQL: Benchmarking Tool Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS devices;

-- Create devices table
CREATE TABLE devices (
    id INT PRIMARY KEY,
    score INT
);

-- Insert data into devices
INSERT INTO devices (id, score) VALUES
(1, 20),
(2, 50),
(3, 50),
(4, 68),
(5, 95);

-- Write your query for Question 49 here:
-- Expected Output: device
-- Sort by device ID in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 50: SQL: Smart Home Application Customer Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS readings;
DROP TABLE IF EXISTS tariffs;
DROP TABLE IF EXISTS accounts;

-- Create accounts table
CREATE TABLE accounts (
    id INT PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255)
);

-- Create tariffs table
CREATE TABLE tariffs (
    id INT PRIMARY KEY,
    name ENUM('A','B','C','D','E'),
    cost DECIMAL(4,3)
);

-- Create readings table
CREATE TABLE readings (
    account_id INT,
    tariff_id INT,
    amount SMALLINT,
    FOREIGN KEY (account_id) REFERENCES accounts(id),
    FOREIGN KEY (tariff_id) REFERENCES tariffs(id)
);

-- Insert data into accounts
INSERT INTO accounts (id, username, email) VALUES
(1, 'hshillabeare0', 'rcalkin0@sourceforge.net'),
(2, 'sdandy1', 'agaule1@businessweek.com'),
(3, 'sgreiswood2', 'toppy2@lulu.com');

-- Insert data into tariffs
INSERT INTO tariffs (id, name, cost) VALUES
(1, 'A', 0.010),
(2, 'B', 0.020),
(3, 'C', 0.050),
(4, 'D', 0.075),
(5, 'E', 0.100);

-- Insert data into readings
INSERT INTO readings (account_id, tariff_id, amount) VALUES
(1, 2, 54), (1, 3, 19), (1, 3, 37), (1, 3, 89), (1, 3, 119),
(2, 1, 12), (2, 1, 44), (2, 1, 81), (2, 2, 60), (2, 2, 164),
(2, 2, 199), (2, 3, 79), (2, 5, 186),
(3, 1, 31), (3, 1, 59), (3, 1, 77), (3, 1, 95), (3, 1, 110),
(3, 1, 125), (3, 2, 31);

-- Write your query for Question 50 here:
-- Expected Output: username | email | highest_tariff | consumption | total_cost
-- Sort by username in ascending order.

-- Your query here:
-- SELECT ...