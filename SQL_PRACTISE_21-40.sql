-- =====================================================
-- QUESTION 21: SQL: Total Transactions and Sum for Each User
-- =====================================================

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS users;

CREATE TABLE users ( id INT PRIMARY KEY, email VARCHAR(255) );
INSERT INTO users (id, email) VALUES
(1, 'lvasilevich0@google.co.uk'),(2, 'hscholey1@sina.com.cn'),(3, 'mmcjury2@hibu.com');

CREATE TABLE transactions ( user_id INT, dt VARCHAR(19), amount DECIMAL(5,2), FOREIGN KEY(user_id) REFERENCES users(id) );
INSERT INTO transactions (user_id, dt, amount) VALUES
(3, '2022-12-05 00:16:56', 162.11),(1, '2023-05-20 03:20:58', 81.58),(1, '2023-06-08 19:24:02', 52.46),
(1, '2023-06-27 21:16:07', 447.59),(1, '2023-07-20 08:19:32', 136.68),(1, '2023-12-11 17:08:05', 852.55),
(1, '2023-12-15 04:45:54', 77.11),(1, '2023-12-22 00:46:34', 670.71),(1, '2023-12-29 12:43:23', 948.46),
(2, '2023-01-04 00:51:46', 793.50),(2, '2023-04-07 16:29:14', 762.52),(2, '2023-06-17 17:42:50', 527.18),
(2, '2023-10-10 11:16:51', 733.47),(2, '2023-10-18 23:32:00', 920.14),(3, '2023-03-27 18:31:41', 408.13),
(3, '2023-04-08 09:57:55', 817.88),(3, '2023-05-18 09:47:14', 916.98),(3, '2023-09-14 14:00:54', 53.30),
(3, '2023-09-30 01:34:01', 589.37),(3, '2024-01-27 15:13:58', 666.37);

-- Solution for Question 21:
SELECT
    u.email,
    COUNT(t.user_id) AS total_transactions,
    to_char(SUM(t.amount), 'FM999999.00') AS total_amount
FROM
    users u
JOIN
    transactions t ON u.id = t.user_id
WHERE
    EXTRACT(YEAR FROM t.dt::timestamp) = 2023
GROUP BY
    u.email
ORDER BY
    u.email ASC;

---
-- =====================================================
-- QUESTION 22: SQL: Top Cryptocurrencies by Average Transaction Amount
-- =====================================================

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS coins;

CREATE TABLE coins ( id INT PRIMARY KEY, name VARCHAR(255) );
INSERT INTO coins (id, name) VALUES
(1, 'BitCash'),(2, 'Etherium'),(3, 'Litecoin'),(4, 'Ripple'),(5, 'Dogecoin');
CREATE TABLE transactions ( coin_id INT, dt VARCHAR(19), amount DECIMAL(5,2), FOREIGN KEY(coin_id) REFERENCES coins(id) );
INSERT INTO transactions (coin_id, dt, amount) VALUES
(1, '2022-12-09 19:40:17', 60.91),(1, '2023-01-02 09:35:37', 76.35),(1, '2023-03-21 09:34:39', 23.11),
(1, '2023-08-11 03:43:27', 80.20),(1, '2023-10-21 19:42:46', 29.59),(2, '2023-07-08 19:47:20', 69.49),
(2, '2023-09-22 14:23:40', 23.13),(3, '2023-01-08 10:22:10', 72.45),(3, '2023-01-28 00:54:51', 98.72),
(3, '2023-02-24 00:13:32', 70.36),(3, '2023-05-16 15:13:19', 93.59),(4, '2023-05-24 13:43:44', 9.34),
(4, '2023-07-25 14:59:09', 78.52),(5, '2023-01-20 15:49:38', 81.66),(5, '2023-08-21 17:19:45', 94.89),
(5, '2023-10-25 00:44:42', 64.40),(5, '2023-11-30 02:38:47', 86.84),(5, '2023-12-31 03:26:39', 58.99);

-- Solution for Question 22:
SELECT
    c.name,
    to_char(AVG(t.amount), 'FM999.00') AS avg_transaction_amount
FROM
    coins c
JOIN
    transactions t ON c.id = t.coin_id
WHERE
    EXTRACT(YEAR FROM t.dt::timestamp) = 2023
GROUP BY
    c.name
ORDER BY
    AVG(t.amount) ASC
LIMIT 3;

---
-- =====================================================
-- QUESTION 23: SQL: Cryptocurrency Transactions Summary Report
-- =====================================================

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS coins;

