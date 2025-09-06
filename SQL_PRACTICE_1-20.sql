-- =====================================================
-- QUESTION 1: SQL: User Failed Transaction Analysis
-- =====================================================

-- This solution is standard SQL and works in PostgreSQL without changes.

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    user_id INT,
    payment_method VARCHAR(255),
    amount DECIMAL(10,2),
    transaction_date DATE,
    status VARCHAR(255)
);
INSERT INTO transactions VALUES
(101, 202, 'Credit Card', 200.43, '2025-02-16', 'Completed'),
(102, 203, 'Netbanking', 3233.10, '2025-03-11', 'Failed'),
(103, 203, 'Netbanking', 1195.35, '2025-02-24', 'Failed'),
(104, 203, 'Debit Card', 376.11, '2025-03-10', 'Failed'),
(105, 203, 'Netbanking', 112.01, '2025-04-04', 'Failed'),
(106, 203, 'Credit Card', 111.10, '2025-09-12', 'Failed'),
(107, 203, 'Debit Card', 2344.50, '2025-10-03', 'Failed');

-- Solution for Question 1:
SELECT
    user_id,
    COUNT(transaction_id) AS failed_transactions,
    COUNT(DISTINCT payment_method) AS distinct_payment_methods
FROM
    transactions
WHERE
    status = 'Failed'
GROUP BY
    user_id
HAVING
    COUNT(transaction_id) > 5;

---
-- =====================================================
-- QUESTION 2: SQL: Average Response Time
-- =====================================================

DROP TABLE IF EXISTS support_tickets;
CREATE TABLE support_tickets (
    id INT PRIMARY KEY,
    customer_id INT,
    created_at VARCHAR(19),
    resolved_at VARCHAR(19)
);
INSERT INTO support_tickets VALUES
(1, 1, '2023-12-21 05:42:00', '2024-01-01 05:42:00'),
(2, 2, '2023-07-08 14:22:00', NULL),
(3, 3, '2023-05-22 08:54:00', '2023-06-17 08:54:00');

-- Solution for Question 2:
SELECT
    to_char(
        AVG(EXTRACT(EPOCH FROM (resolved_at::timestamp - created_at::timestamp)) / 3600),
        'FM999999.00'
    ) AS average_response_time
FROM
    support_tickets
WHERE
    resolved_at IS NOT NULL;

---
-- =====================================================
-- QUESTION 3: SQL: Highest-Spending Customers per City
-- =====================================================

-- The use of FLOOR is standard, but in PostgreSQL, you might need to cast the result.
-- The rest of the query is standard window function syntax.

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT PRIMARY KEY, name VARCHAR(255), city VARCHAR(255) );
CREATE TABLE orders ( id INT PRIMARY KEY, customer_id INT, amount DECIMAL(10,2), FOREIGN KEY(customer_id) REFERENCES customers(id) );
INSERT INTO customers VALUES (1, 'Customer 1', 'Los Angeles'), (2, 'Customer 2', 'Chicago'), (3, 'Customer 3', 'Chicago');
INSERT INTO orders VALUES (1, 1, 150.75), (2, 2, 230.50), (3, 3, 345.25);

-- Solution for Question 3:
WITH CustomerSpending AS (
    SELECT
        c.id AS customer_id,
        c.name,
        c.city,
        SUM(o.amount) AS total_amount,
        RANK() OVER (PARTITION BY c.city ORDER BY SUM(o.amount) DESC) as rnk
    FROM
        customers c
    JOIN
        orders o ON c.id = o.customer_id
    GROUP BY
        c.id, c.name, c.city
)
SELECT
    customer_id,
    name,
    city,
    FLOOR(total_amount)::INT AS total_spending
FROM
    CustomerSpending
WHERE
    rnk = 1;

---
-- =====================================================
-- QUESTION 4: SQL: E-commerce Product Request Report
-- =====================================================

-- Changed SMALLINT to BOOLEAN for is_available, as it's more idiomatic in PostgreSQL.

