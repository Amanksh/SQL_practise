-- =====================================================
-- SQL Practice Questions 50-70
-- PostgreSQL/pgAdmin4 Compatible
-- =====================================================

-- =====================================================
-- QUESTION 50: Smart Home Application Customer Report
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
(1, 2, 54),
(1, 3, 19),
(1, 3, 37),
(1, 3, 89),
(1, 3, 119),
(2, 1, 12),
(2, 1, 44),
(2, 1, 81),
(2, 2, 60),
(2, 2, 164),
(2, 2, 199),
(2, 3, 79),
(2, 5, 186),
(3, 1, 31),
(3, 1, 59),
(3, 1, 77),
(3, 1, 95),
(3, 1, 110),
(3, 1, 125),
(3, 2, 31);

-- Write your query for Question 50 here:
-- Expected Output: username | email | highest_tariff | consumption | total_cost
-- Sort by username ascending

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 51: MMORPG Game Inventory Overload Notification
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS accounts_items;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS accounts;

-- Create accounts table
CREATE TABLE accounts (
    id INT PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255)
);

-- Create items table
CREATE TABLE items (
    id INT PRIMARY KEY,
    type ENUM('sword','shield','armor'),
    name VARCHAR(255),
    weight SMALLINT
);

-- Create accounts_items table
CREATE TABLE accounts_items (
    account_id INT,
    item_id INT,
    FOREIGN KEY (account_id) REFERENCES accounts(id),
    FOREIGN KEY (item_id) REFERENCES items(id)
);

-- Insert data into accounts
INSERT INTO accounts (id, username, email) VALUES
(1, 'esoane0', 'alefwich0@nytimes.com'),
(2, 'jrafter1', 'bmcniff1@census.gov'),
(3, 'rcawston2', 'fnickoll2@flickr.com');

-- Insert data into items
INSERT INTO items (id, type, name, weight) VALUES
(1, 'shield', 'Shield of Asteraceae', 3),
(2, 'sword', 'Sword of Cyperaceae', 3),
(3, 'shield', 'Shield of Apiaceae', 3),
(4, 'sword', 'Sword of Onagraceae', 3),
(5, 'sword', 'Sword of Campanulaceae', 3);

-- Insert data into accounts_items
INSERT INTO accounts_items (account_id, item_id) VALUES
(1, 2),
(1, 3),
(1, 3),
(1, 4),
(1, 4),
(1, 5),
(1, 5),
(1, 5),
(2, 1),
(2, 1),
(2, 2),
(2, 2),
(2, 2),
(2, 2),
(2, 2),
(2, 3),
(2, 3),
(2, 5),
(3, 3),
(3, 4);

-- Write your query for Question 51 here:
-- Expected Output: username | email | items | total_weight
-- Sort by total_weight descending, then username ascending
-- Only include accounts where total weight > 20

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 52: Outdoor Banner Digital Marketplace Placement Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS banners;
DROP TABLE IF EXISTS cities;

