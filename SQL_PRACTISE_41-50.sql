-- =====================================================
-- QUESTION 41: SQL: Expected Cash Flow Analysis
-- =====================================================
-- This query uses standard SQL aggregates and is compatible with PostgreSQL without changes.

DROP TABLE IF EXISTS cash_flows;
DROP TABLE IF EXISTS investors;

CREATE TABLE investors (
    id INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE
);

CREATE TABLE cash_flows (
    investor_id INT,
    expected_flow DECIMAL(8,2),
    FOREIGN KEY(investor_id) REFERENCES investors(id)
);

INSERT INTO investors (id, email) VALUES
(1, 'tdowner0@timesonline.co.uk'), (2, 'cgarza1@opera.com'), (3, 'nbarwise2@si.edu');

INSERT INTO cash_flows (investor_id, expected_flow) VALUES
(1, 24923.83), (1, 30212.10), (1, 87126.50), (1, 56018.65), (1, 93357.47), (1, 55073.54), (1, 27095.07),
(2, 44165.12), (2, 43658.84), (2, 35835.34), (2, 12660.46), (2, 58676.60), (2, 95929.25), (2, 47161.23),
(2, 80283.91), (2, 54427.20), (2, 93223.98),
(3, 19741.35), (3, 12243.25), (3, 50470.06);

-- Solution for Question 41:
SELECT
    i.email,
    COUNT(cf.investor_id) AS investment_count,
    SUM(cf.expected_flow) AS total_expected_flow,
    (MAX(cf.expected_flow) - MIN(cf.expected_flow)) AS range_expected_flow
FROM
    investors i
JOIN
    cash_flows cf ON i.id = cf.investor_id
GROUP BY
    i.email
HAVING
    SUM(cf.expected_flow) > 100000
ORDER BY
    i.email ASC;

---
-- =====================================================
-- QUESTION 42: SQL: Online Store Coupon Codes Report
-- =====================================================

DROP TABLE IF EXISTS coupon_uses;
DROP TABLE IF EXISTS coupons;

CREATE TABLE coupons (
    id INT PRIMARY KEY,
    coupon_code VARCHAR(255) UNIQUE,
    description VARCHAR(255),
    is_enabled BOOLEAN -- Changed from SMALLINT to BOOLEAN
);

CREATE TABLE coupon_uses (
    coupon_id INT,
    amount DECIMAL(4,2),
    FOREIGN KEY(coupon_id) REFERENCES coupons(id)
);

INSERT INTO coupons (id, coupon_code, description, is_enabled) VALUES
(1, 'COUPON123', 'nisi nam ultrices libero non', FALSE),
(2, 'SAVE20', 'ac est lacinia', TRUE),
(3, 'DISCOUNT50', 'quis odio consequat', TRUE);

INSERT INTO coupon_uses (coupon_id, amount) VALUES
(1, 36.68), (1, 3.56), (1, 2.10), (1, 39.58), (2, 39.81), (2, 24.07), (2, 28.42),
(2, 31.03), (2, 3.24), (2, 36.33), (3, 8.89), (3, 30.44), (3, 36.94), (3, 42.65),
(3, 33.61), (3, 41.92), (3, 1.78), (3, 20.26), (3, 27.92), (3, 0.23);

-- Solution for Question 42:
SELECT
    c.coupon_code,
    c.description,
    COUNT(cu.coupon_id) AS total_uses,
    MIN(cu.amount) AS min_discount,
    MAX(cu.amount) AS max_discount,
    ROUND(AVG(cu.amount), 2) AS avg_discount
FROM
    coupons c
JOIN
    coupon_uses cu ON c.id = cu.coupon_id
WHERE
    c.is_enabled = TRUE
GROUP BY
    c.coupon_code, c.description
ORDER BY
    c.coupon_code ASC;

---
-- =====================================================
-- QUESTION 43: SQL: Freelancer Platform Yearly Income Report
-- =====================================================

DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS freelancers;
DROP TABLE IF EXISTS professions;

-- Create a custom TYPE for project status since PostgreSQL doesn't have inline ENUM
CREATE TYPE project_status AS ENUM('Completed','Ongoing','Cancelled');