DROP TABLE IF EXISTS requests;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT NOT NULL PRIMARY KEY, name VARCHAR(255), category VARCHAR(255), is_available BOOLEAN );
CREATE TABLE requests ( product_id INT, client_email VARCHAR(255), FOREIGN KEY(product_id) REFERENCES products(id) );
INSERT INTO products VALUES
(1, 'PromoPro', 'beauty products', TRUE),
(2, 'AdVantage', 'outdoor gear', TRUE),
(3, 'MarketMagnet', 'sports equipment', TRUE),
(5, 'AdBlitz', 'beauty products', FALSE);
INSERT INTO requests VALUES
(1, 'salgate1@fc2.com'), (1, 'lwycliff6@list-manage.com'), (1, 'ekimbleyf@scientificamerican.com'),
(2, 'bgooro@spotify.com'), (2, 'vsamwayest@bbb.org'), (3, 'apappin0@yellowbook.com'),
(3, 'ringreyb@businessinsider.com'), (3, 'mrysonm@istockphoto.com'), (5, 'ayushin1c@opera.com'),
(5, 'bcoulston1q@hubpages.com');

-- Solution for Question 4:
SELECT
    p.name AS product_name,
    COUNT(r.product_id) AS total_requests
FROM
    products p
JOIN
    requests r ON p.id = r.product_id
WHERE
    p.is_available = TRUE
GROUP BY
    p.name
ORDER BY
    total_requests DESC,
    product_name ASC;

---
-- =====================================================
-- QUESTION 5: SQL: Active Campaign Engagement Report
-- =====================================================

-- Changed SMALLINT to BOOLEAN for is_active.

DROP TABLE IF EXISTS engagements;
DROP TABLE IF EXISTS campaigns;
CREATE TABLE campaigns ( id INT NOT NULL PRIMARY KEY, name VARCHAR(255), is_active BOOLEAN );
CREATE TABLE engagements ( campaign_id INT, views INT, clicks INT, FOREIGN KEY(campaign_id) REFERENCES campaigns(id) );
INSERT INTO campaigns VALUES (1, 'SummerSavings', TRUE), (2, 'FallFrenzy', TRUE), (3, 'WinterWonderland', FALSE);
INSERT INTO engagements VALUES
(1, 100, 10), (1, 150, 20), (2, 200, 30), (2, 250, 40), (3, 300, 50),
(1, 120, 15), (2, 180, 25), (3, 220, 35), (1, 130, 18), (2, 210, 28);

-- Solution for Question 5:
SELECT
    c.name AS campaign_name,
    COUNT(e.campaign_id) AS total_engagements,
    SUM(e.views + e.clicks) AS total_views_and_clicks
FROM
    campaigns c
JOIN
    engagements e ON c.id = e.campaign_id
WHERE
    c.is_active = TRUE
GROUP BY
    c.name
ORDER BY
    campaign_name ASC;

---
-- =====================================================
-- QUESTION 6: SQL: Tax Report Summary
-- =====================================================

DROP TABLE IF EXISTS reports;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts ( id INT NOT NULL PRIMARY KEY, email VARCHAR(255) );
CREATE TABLE reports ( account_id INT, dt VARCHAR(19), amount DECIMAL(6, 2), FOREIGN KEY(account_id) REFERENCES accounts(id) );
INSERT INTO accounts VALUES (1, 'hratke0@disqus.com'), (2, 'lcaiger1@si.edu'), (3, 'gburkett2@vinaora.com');
INSERT INTO reports VALUES
(1, '2023-05-27 01:46:19', 830.45), (2, '2023-01-15 09:23:21', 2518.18),
(3, '2023-05-08 01:44:41', 4637.39), (1, '2023-06-30 15:02:03', 3953.69),
(2, '2023-12-05 04:39:31', 3357.99), (3, '2023-02-03 09:41:00', 1907.38),
(1, '2022-12-30 04:05:57', 1217.29), (2, '2024-01-24 14:18:07', 2441.66),
(3, '2024-01-05 23:19:31', 3055.21), (1, '2023-05-26 01:54:24', 2077.36);

-- Solution for Question 6:
SELECT
    a.email,
    to_char(SUM(r.amount), 'FM999999.00') AS total_report_amount
FROM
    accounts a
JOIN
    reports r ON a.id = r.account_id
WHERE
    EXTRACT(YEAR FROM r.dt::timestamp) = 2023
GROUP BY
    a.email
ORDER BY
    a.email ASC;

---
-- =====================================================
-- QUESTION 7: SQL: Antivirus Device Scan Report
-- =====================================================

