-- =====================================================
-- QUESTION 1: SQL: User Failed Transaction Analysis
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS transactions;

-- Create transactions table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    user_id INT,
    payment_method VARCHAR(255),
    amount DECIMAL(10,2),
    transaction_date DATE,
    status VARCHAR(255)
);

-- Insert data into transactions
INSERT INTO transactions (transaction_id, user_id, payment_method, amount, transaction_date, status) VALUES
(101, 202, 'Credit Card', 200.43, '2025-02-16', 'Completed'),
(102, 203, 'Netbanking', 3233.10, '2025-03-11', 'Failed'),
(103, 203, 'Netbanking', 1195.35, '2025-02-24', 'Failed'),
(104, 203, 'Debit Card', 376.11, '2025-03-10', 'Failed'),
(105, 203, 'Netbanking', 112.01, '2025-04-04', 'Failed'),
(106, 203, 'Credit Card', 111.10, '2025-09-12', 'Failed'),
(107, 203, 'Debit Card', 2344.50, '2025-10-03', 'Failed');

-- Write your query for Question 1 here:
-- Expected Output: user_id | failed_transactions | distinct_payment_methods
-- Only include users with more than 5 failed transactions.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 2: SQL: Average Response Time
-- =====================================================

-- Drop table if it exists
DROP TABLE IF EXISTS support_tickets;

-- Create support_tickets table
CREATE TABLE support_tickets (
    id INT PRIMARY KEY,
    customer_id INT,
    created_at VARCHAR(19),
    resolved_at VARCHAR(19)
);

-- Insert data into support_tickets
INSERT INTO support_tickets (id, customer_id, created_at, resolved_at) VALUES
(1, 1, '2023-12-21 05:42:00', '2024-01-01 05:42:00'),
(2, 2, '2023-07-08 14:22:00', NULL),
(3, 3, '2023-05-22 08:54:00', '2023-06-17 08:54:00');

-- Write your query for Question 2 here:
-- Expected Output: average_response_time
-- Calculate the average response time in hours for resolved tickets.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 3: SQL: Highest-Spending Customers per City
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;


-- Create customers table
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    city VARCHAR(255)
);

-- Create orders table
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

-- Insert data into customers
INSERT INTO customers (id, name, city) VALUES
(1, 'Customer 1', 'Los Angeles'),
(2, 'Customer 2', 'Chicago'),
(3, 'Customer 3', 'Chicago');

-- Insert data into orders
INSERT INTO orders (id, customer_id, amount) VALUES
(1, 1, 150.75),
(2, 2, 230.50),
(3, 3, 345.25);

-- Write your query for Question 3 here:
-- Expected Output: customer_id | name | city | total_spending
-- Row order does not matter.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 4: SQL: E-commerce Product Request Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS requests;
DROP TABLE IF EXISTS products;

-- Create products table
CREATE TABLE products (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    category VARCHAR(255),
    is_available SMALLINT
);

-- Create requests table
CREATE TABLE requests (
    product_id INT,
    client_email VARCHAR(255),
    FOREIGN KEY(product_id) REFERENCES products(id)
);

-- Insert data into products
INSERT INTO products (id, name, category, is_available) VALUES
(1, 'PromoPro', 'beauty products', 1),
(2, 'AdVantage', 'outdoor gear', 1),
(3, 'MarketMagnet', 'sports equipment', 1),
(5, 'AdBlitz', 'beauty products', 0);

-- Insert data into requests
INSERT INTO requests (product_id, client_email) VALUES
(1, 'salgate1@fc2.com'),
(1, 'lwycliff6@list-manage.com'),
(1, 'ekimbleyf@scientificamerican.com'),
(2, 'bgooro@spotify.com'),
(2, 'vsamwayest@bbb.org'),
(3, 'apappin0@yellowbook.com'),
(3, 'ringreyb@businessinsider.com'),
(3, 'mrysonm@istockphoto.com'),
(5, 'ayushin1c@opera.com'),
(5, 'bcoulston1q@hubpages.com');

-- Write your query for Question 4 here:
-- Expected Output: product_name | total_requests
-- Sort by total_requests descending, then by product_name ascending.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 5: SQL: Active Campaign Engagement Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS engagements;
DROP TABLE IF EXISTS campaigns;

-- Create campaigns table
CREATE TABLE campaigns (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    is_active SMALLINT
);