CREATE TABLE professions ( id INT PRIMARY KEY, title VARCHAR(255) UNIQUE );
CREATE TABLE freelancers ( id INT PRIMARY KEY, profession_id INT, email VARCHAR(255) UNIQUE, FOREIGN KEY(profession_id) REFERENCES professions(id) );
CREATE TABLE projects ( id INT PRIMARY KEY, freelancer_id INT, status project_status, income DECIMAL(6,2), FOREIGN KEY(freelancer_id) REFERENCES freelancers(id) );

INSERT INTO professions (id, title) VALUES (1, 'Artificial Intelligence Engineer'), (3, 'Game Developer'), (2, 'Network Administrator');
INSERT INTO freelancers (id, profession_id, email) VALUES
(1, 1, 'lfernez0@microsoft.com'), (3, 2, 'mbrydone2@delicious.com'),
(4, 2, 'jhamp3@4shared.com'), (5, 3, 'cparfett4@twitter.com');
INSERT INTO projects (id, freelancer_id, status, income) VALUES
(5, 1, 'Completed', 8562.13), (11, 1, 'Completed', 6727.56), (10, 3, 'Completed', 3753.46),
(20, 3, 'Completed', 6659.39), (6, 4, 'Completed', 8459.28), (13, 4, 'Completed', 5899.31),
(16, 4, 'Completed', 2709.63), (4, 5, 'Completed', 5029.44), (7, 5, 'Completed', 1763.94),
(9, 5, 'Completed', 6988.36), (8, 3, 'Cancelled', 8699.67), (1, 5, 'Cancelled', 5403.21),
(19, 3, 'Ongoing', 72.51), (3, 4, 'Ongoing', 8561.14), (15, 4, 'Ongoing', 9235.78), (17, 4, 'Ongoing', 4307.76);

-- Solution for Question 43:
SELECT
    prof.title,
    COUNT(proj.id) AS total_projects,
    SUM(proj.income) AS total_income,
    COUNT(DISTINCT f.id) AS total_freelancers,
    ROUND(SUM(proj.income) / COUNT(DISTINCT f.id), 2) AS average_income_per_freelancer
FROM
    professions prof
JOIN
    freelancers f ON prof.id = f.profession_id
JOIN
    projects proj ON f.id = proj.freelancer_id
WHERE
    proj.status = 'Completed'
GROUP BY
    prof.title
ORDER BY
    total_income DESC;

---
-- =====================================================
-- QUESTION 44: SQL: Ecommerce Warehouse Stock Report
-- =====================================================
-- This query is standard SQL and works in PostgreSQL without changes.

DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories ( id INT PRIMARY KEY, title VARCHAR(255) UNIQUE );
CREATE TABLE products ( id INT PRIMARY KEY, category_id INT, title VARCHAR(255), sku VARCHAR(255) UNIQUE, stock_number INT, FOREIGN KEY(category_id) REFERENCES categories(id) );

INSERT INTO categories (id, title) VALUES (1, 'Electronics'), (2, 'Clothing'), (3, 'Home & Kitchen');
INSERT INTO products (id, category_id, title, sku, stock_number) VALUES
(11, 1, 'Elegant Gadget', 'EG-11', 4), (3, 1, 'Luxury Gizmo', 'LG-3', 10), (19, 1, 'Sleek Widget', 'SW-19', 8), (8, 1, 'Sleek Widget', 'SW-8', 8),
(14, 2, 'Elegant Gadget', 'EG-14', 2), (16, 2, 'Elegant Gadget', 'EG-16', 6), (10, 2, 'Elegant Gadget', 'EG-10', 10),
(7, 2, 'Luxury Gizmo', 'LG-7', 3), (2, 2, 'Luxury Gizmo', 'LG-2', 8), (18, 2, 'Luxury Gizmo', 'LG-18', 9),
(1, 2, 'Sleek Widget', 'SW-1', 3), (6, 2, 'Sleek Widget', 'SW-6', 7),
(20, 3, 'Elegant Gadget', 'EG-20', 10), (9, 3, 'Luxury Gizmo', 'LG-9', 4), (12, 3, 'Luxury Gizmo', 'LG-12', 5),
(13, 3, 'Luxury Gizmo', 'LG-13', 5), (5, 3, 'Luxury Gizmo', 'LG-5', 9), (4, 3, 'Sleek Widget', 'SW-4', 8),
(15, 3, 'Sleek Widget', 'SW-15', 9), (17, 3, 'Sleek Widget', 'SW-17', 9);