-- Changed SMALLINT to INTEGER for is_infected, as SUM() is used on it.

DROP TABLE IF EXISTS scanned_files;
DROP TABLE IF EXISTS devices;
CREATE TABLE devices ( id INT NOT NULL PRIMARY KEY, mac_address VARCHAR(255) );
CREATE TABLE scanned_files ( device_id INT, filename VARCHAR(255), is_infected INTEGER, FOREIGN KEY(device_id) REFERENCES devices(id) );
INSERT INTO devices VALUES (1, '66-0F-84-41-B8-8E'), (2, 'A6-1A-2F-3A-7B-83'), (3, '76-CD-24-48-F0-DD');
INSERT INTO scanned_files VALUES
(1, 'File1.mp3', 0), (1, 'File2.xls', 1), (2, 'File3.doc', 0), (2, 'File4.ppt', 1),
(2, 'File5.mp3', 1), (3, 'File6.xls', 0), (3, 'File7.doc', 1), (3, 'File8.ppt', 0),
(3, 'File9.mp3', 1), (3, 'File10.xls', 0);

-- Solution for Question 7:
SELECT
    d.mac_address,
    COUNT(s.filename) AS total_files_scanned,
    SUM(s.is_infected) AS total_infected_files
FROM
    devices d
JOIN
    scanned_files s ON d.id = s.device_id
GROUP BY
    d.mac_address
ORDER BY
    d.mac_address ASC;

---
-- =====================================================
-- QUESTION 8: SQL: Cryptocurrency Transactions Report
-- =====================================================

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS coins;
CREATE TABLE coins ( id INT NOT NULL PRIMARY KEY, name VARCHAR(255) );
CREATE TABLE transactions ( coin_id INT, dt VARCHAR(19), amount DECIMAL(5, 2), FOREIGN KEY(coin_id) REFERENCES coins(id) );
INSERT INTO coins VALUES (1, 'BitCash'), (2, 'Etherium'), (3, 'Litecoin');
INSERT INTO transactions VALUES
(1, '2023-07-03 12:16:53', 34.32), (1, '2023-12-08 12:14:58', 47.59),
(2, '2022-12-16 20:42:10', 45.54), (2, '2023-11-05 09:27:11', 53.30),
(3, '2023-12-05 06:45:23', 71.51), (3, '2023-01-19 01:43:25', 97.18),
(3, '2024-01-24 13:34:00', 86.68), (1, '2023-05-07 05:30:06', 25.60),
(2, '2023-03-08 08:07:20', 40.11), (3, '2023-08-13 10:44:54', 87.54);

-- Solution for Question 8:
SELECT
    c.name AS coin_name,
    to_char(SUM(t.amount), 'FM99999.00') AS total_transaction_amount,
    COUNT(t.coin_id) AS total_transactions
FROM
    coins c
JOIN
    transactions t ON c.id = t.coin_id
WHERE
    EXTRACT(YEAR FROM t.dt::timestamp) = 2023
GROUP BY
    c.name
ORDER BY
    c.name ASC;

---
-- =====================================================
-- QUESTION 9: SQL: Customer Domain Ownership Report
-- =====================================================

-- This solution is standard SQL and works in PostgreSQL without changes.

DROP TABLE IF EXISTS domains;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT NOT NULL PRIMARY KEY, email VARCHAR(255) );
CREATE TABLE domains ( customer_id INT, name VARCHAR(255), FOREIGN KEY(customer_id) REFERENCES customers(id) );
INSERT INTO customers VALUES
(1, 'ebayldon0@washingtonpost.com'), (2, 'agammade1@comcast.net'), (3, 'goloshkin2@reference.com'),
(4, 'cantonescu3@earthlink.net'), (5, 'fparzis4@ow.ly');
INSERT INTO domains VALUES
(1, 'bfilipa.net'), (1, 'gsparsholti.net'), (1, 'jhughsr.org'), (2, 'scopas8.net'),
(2, 'cglison1u.org'), (3, 'tginiz.com'), (3, 'arubinowitsch2l.net'), (3, 'clockyear2m.org'),
(4, 'sfinnigand.com'), (4, 'vborrelt.net');

-- Solution for Question 9:
SELECT
    c.email,
    COUNT(d.name) AS total_domains