-- Create engagements table
CREATE TABLE engagements (
    campaign_id INT,
    views INT,
    clicks INT,
    FOREIGN KEY(campaign_id) REFERENCES campaigns(id)
);

-- Insert data into campaigns
INSERT INTO campaigns (id, name, is_active) VALUES
(1, 'SummerSavings', 1),
(2, 'FallFrenzy', 1),
(3, 'WinterWonderland', 0);

-- Insert data into engagements
INSERT INTO engagements (campaign_id, views, clicks) VALUES
(1, 100, 10),
(1, 150, 20),
(2, 200, 30),
(2, 250, 40),
(3, 300, 50),
(1, 120, 15),
(2, 180, 25),
(3, 220, 35),
(1, 130, 18),
(2, 210, 28);

-- Write your query for Question 5 here:
-- Expected Output: campaign_name | total_engagements | total_views_and_clicks
-- Sort by campaign_name in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 6: SQL: Tax Report Summary
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS reports;
DROP TABLE IF EXISTS accounts;

-- Create accounts table
CREATE TABLE accounts (
    id INT NOT NULL PRIMARY KEY,
    email VARCHAR(255)
);

-- Create reports table
CREATE TABLE reports (
    account_id INT,
    dt VARCHAR(19),
    amount DECIMAL(6, 2),
    FOREIGN KEY(account_id) REFERENCES accounts(id)
);

-- Insert data into accounts
INSERT INTO accounts (id, email) VALUES
(1, 'hratke0@disqus.com'),
(2, 'lcaiger1@si.edu'),
(3, 'gburkett2@vinaora.com');

-- Insert data into reports
INSERT INTO reports (account_id, dt, amount) VALUES
(1, '2023-05-27 01:46:19', 830.45),
(2, '2023-01-15 09:23:21', 2518.18),
(3, '2023-05-08 01:44:41', 4637.39),
(1, '2023-06-30 15:02:03', 3953.69),
(2, '2023-12-05 04:39:31', 3357.99),
(3, '2023-02-03 09:41:00', 1907.38),
(1, '2022-12-30 04:05:57', 1217.29),
(2, '2024-01-24 14:18:07', 2441.66),
(3, '2024-01-05 23:19:31', 3055.21),
(1, '2023-05-26 01:54:24', 2077.36);

-- Write your query for Question 6 here:
-- Expected Output: email | total_report_amount
-- Sort by email in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 7: SQL: Antivirus Device Scan Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS scanned_files;
DROP TABLE IF EXISTS devices;

-- Create devices table
CREATE TABLE devices (
    id INT NOT NULL PRIMARY KEY,
    mac_address VARCHAR(255)
);

-- Create scanned_files table
CREATE TABLE scanned_files (
    device_id INT,
    filename VARCHAR(255),
    is_infected SMALLINT,
    FOREIGN KEY(device_id) REFERENCES devices(id)
);

-- Insert data into devices
INSERT INTO devices (id, mac_address) VALUES
(1, '66-0F-84-41-B8-8E'),
(2, 'A6-1A-2F-3A-7B-83'),
(3, '76-CD-24-48-F0-DD');

-- Insert data into scanned_files
INSERT INTO scanned_files (device_id, filename, is_infected) VALUES
(1, 'File1.mp3', 0),
(1, 'File2.xls', 1),
(2, 'File3.doc', 0),
(2, 'File4.ppt', 1),
(2, 'File5.mp3', 1),
(3, 'File6.xls', 0),
(3, 'File7.doc', 1),
(3, 'File8.ppt', 0),
(3, 'File9.mp3', 1),
(3, 'File10.xls', 0);

-- Write your query for Question 7 here:
-- Expected Output: mac_address | total_files_scanned | total_infected_files
-- Sort by mac_address in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 8: SQL: Cryptocurrency Transactions Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS coins;

-- Create coins table
CREATE TABLE coins (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255)
);

-- Create transactions table
CREATE TABLE transactions (
    coin_id INT,
    dt VARCHAR(19),
    amount DECIMAL(5, 2),
    FOREIGN KEY(coin_id) REFERENCES coins(id)
);

-- Insert data into coins
INSERT INTO coins (id, name) VALUES
(1, 'BitCash'),
(2, 'Etherium'),
(3, 'Litecoin');