CREATE TABLE coins ( id INT PRIMARY KEY, name VARCHAR(255) );
INSERT INTO coins (id, name) VALUES (1, 'BitCash'),(2, 'Etherium'),(3, 'Litecoin');
CREATE TABLE transactions ( coin_id INT, dt VARCHAR(19), amount DECIMAL(5,2), FOREIGN KEY(coin_id) REFERENCES coins(id) );
INSERT INTO transactions (coin_id, dt, amount) VALUES
(1, '2024-03-07 15:07:57', 73.45),(1, '2024-03-13 00:47:18', 2.10),(1, '2024-03-13 06:21:06', 5.68),
(1, '2024-03-14 15:06:59', 25.32),(1, '2024-03-20 02:10:37', 72.85),(2, '2024-03-09 12:06:47', 67.79),
(2, '2024-03-16 06:17:14', 82.87),(2, '2024-03-24 11:11:23', 5.96),(2, '2024-03-26 14:36:34', 21.80),
(3, '2024-03-20 08:28:56', 5.07),(3, '2024-03-23 06:45:13', 11.85),(3, '2024-03-27 02:40:23', 34.25),
(3, '2024-03-28 07:37:50', 81.12),(3, '2024-03-29 07:34:32', 19.06);

-- Solution for Question 23:
SELECT
    c.name,
    COUNT(t.coin_id) AS total_transactions,
    to_char(MIN(t.amount), 'FM999.00') AS min_amount,
    to_char(MAX(t.amount), 'FM999.00') AS max_amount,
    to_char(AVG(t.amount), 'FM999.00') AS avg_amount
FROM
    coins c
JOIN
    transactions t ON c.id = t.coin_id
WHERE
    EXTRACT(YEAR FROM t.dt::timestamp) = 2024 AND EXTRACT(MONTH FROM t.dt::timestamp) = 3
GROUP BY
    c.name
ORDER BY
    total_transactions DESC,
    name ASC;

---
-- =====================================================
-- QUESTION 24: SQL: Antivirus Suspicious File Extensions Report
-- =====================================================

DROP TABLE IF EXISTS suspicious_files;
CREATE TABLE suspicious_files ( filename VARCHAR(255), extension VARCHAR(255), scan_dt VARCHAR(19), is_suspicious BOOLEAN );
INSERT INTO suspicious_files VALUES
('Sapien.avi', '.avi', '2024-03-30 12:24:10', TRUE),('Pulvinar.doc', '.doc', '2024-03-08 22:00:41', TRUE),
('TemporConvallisNulla.gif', '.gif', '2024-03-29 21:32:41', TRUE),('InFaucibus.mp3', '.mp3', '2024-03-20 14:18:32', TRUE),
('AEleifendPedeLibero.ppt', '.ppt', '2024-03-05 04:47:56', TRUE),('VestibulumAnteIpsum.ppt', '.ppt', '2024-03-05 17:34:34', TRUE),
('IntegerPede.ppt', '.ppt', '2024-03-12 17:11:28', TRUE),('VenenatisNon.tiff', '.tiff', '2024-03-20 18:04:47', TRUE),
('IaculisDiam.xls', '.xls', '2024-03-01 05:18:03', TRUE),('QuisqueArcuLibero.xls', '.xls', '2024-03-09 09:00:32', TRUE),
('EratVestibulum.gif', '.gif', '2024-03-30 04:19:52', FALSE),('Neque.jpeg', '.jpeg', '2024-03-07 07:11:26', FALSE),
('VolutpatQuam.ppt', '.ppt', '2024-03-23 04:33:43', FALSE),('NonQuam.xls', '.xls', '2024-03-10 19:12:29', FALSE);

-- Solution for Question 24:
SELECT
    extension,
    COUNT(*) AS total_suspicious_files
FROM
    suspicious_files
WHERE
    is_suspicious = TRUE AND scan_dt LIKE '2024-03-%'
GROUP BY
    extension
ORDER BY
    total_suspicious_files DESC,
    extension ASC
LIMIT 5;

---
-- =====================================================
-- QUESTION 25: SQL: Antivirus Scanned Devices Report
-- =====================================================

DROP TABLE IF EXISTS devices;
DROP TABLE IF EXISTS clients;
CREATE TABLE clients ( id INT PRIMARY KEY, email VARCHAR(255) );
INSERT INTO clients VALUES (1, 'cbracegirdle0@irs.gov'),(2, 'gwickardt1@msu.edu'),(3, 'mpaulon2@edublogs.org');
CREATE TABLE devices ( client_id INT, mac_address VARCHAR(255), is_scanned BOOLEAN, scheduled_scan_dt VARCHAR(19), FOREIGN KEY(client_id) REFERENCES clients(id) );
INSERT INTO devices VALUES
(1, '37-FE-45-2B-9D-2A', TRUE, '2024-03-07 00:00:05'),(1, '13-82-F2-48-88-FD', TRUE, '2024-03-11 06:53:47'),
(1, '0D-56-2A-B2-33-EF', TRUE, '2024-03-30 19:41:31'),(2, 'CA-79-F4-B4-9E-69', FALSE, '2024-03-29 00:05:10'),
(3, '71-EB-63-A2-3C-AF', TRUE, '2024-03-03 07:50:20'),(3, '0B-40-DF-14-53-0F', TRUE, '2024-03-21 11:10:52'),
(3, '44-A5-56-27-C8-70', FALSE, '2024-03-28 21:15:26'),(3, '93-64-42-51-62-6F', FALSE, '2024-03-31 20:26:01');

-- Solution for Question 25:
SELECT
    c.email,
    COUNT(d.client_id) AS total_scanned_devices
FROM
    clients c
JOIN
    devices d ON c.id = d.client_id