-- Create cities table
CREATE TABLE cities (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create banners table
CREATE TABLE banners (
    city_id INT,
    width SMALLINT,
    height SMALLINT,
    FOREIGN KEY (city_id) REFERENCES cities(id)
);

-- Insert data into cities
INSERT INTO cities (id, name) VALUES
(1, 'Kayu Agung'),
(2, 'Yangkou'),
(3, 'Marseille');

-- Insert data into banners
INSERT INTO banners (city_id, width, height) VALUES
(3, 6, 20),
(1, 20, 14),
(1, 6, 17),
(1, 15, 6),
(2, 16, 8),
(2, 6, 7),
(3, 6, 9),
(1, 20, 16),
(3, 19, 14),
(2, 9, 17),
(2, 8, 12),
(1, 12, 16),
(3, 15, 14),
(3, 11, 7),
(3, 6, 14),
(2, 12, 7),
(3, 7, 20),
(1, 13, 6),
(3, 10, 13),
(2, 19, 15);

-- Write your query for Question 52 here:
-- Expected Output: city | banners | min_area | avg_area | max_area | total_area
-- Sort by city ascending
-- Note: avg_area should be rounded up to nearest integer

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 53: Auction Web Service Lot Statistics
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS offers;
DROP TABLE IF EXISTS lots;

-- Create lots table
CREATE TABLE lots (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create offers table
CREATE TABLE offers (
    lot_id INT,
    amount DECIMAL(6,2),
    FOREIGN KEY (lot_id) REFERENCES lots(id)
);

-- Insert data into lots
INSERT INTO lots (id, name) VALUES
(1, 'Merremia quinquefolia (L.) Hallier f.'),
(2, 'Plantago maritima L.'),
(3, 'Hohenbergia antillana Mez'),
(4, 'Penstemon eriantherus Pursh var. argillosus M.E. Jones');

-- Insert data into offers
INSERT INTO offers (lot_id, amount) VALUES
(1, 510.51),
(2, 703.80),
(2, 181.80),
(1, 38.06),
(2, 368.78),
(3, 91.40),
(2, 413.80),
(3, 157.99),
(3, 885.82),
(2, 863.99),
(1, 307.61),
(2, 120.39),
(1, 771.96),
(2, 801.42),
(3, 871.59),
(1, 541.61),
(3, 477.62),
(2, 303.29),
(2, 612.83),
(3, 464.98);

-- Write your query for Question 53 here:
-- Expected Output: name | offers | min_offer | avg_offer | max_offer
-- Sort by offers descending
-- Note: Some lots may not have offers (show NULL for those)

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 54: Tax Calculator Web Service Simple Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS declarations;
DROP TABLE IF EXISTS accounts;

-- Create accounts table
CREATE TABLE accounts (
    id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    iban VARCHAR(255)
);

-- Create declarations table
CREATE TABLE declarations (
    account_id INT,
    quarter ENUM('Q1','Q2','Q3','Q4'),
    income DECIMAL(7,2),
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Insert data into accounts
INSERT INTO accounts (id, first_name, last_name, iban) VALUES
(1, 'Alex', 'Cantua', 'IL29 9590 1551 0560 0553 712'),
(2, 'Chris', 'Lashmore', 'AZ54 CNUI 01DR XEXZ ASKY QM4W F8JI'),
(3, 'Taylor', 'Blum', 'HR20 2041 7741 5014 9873 9'),
(4, 'Robin', 'Neachell', 'NL87 PPCD 0429 1849 92'),
(5, 'Drew', 'Barbier', 'FR72 7843 3990 42WM QC8P GVNV 78');

-- Insert data into declarations
INSERT INTO declarations (account_id, quarter, income) VALUES
(1, 'Q1', 49235.67),
(1, 'Q2', 46653.11),
(1, 'Q3', 63739.99),
(1, 'Q4', 43222.54),
(2, 'Q1', 69743.50),
(2, 'Q2', 29641.01),
(2, 'Q3', 97725.49),
(2, 'Q4', 91481.98),
(3, 'Q1', 68402.43),
(3, 'Q2', 12660.12),
(3, 'Q3', 59601.65),
(3, 'Q4', 54701.74),
(4, 'Q1', 55220.27),
(4, 'Q2', 87752.41),
(4, 'Q3', 44447.06),
(4, 'Q4', 45876.26),
(5, 'Q1', 42511.74),
(5, 'Q2', 22022.78),
(5, 'Q3', 88396.81),
(5, 'Q4', 67252.54);

-- Write your query for Question 54 here:
-- Expected Output: full_name | iban | income | rate | tax
-- Sort by full_name ascending
-- Note: Tax rate is 10% for all accounts, tax = income * 0.10

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 55: Social Network Relationship Statistics
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS relations;
DROP TABLE IF EXISTS profiles;

-- Create profiles table
CREATE TABLE profiles (
    id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255)
);

-- Create relations table
CREATE TABLE relations (
    profile_id INT,
    related_to VARCHAR(255),
    is_approved BOOLEAN,
    FOREIGN KEY (profile_id) REFERENCES profiles(id)
);

-- Insert data into profiles
INSERT INTO profiles (id, first_name, last_name, email) VALUES
(1, 'Shayne', 'Shilito', 'sshilito0@ftc.gov'),
(2, 'Shell', 'Shade', 'sshade1@paginegialle.it'),
(3, 'Nobie', 'Splain', 'nsplain2@npr.org');

-- Insert data into relations
INSERT INTO relations (profile_id, related_to, is_approved) VALUES
(1, 'cbasinigazzii', 1),
(1, 'ldevered', 1),
(1, 'edeniskeb', 1),
(1, 'cstirland4', 1),
(1, 'ngooddiea', 1),
(1, 'alockney7', 1),
(1, 'jsorrillj', 0),
(1, 'bnodin3', 0),
(1, 'dwall2', 0),
(1, 'folivas1', 0),
(2, 'ksharland6', 0),
(2, 'pbarosch8', 0),
(2, 'smacieja9', 0),
(2, 'bbrasonf', 0),
(2, 'dabrahartg', 0),
(3, 'gaymer5', 1),
(3, 'rwoolcockse', 1),
(3, 'egilyott0', 1),
(3, 'agillionc', 0),
(3, 'fgribbinh', 0);

-- Write your query for Question 55 here:
-- Expected Output: full_name | email | total_relations | approved_relations | pending_relations
-- Sort by full_name ascending
-- Note: is_approved = 1 means approved, is_approved = 0 means pending

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 56: Online Banking Transactions
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;

-- Create accounts table
CREATE TABLE accounts (
    id INT PRIMARY KEY,
    iban VARCHAR(255)
);

-- Create transactions table
CREATE TABLE transactions (
    account_id INT,
    dt DATETIME,
    amount DECIMAL(5,2),
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Insert data into accounts
INSERT INTO accounts (id, iban) VALUES
(1, 'SE48 2961 2087 8112 2835 6438'),
(2, 'BE89 2286 5514 4847'),
(3, 'MU84 HRGV 2047 2584 5774 3195 856J PZ');

-- Insert data into transactions
INSERT INTO transactions (account_id, dt, amount) VALUES
(2, '2022-09-25 19:24:50', 75.06),
(2, '2022-09-24 03:09:17', 41.10),
(1, '2022-09-19 04:13:17', 65.85),
(3, '2022-09-30 07:18:29', 44.57),
(1, '2022-09-26 01:51:44', 98.93),
(1, '2022-08-28 02:51:04', 60.42),
(1, '2022-08-25 23:25:54', 45.34),
(2, '2022-09-09 11:00:48', 11.05),
(3, '2022-08-25 19:37:02', 53.61),
(2, '2022-09-23 09:44:05', 89.18),
(1, '2022-08-28 19:48:40', 47.60),
(3, '2022-09-12 10:28:10', 96.40),
(3, '2022-10-03 16:49:51', 45.41),
(2, '2022-09-05 16:20:41', 46.78),
(3, '2022-10-03 04:51:29', 50.81),
(1, '2022-09-10 17:31:44', 78.72),
(2, '2022-08-31 21:59:56', 61.09),
(2, '2022-09-14 12:52:13', 20.36),
(1, '2022-09-28 11:05:21', 70.52),
(3, '2022-09-30 09:21:12', 48.00);

-- Write your query for Question 56 here:
-- Expected Output: iban | transactions | total
-- Sort by total descending
-- Note: Only include transactions in September 2022

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 57: Internet Service Provider Monthly Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS traffic;
DROP TABLE IF EXISTS clients;

-- Create clients table
CREATE TABLE clients (
    id SMALLINT PRIMARY KEY,
    mac VARCHAR(17),
    tariff DECIMAL(6,5)
);

-- Create traffic table
CREATE TABLE traffic (
    client_id SMALLINT,
    dt VARCHAR(19),
    amount INT,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

-- Insert data into clients
INSERT INTO clients (id, mac, tariff) VALUES
(1, 'A2-53-FC-0C-3E-B4', 0.00007),
(2, 'DC-80-42-E9-AE-FC', 0.00003),
(3, '3-9B-AF9-2A-B1-7B', 0.00007),
(4, 'D4-6F-E4-AF-47-D5', 0.00004),
(5, 'B9-65-C-8E-FF0-15', 0.00007);

-- Insert data into traffic
INSERT INTO traffic (client_id, dt, amount) VALUES
(1, '2022-05-22', 9127),
(1, '2022-06-07', 62203),
(1, '2022-06-10', 88227),
(2, '2022-05-31', 99874),
(2, '2022-06-01', 78400),
(2, '2022-06-03', 61106),
(2, '2022-06-12', 20963),
(2, '2022-06-29', 98304),
(2, '2022-07-04', 6626),
(3, '2022-05-22', 8386),
(3, '2022-06-08', 22959),
(3, '2022-07-05', 52096),
(3, '2022-07-14', 70777),
(4, '2022-05-22', 93743),
(5, '2022-05-16', 84660),
(5, '2022-05-28', 63267),
(5, '2022-06-10', 80681),
(5, '2022-06-21', 55460),
(5, '2022-07-04', 91365),
(5, '2022-07-09', 23296);

-- Write your query for Question 57 here:
-- Expected Output: mac | traffic | cost
-- Sort by cost descending
-- Note: Only include traffic in May 2022, cost = traffic * tariff

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 58: The Yellow Pages Companies Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS companies;

-- Create companies table
CREATE TABLE companies (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(255)
);

-- Create categories table
CREATE TABLE categories (
    company_id SMALLINT,
    name VARCHAR(255),
    review_rating SMALLINT,
    FOREIGN KEY (company_id) REFERENCES companies(id)
);

-- Insert data into companies
INSERT INTO companies (id, name, address, phone) VALUES
(1, 'Casper, Oberbrunner and Williamson', '53 Di Loreto Hill', '+420 (569) 566-3689'),
(2, 'Tromp, Kozey and Abbott', '84 Mcguire Plaza', '+62 (145) 722-2330'),
(3, 'Gerlach, Hayes and Stamm', '80 Service Point', '+86 (731) 234-4119'),
(4, 'Wolff-Fadel', '06 Fair Oaks Trail', '+7 (894) 233-0976'),
(5, 'Kihn-Cronin', '483 Nobel Road', '+1 (396) 693-1661');

-- Insert data into categories
INSERT INTO categories (company_id, name, review_rating) VALUES
(1, 'HVAC', 2),
(2, 'HVAC', 2),
(2, 'Retaining Wall and Brick Pavers', 1),
(2, 'Rebar & Wire Mesh Install', 2),
(3, 'Prefabricated Aluminum Metal Canopies', 2),
(3, 'Prefabricated Aluminum Metal Canopies', 0),
(3, 'RF Shielding', 2),
(3, 'Overhead Doors', 0),
(3, 'Rebar & Wire Mesh Install', 5),
(3, 'Termite Control', 0),
(4, 'Sitework & Site Utilities', 0),
(4, 'Electrical and Fire Alarm', 2),
(4, 'Masonry', 2),
(4, 'Temp Fencing, Decorative Fencing and Gates', 0),
(4, 'Elevator', 1),
(4, 'Drywall & Acoustical (FED)', 5),
(5, 'Asphalt Paving', 0),
(5, 'Glass & Glazing', 1),
(5, 'Framing (Steel)', 3),
(5, 'Structural & Misc Steel Erection', 1);

-- Write your query for Question 58 here:
-- Expected Output: name | address | phone | overall_review_rating
-- Sort by average rating descending, then name ascending
-- Format: "X.X (Y categories)" where X.X is average rating, Y is category count

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 59: Domain Name Registrar Accounts Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS domains;
DROP TABLE IF EXISTS accounts;

-- Create accounts table
CREATE TABLE accounts (
    id SMALLINT PRIMARY KEY,
    username VARCHAR(255),
    is_active SMALLINT
);

-- Create domains table
CREATE TABLE domains (
    account_id SMALLINT,
    name VARCHAR(255),
    expiration_date VARCHAR(19),
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Insert data into accounts
INSERT INTO accounts (id, username, is_active) VALUES
(1, 'obeedie0', 0),
(2, 'stopham1', 1),
(3, 'ndolder2', 1),
(4, 'jyanshinov3', 1),
(5, 'ewilflinger4', 0);

-- Insert data into domains
INSERT INTO domains (account_id, name, expiration_date) VALUES
(1, 'imgur.com', '2022-05-14'),
(1, 'domainmarket.com', '2022-07-02'),
(1, 'comsenz.com', '2022-07-28'),
(1, 'gizmodo.com', '2022-08-09'),
(1, 'toplist.cz', '2022-08-15'),
(1, 'scientificamerican.com', '2022-09-03'),
(1, 'examiner.com', '2022-12-18'),
(1, 'photobucket.com', '2023-01-22'),
(2, 'merriam-webster.com', '2022-02-20'),
(2, 'tripod.com', '2022-08-08'),
(3, 'ca.gov', '2022-04-24'),
(3, 'ehow.com', '2022-06-28'),
(3, 'purevolume.com', '2022-07-01'),
(3, 'squidoo.com', '2022-10-27'),
(3, 'eepurl.com', '2022-12-21'),
(4, 'digg.com', '2022-05-14'),
(4, 'jugem.jp', '2022-08-05'),
(4, 'artisteer.com', '2022-10-21'),
(5, 'behance.net', '2022-03-24'),
(5, 'cnn.com', '2022-05-11');

-- Write your query for Question 59 here:
-- Expected Output: username | domains | nearest_expiration
-- Sort by username ascending
-- Note: Only active accounts (is_active = 1) and domains not expired after July 15, 2022

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 60: Advertising Network Events Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS campaigns;

-- Create campaigns table
CREATE TABLE campaigns (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create events table
CREATE TABLE events (
    campaign_id SMALLINT,
    dt VARCHAR(19),
    value DECIMAL(6,5),
    FOREIGN KEY (campaign_id) REFERENCES campaigns(id)
);

-- Insert data into campaigns
INSERT INTO campaigns (id, name) VALUES
(1, '11-080 - Registration Equipment'),
(2, '12-700 - Systems Furniture'),
(3, '9-900 - Paints and Coatings');

-- Insert data into events
INSERT INTO events (campaign_id, dt, value) VALUES
(1, '2022-07-14 13:11:38', 0.59275),
(1, '2022-07-14 14:55:43', 0.12928),
(1, '2022-07-14 18:16:11', 0.82350),
(1, '2022-07-15 01:19:44', 0.97144),
(1, '2022-07-15 22:52:02', 0.60728),
(1, '2022-07-16 08:55:38', 0.71158),
(1, '2022-07-16 10:22:44', 0.29627),
(2, '2022-07-14 02:36:31', 0.42323),
(2, '2022-07-14 04:45:32', 0.91077),
(2, '2022-07-14 07:24:11', 0.35956),
(2, '2022-07-15 06:43:08', 0.16662),
(2, '2022-07-16 08:21:27', 0.02559),
(2, '2022-07-16 11:59:41', 0.34606),
(2, '2022-07-16 23:26:12', 0.62697),
(3, '2022-07-14 00:21:56', 0.97297),
(3, '2022-07-14 10:22:11', 0.93894),
(3, '2022-07-14 12:29:59', 0.44633),
(3, '2022-07-15 01:17:41', 0.37531),
(3, '2022-07-15 14:20:48', 0.24872),
(3, '2022-07-16 23:02:51', 0.80594);

-- Write your query for Question 60 here:
-- Expected Output: campaign | events | average_value
-- Sort by average_value descending
-- Note: Only events for July 15, 2022, and campaigns with average >= 0.7

-- Your query here:
-- SELECT ...

-- =====================================================
-- END OF QUESTIONS 50-60
-- =====================================================

-- =====================================================
-- QUESTION 61: Ecommerce Deal Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS deals;
DROP TABLE IF EXISTS profiles;

-- Create profiles table
CREATE TABLE profiles (
    id SMALLINT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255)
);

-- Create deals table
CREATE TABLE deals (
    profile_id SMALLINT,
    dt VARCHAR(19),
    amount DECIMAL(5,2),
    FOREIGN KEY (profile_id) REFERENCES profiles(id)
);

-- Insert data into profiles
INSERT INTO profiles (id, first_name, last_name, email) VALUES
(1, 'Wallis', 'Treadway', 'wtreadway0@senate.gov'),
(2, 'Franklin', 'Blackston', 'fblackston1@parallels.com'),
(3, 'Honoria', 'Constant', 'hconstant2@umich.edu'),
(4, 'Bertine', 'Hillaby', 'bhillaby3@artisteer.com'),
(5, 'Constance', 'Knutsen', 'cknutsen4@google.ca');

-- Insert data into deals
INSERT INTO deals (profile_id, dt, amount) VALUES
(5, '2022-05-21 02:44:24', 49.10),
(2, '2022-05-22 23:26:59', 46.21),
(1, '2022-05-23 09:56:25', 58.57),
(5, '2022-05-28 02:38:08', 27.81),
(4, '2022-06-04 07:16:27', 22.31),
(4, '2022-06-04 14:15:03', 36.33),
(5, '2022-06-04 15:03:10', 21.41),
(1, '2022-06-07 02:58:06', 92.84),
(4, '2022-06-08 05:09:52', 24.41),
(3, '2022-06-13 03:28:52', 61.55),
(4, '2022-06-16 15:09:39', 77.70),
(5, '2022-06-18 16:51:32', 58.79),
(4, '2022-06-20 02:55:20', 43.61),
(3, '2022-06-22 06:52:10', 10.41),
(1, '2022-06-23 04:59:05', 6.59),
(1, '2022-06-30 16:11:02', 43.07),
(4, '2022-07-05 06:05:28', 36.45),
(5, '2022-07-12 07:49:51', 14.76),
(4, '2022-07-12 18:58:11', 91.61),
(5, '2022-07-14 00:50:45', 69.61);

-- Write your query for Question 61 here:
-- Expected Output: first_name | last_name | email | total
-- Sort by total descending, limit to top 3
-- Note: Only deals for June 2022 should be included

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 62: Freelance Platform Candidate Review
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS stats;
DROP TABLE IF EXISTS profiles;

-- Create profiles table
CREATE TABLE profiles (
    id SMALLINT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    is_verified SMALLINT
);

-- Create stats table
CREATE TABLE stats (
    profile_id SMALLINT,
    job_success_score SMALLINT,
    FOREIGN KEY (profile_id) REFERENCES profiles(id)
);

-- Insert data into profiles
INSERT INTO profiles (id, first_name, last_name, email, is_verified) VALUES
(1, 'Junia', 'Sehorsch', 'jsehorsch0@oracle.com', 0),
(2, 'Dave', 'Halliburton', 'dhalliburton1@pbs.org', 1),
(3, 'Agneta', 'Dutch', 'adutch2@thetimes.co.uk', 1),
(4, 'Kendell', 'Sylvester', 'ksylvester3@canalblog.com', 1),
(5, 'Koralle', 'Ragsdale', 'kragsdale4@buzzfeed.com', 1),
(6, 'Roma', 'Kenelin', 'rkenelin5@prnewswire.com', 1),
(7, 'Harold', 'Molloy', 'hmolloy6@ycombinator.com', 1),
(8, 'Berri', 'Hartzogs', 'bhartzogs7@ox.ac.uk', 0),
(9, 'Garrik', 'Preddle', 'gpreddle8@topsy.com', 1),
(10, 'Sophie', 'Messenger', 'smessenger9@myspace.com', 1),
(11, 'Ashby', 'Philipsson', 'aphilipssona@typepad.com', 1),
(12, 'Kayle', 'Jesteco', 'kjestecob@ocn.ne.jp', 1),
(13, 'Munroe', 'Chevolleau', 'mchevolleauc@yandex.ru', 1),
(14, 'Etheline', 'Choake', 'echoaked@hao123.com', 1),
(15, 'Marten', 'Zamboniari', 'mzamboniarie@cbc.ca', 1),
(16, 'Hersch', 'Blasdale', 'hblasdalef@wunderground.com', 1),
(17, 'Jori', 'MacFaell', 'jmacfaellg@va.gov', 1),
(18, 'Margo', 'Finnemore', 'mfinnemoreh@discovery.com', 1),
(19, 'Felicle', 'Ramsdale', 'framsdalei@devhub.com', 1),
(20, 'Demetris', 'Arnet', 'darnetj@livejournal.com', 1);

-- Insert data into stats
INSERT INTO stats (profile_id, job_success_score) VALUES
(4, 100),
(1, 100),
(18, 95),
(5, 95),
(8, 95),
(10, 95),
(12, 95),
(13, 95),
(14, 95),
(20, 90),
(17, 90),
(7, 90),
(15, 90),
(11, 85),
(16, 85),
(9, 85),
(6, 85),
(2, 85),
(3, 75),
(19, 75);

-- Write your query for Question 62 here:
-- Expected Output: first_name | last_name | email | job_success_score
-- Sort by job_success_score descending, then first_name and last_name ascending
-- Limit to first 10 records
-- Note: Only profiles with JSS > 90 and is_verified = 1

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 63: Virtual Machine Deployment Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS deployments;
DROP TABLE IF EXISTS configurations;

-- Create configurations table
CREATE TABLE configurations (
    id VARCHAR(64) PRIMARY KEY,
    name VARCHAR(255)
);

-- Create deployments table
CREATE TABLE deployments (
    configuration_id VARCHAR(64),
    dt VARCHAR(19),
    FOREIGN KEY (configuration_id) REFERENCES configurations(id)
);

-- Insert data into configurations
INSERT INTO configurations (id, name) VALUES
('1vcpu_512mb_10gb_500gb', '1 CPU / 512 MB RAM / 10 GB SSD Disk / 500 GB transfer'),
('1vcpu_1gb_25gb_1tb', '1 CPU / 1 GB RAM / 25 GB SSD Disk / 1000 GB transfer'),
('1vcpu_2gb_50gb_2tb', '1 CPU / 2 GB RAM / 50 GB SSD Disk / 2 TB transfer'),
('2vcpu_2gb_60gb_3tb', '2 CPUs / 2 GB RAM / 60 GB SSD Disk / 3 TB transfer'),
('2vcpu_4gb_80gb_4tb', '2 CPUs / 4 GB RAM / 80 GB SSD Disk / 4 TB transfer'),
('4vcpu_8gb_160gb_5tb', '4 CPUs / 8 GB RAM / 160 GB SSD Disk / 5 TB transfer'),
('8vcpu_16gb_320gb_6tb', '8 CPUs / 16 GB RAM / 320 GB SSD Disk / 6 TB transfer');

-- Insert data into deployments
INSERT INTO deployments (configuration_id, dt) VALUES
('1vcpu_512mb_10gb_500gb', '2020-10-22 05:59:47'),
('1vcpu_1gb_25gb_1tb', '2020-11-09 06:07:57'),
('1vcpu_2gb_50gb_2tb', '2020-12-02 14:47:24'),
('2vcpu_2gb_60gb_3tb', '2021-01-24 15:41:42'),
('4vcpu_8gb_160gb_5tb', '2021-01-25 09:31:37'),
('2vcpu_2gb_60gb_3tb', '2021-02-08 02:43:14'),
('1vcpu_512mb_10gb_500gb', '2021-03-25 06:13:36'),
('8vcpu_16gb_320gb_6tb', '2021-03-26 22:23:42'),
('2vcpu_2gb_60gb_3tb', '2021-05-24 09:48:16'),
('1vcpu_512mb_10gb_500gb', '2021-05-31 05:03:28'),
('1vcpu_2gb_50gb_2tb', '2021-08-25 22:24:10'),
('2vcpu_4gb_80gb_4tb', '2021-09-05 22:12:17'),
('2vcpu_4gb_80gb_4tb', '2021-09-23 08:31:50'),
('2vcpu_4gb_80gb_4tb', '2021-09-28 05:15:24'),
('2vcpu_2gb_60gb_3tb', '2021-10-14 08:26:20'),
('1vcpu_2gb_50gb_2tb', '2021-11-01 19:00:30'),
('1vcpu_512mb_10gb_500gb', '2021-11-26 10:53:05'),
('1vcpu_1gb_25gb_1tb', '2021-12-27 07:07:23'),
('2vcpu_2gb_60gb_3tb', '2022-02-13 06:00:29'),
('2vcpu_2gb_60gb_3tb', '2022-03-03 09:10:30');

-- Write your query for Question 63 here:
-- Expected Output: configuration | deployments
-- Sort by deployments descending
-- Note: Only deployments in 2021 should be included

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 64: Visitors Behavior Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS events;

-- Create events table
CREATE TABLE events (
    dt VARCHAR(19),
    type VARCHAR(64)
);

-- Insert data into events
INSERT INTO events (dt, type) VALUES
('2022-04-04 03:36:00', 'buy'),
('2022-04-21 07:05:09', 'buy'),
('2022-04-02 11:34:24', 'sell'),
('2022-05-27 16:12:50', 'buy'),
('2022-05-20 09:09:07', 'buy'),
('2022-05-22 09:06:37', 'buy'),
('2022-05-31 07:49:36', 'buy'),
('2022-05-14 22:29:10', 'buy'),
('2022-05-13 15:00:54', 'sell'),
('2022-05-24 15:40:54', 'sell'),
('2022-05-13 01:20:05', 'sell'),
('2022-05-16 07:07:44', 'sell'),
('2022-05-01 16:57:00', 'sell'),
('2022-06-02 09:42:02', 'buy'),
('2022-06-01 06:34:59', 'buy'),
('2022-06-06 17:14:47', 'buy'),
('2022-06-17 19:10:13', 'buy'),
('2022-06-15 21:40:13', 'sell'),
('2022-06-11 12:26:43', 'sell');

-- Write your query for Question 64 here:
-- Expected Output: purchases
-- Note: Only events of type "buy" in May 2022 should be included

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 65: Advertising Campaigns Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS campaigns;
DROP TABLE IF EXISTS companies;

-- Create companies table
CREATE TABLE companies (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create campaigns table
CREATE TABLE campaigns (
    company_id SMALLINT,
    expenses DECIMAL(7,2),
    revenue DECIMAL(7,2),
    FOREIGN KEY (company_id) REFERENCES companies(id)
);

-- Insert data into companies
INSERT INTO companies (id, name) VALUES
(1, 'Lion Biotechnologies, Inc.'),
(2, 'Boston Private Financial Holdings, Inc.'),
(3, 'Universal Corporation'),
(4, 'Arbutus Biopharma Corporation'),
(5, 'Royal Bank Of Canada'),
(6, 'Penn West Petroleum Ltd'),
(7, 'Public Storage'),
(8, 'Halcon Resources Corporation'),
(9, 'TTM Technologies, Inc.'),
(10, 'Atwood Oceanics, Inc.'),
(11, 'ACADIA Pharmaceuticals Inc.'),
(12, 'Central European Media Enterprises Ltd.'),
(13, 'Oxbridge Re Holdings Limited'),
(14, 'Western Refining Logistics, LP'),
(15, 'Vaalco Energy Inc'),
(16, 'Xilinx, Inc.'),
(17, 'Liberty Global plc'),
(18, 'Honda Motor Company, Ltd.'),
(19, 'Great Plains Energy Inc'),
(20, 'Assurant, Inc.');

-- Insert data into campaigns
INSERT INTO campaigns (company_id, expenses, revenue) VALUES
(1, 7390.24, 8652.18),
(2, 5774.65, 7955.47),
(3, 2154.71, 5920.23),
(4, 9366.49, 3397.85),
(5, 2765.18, 9158.63),
(6, 7908.41, 5018.85),
(7, 2251.44, 6654.52),
(8, 3383.14, 9354.79),
(9, 8287.96, 9522.53),
(10, 4356.62, 4658.52),
(11, 9272.86, 9161.77),
(12, 4996.18, 5903.57),
(13, 8354.75, 2259.26),
(14, 6402.90, 8146.16),
(15, 1692.05, 686.71),
(16, 5988.48, 9089.41),
(17, 6192.33, 7580.19),
(18, 3016.37, 7761.25),
(19, 9838.05, 1293.09),
(20, 4386.52, 9513.73);

-- Write your query for Question 65 here:
-- Expected Output: company_name | profit
-- Sort by profit descending, limit to top 3
-- Note: Only companies with positive return (revenue > expenses)

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 66: Traffic Audit Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS clients;

-- Create clients table
CREATE TABLE clients (
    mac VARCHAR(64),
    upstream_rate INT,
    downstream_rate INT,
    downtime_rate VARCHAR(64)
);

-- Insert data into clients
INSERT INTO clients (mac, upstream_rate, downstream_rate, downtime_rate) VALUES
('78-C1-E5-20-D5-61', 925526, 5195, 'never'),
('78-E2-20-71-9C-30', 582152, 375829, 'never'),
('0D-09-F7-77-03-E5', 359529, 710743, 'never'),
('56-18-67-55-58-EA', 78626, 562544, 'once'),
('C9-73-EC-1C-4C-B7', 574927, 669655, 'yearly'),
('02-35-3F-7B-CC-76', 430072, 296196, 'seldom'),
('3D-95-33-8A-65-F9', 894176, 489401, 'monthly'),
('8D-33-3F-0E-04-D5', 897666, 297063, 'weekly'),
('0E-0A-63-B9-79-3E', 69133, 984354, 'seldom'),
('15-D3-2A-DD-02-A4', 19203, 995983, 'seldom'),
('8D-42-B1-97-AB-87', 476648, 177677, 'monthly'),
('6B-64-60-47-16-D3', 700056, 374321, 'monthly'),
('D-61-81-00-BF-EC', 216401, 498229, 'yearly'),
('95-46-C6-C7-6F-E0', 236331, 341013, 'monthly'),
('11-0E-62-32-62-5E', 694746, 451525, 'daily'),
('D6-5B-72-D5-FF-4F', 2931, 992852, 'monthly'),
('66-B-AD-FF2-E5-45', 861075, 44216, 'monthly'),
('E5-C9-C6-74-2E-A8', 639487, 968494, 'daily'),
('18-56-3A-93-8E-9F', 494945, 259910, 'weekly'),
('51-EB-D7-22-45-99', 219419, 326479, 'often');

-- Write your query for Question 66 here:
-- Expected Output: mac | upstream_rate | downstream_rate | downtime_rate
-- Sort by mac ascending
-- Note: Only clients with downstream_rate > upstream_rate and downtime_rate in ('never', 'once')

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 67: Calendar Application Events Report
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS owners;

-- Create owners table
CREATE TABLE owners (
    id SMALLINT PRIMARY KEY,
    full_name VARCHAR(255),
    email_address VARCHAR(255),
    on_vacation SMALLINT
);

-- Create events table
CREATE TABLE events (
    owner_id SMALLINT,
    dt VARCHAR(19),
    title VARCHAR(255),
    FOREIGN KEY (owner_id) REFERENCES owners(id)
);

-- Insert data into owners
INSERT INTO owners (id, full_name, email_address, on_vacation) VALUES
(1, 'Benjamin Sevier', 'bsevier0@discuz.net', 1),
(2, 'Aleksandr Fellows', 'afellows1@instagram.com', 0),
(3, 'Collette Pack', 'cpack2@mit.edu', 0),
(4, 'Lorelle Squibb', 'lsquibb3@huffingtonpost.com', 0),
(5, 'Cointon Welberry', 'cwelberry4@theguardian.com', 1);

-- Insert data into events
INSERT INTO events (owner_id, dt, title) VALUES
(1, '2021-08-13 09:17:41', 'ac consequat metus sapien ut'),
(1, '2021-10-26 16:14:28', 'a libero nam'),
(1, '2022-05-18 16:09:36', 'vestibulum ante ipsum primis in faucibus'),
(1, '2022-06-04 20:37:36', 'nisi volutpat eleifend donec'),
(2, '2021-01-17 23:34:59', 'eu mi nulla ac'),
(2, '2021-01-26 15:59:04', 'nisl venenatis lacinia'),
(2, '2021-04-25 05:04:29', 'arcu adipiscing molestie hendrerit'),
(2, '2022-02-22 10:24:50', 'lectus vestibulum quam sapien varius'),
(2, '2022-05-22 03:04:33', 'pellentesque quisque porta volutpat erat'),
(3, '2021-03-11 08:25:21', 'felis sed interdum venenatis'),
(3, '2022-02-15 07:29:45', 'nulla sed accumsan felis ut'),
(4, '2021-02-28 16:10:55', 'cras mi pede malesuada in imperdiet et'),
(4, '2021-05-20 03:35:11', 'odio in hac habitasse platea dictumst'),
(4, '2021-09-01 19:25:41', 'sagittis nam congue risus semper'),
(4, '2022-02-04 03:11:53', 'luctus cum sociis natoque penatibus et magnis'),
(4, '2022-06-18 08:39:41', 'nec molestie sed justo pellentesque'),
(5, '2021-04-04 13:39:38', 'id massa id nisl venenatis lacinia aenean'),
(5, '2021-10-18 19:04:14', 'adipiscing lorem vitae mattis'),
(5, '2021-10-19 00:56:11', 'vestibulum eget vulputate ut ultrices vel augue'),
(5, '2022-04-26 18:55:04', 'at dolor quis');

-- Write your query for Question 67 here:
-- Expected Output: dt | title | full_name | email_address
-- Sort by dt ascending, limit to first 5 records
-- Note: Only events whose owner is not on vacation (on_vacation = 0)

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 68: Firewall Active Clients Tracking
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS traffic;
DROP TABLE IF EXISTS clients;

-- Create clients table
CREATE TABLE clients (
    id SMALLINT PRIMARY KEY,
    mac VARCHAR(64)
);

-- Create traffic table
CREATE TABLE traffic (
    client_id SMALLINT,
    amount INT,
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

-- Insert data into clients
INSERT INTO clients (id, mac) VALUES
(1, 'E5-A3-AC-8A-20-F9'),
(2, '3B-2F-83-25-A8-81'),
(3, '3A-4E-A6-43-1D-B1'),
(4, 'B7-03-14-91-8-58F'),
(5, '63-1A-FD-9A-A-6FF'),
(6, 'D6-B8-1F-1D-34-04'),
(7, '38-83-E5-8-C8-DCF'),
(8, 'E9-6-89-7FF-8D-34'),
(9, '82-2E-B3-67-04-41'),
(10, 'D1-9D-DE-37-A0-49'),
(11, '8A-46-F4-83-29-13'),
(12, '4C-1F-7B-C7-08-7E'),
(13, '72-57-E6-CA-2C-91'),
(14, '57-F7-E7-E7-45-36'),
(15, '05-8A-05-1D-2D-20'),
(16, '46-06-F1-B9-65-7C'),
(17, '0A-E0-26-9D-2A-27'),
(18, '0-86-99-18-36-9BF'),
(19, 'DD-81-B-53-BD-9BF'),
(20, '50-53-64-8E-42-BE');

-- Insert data into traffic
INSERT INTO traffic (client_id, amount) VALUES
(3, 6385047),
(8, 6490817),
(14, 9109219),
(16, 5558512),
(17, 1870152),
(17, 8228920),
(18, 326127),
(18, 5429741),
(18, 4063477),
(19, 7411789),
(20, 5832337),
(20, 1426585),
(23, 1097368),
(23, 6769594),
(23, 802387),
(24, 5959513),
(24, 1300408),
(24, 4631624),
(28, 1629306),
(29, 2814818);

-- Write your query for Question 68 here:
-- Expected Output: mac
-- Note: Only MAC addresses that have at least one record in the traffic table

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 69: Active Wallets
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS wallets;

-- Create wallets table
CREATE TABLE wallets (
    id SMALLINT PRIMARY KEY,
    address VARCHAR(64)
);

-- Create transactions table
CREATE TABLE transactions (
    wallet_id SMALLINT,
    credit DECIMAL(4,2),
    FOREIGN KEY (wallet_id) REFERENCES wallets(id)
);

-- Insert data into wallets
INSERT INTO wallets (id, address) VALUES
(1, '0x1ecc4cefde6dfb773352a2dcd8b5f518ccd24ff4'),
(2, '0x0f4487168610dcae7f16b6c000a7ba284bb6703c'),
(3, '0x54c5c516b5c601a3e6fdea18db966186274879e6'),
(4, '0x50c404a6790d44849c3500d95f147d2102db5f77'),
(5, '0x41cc32037fdcc6cbf5cb04ada4e38032a84361ac'),
(6, '0xb38ca2076b2c3a0a1c0796ccab5dc3fcbb645336'),
(7, '0x923c6ee4debce6c37c512eb90e9b26fc9bbfc3e1'),
(8, '0x76cfbf67e1765117a98fd2286bdbcb731b0d29ec'),
(9, '0xf4dff43df89365453440dbeb5e53445d3400d218'),
(10, '0x010a4b23f985eda6b397864878cb70bf0b233aa6'),
(11, '0x106c4c852394d5a6580c11ca0060687a798ec78c'),
(12, '0x541da74b9f4b2283524a65156263bcce7429ba61'),
(13, '0x86df8e62ad23a35ee2e64b3b4b128d8a3660116a'),
(14, '0x6b021b12b779aec27009f18bd6ad227685df5474'),
(15, '0x7073e9f48b7211d9940db4c8bad8e31d5d9d0577'),
(16, '0x4672e132b9627a7db76e5af431bb5febc93b1b2f'),
(17, '0x5cbc82a01d3b9df8f50ee09bf5a1c48afe0cb966'),
(18, '0x1c7d30f90081b45004e0d6549534ef8658795672'),
(19, '0xf830618ca9f027ce5f23bf270629a6a418ad355c'),
(20, '0x1a31ac1b923fcc17a42a340091424ea18192a3e7');

-- Insert data into transactions
INSERT INTO transactions (wallet_id, credit) VALUES
(3, 5.21),
(6, 24.04),
(8, 29.66),
(10, 1.67),
(10, 3.32),
(10, 4.27),
(14, 3.32),
(14, 3.35),
(15, 14.34),
(16, 11.94),
(20, 13.86),
(20, 16.54),
(21, 11.64),
(25, 12.86),
(26, 8.77),
(26, 12.36),
(27, 29.65),
(28, 3.00),
(28, 13.26),
(28, 2.85);

-- Write your query for Question 69 here:
-- Expected Output: address
-- Note: Only wallet addresses that have at least one record in the transactions table

-- Your query here:
-- SELECT ...

-- =====================================================
-- QUESTION 70: Animal Tracking
-- =====================================================

-- Drop tables if they exist
DROP TABLE IF EXISTS tracklog;
DROP TABLE IF EXISTS animals;

-- Create animals table
CREATE TABLE animals (
    id SMALLINT PRIMARY KEY,
    name VARCHAR(64)
);

-- Create tracklog table
CREATE TABLE tracklog (
    animal_id SMALLINT,
    tracked_at VARCHAR(19),
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

-- Insert data into animals
INSERT INTO animals (id, name) VALUES
(1, 'Blue and yellow macaw'),
(2, 'Jungle kangaroo'),
(3, 'Stork, woolly-necked'),
(4, 'North American river otter'),
(5, 'Square-lipped rhinoceros'),
(6, 'Black-fronted bulbul'),
(7, 'American beaver'),
(8, 'Capybara'),
(9, 'Black-backed jackal'),
(10, 'Dragon, ornate rock'),
(11, 'Wombat, southern hairy-nosed'),
(12, 'Snake, carpet'),
(13, 'Egyptian cobra'),
(14, 'Green heron'),
(15, 'Indian star tortoise'),
(16, 'Roan antelope'),
(17, 'Rhea, common'),
(18, 'Fairy penguin'),
(19, 'Black-eyed bulbul'),
(20, 'Starling, cape');

-- Insert data into tracklog
INSERT INTO tracklog (animal_id, tracked_at) VALUES
(2, '2021-07-08 12:30:34'),
(5, '2021-09-15 03:00:04'),
(8, '2021-12-14 11:20:50'),
(9, '2021-05-15 14:54:15'),
(11, '2021-07-03 17:04:14'),
(11, '2021-02-23 09:02:11'),
(15, '2021-11-02 22:49:37'),
(15, '2021-07-31 04:51:25'),
(15, '2021-06-06 14:57:23'),
(19, '2021-03-25 02:00:31'),
(19, '2021-04-21 22:02:51'),
(19, '2021-07-17 17:12:35'),
(21, '2021-05-06 03:35:59'),
(22, '2021-09-21 22:49:36'),
(22, '2021-12-04 00:26:29'),
(24, '2021-12-27 08:19:52'),
(26, '2021-05-14 07:30:11'),
(28, '2021-06-08 00:47:00'),
(28, '2021-04-24 00:42:31'),
(30, '2021-05-06 21:03:03');

-- Write your query for Question 70 here:
-- Expected Output: name
-- Note: Only animal names that have at least one record in the tracklog table

-- Your query here:
-- SELECT ...

-- =====================================================
-- END OF QUESTIONS 61-70
-- =====================================================
-- 
-- Instructions:
-- 1. Load this file into pgAdmin4
-- 2. Execute the entire file to create all tables and insert data
-- 3. Write your queries in the spaces provided above each question
-- 4. Test your queries to match the expected output
-- 5. Each question is independent - tables are recreated for each question
-- =====================================================