-- Insert data into transactions
INSERT INTO transactions (coin_id, dt, amount) VALUES
(1, '2023-07-03 12:16:53', 34.32),
(1, '2023-12-08 12:14:58', 47.59),
(2, '2022-12-16 20:42:10', 45.54),
(2, '2023-11-05 09:27:11', 53.30),
(3, '2023-12-05 06:45:23', 71.51),
(3, '2023-01-19 01:43:25', 97.18),
(3, '2024-01-24 13:34:00', 86.68),
(1, '2023-05-07 05:30:06', 25.60),
(2, '2023-03-08 08:07:20', 40.11),
(3, '2023-08-13 10:44:54', 87.54);

-- Write your query for Question 8 here:
-- Expected Output: coin_name | total_transaction_amount | total_transactions
-- Sort by coin_name in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 9: SQL: Customer Domain Ownership Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS domains;
DROP TABLE IF EXISTS customers;

-- Create customers table
CREATE TABLE customers (
    id INT NOT NULL PRIMARY KEY,
    email VARCHAR(255)
);

-- Create domains table
CREATE TABLE domains (
    customer_id INT,
    name VARCHAR(255),
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

-- Insert data into customers
INSERT INTO customers (id, email) VALUES
(1, 'ebayldon0@washingtonpost.com'),
(2, 'agammade1@comcast.net'),
(3, 'goloshkin2@reference.com'),
(4, 'cantonescu3@earthlink.net'),
(5, 'fparzis4@ow.ly'),
(6, 'cpetroulis5@shutterfly.com'),
(7, 'tbeels6@bbb.org'),
(8, 'zmacturlough7@4shared.com'),
(9, 'eshury8@skype.com'),
(10, 'jfehners9@github.io');

-- Insert data into domains
INSERT INTO domains (customer_id, name) VALUES
(1, 'bfilipa.net'),
(1, 'gsparsholti.net'),
(1, 'jhughsr.org'),
(2, 'scopas8.net'),
(2, 'cglison1u.org'),
(3, 'tginiz.com'),
(3, 'arubinowitsch2l.net'),
(3, 'clockyear2m.org'),
(4, 'sfinnigand.com'),
(4, 'vborrelt.net');

-- Write your query for Question 9 here:
-- Expected Output: email | total_domains
-- Sort by email in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 10: SQL: E-commerce Wishlist Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS wishlists;
DROP TABLE IF EXISTS products;

-- Create products table
CREATE TABLE products (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(6, 2),
    in_stock SMALLINT
);

-- Create wishlists table
CREATE TABLE wishlists (
    product_id INT,
    customer_email VARCHAR(255),
    FOREIGN KEY(product_id) REFERENCES products(id)
);

-- Insert data into products
INSERT INTO products (id, name, price, in_stock) VALUES
(1, 'TechGadget Pro X', 324.24, 1),
(2, 'LuxuryHome Decor Set', 884.90, 1),
(3, 'FitnessTracker Elite', 698.59, 0);

-- Insert data into wishlists
INSERT INTO wishlists (product_id, customer_email) VALUES
(1, 'user1@example.com'),
(1, 'user2@example.com'),
(2, 'user3@example.com'),
(2, 'user4@example.com'),
(2, 'user5@example.com'),
(3, 'user6@example.com'),
(1, 'user7@example.com'),
(2, 'user8@example.com'),
(1, 'user9@example.com'),
(3, 'user10@example.com');

-- Write your query for Question 10 here:
-- Expected Output: product_name | price | total_wishlist_count
-- Sort by product_name in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 11: SQL: Email Campaign Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS email_stats;
DROP TABLE IF EXISTS campaigns;

-- Create campaigns table
CREATE TABLE campaigns (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255)
);

-- Create email_stats table
CREATE TABLE email_stats (
    campaign_id INT,
    emails_sent INT,
    emails_opened INT,
    FOREIGN KEY(campaign_id) REFERENCES campaigns(id)
);

-- Insert data into campaigns
INSERT INTO campaigns (id, name) VALUES
(1, 'SummerSale2021'),
(2, 'FallPromo'),
(3, 'WinterWonderland');

-- Insert data into email_stats
INSERT INTO email_stats (campaign_id, emails_sent, emails_opened) VALUES
(1, 1000, 800),
(2, 1500, 1200),
(3, 2000, 1800),
(1, 500, 300),
(2, 700, 500),
(3, 800, 600),
(1, 300, 200),
(2, 400, 300),
(3, 600, 500),
(3, 400, 300);