FROM
    customers c
JOIN
    domains d ON c.id = d.customer_id
GROUP BY
    c.email
ORDER BY
    c.email ASC;

---
-- =====================================================
-- QUESTION 10: SQL: E-commerce Wishlist Report
-- =====================================================

-- Changed SMALLINT to BOOLEAN for in_stock.

DROP TABLE IF EXISTS wishlists;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT NOT NULL PRIMARY KEY, name VARCHAR(255), price DECIMAL(6, 2), in_stock BOOLEAN );
CREATE TABLE wishlists ( product_id INT, customer_email VARCHAR(255), FOREIGN KEY(product_id) REFERENCES products(id) );
INSERT INTO products VALUES
(1, 'TechGadget Pro X', 324.24, TRUE),
(2, 'LuxuryHome Decor Set', 884.90, TRUE),
(3, 'FitnessTracker Elite', 698.59, FALSE);
INSERT INTO wishlists VALUES
(1, 'user1@example.com'), (1, 'user2@example.com'), (2, 'user3@example.com'), (2, 'user4@example.com'),
(2, 'user5@example.com'), (3, 'user6@example.com'), (1, 'user7@example.com'), (1, 'user9@example.com');

-- Solution for Question 10:
SELECT
    p.name AS product_name,
    p.price,
    COUNT(w.product_id) AS total_wishlist_count
FROM
    products p
JOIN
    wishlists w ON p.id = w.product_id
WHERE
    p.in_stock = TRUE
GROUP BY
    p.name, p.price
ORDER BY
    product_name ASC;

---
-- =====================================================
-- QUESTION 11: SQL: Email Campaign Report
-- =====================================================

-- This solution is standard SQL and works in PostgreSQL without changes.

DROP TABLE IF EXISTS email_stats;
DROP TABLE IF EXISTS campaigns;
CREATE TABLE campaigns ( id INT NOT NULL PRIMARY KEY, name VARCHAR(255) );
CREATE TABLE email_stats ( campaign_id INT, emails_sent INT, emails_opened INT, FOREIGN KEY(campaign_id) REFERENCES campaigns(id) );
INSERT INTO campaigns VALUES (1, 'SummerSale2021'), (2, 'FallPromo'), (3, 'WinterWonderland');
INSERT INTO email_stats VALUES
(1, 1000, 800), (2, 1500, 1200), (3, 2000, 1800), (1, 500, 300), (2, 700, 500),
(3, 800, 600), (1, 300, 200), (2, 400, 300), (3, 600, 500), (3, 400, 300);

-- Solution for Question 11:
SELECT
    c.name AS campaign_name,
    SUM(e.emails_sent) AS total_emails_sent,
    SUM(e.emails_opened) AS total_emails_opened,
    SUM(e.emails_sent - e.emails_opened) AS total_emails_not_opened
FROM
    campaigns c
JOIN
    email_stats e ON c.id = e.campaign_id
GROUP BY
    c.name
ORDER BY
    campaign_name ASC;

---
-- =====================================================
-- QUESTION 12: SQL: Auction Lot Offers Report
-- =====================================================

DROP TABLE IF EXISTS offers;
DROP TABLE IF EXISTS lots;
CREATE TABLE lots ( id INT NOT NULL PRIMARY KEY, name VARCHAR(255) );
CREATE TABLE offers ( lot_id INT, amount DECIMAL(6, 2), FOREIGN KEY(lot_id) REFERENCES lots(id) );
INSERT INTO lots VALUES
(1, 'Acacia parramattensis Tindale'),
(2, 'Poa arctica R. Br. ssp. aperta (Scribn. & Merr.) Soreng'),
(3, 'Calophyllum inophyllum L.');
INSERT INTO offers VALUES
(1, 260.91), (1, 802.83), (1, 986.78), (2, 814.57), (2, 999.06),
(2, 414.67), (3, 200.41), (3, 593.07), (3, 701.88), (3, 972.87);

-- Solution for Question 12:
SELECT
    l.name AS lot_name,
    to_char(MAX(o.amount), 'FM9999.00') AS highest_offer,
    COUNT(o.lot_id) AS total_offers
FROM
    lots l
JOIN
    offers o ON l.id = o.lot_id