WHERE
    d.is_scanned = TRUE AND d.scheduled_scan_dt LIKE '2024-03-%'
GROUP BY
    c.email
ORDER BY
    c.email ASC;

---
-- =====================================================
-- QUESTION 26: SQL: Resource Usage Report for Online Hosting Panel
-- =====================================================

DROP TABLE IF EXISTS site_metrics;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT PRIMARY KEY, email VARCHAR(255) );
INSERT INTO customers VALUES
(1, 'lrathke0@usa.gov'),(2, 'epearsall1@fema.gov'),(3, 'sivasechko2@cisco.com');
CREATE TABLE site_metrics ( customer_id INT, cpu_usage DECIMAL(5,2), memory_usage DECIMAL(5,2), disk_usage DECIMAL(5,2), FOREIGN KEY(customer_id) REFERENCES customers(id) );
INSERT INTO site_metrics VALUES
(1, 31.53, 80.84, 1.51),(1, 12.54, 26.47, 47.74),(1, 12.34, 46.24, 34.43),(1, 26.64, 84.98, 17.56),
(2, 80.45, 50.05, 10.63),(2, 40.14, 86.67, 15.98),(2, 30.14, 34.38, 17.67),(2, 1.11, 83.44, 2.95),
(3, 30.60, 18.60, 28.02),(3, 41.64, 33.64, 5.20),(3, 31.88, 7.37, 91.14),(3, 43.20, 9.56, 40.40);

-- Solution for Question 26:
SELECT
    c.email,
    to_char(AVG(sm.cpu_usage), 'FM999.00') AS average_cpu_usage,
    to_char(AVG(sm.memory_usage), 'FM999.00') AS average_memory_usage,
    to_char(AVG(sm.disk_usage), 'FM999.00') AS average_disk_usage
FROM
    customers c
JOIN
    site_metrics sm ON c.id = sm.customer_id
GROUP BY
    c.email
HAVING
    AVG(sm.cpu_usage) > 50 OR AVG(sm.memory_usage) > 50 OR AVG(sm.disk_usage) > 50
ORDER BY
    c.email ASC;

---
-- =====================================================
-- QUESTION 27: SQL: Dashboard Report for Online Hosting Customers Panel
-- =====================================================

DROP TABLE IF EXISTS sites;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT PRIMARY KEY, email VARCHAR(255) );
INSERT INTO customers VALUES
(1, 'dcristofol0@slashdot.org'),(2, 'mbillanie1@japanpost.jp'),(3, 'hmainz2@utexas.edu');
CREATE TABLE sites ( customer_id INT, url VARCHAR(255), is_active BOOLEAN, FOREIGN KEY(customer_id) REFERENCES customers(id) );
INSERT INTO sites VALUES
(1, 'https://trellian.com', TRUE),(1, 'https://www.google.de', TRUE),(1, 'https://merriam-webster.com', TRUE),
(1, 'https://wordpress.com', TRUE),(1, 'https://nsw.gov.au', TRUE),(1, 'https://www.barnesandnoble.com', TRUE),
(1, 'https://www.yahoo.com', TRUE),(2, 'https://cloudflare.com', FALSE),(2, 'https://www.is.gd', TRUE),
(2, 'https://www.unesco.org', TRUE),(3, 'https://www.sina.com.cn', FALSE),(3, 'https://xinhuanet.com', TRUE),
(3, 'https://cyberchimps.com', TRUE),(3, 'https://ask.com', TRUE),(3, 'https://businessinsider.com', TRUE),
(3, 'https://www.dailymail.co.uk', TRUE),(3, 'https://www.guardian.co.uk', TRUE),(3, 'https://www.microsoft.com', TRUE),
(3, 'https://www.gizmodo.com', TRUE),(3, 'https://www.163.com', TRUE);

-- Solution for Question 27:
SELECT
    c.email,
    COUNT(s.customer_id) AS total_active_sites
FROM
    customers c
JOIN
    sites s ON c.id = s.customer_id
WHERE
    s.is_active = TRUE
GROUP BY
    c.email
ORDER BY
    c.email ASC;

---
-- =====================================================
-- QUESTION 28: SQL: Average Income Report in Online Tax Application
-- =====================================================

DROP TABLE IF EXISTS income;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts ( id INT PRIMARY KEY, iban VARCHAR(255) );
INSERT INTO accounts VALUES
(1, 'SK39 8924 2092 2997 1101 4161'),(2, 'PL28 9141 8610 8442 2367 7521 0000'),
(3, 'CH93 8418 0F7G KQK4 NEHFQ'),(4, 'GT41 TBM8 DPFH MTNS BVW5 D4CX VIRR');
CREATE TABLE income ( account_id INT, dt VARCHAR(19), amount DECIMAL(6,2), FOREIGN KEY(account_id) REFERENCES accounts(id) );
INSERT INTO income VALUES
(1, '2024-01-17 16:43:20', 4061.53),(1, '2024-02-28 05:30:15', 4488.11),(2, '2024-01-08 04:48:45', 3640.82),
(2, '2024-01-20 17:31:20', 3385.15),(3, '2024-01-06 23:18:30', 2347.15),(3, '2024-03-08 12:53:20', 3814.86),
(4, '2024-01-02 23:52:06', 3526.08),(4, '2024-02-04 12:32:28', 2221.91),(4, '2024-02-11 19:44:53', 4197.07),
(4, '2024-03-06 06:28:34', 1357.44),(4, '2024-03-16 16:13:49', 1854.52);