-- Solution for Question 44:
SELECT
    c.title AS category,
    p.title,
    SUM(p.stock_number) AS total_stock
FROM
    categories c
JOIN
    products p ON c.id = p.category_id
GROUP BY
    c.title, p.title
HAVING
    SUM(p.stock_number) > 10
ORDER BY
    category ASC, title ASC, total_stock DESC;

---
-- =====================================================
-- QUESTION 45: SQL: Antivirus Database Quarantine Report
-- =====================================================

DROP TABLE IF EXISTS quarantine_urls;
DROP TABLE IF EXISTS threat_types;

CREATE TYPE url_status AS ENUM('Quarantined','Safe','Deleted');
CREATE TABLE threat_types ( id INT PRIMARY KEY, threat_type VARCHAR(255) );
CREATE TABLE quarantine_urls ( id INT PRIMARY KEY, threat_id INT, domain_name VARCHAR(255), status url_status, users_affected INT, FOREIGN KEY(threat_id) REFERENCES threat_types(id) );

INSERT INTO threat_types (id, threat_type) VALUES (1, 'Phishing'), (2, 'Rootkit'), (3, 'Malware');
INSERT INTO quarantine_urls (id, threat_id, domain_name, status, users_affected) VALUES
(17, 1, 'amazon.com', 'Quarantined', 862), (16, 1, 'google.com', 'Quarantined', 63), (9, 1, 'amazon.com', 'Quarantined', 41),
(18, 2, 'amazon.com', 'Quarantined', 149), (12, 2, 'yahoo.com', 'Quarantined', 967),
(4, 3, 'amazon.com', 'Quarantined', 377), (10, 3, 'yahoo.com', 'Quarantined', 721),
(11, 1, 'yahoo.com', 'Deleted', 551), (20, 1, 'amazon.com', 'Safe', 407), (19, 1, 'amazon.com', 'Deleted', 665),
(15, 1, 'facebook.com', 'Safe', 52), (2, 1, 'google.com', 'Safe', 309);

-- Solution for Question 45:
SELECT
    q.domain_name,
    t.threat_type,
    COUNT(q.id) AS total_occurrences,
    SUM(q.users_affected) AS total_users_affected
FROM
    quarantine_urls q
JOIN
    threat_types t ON q.threat_id = t.id
WHERE
    q.status = 'Quarantined'
GROUP BY
    q.domain_name, t.threat_type
ORDER BY
    total_users_affected DESC,
    q.domain_name ASC;

---
-- =====================================================
-- QUESTION 46: SQL: Online Streaming Service Traffic Report
-- =====================================================

DROP TABLE IF EXISTS streams;
DROP TABLE IF EXISTS clients;

CREATE TYPE stream_quality AS ENUM('240p','360p','480p','720p','1080p','1440p','2160p');
CREATE TABLE clients ( id INT PRIMARY KEY, mac_address VARCHAR(255) );
CREATE TABLE streams ( client_id INT, title VARCHAR(255), quality stream_quality, traffic INT, FOREIGN KEY(client_id) REFERENCES clients(id) );

INSERT INTO clients (id, mac_address) VALUES (1, '2F-80-8E-F2-0E-4C'), (2, 'A1-F7-D4-48-B9-E6'), (3, '9F-72-DB-7C-73-FC');
INSERT INTO streams (client_id, title, quality, traffic) VALUES
(1, 'Dirty Dancing', '1440p', 56419563), (1, 'Ragtime', '1440p', 12404457), (1, 'Oscar', '1440p', 49717246),
(1, 'Barb Wire', '2160p', 83761463), (1, 'Jason and the Argonauts', '2160p', 27364051),
(2, 'Nights and Weekends', '1440p', 32708277), (3, 'Good Pick', '720p', 71890218),
(3, 'Wuthering Heights', '720p', 19813053), (3, 'Big Kahuna, The', '1080p', 28786846),
(3, 'Work of Director Michel Gondry, The', '2160p', 18789351), (3, 'My Best Friends', '2160p', 44347338);

-- Solution for Question 46:
SELECT
    c.mac_address,
    COUNT(s.client_id) AS streams,
    SUM(s.traffic) AS total_traffic