-- Write your query for Question 11 here:
-- Expected Output: campaign_name | total_emails_sent | total_emails_opened | total_emails_not_opened
-- Sort by campaign_name in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 12: SQL: Auction Lot Offers Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS offers;
DROP TABLE IF EXISTS lots;

-- Create lots table
CREATE TABLE lots (
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255)
);

-- Create offers table
CREATE TABLE offers (
    lot_id INT,
    amount DECIMAL(6, 2),
    FOREIGN KEY(lot_id) REFERENCES lots(id)
);

-- Insert data into lots
INSERT INTO lots (id, name) VALUES
(1, 'Acacia parramattensis Tindale'),
(2, 'Poa arctica R. Br. ssp. aperta (Scribn. & Merr.) Soreng'),
(3, 'Calophyllum inophyllum L.');

-- Insert data into offers
INSERT INTO offers (lot_id, amount) VALUES
(1, 260.91),
(1, 802.83),
(1, 986.78),
(2, 814.57),
(2, 999.06),
(2, 414.67),
(3, 200.41),
(3, 593.07),
(3, 701.88),
(3, 972.87);

-- Write your query for Question 12 here:
-- Expected Output: lot_name | highest_offer | total_offers
-- Sort by lot_name in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 13: SQL: Online Banking Transactions Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;

-- Create accounts table
CREATE TABLE accounts (
    id INT NOT NULL PRIMARY KEY,
    iban VARCHAR(255)
);

-- Create transactions table
CREATE TABLE transactions (
    account_id INT,
    dt CHAR(19),
    amount DECIMAL(5, 2),
    FOREIGN KEY(account_id) REFERENCES accounts(id)
);

-- Insert data into accounts
INSERT INTO accounts (id, iban) VALUES
(1, 'BG40 RFFX 4898 53DD CZD6 KQ'),
(2, 'PT42 5267 0592 8451 8001 2180 3'),
(3, 'FR96 8758 8909 81LR DJ71 ERKN D56');

-- Insert data into transactions
INSERT INTO transactions (account_id, dt, amount) VALUES
(1, '2022-09-02 06:33:39', 33.31),
(1, '2022-09-20 08:14:39', 31.77),
(1, '2022-09-25 06:41:45', 72.84),
(2, '2022-09-04 22:28:12', 35.26),
(2, '2022-09-17 07:57:29', 33.27),
(2, '2022-09-27 22:30:36', 70.78),
(3, '2022-09-16 21:54:12', 75.04),
(3, '2022-09-19 18:27:39', 71.19),
(3, '2022-09-28 01:38:56', 14.34),
(3, '2022-08-30 01:35:31', 69.19);

-- Write your query for Question 13 here:
-- Expected Output: IBAN | min_transaction | max_transaction | avg_transaction | total_transactions
-- Sort by IBAN in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 14: SQL: Top Wishlist Products Summary
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS wishlists;
DROP TABLE IF EXISTS products;

-- Create products table
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    price DECIMAL(6,2),
    in_stock SMALLINT
);

-- Create wishlists table
CREATE TABLE wishlists (
    product_id INT,
    customer_email VARCHAR(255),
    FOREIGN KEY(product_id) REFERENCES products(id)
);

-- Insert data into products
INSERT INTO products (id, name, price, in_stock) VALUES
(1, 'TechGadget Pro X', 274.80, 1),
(2, 'LuxuryHome Decor Set', 262.84, 1),
(3, 'FitnessTracker Elite', 637.92, 0),
(4, 'GourmetCookware Set', 535.34, 1),
(5, 'Fashionista Wardrobe Collection', 525.44, 1);

-- Insert data into wishlists
INSERT INTO wishlists (product_id, customer_email) VALUES
(1, 'crabbec@redcross.org'),
(1, 'efindlow2@tinypic.com'),
(1, 'jmachoste5@issuu.com'),
(1, 'nselle@simplemachines.org'),
(2, 'aonn1@ebay.co.uk'),
(2, 'bbolton0@google.cn'),
(2, 'ebockett3@storify.com'),
(2, 'fdunguyg@symantec.com'),
(2, 'slowried@cbsnews.com'),
(3, 'jgately7@goo.ne.jp'),
(3, 'ospearettj@bandcamp.com'),
(3, 'rpanonsb@paypal.com'),
(3, 'ydevauxh@toplist.cz'),
(3, 'zbabbage9@imageshack.us'),
(4, 'dpauleya@cnbc.com'),
(4, 'jletterick4@dailymotion.com'),
(4, 'khunnisett6@princeton.edu'),
(4, 'rkernellf@uiuc.edu'),
(5, 'blodin8@wikimedia.org'),
(5, 'lyusupovi@nps.gov');