-- Solution for Question 28:
SELECT
    a.iban,
    to_char(AVG(i.amount), 'FM9999.00') AS average_income,
    to_char(SUM(i.amount), 'FM99999.00') AS total_income
FROM
    accounts a
JOIN
    income i ON a.id = i.account_id
WHERE
    i.dt::timestamp BETWEEN '2024-01-01' AND '2024-03-31 23:59:59'
GROUP BY
    a.iban
ORDER BY
    AVG(i.amount) DESC,
    a.iban ASC
LIMIT 3;

---
-- =====================================================
-- QUESTION 29: SQL: Tax Calculation for Online Tax Application
-- =====================================================

DROP TABLE IF EXISTS income;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts ( id INT PRIMARY KEY, iban VARCHAR(255) );
INSERT INTO accounts VALUES
(1, 'FR55 4477 6154 73ND TN3F HMOU T36'),(2, 'DK46 1272 1831 2573 01'),(3, 'RS53 5237 5794 6016 5411 43');
CREATE TABLE income ( account_id INT, dt VARCHAR(19), amount DECIMAL(6,2), FOREIGN KEY(account_id) REFERENCES accounts(id) );
INSERT INTO income VALUES
(1, '2023-02-04 08:50:14', 1777.68),(1, '2023-02-13 04:22:07', 1954.81),(1, '2023-03-04 14:46:04', 1547.79),
(1, '2023-05-23 15:42:13', 1208.49),(1, '2023-05-24 23:24:07', 1521.72),(1, '2023-07-28 11:01:46', 1792.75),
(1, '2023-12-07 14:19:09', 2374.25),(2, '2023-02-17 00:59:57', 3074.11),(2, '2023-03-01 08:17:15', 1007.30),
(2, '2023-08-19 09:16:41', 4515.04),(3, '2023-05-09 07:28:27', 3158.66),(3, '2023-05-22 04:39:34', 3851.20),
(3, '2023-07-21 19:51:14', 4152.29),(3, '2023-10-05 05:42:49', 4722.20),(3, '2023-11-11 02:42:59', 1592.16);

-- Solution for Question 29:
SELECT
    a.iban,
    to_char(SUM(i.amount), 'FM999999.00') AS total_income,
    '20%' AS tax_rate,
    to_char(SUM(i.amount) * 0.20, 'FM999999.00') AS calculated_tax
FROM
    accounts a
JOIN
    income i ON a.id = i.account_id
WHERE
    EXTRACT(YEAR FROM i.dt::timestamp) = 2023
GROUP BY
    a.iban
ORDER BY
    a.iban ASC;

---
-- =====================================================
-- QUESTION 30: SQL: Monthly Budget Report for Online Budgeting Application
-- =====================================================

DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS income;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT PRIMARY KEY, email VARCHAR(255) );
INSERT INTO customers VALUES (1, 'otoohey0@elpais.com'),(2, 'egrebbin1@state.gov'),(3, 'arides2@sohu.com');
CREATE TABLE expenses ( customer_id INT, dt VARCHAR(19), amount DECIMAL(6,2), FOREIGN KEY(customer_id) REFERENCES customers(id) );
INSERT INTO expenses VALUES
(1, '2024-03-10 05:19:43', 442.01),(1, '2024-03-11 19:48:25', 327.35),(1, '2024-03-24 22:03:06', 639.62),
(1, '2024-03-29 00:37:46', 150.12),(2, '2024-03-11 15:34:19', 298.41),(2, '2024-03-25 04:36:27', 376.87),
(2, '2024-03-29 19:05:51', 530.07),(2, '2024-03-30 07:07:28', 287.84),(3, '2024-03-01 16:02:47', 33.30),
(3, '2024-03-06 11:53:42', 838.51),(3, '2024-03-20 23:34:48', 968.08),(3, '2024-03-21 21:18:08', 35.36),
(3, '2024-03-30 06:51:13', 956.12),(3, '2024-03-31 10:11:56', 896.32),(3, '2024-03-31 22:36:57', 740.94);
CREATE TABLE income ( customer_id INT, dt VARCHAR(19), amount DECIMAL(6,2), FOREIGN KEY(customer_id) REFERENCES customers(id) );
INSERT INTO income VALUES
(1, '2024-03-11 03:25:04', 769.38),(1, '2024-03-15 00:49:53', 84.10),(1, '2024-03-21 18:32:51', 839.48),
(1, '2024-03-29 15:34:13', 333.97),(2, '2024-03-19 09:24:47', 24.08),(2, '2024-03-20 15:54:24', 988.34),
(3, '2024-03-01 05:10:42', 962.60),(3, '2024-03-04 08:27:34', 30.21),(3, '2024-03-19 12:12:01', 80.00),
(3, '2024-03-21 00:32:10', 674.76),(3, '2024-03-23 14:14:32', 863.79);