FROM
    clients c
JOIN
    streams s ON c.id = s.client_id
WHERE
    s.quality >= '720p'
GROUP BY
    c.mac_address
ORDER BY
    total_traffic DESC;

---
-- =====================================================
-- QUESTION 47: SQL: Cloud Hosting Instances Performance Statistics
-- =====================================================

DROP TABLE IF EXISTS instances;
DROP TABLE IF EXISTS networks;
CREATE TABLE networks ( id INT PRIMARY KEY, cidr VARCHAR(255) );
CREATE TABLE instances ( network_id INT, cpu_usage VARCHAR(255), memory_usage VARCHAR(255), network_usage VARCHAR(255), FOREIGN KEY (network_id) REFERENCES networks(id) );
INSERT INTO networks VALUES (1, '24.77.36.156/9'), (2, '74.213.138.70/7'), (3, '167.244.163.58/29');
INSERT INTO instances VALUES
(1, '20%', '74%', '74%'), (3, '26%', '9%', '99%'), (3, '2%', '21%', '97%'),
(1, '51%', '19%', '89%'), (2, '2%', '27%', '79%'), (3, '92%', '35%', '41%'),
(2, '27%', '5%', '44%'), (3, '67%', '47%', '79%'), (1, '14%', '28%', '43%'),
(3, '47%', '0%', '53%'), (1, '38%', '3%', '46%'), (2, '71%', '51%', '6%'),
(3, '77%', '74%', '53%'), (3, '31%', '48%', '80%'), (2, '31%', '42%', '24%'),
(1, '77%', '65%', '46%'), (2, '51%', '94%', '41%'), (3, '8%', '3%', '57%'),
(1, '1%', '56%', '62%'), (2, '15%', '66%', '65%');

-- Solution for Question 47:
SELECT
    n.cidr,
    COUNT(i.network_id) AS instances,
    CEIL(AVG(TRIM(TRAILING '%' FROM i.cpu_usage)::numeric)) || '%' AS avg_cpu_usage,
    CEIL(AVG(TRIM(TRAILING '%' FROM i.memory_usage)::numeric)) || '%' AS avg_memory_usage,
    CEIL(AVG(TRIM(TRAILING '%' FROM i.network_usage)::numeric)) || '%' AS avg_network_usage
FROM
    networks n
JOIN
    instances i ON n.id = i.network_id
WHERE
    n.id IN (
        SELECT network_id FROM instances WHERE TRIM(TRAILING '%' FROM cpu_usage)::numeric >= 80
    )
GROUP BY
    n.cidr
ORDER BY
    n.cidr ASC;

---
-- =====================================================
-- QUESTION 48: SQL: AI Video Processing Service Usage Time Calculation
-- =====================================================

DROP TABLE IF EXISTS processes;
DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks ( id INT PRIMARY KEY, hash VARCHAR(255) );
CREATE TABLE processes ( task_id INT, start_dt VARCHAR(19), end_dt VARCHAR(19), FOREIGN KEY(task_id) REFERENCES tasks(id) );
INSERT INTO tasks VALUES
(1, '208f95e0fcff792f617ade3cebf33ad9'), (2, '0f44a9ffead2f18a7f25425c1260fc74'), (3, 'dbcf54e94395c32e01ec09a5db731912');
INSERT INTO processes VALUES
(1, '2023-04-20 02:01:16', '2023-04-20 02:11:35'), (1, '2023-04-09 15:11:10', '2023-04-09 15:26:43'),
(1, '2023-04-07 23:41:49', '2023-04-08 00:34:10'), (2, '2023-04-07 23:05:47', '2023-04-08 00:00:05'),
(2, '2023-04-19 18:39:33', '2023-04-19 18:54:57'), (2, '2023-04-28 13:17:11', '2023-04-28 13:24:37'),
(2, '2023-04-16 00:13:06', '2023-04-16 01:02:39'), (2, '2023-04-16 15:02:26', '2023-04-16 15:58:14'),
(2, '2023-04-27 02:23:07', '2023-04-27 02:59:13'), (2, '2023-04-10 23:33:47', '2023-04-11 00:09:35'),
(2, '2023-04-16 17:29:51', '2023-04-16 18:10:22'), (2, '2023-04-23 12:16:01', '2023-04-23 12:48:07'),
(3, '2023-04-01 02:25:12', '2023-04-01 02:49:26'), (3, '2023-04-04 03:02:43', '2023-04-04 03:42:03'),
(3, '2023-04-10 22:42:26', '2023-04-10 23:14:42'), (3, '2023-04-09 17:46:12', '2023-04-09 18:10:19');