GROUP BY
    l.name
ORDER BY
    lot_name ASC;

---
-- =====================================================
-- QUESTION 13: SQL: Online Banking Transactions Report
-- =====================================================

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts ( id INT NOT NULL PRIMARY KEY, iban VARCHAR(255) );
CREATE TABLE transactions ( account_id INT, dt CHAR(19), amount DECIMAL(5, 2), FOREIGN KEY(account_id) REFERENCES accounts(id) );
INSERT INTO accounts VALUES
(1, 'BG40 RFFX 4898 53DD CZD6 KQ'), (2, 'PT42 5267 0592 8451 8001 2180 3'), (3, 'FR96 8758 8909 81LR DJ71 ERKN D56');
INSERT INTO transactions VALUES
(1, '2022-09-02 06:33:39', 33.31), (1, '2022-09-20 08:14:39', 31.77), (1, '2022-09-25 06:41:45', 72.84),
(2, '2022-09-04 22:28:12', 35.26), (2, '2022-09-17 07:57:29', 33.27), (2, '2022-09-27 22:30:36', 70.78),
(3, '2022-09-16 21:54:12', 75.04), (3, '2022-09-19 18:27:39', 71.19), (3, '2022-09-28 01:38:56', 14.34),
(3, '2022-08-30 01:35:31', 69.19);

-- Solution for Question 13:
SELECT
    a.iban AS IBAN,
    to_char(MIN(t.amount), 'FM999.00') AS min_transaction,
    to_char(MAX(t.amount), 'FM999.00') AS max_transaction,
    to_char(AVG(t.amount), 'FM999.00') AS avg_transaction,
    COUNT(t.account_id) AS total_transactions
FROM
    accounts a
JOIN
    transactions t ON a.id = t.account_id
WHERE
    t.dt LIKE '2022-09-%'
GROUP BY
    a.iban
ORDER BY
    IBAN ASC;

---
-- =====================================================
-- QUESTION 14: SQL: Top Wishlist Products Summary
-- =====================================================

-- Changed SMALLINT to BOOLEAN for in_stock.

DROP TABLE IF EXISTS wishlists;
DROP TABLE IF EXISTS products;
CREATE TABLE products ( id INT PRIMARY KEY, name VARCHAR(255), price DECIMAL(6,2), in_stock BOOLEAN );
CREATE TABLE wishlists ( product_id INT, customer_email VARCHAR(255), FOREIGN KEY(product_id) REFERENCES products(id) );
INSERT INTO products VALUES
(1, 'TechGadget Pro X', 274.80, TRUE), (2, 'LuxuryHome Decor Set', 262.84, TRUE),
(3, 'FitnessTracker Elite', 637.92, FALSE), (4, 'GourmetCookware Set', 535.34, TRUE),
(5, 'Fashionista Wardrobe Collection', 525.44, TRUE);
INSERT INTO wishlists VALUES
(1, 'a@a.com'), (1, 'b@b.com'), (1, 'c@c.com'), (1, 'd@d.com'), (2, 'e@e.com'),
(2, 'f@f.com'), (2, 'g@g.com'), (2, 'h@h.com'), (2, 'i@i.com'), (4, 'j@j.com'),
(4, 'k@k.com'), (4, 'l@l.com'), (4, 'm@m.com'), (5, 'n@n.com'), (5, 'o@o.com');

-- Solution for Question 14:
SELECT
    p.name,
    p.price,
    COUNT(w.product_id) AS total_wishes
FROM
    products p
JOIN
    wishlists w ON p.id = w.product_id
WHERE
    p.in_stock = TRUE
GROUP BY
    p.id, p.name, p.price
ORDER BY
    total_wishes DESC,
    p.name ASC
LIMIT 3;

---
-- =====================================================
-- QUESTION 15: SQL: E-commerce Customer Purchases Report
-- =====================================================

DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS customers;
CREATE TABLE customers ( id INT PRIMARY KEY, email VARCHAR(255) );
CREATE TABLE purchases ( customer_id INT, dt VARCHAR(19), amount DECIMAL(6,2), FOREIGN KEY(customer_id) REFERENCES customers(id) );
INSERT INTO customers VALUES
(1, 'floggie0@newsvine.com'), (2, 'sgillbe1@ca.gov'), (3, 'jgohn2@elegantthemes.com');
INSERT INTO purchases VALUES
(1, '2024-03-14 15:50:13', 109.16), (1, '2024-03-17 00:31:44', 11.49), (1, '2024-03-17 04:15:42', 692.64),
(2, '2024-03-01 04:35:09', 589.74), (2, '2024-03-13 14:42:23', 508.75), (2, '2024-03-17 07:57:36', 933.91),
(2, '2024-03-19 08:24:38', 488.26), (2, '2024-03-31 23:30:54', 55.07),
(3, '2024-03-03 11:34:30', 816.67), (3, '2024-03-08 23:46:07', 672.93), (3, '2024-03-15 18:09:56', 260.66),
(3, '2024-03-20 15:18:11', 321.07), (3, '2024-03-20 17:40:35', 29.06), (3, '2024-03-20 23:41:39', 314.85),
(3, '2024-03-25 11:41:07', 67.12);

-- Solution for Question 15:
SELECT
    c.email,
    COUNT(p.customer_id) AS total_purchases,
    to_char(SUM(p.amount), 'FM999999.00') AS total_purchase_amount
FROM
    customers c
JOIN
    purchases p ON c.id = p.customer_id
WHERE
    p.dt LIKE '2024-03-%'
GROUP BY
    c.email
ORDER BY
    c.email ASC;

---
-- =====================================================
-- QUESTION 16: SQL: Report on Applicants Pending Consular Service
-- =====================================================

DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS applicants;
CREATE TABLE applicants ( id INT PRIMARY KEY, email VARCHAR(255) );
CREATE TABLE appointments ( applicant_id INT, dt VARCHAR(19), is_received BOOLEAN, FOREIGN KEY(applicant_id) REFERENCES applicants(id) );
INSERT INTO applicants VALUES
(1, 'nkienzle0@spiegel.de'),(2, 'alaste1@bbc.co.uk'),(3, 'jjochanany2@ow.ly'),(4, 'bsenn3@salon.com'),(5, 'bwhittall4@nhs.uk');
INSERT INTO appointments VALUES
(1, '2024-04-27', FALSE),(2, '2024-04-01', FALSE),(3, '2024-04-15', FALSE),(4, '2024-03-27', FALSE),(5, '2024-03-26', TRUE);

-- Solution for Question 16:
SELECT
    a.email,
    ap.dt::date AS scheduled_appointment,
    ('2024-04-10'::date - ap.dt::date) AS days_of_delay
FROM
    applicants a
JOIN
    appointments ap ON a.id = ap.applicant_id
WHERE
    ap.is_received = FALSE AND ap.dt::date < '2024-04-10'::date
ORDER BY
    scheduled_appointment ASC,
    a.email ASC;

---
-- =====================================================
-- QUESTION 17: SQL: Weekend Appointments for Consular Services Rescheduling
-- =====================================================

DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS applicants;
CREATE TABLE applicants ( id INT PRIMARY KEY, email VARCHAR(255) );
CREATE TABLE appointments ( applicant_id INT, dt VARCHAR(19), FOREIGN KEY(applicant_id) REFERENCES applicants(id) );
INSERT INTO applicants VALUES
(1, 'rastlatt0@instagram.com'),(2, 'gcarmody1@stanford.edu'),(3, 'mgreenset2@state.tx.us');
INSERT INTO appointments VALUES
(1, '2024-05-26 01:36:43'),(2, '2024-05-27 16:30:28'),(3, '2024-05-18 19:28:52');

-- Solution for Question 17:
SELECT
    a.email,
    to_char(ap.dt::timestamp, 'Day') AS scheduled_appointment
FROM
    applicants a
JOIN
    appointments ap ON a.id = ap.applicant_id
WHERE
    EXTRACT(ISODOW FROM ap.dt::timestamp) IN (6, 7) -- 6=Saturday, 7=Sunday
ORDER BY
    a.email ASC;

---
-- =====================================================
-- QUESTION 18: SQL: Active Domains Registration by Country with Totals
-- =====================================================

-- This solution is standard SQL and works in PostgreSQL without changes (assuming is_active is BOOLEAN).