-- Write your query for Question 14 here:
-- Expected Output: name | price | total_wishes
-- Sort by total_wishes descending, then name ascending.
-- Limit to the top 3 products.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 15: SQL: E-commerce Customer Purchases Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS customers;

-- Create customers table
CREATE TABLE customers (
    id INT PRIMARY KEY,
    email VARCHAR(255)
);

-- Create purchases table
CREATE TABLE purchases (
    customer_id INT,
    dt VARCHAR(19),
    amount DECIMAL(6,2),
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

-- Insert data into customers
INSERT INTO customers (id, email) VALUES
(1, 'floggie0@newsvine.com'),
(2, 'sgillbe1@ca.gov'),
(3, 'jgohn2@elegantthemes.com');

-- Insert data into purchases
INSERT INTO purchases (customer_id, dt, amount) VALUES
(2, '2024-02-21 02:56:12', 228.58),
(2, '2024-02-23 09:32:47', 972.41),
(1, '2024-03-14 15:50:13', 109.16),
(1, '2024-03-17 00:31:44', 11.49),
(1, '2024-03-17 04:15:42', 692.64),
(2, '2024-03-01 04:35:09', 589.74),
(2, '2024-03-13 14:42:23', 508.75),
(2, '2024-03-17 07:57:36', 933.91),
(2, '2024-03-19 08:24:38', 488.26),
(2, '2024-03-31 23:30:54', 55.07),
(3, '2024-03-03 11:34:30', 816.67),
(3, '2024-03-08 23:46:07', 672.93),
(3, '2024-03-15 18:09:56', 260.66),
(3, '2024-03-20 15:18:11', 321.07),
(3, '2024-03-20 17:40:35', 29.06),
(3, '2024-03-20 23:41:39', 314.85),
(3, '2024-03-25 11:41:07', 67.12),
(1, '2024-04-05 03:05:10', 417.78),
(2, '2024-04-09 08:16:17', 697.53),
(3, '2024-04-02 07:56:48', 156.27);

-- Write your query for Question 15 here:
-- Expected Output: email | total_purchases | total_purchase_amount
-- Sort by email in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 16: SQL: Report on Applicants Pending Consular Service
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS applicants;

-- Create applicants table
CREATE TABLE applicants (
    id INT PRIMARY KEY,
    email VARCHAR(255)
);

-- Create appointments table
CREATE TABLE appointments (
    applicant_id INT,
    dt VARCHAR(19),
    is_received BOOLEAN,
    FOREIGN KEY(applicant_id) REFERENCES applicants(id)
);

-- Insert data into applicants
INSERT INTO applicants (id, email) VALUES
(1, 'nkienzle0@spiegel.de'),
(2, 'alaste1@bbc.co.uk'),
(3, 'jjochanany2@ow.ly'),
(4, 'bsenn3@salon.com'),
(5, 'bwhittall4@nhs.uk');

-- Insert data into appointments
INSERT INTO appointments (applicant_id, dt, is_received) VALUES
(1, '2024-04-27', 0),
(2, '2024-04-01', 0),
(3, '2024-04-15', 0),
(4, '2024-03-27', 0),
(5, '2024-03-26', 1);

-- Write your query for Question 16 here:
-- Expected Output: email | scheduled_appointment | days_of_delay
-- Sort by scheduled_appointment ascending, then email ascending.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 17: SQL: Weekend Appointments for Consular Services Rescheduling
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS applicants;

-- Create applicants table
CREATE TABLE applicants (
    id INT PRIMARY KEY,
    email VARCHAR(255)
);

-- Create appointments table
CREATE TABLE appointments (
    applicant_id INT,
    dt VARCHAR(19),
    FOREIGN KEY(applicant_id) REFERENCES applicants(id)
);

-- Insert data into applicants
INSERT INTO applicants (id, email) VALUES
(1, 'rastlatt0@instagram.com'),
(2, 'gcarmody1@stanford.edu'),
(3, 'mgreenset2@state.tx.us');

-- Insert data into appointments
INSERT INTO appointments (applicant_id, dt) VALUES
(1, '2024-05-26 01:36:43'),
(2, '2024-05-27 16:30:28'),
(3, '2024-05-18 19:28:52');

-- Write your query for Question 17 here:
-- Expected Output: email | scheduled_appointment
-- Sort by email in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 18: SQL: Active Domains Registration by Country with Totals
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS domains;
DROP TABLE IF EXISTS countries;

-- Create countries table
CREATE TABLE countries (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create domains table
CREATE TABLE domains (
    country_id INT,
    name VARCHAR(255),
    is_active BOOLEAN,
    FOREIGN KEY(country_id) REFERENCES countries(id)
);

-- Insert data into countries
INSERT INTO countries (id, name) VALUES
(1, 'Azerbaijan'),
(2, 'Colombia'),
(3, 'China');

-- Insert data into domains
INSERT INTO domains (country_id, name, is_active) VALUES
(1, 'angelfire.com', 1),
(1, 'free.fr', 1),
(1, 'google.cn', 1),
(1, 'nationalgeographic.com', 1),
(1, 'ovh.net', 1),
(1, 'surveymonkey.com', 1),
(1, 'twitpic.com', 1),
(2, 'ameblo.jp', 1),
(2, 'berkeley.edu', 1),
(2, 'multiply.com', 1),
(2, 'redcross.org', 1),
(2, 'sourceforge.net', 1),
(3, 'hc360.com', 1),
(3, 'liveinternet.ru', 1),
(3, 'squidoo.com', 1),
(3, 'technorati.com', 1),
(3, 'webnode.com', 1),
(3, 'yahoo.co.jp', 1),
(1, '1und1.de', 0),
(1, 'qq.com', 0);

-- Write your query for Question 18 here:
-- Expected Output: country_name | total_domains
-- Sort by country_name in ascending order.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 19: SQL: Domain Renewal Overview
-- =====================================================

-- Drop table if exists
DROP TABLE IF EXISTS domains;

-- Create domains table
CREATE TABLE domains (
    name VARCHAR(255),
    next_renewal_date VARCHAR(19)
);

-- Insert data into domains
INSERT INTO domains (name, next_renewal_date) VALUES
('wired.com', '2024-06-14 00:10:12'),
('blogger.com', '2024-07-18 05:54:57'),
('com.com', '2024-07-21 02:57:25');

-- Write your query for Question 19 here:
-- Expected Output: name | today_date | next_renewal_date | days_until_renewal
-- Sort by days_until_renewal ascending, then name ascending.

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 20: SQL: User Transaction Details
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(255)
);

-- Create transactions table
CREATE TABLE transactions (
    user_id INT,
    dt VARCHAR(19),
    amount DECIMAL(5,2),
    FOREIGN KEY(user_id) REFERENCES users(id)
);

-- Insert data into users
INSERT INTO users (id, email) VALUES
(1, 'bblaszczynski0@devhub.com'),
(2, 'dwookey1@chronoengine.com'),
(3, 'flerway2@wikipedia.org');

-- Insert data into transactions
INSERT INTO transactions (user_id, dt, amount) VALUES
(1, '2024-02-23 19:30:03', 942.50),
(1, '2024-03-07 09:01:15', 855.22),
(1, '2024-04-01 04:18:41', 253.35),
(1, '2024-04-07 02:40:58', 886.88),
(2, '2024-02-25 05:11:39', 957.77),
(2, '2024-03-06 03:00:40', 413.39),
(2, '2024-03-07 14:41:03', 906.16),
(2, '2024-03-10 00:58:13', 116.59),
(2, '2024-03-13 23:38:29', 550.31),
(2, '2024-03-22 03:07:46', 196.23),
(2, '2024-03-24 00:23:14', 399.76),
(2, '2024-03-25 12:28:18', 398.07),
(2, '2024-03-27 09:11:15', 212.33),
(2, '2024-04-09 06:33:26', 97.85),
(3, '2024-03-01 17:24:48', 323.11),
(3, '2024-03-05 10:16:06', 673.23),
(3, '2024-03-08 14:19:46', 236.74),
(3, '2024-03-23 15:37:47', 234.87),
(3, '2024-04-05 20:55:45', 989.35),
(3, '2024-04-07 05:26:35', 369.20);

-- Write your query for Question 20 here:
-- Expected Output: email | total_transactions | min_amount | max_amount | total_amount
-- Sort by email in ascending order.

-- Your query here:
-- SELECT ...