-- Solution for Question 48:
SELECT
    t.hash,
    SUM(EXTRACT(EPOCH FROM (p.end_dt::timestamp - p.start_dt::timestamp)))::INT AS usage_time
FROM
    tasks t
JOIN
    processes p ON t.id = p.task_id
GROUP BY
    t.hash
ORDER BY
    usage_time DESC;

---
-- =====================================================
-- QUESTION 49: SQL: Benchmarking Tool Report
-- =====================================================
-- This solution is standard SQL and works in PostgreSQL without changes.

DROP TABLE IF EXISTS devices;
CREATE TABLE devices ( id INT PRIMARY KEY, score INT );
INSERT INTO devices (id, score) VALUES (1, 20), (2, 50), (3, 50), (4, 68), (5, 95);

-- Solution for Question 49:
SELECT
    'Device ' || id || ' has class: ' ||
    CASE
        WHEN score >= 80 THEN 'A'
        WHEN score >= 60 THEN 'B'
        WHEN score >= 40 THEN 'C'
        WHEN score >= 20 THEN 'D'
        ELSE 'F'
    END AS device
FROM
    devices
ORDER BY
    id ASC;

---
-- =====================================================
-- QUESTION 50: SQL: Smart Home Application Customer Report
-- =====================================================

DROP TABLE IF EXISTS readings;
DROP TABLE IF EXISTS tariffs;
DROP TABLE IF EXISTS accounts;

CREATE TYPE tariff_name AS ENUM('A','B','C','D','E');
CREATE TABLE accounts ( id INT PRIMARY KEY, username VARCHAR(255), email VARCHAR(255) );
CREATE TABLE tariffs ( id INT PRIMARY KEY, name tariff_name, cost DECIMAL(4,3) );
CREATE TABLE readings ( account_id INT, tariff_id INT, amount SMALLINT, FOREIGN KEY (account_id) REFERENCES accounts(id), FOREIGN KEY (tariff_id) REFERENCES tariffs(id) );

INSERT INTO accounts VALUES (1, 'hshillabeare0', 'rcalkin0@sourceforge.net'), (2, 'sdandy1', 'agaule1@businessweek.com'), (3, 'sgreiswood2', 'toppy2@lulu.com');
INSERT INTO tariffs VALUES (1, 'A', 0.010), (2, 'B', 0.020), (3, 'C', 0.050), (4, 'D', 0.075), (5, 'E', 0.100);
INSERT INTO readings VALUES
(1, 2, 54), (1, 3, 19), (1, 3, 37), (1, 3, 89), (1, 3, 119), (2, 1, 12), (2, 1, 44), (2, 1, 81), (2, 2, 60),
(2, 2, 164), (2, 2, 199), (2, 3, 79), (2, 5, 186), (3, 1, 31), (3, 1, 59), (3, 1, 77), (3, 1, 95),
(3, 1, 110), (3, 1, 125), (3, 2, 31);

-- Solution for Question 50:
WITH Aggregations AS (
    SELECT
        r.account_id,
        SUM(r.amount) as total_consumption,
        SUM(r.amount * t.cost) as total_cost,
        -- Find the tariff name with the highest cost for this user
        (SELECT t_sub.name FROM tariffs t_sub JOIN readings r_sub ON t_sub.id = r_sub.tariff_id WHERE r_sub.account_id = r.account_id ORDER BY t_sub.cost DESC LIMIT 1) AS highest_tariff
    FROM
        readings r
    JOIN
        tariffs t ON r.tariff_id = t.id
    GROUP BY
        r.account_id
)
SELECT
    a.username,
    a.email,
    agg.highest_tariff,
    agg.total_consumption AS consumption,
    to_char(agg.total_cost, 'FM999.00') AS total_cost
FROM
    accounts a
JOIN
    Aggregations agg ON a.id = agg.account_id
ORDER BY
    a.username ASC;