-- Solution for Question 30:
WITH MarchExpenses AS (
    SELECT customer_id, SUM(amount) AS total_exp
    FROM expenses WHERE dt LIKE '2024-03-%' GROUP BY customer_id
), MarchIncome AS (
    SELECT customer_id, SUM(amount) AS total_inc
    FROM income WHERE dt LIKE '2024-03-%' GROUP BY customer_id
)
SELECT
    c.email,
    to_char(COALESCE(me.total_exp, 0), 'FM9999.00') AS total_expenses,
    to_char(COALESCE(mi.total_inc, 0), 'FM9999.00') AS total_income
FROM customers c
LEFT JOIN MarchExpenses me ON c.id = me.customer_id
LEFT JOIN MarchIncome mi ON c.id = mi.customer_id
ORDER BY c.email ASC;

---
-- =====================================================
-- QUESTION 31: SQL: Balance Report for Online Budgeting Application
-- =====================================================

DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS income;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT PRIMARY KEY, email VARCHAR(255) );
INSERT INTO customers VALUES
(1, 'dtollmache0@typepad.com'),(2, 'eclutterbuck1@baidu.com'),(3, 'mdensun2@ustream.tv');
CREATE TABLE expenses ( customer_id INT, amount DECIMAL(6,2), FOREIGN KEY(customer_id) REFERENCES customers(id) );
INSERT INTO expenses VALUES
(1, 136.18), (1, 323.28), (1, 383.37), (1, 505.41), (1, 841.21), (2, 5.23), (2, 408.33), (2, 489.45),
(2, 545.40), (2, 591.43), (2, 706.13), (2, 716.82), (2, 761.75), (2, 796.30), (3, 152.26),
(3, 211.30), (3, 447.57), (3, 685.03), (3, 966.89), (3, 967.30);
CREATE TABLE income ( customer_id INT, amount DECIMAL(6,2), FOREIGN KEY(customer_id) REFERENCES customers(id) );
INSERT INTO income VALUES
(1, 39.44), (1, 49.49), (1, 292.19), (1, 419.36), (1, 529.26), (1, 695.43), (1, 763.72), (1, 797.92),
(1, 833.34), (2, 139.42), (2, 422.18), (2, 506.59), (2, 566.00), (2, 697.92), (2, 938.51),
(3, 304.66), (3, 345.03), (3, 371.86), (3, 371.88), (3, 552.08);

-- Solution for Question 31:
WITH TotalExpenses AS (
    SELECT customer_id, SUM(amount) AS total_exp FROM expenses GROUP BY customer_id
), TotalIncome AS (
    SELECT customer_id, SUM(amount) AS total_inc FROM income GROUP BY customer_id
)
SELECT
    c.email,
    to_char((COALESCE(ti.total_inc, 0) - COALESCE(te.total_exp, 0)), 'FM9999.00') AS balance
FROM customers c
LEFT JOIN TotalIncome ti ON c.id = ti.customer_id
LEFT JOIN TotalExpenses te ON c.id = te.customer_id
WHERE (COALESCE(ti.total_inc, 0) - COALESCE(te.total_exp, 0)) < 0
ORDER BY c.email ASC;

---
-- =====================================================
-- QUESTION 32: SQL: Monthly Sales Report
-- =====================================================

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT PRIMARY KEY, name VARCHAR(255) );
INSERT INTO products VALUES (1, 'Luxury Gold Watch'),(2, 'Smartphone Holder Stand'),(3, 'Stainless Steel Water Bottle');
CREATE TABLE sales ( product_id INT, dt VARCHAR(19), amount DECIMAL(7,2), FOREIGN KEY(product_id) REFERENCES products(id) );
INSERT INTO sales VALUES
(1, '2024-01-13 17:12:22', 7008.16),(1, '2024-01-03 03:15:27', 6191.64),(1, '2024-01-22 18:29:09', 4527.86),
(1, '2024-01-26 19:38:53', 7828.36),(1, '2024-02-17 09:27:13', 5273.16),(1, '2024-02-11 09:51:24', 3364.73),
(1, '2024-02-22 23:53:15', 8584.33),(2, '2024-01-28 11:33:58', 3710.06),(2, '2024-01-25 14:47:25', 5221.02),
(2, '2024-01-21 07:58:53', 2525.72),(2, '2024-03-15 14:16:18', 8158.08),(2, '2024-03-12 17:02:01', 6760.77),
(3, '2024-01-13 19:27:51', 1942.79),(3, '2024-02-15 08:04:40', 9186.38),(3, '2024-03-06 08:02:37', 5821.97),
(3, '2024-03-03 15:39:18', 8676.24);

-- Solution for Question 32:
SELECT
    p.name,
    to_char(s.dt::timestamp, 'Month') AS month,
    to_char(SUM(s.amount), 'FM99999.00') AS total_sales
FROM
    products p
JOIN
    sales s ON p.id = s.product_id
WHERE
    s.dt::timestamp BETWEEN '2024-01-01' AND '2024-03-31 23:59:59'