DROP TABLE IF EXISTS domains;
DROP TABLE IF EXISTS countries;
CREATE TABLE countries ( id INT PRIMARY KEY, name VARCHAR(255) );
CREATE TABLE domains ( country_id INT, name VARCHAR(255), is_active BOOLEAN, FOREIGN KEY(country_id) REFERENCES countries(id) );
INSERT INTO countries VALUES (1, 'Azerbaijan'),(2, 'Colombia'),(3, 'China');
INSERT INTO domains VALUES
(1, 'angelfire.com', TRUE),(1, 'free.fr', TRUE),(1, 'google.cn', TRUE),(1, 'nationalgeographic.com', TRUE),
(1, 'ovh.net', TRUE),(1, 'surveymonkey.com', TRUE),(1, 'twitpic.com', TRUE),(2, 'ameblo.jp', TRUE),
(2, 'berkeley.edu', TRUE),(2, 'multiply.com', TRUE),(2, 'redcross.org', TRUE),(2, 'sourceforge.net', TRUE),
(3, 'hc360.com', TRUE),(3, 'liveinternet.ru', TRUE),(3, 'squidoo.com', TRUE),(3, 'technorati.com', TRUE),
(3, 'webnode.com', TRUE),(3, 'yahoo.co.jp', TRUE),(1, '1und1.de', FALSE),(1, 'qq.com', FALSE);

-- Solution for Question 18:
SELECT
    c.name AS country_name,
    COUNT(d.name) AS total_domains
FROM
    countries c
JOIN
    domains d ON c.id = d.country_id
WHERE
    d.is_active = TRUE
GROUP BY
    c.name
ORDER BY
    country_name ASC;

---
-- =====================================================
-- QUESTION 19: SQL: Domain Renewal Overview
-- =====================================================

DROP TABLE IF EXISTS domains;
CREATE TABLE domains ( name VARCHAR(255), next_renewal_date VARCHAR(19) );
INSERT INTO domains VALUES
('wired.com', '2024-06-14 00:10:12'),
('blogger.com', '2024-07-18 05:54:57'),
('com.com', '2024-07-21 02:57:25');

-- Solution for Question 19:
SELECT
    name,
    '2024-04-10'::date AS today_date,
    next_renewal_date::date AS next_renewal_date,
    (next_renewal_date::date - '2024-04-10'::date) AS days_until_renewal
FROM
    domains
ORDER BY
    days_until_renewal ASC,
    name ASC;

---
-- =====================================================
-- QUESTION 20: SQL: User Transaction Details
-- =====================================================

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS users;
CREATE TABLE users ( id INT PRIMARY KEY, email VARCHAR(255) );
CREATE TABLE transactions ( user_id INT, dt VARCHAR(19), amount DECIMAL(5,2), FOREIGN KEY(user_id) REFERENCES users(id) );
INSERT INTO users VALUES
(1, 'bblaszczynski0@devhub.com'),(2, 'dwookey1@chronoengine.com'),(3, 'flerway2@wikipedia.org');
INSERT INTO transactions VALUES
(1, '2024-02-23 19:30:03', 942.50),(1, '2024-03-07 09:01:15', 855.22),(2, '2024-03-06 03:00:40', 413.39),
(2, '2024-03-07 14:41:03', 906.16),(2, '2024-03-10 00:58:13', 116.59),(2, '2024-03-13 23:38:29', 550.31),
(2, '2024-03-22 03:07:46', 196.23),(2, '2024-03-24 00:23:14', 399.76),(2, '2024-03-25 12:28:18', 398.07),
(2, '2024-03-27 09:11:15', 212.33),(3, '2024-03-01 17:24:48', 323.11),(3, '2024-03-05 10:16:06', 673.23),
(3, '2024-03-08 14:19:46', 236.74),(3, '2024-03-23 15:37:47', 234.87);

-- Solution for Question 20:
SELECT
    u.email,
    COUNT(t.user_id) AS total_transactions,
    to_char(MIN(t.amount), 'FM999.00') AS min_amount,
    to_char(MAX(t.amount), 'FM999.00') AS max_amount,
    to_char(SUM(t.amount), 'FM9999.00') AS total_amount
FROM
    users u
JOIN
    transactions t ON u.id = t.user_id
WHERE
    t.dt LIKE '2024-03-%'
GROUP BY
    u.email
ORDER BY
    u.email ASC;