GROUP BY
    p.name, month, EXTRACT(MONTH FROM s.dt::timestamp)
ORDER BY
    EXTRACT(MONTH FROM MIN(s.dt::timestamp)) ASC,
    SUM(s.amount) DESC;

---
-- =====================================================
-- QUESTION 33: SQL: IT Project Resource Analysis
-- =====================================================

-- This solution is standard SQL and should work in PostgreSQL with minimal changes.

DROP TABLE IF EXISTS projects_employees;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS projects;
CREATE TABLE projects ( id INT PRIMARY KEY, name VARCHAR(255) );
INSERT INTO projects VALUES (1, 'Project X'),(2, 'Sunshine Project'),(3, 'Blue Sky Initiative');
CREATE TABLE employees ( id INT PRIMARY KEY, ein VARCHAR(255), experience_years INT );
INSERT INTO employees VALUES (1, '62-0524667', 4),(2, '62-1435366', 1),(3, '29-3144922', 1),(4, '80-9606443', 1),(5, '63-6630813', 1);
CREATE TABLE projects_employees ( project_id INT, employee_id INT, FOREIGN KEY(project_id) REFERENCES projects(id), FOREIGN KEY(employee_id) REFERENCES employees(id) );
INSERT INTO projects_employees VALUES
(1, 1),(1, 1),(1, 2),(1, 3),(1, 5),(2, 1),(2, 1),(2, 2),(2, 5),(3, 1),(3, 1),(3, 2),
(3, 3),(3, 3),(3, 4),(3, 4),(3, 5),(3, 5),(3, 5),(3, 5);

-- Solution for Question 33:
WITH ProjectStats AS (
    SELECT
        p.name AS project_name,
        COUNT(pe.employee_id) AS employee_count,
        CEIL(AVG(e.experience_years)) AS avg_experience_years
    FROM projects p
    JOIN projects_employees pe ON p.id = pe.project_id
    JOIN employees e ON pe.employee_id = e.id
    GROUP BY p.name
)
SELECT
    project_name,
    employee_count,
    avg_experience_years::INT,
    CASE WHEN employee_count < 5 THEN 'Yes' ELSE 'No' END AS is_understaffed
FROM ProjectStats
WHERE avg_experience_years > 2
ORDER BY employee_count DESC, project_name ASC;

---
-- =====================================================
-- QUESTION 34: SQL: Ethereum Market Dashboard Analysis
-- =====================================================

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions ( dt VARCHAR(19), wallet VARCHAR(255), amount DECIMAL(4,2) );
INSERT INTO transactions VALUES
('2024-02-28 06:20:04', '0x1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c', -7.36),('2024-02-12 07:45:28', '0x1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c', -3.71),
('2024-02-25 10:49:54', '0x1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c', -3.53),('2024-02-03 19:43:00', '0x1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c', 4.01),
('2024-02-14 08:55:30', '0x1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c', 8.20),('2024-02-16 04:31:26', '0x3a4FbC5Df2E1bBfDdE5c4fA7bF8dE7aC1F', -8.96),
('2024-02-06 23:45:31', '0x3a4FbC5Df2E1bBfDdE5c4fA7bF8dE7aC1F', -7.88),('2024-02-11 01:00:35', '0x3a4FbC5Df2E1bBfDdE5c4fA7bF8dE7aC1F', -7.66),
('2024-02-25 09:39:01', '0x3a4FbC5Df2E1bBfDdE5c4fA7bF8dE7aC1F', -7.45),('2024-02-14 04:04:15', '0x3a4FbC5Df2E1bBfDdE5c4fA7bF8dE7aC1F', 4.17),
('2024-02-15 11:47:23', '0x3a4FbC5Df2E1bBfDdE5c4fA7bF8dE7aC1F', 7.56),('2024-02-24 14:58:54', '0x9B8aDc2eFf4cC3DdEe5f6a7B8dE9aC1F', -1.45),
('2024-02-18 21:17:24', '0x9B8aDc2eFf4cC3DdEe5f6a7B8dE9aC1F', 1.05),('2024-02-19 11:12:32', '0x9B8aDc2eFf4cC3DdEe5f6a7B8dE9aC1F', 3.67);

-- Solution for Question 34:
SELECT
    wallet,
    COUNT(*) AS total_transactions,
    to_char(SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END), 'FM99.00') AS total_bought,
    to_char(ABS(SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END)), 'FM99.00') AS total_sold
FROM
    transactions
WHERE
    dt LIKE '2024-02-%'
GROUP BY
    wallet
ORDER BY
    wallet ASC;

---
-- =====================================================
-- QUESTION 35: SQL: Employee Leave Tracker
-- =====================================================

DROP TABLE IF EXISTS leave_records;
DROP TABLE IF EXISTS employees;
CREATE TABLE employees ( id INT PRIMARY KEY, email VARCHAR(255) );
INSERT INTO employees VALUES
(1, 'jquartly0@macromedia.com'),(2, 'cchastand1@stanford.edu'),(3, 'lpuckrin2@creativecommons.org');
CREATE TABLE leave_records ( employee_id INT, leave_dt VARCHAR(19), days_taken INT, FOREIGN KEY(employee_id) REFERENCES employees(id) );
INSERT INTO leave_records VALUES
(1, '2023-05-19 04:40:25', 2),(1, '2023-12-25 16:29:51', 7),(1, '2023-03-12 18:54:29', 1),
(1, '2023-08-23 12:33:56', 6),(2, '2023-04-20 04:19:10', 5),(2, '2023-04-28 00:41:50', 7),
(3, '2023-06-11 18:49:25', 2),(3, '2023-12-23 15:53:10', 7),(3, '2023-03-13 13:46:16', 2),
(3, '2023-10-08 11:57:43', 2),(3, '2023-04-12 07:49:02', 4),(3, '2023-01-17 06:05:35', 6);

-- Solution for Question 35:
WITH LeaveSummary AS (
    SELECT
        e.email,
        SUM(lr.days_taken) AS leave_days_taken
    FROM employees e
    JOIN leave_records lr ON e.id = lr.employee_id
    WHERE lr.leave_dt LIKE '2023-%'
    GROUP BY e.email
)
SELECT
    email,
    leave_days_taken,
    CASE WHEN leave_days_taken <= 20 THEN 'Within Limit' ELSE 'Exceeded' END AS leave_status
FROM LeaveSummary
ORDER BY email ASC;

---
-- =====================================================
-- QUESTION 36: SQL: Email Platform Engagement Stats
-- =====================================================

DROP TABLE IF EXISTS email_stats;
DROP TABLE IF EXISTS campaigns;
CREATE TABLE campaigns ( id INT PRIMARY KEY, name VARCHAR(255) );
INSERT INTO campaigns VALUES (1, 'SummerSale2021'),(2, 'FallPromo'),(3, 'WinterWonderland');
CREATE TABLE email_stats ( campaign_id INT, emails_sent INT, emails_opened INT, FOREIGN KEY(campaign_id) REFERENCES campaigns(id) );
INSERT INTO email_stats VALUES
(1, 1749, 775),(1, 641, 423),(1, 976, 598),(1, 756, 121),(1, 975, 107),(1, 752, 367),
(1, 1068, 809),(1, 1046, 589),(1, 1212, 939),(1, 567, 214),(2, 1084, 283),
(2, 992, 478),(2, 1505, 604),(3, 899, 315),(3, 742, 554),(3, 1744, 917),
(3, 1163, 423),(3, 1501, 948),(3, 736, 451),(3, 537, 434);

-- Solution for Question 36:
SELECT
    c.name,
    SUM(es.emails_sent) AS total_emails_sent,
    SUM(es.emails_opened) AS total_emails_opened,
    to_char((SUM(es.emails_opened) * 100.0 / SUM(es.emails_sent)), 'FM99.00') AS open_rate
FROM
    campaigns c
JOIN
    email_stats es ON c.id = es.campaign_id
GROUP BY
    c.name
HAVING
    (SUM(es.emails_opened) * 100.0 / SUM(es.emails_sent)) > 50
ORDER BY
    (SUM(es.emails_opened) * 100.0 / SUM(es.emails_sent)) DESC,
    c.name ASC;

---
-- =====================================================
-- QUESTION 37: SQL: Bond Maturity Analysis
-- =====================================================

DROP TABLE IF EXISTS maturities;
DROP TABLE IF EXISTS bonds;
CREATE TABLE bonds ( id INT PRIMARY KEY, name VARCHAR(255) );
INSERT INTO bonds VALUES (1, 'Alpha Mortgage Bond'),(2, 'Beta Mortgage Bond'),(3, 'Gamma Mortgage Bond');
CREATE TABLE maturities ( bond_id INT, maturity DATE, FOREIGN KEY(bond_id) REFERENCES bonds(id) );
INSERT INTO maturities VALUES
(1, '2024-01-26'),(1, '2024-02-22'),(1, '2024-03-26'),(1, '2024-05-13'),(1, '2024-07-06'),
(1, '2024-08-23'),(1, '2024-09-06'),(1, '2024-11-30'),(1, '2024-12-30'),(1, '2025-04-30'),
(1, '2025-05-03'),(2, '2024-07-25'),(2, '2024-12-07'),(3, '2023-12-16'),(3, '2024-01-25');

-- Solution for Question 37:
SELECT
    b.name,
    COUNT(m.maturity) AS maturity_dates,
    MIN(m.maturity) AS earliest_maturity,
    MAX(m.maturity) AS latest_maturity,
    CEIL(AVG(m.maturity - '2023-09-13'::date))::INT AS avg_days_to_maturity
FROM
    bonds b
JOIN
    maturities m ON b.id = m.bond_id
GROUP BY
    b.name
HAVING
    AVG(m.maturity - '2023-09-13'::date) > 365
ORDER BY
    b.name ASC;

---
-- =====================================================
-- QUESTION 38: SQL: Bond Interest Rate Analysis
-- =====================================================

DROP TABLE IF EXISTS interest_rates;
DROP TABLE IF EXISTS bonds;
CREATE TABLE bonds ( id INT PRIMARY KEY, name VARCHAR(255) );
INSERT INTO bonds VALUES (1, 'Alpha Mortgage Bond'),(2, 'Beta Mortgage Bond'),(3, 'Gamma Mortgage Bond');
CREATE TABLE interest_rates ( bond_id INT, rate DECIMAL(2,1), FOREIGN KEY(bond_id) REFERENCES bonds(id) );
INSERT INTO interest_rates VALUES
(1, 1.4),(1, 1.8),(1, 2.0),(1, 2.4),(1, 3.4),(1, 4.6),(1, 4.7),(1, 4.9),(2, 2.0),(2, 2.1),
(2, 3.0),(2, 3.2),(2, 4.0),(3, 1.2),(3, 1.3),(3, 1.4),(3, 2.1),(3, 2.5),(3, 3.5),(3, 4.0);

-- Solution for Question 38:
SELECT
    b.name,
    COUNT(ir.rate) AS interest_rates,
    to_char(MIN(ir.rate), 'FM9.0') AS lowest_rate,
    to_char(MAX(ir.rate), 'FM9.0') AS highest_rate,
    to_char(AVG(ir.rate), 'FM9.00') AS avg_rate
FROM
    bonds b
JOIN
    interest_rates ir ON b.id = ir.bond_id
GROUP BY
    b.name
HAVING
    AVG(ir.rate) > 3
ORDER BY
    b.name ASC;

---
-- =====================================================
-- QUESTION 39: SQL: Bond Cash Flow Analysis for Bondholders
-- =====================================================

DROP TABLE IF EXISTS bondholders_bonds;
DROP TABLE IF EXISTS bonds;
DROP TABLE IF EXISTS bondholders;
CREATE TABLE bondholders ( id INT PRIMARY KEY, name VARCHAR(255) );
INSERT INTO bondholders VALUES (1, 'Alex Smith'),(2, 'Taylor Johnson'),(3, 'Jordan Davis');
CREATE TABLE bonds ( id INT PRIMARY KEY, name VARCHAR(255), annual_coupon DECIMAL(5,2), coupons_remaining INT );
INSERT INTO bonds VALUES
(1, 'Golden Bonds', 150.00, 4),(2, 'Silver Lining', 200.00, 2),(4, 'Emerald Wealth', 350.00, 5),
(5, 'Ruby Returns', 150.00, 8),(7, 'Amber Assurance', 100.00, 8),(11, 'Platinum Promise', 450.00, 9),
(15, 'Quartz Capital', 100.00, 2),(18, 'Peridot Portfolio', 300.00, 8);
CREATE TABLE bondholders_bonds ( bondholder_id INT, bond_id INT, FOREIGN KEY(bondholder_id) REFERENCES bondholders(id), FOREIGN KEY(bond_id) REFERENCES bonds(id) );
INSERT INTO bondholders_bonds VALUES (1, 1),(1, 2),(2, 4),(2, 5),(2, 7),(2, 11),(2, 15),(2, 18);

-- Solution for Question 39:
SELECT
    bh.name,
    to_char(SUM(b.annual_coupon * b.coupons_remaining), 'FM99999.00') AS total_cash_flow
FROM
    bondholders bh
JOIN
    bondholders_bonds bb ON bh.id = bb.bondholder_id
JOIN
    bonds b ON bb.bond_id = b.id
GROUP BY
    bh.name
HAVING
    SUM(b.annual_coupon * b.coupons_remaining) > 10000
ORDER BY
    SUM(b.annual_coupon * b.coupons_remaining) DESC;

---
-- =====================================================
-- QUESTION 40: SQL: Sum of the Cash Flows Analysis
-- =====================================================

DROP TABLE IF EXISTS cash_flows;
DROP TABLE IF EXISTS investors;
CREATE TABLE investors ( id INT PRIMARY KEY, email VARCHAR(255) UNIQUE );
INSERT INTO investors VALUES (1, 'ematson0@ebay.co.uk'),(2, 'lsalvadore1@msn.com'),(3, 'aclowser2@patch.com');
CREATE TABLE cash_flows ( investor_id INT, cash_flow DECIMAL(8,2), FOREIGN KEY(investor_id) REFERENCES investors(id) );
INSERT INTO cash_flows VALUES
(1, 184040.12),(1, 179280.08),(1, 179374.42),(1, 79302.21),(1, 87466.20),
(1, 194588.36),(1, 153563.92),(1, 56377.92),(2, 59039.14),(2, 167247.23),
(2, 59311.03),(2, 183883.00),(2, 118851.21),(3, 58868.62),(3, 96909.26);

-- Solution for Question 40:
SELECT
    i.email,
    COUNT(cf.investor_id) AS investments,
    MIN(cf.cash_flow) AS min_cash_flow,
    MAX(cf.cash_flow) AS max_cash_flow,
    to_char(AVG(cf.cash_flow), 'FM999999.00') AS avg_cash_flow
FROM
    investors i
JOIN
    cash_flows cf ON i.id = cf.investor_id
GROUP BY
    i.email
HAVING
    SUM(cf.cash_flow) > 1000000
ORDER BY
    i.email ASC;
