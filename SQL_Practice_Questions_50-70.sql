-- =====================================================
-- SQL Practice Questions 50-70
-- PostgreSQL/pgAdmin4 Compatible
-- =====================================================

-- =====================================================
-- QUESTION 50: Smart Home Application Customer Report
-- =====================================================

DROP TABLE IF EXISTS readings;
DROP TABLE IF EXISTS tariffs;
DROP TABLE IF EXISTS accounts;
DROP TYPE IF EXISTS tariff_name; -- Drop custom type if it exists

-- PostgreSQL requires creating a custom TYPE for ENUMs
CREATE TYPE tariff_name AS ENUM('A','B','C','D','E');

CREATE TABLE accounts (
    id INT PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255)
);
CREATE TABLE tariffs (
    id INT PRIMARY KEY,
    name tariff_name,
    cost DECIMAL(4,3)
);
CREATE TABLE readings (
    account_id INT,
    tariff_id INT,
    amount SMALLINT,
    FOREIGN KEY (account_id) REFERENCES accounts(id),
    FOREIGN KEY (tariff_id) REFERENCES tariffs(id)
);

INSERT INTO accounts (id, username, email) VALUES
(1, 'hshillabeare0', 'rcalkin0@sourceforge.net'),
(2, 'sdandy1', 'agaule1@businessweek.com'),
(3, 'sgreiswood2', 'toppy2@lulu.com');
INSERT INTO tariffs (id, name, cost) VALUES
(1, 'A', 0.010),(2, 'B', 0.020),(3, 'C', 0.050),(4, 'D', 0.075),(5, 'E', 0.100);
INSERT INTO readings (account_id, tariff_id, amount) VALUES
(1, 2, 54),(1, 3, 19),(1, 3, 37),(1, 3, 89),(1, 3, 119),(2, 1, 12),(2, 1, 44),(2, 1, 81),
(2, 2, 60),(2, 2, 164),(2, 2, 199),(2, 3, 79),(2, 5, 186),(3, 1, 31),(3, 1, 59),(3, 1, 77),
(3, 1, 95),(3, 1, 110),(3, 1, 125),(3, 2, 31);

-- Solution for Question 50:
WITH Aggregations AS (
    SELECT
        r.account_id,
        SUM(r.amount) as total_consumption,
        SUM(r.amount * t.cost) as calculated_cost,
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
    to_char(agg.calculated_cost, 'FM999.00') AS total_cost
FROM
    accounts a
JOIN
    Aggregations agg ON a.id = agg.account_id
ORDER BY
    a.username ASC;

---
-- =====================================================
-- QUESTION 51: MMORPG Game Inventory Overload Notification
-- =====================================================

DROP TABLE IF EXISTS accounts_items;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS accounts;
DROP TYPE IF EXISTS item_type;

CREATE TYPE item_type AS ENUM('sword','shield','armor');

CREATE TABLE accounts ( id INT PRIMARY KEY, username VARCHAR(255), email VARCHAR(255) );
CREATE TABLE items ( id INT PRIMARY KEY, type item_type, name VARCHAR(255), weight SMALLINT );
CREATE TABLE accounts_items ( account_id INT, item_id INT, FOREIGN KEY (account_id) REFERENCES accounts(id), FOREIGN KEY (item_id) REFERENCES items(id) );

INSERT INTO accounts VALUES
(1, 'esoane0', 'alefwich0@nytimes.com'), (2, 'jrafter1', 'bmcniff1@census.gov'), (3, 'rcawston2', 'fnickoll2@flickr.com');
INSERT INTO items VALUES
(1, 'shield', 'Shield of Asteraceae', 3), (2, 'sword', 'Sword of Cyperaceae', 3), (3, 'shield', 'Shield of Apiaceae', 3),
(4, 'sword', 'Sword of Onagraceae', 3), (5, 'sword', 'Sword of Campanulaceae', 3);
INSERT INTO accounts_items VALUES
(1, 2),(1, 3),(1, 3),(1, 4),(1, 4),(1, 5),(1, 5),(1, 5),(2, 1),(2, 1),(2, 2),(2, 2),
(2, 2),(2, 2),(2, 2),(2, 3),(2, 3),(2, 5),(3, 3),(3, 4);

-- Solution for Question 51:
SELECT
    a.username,
    a.email,
    COUNT(i.id) AS items,
    SUM(i.weight) AS total_weight
FROM
    accounts a
JOIN
    accounts_items ai ON a.id = ai.account_id
JOIN
    items i ON ai.item_id = i.id
GROUP BY
    a.id, a.username, a.email
HAVING
    SUM(i.weight) > 20
ORDER BY
    total_weight DESC,
    a.username ASC;

---
-- =====================================================
-- QUESTION 52: Outdoor Banner Digital Marketplace Placement Report
-- =====================================================

DROP TABLE IF EXISTS banners;
DROP TABLE IF EXISTS cities;

CREATE TABLE cities ( id INT PRIMARY KEY, name VARCHAR(255) );
CREATE TABLE banners ( city_id INT, width SMALLINT, height SMALLINT, FOREIGN KEY (city_id) REFERENCES cities(id) );

INSERT INTO cities VALUES (1, 'Kayu Agung'),(2, 'Yangkou'),(3, 'Marseille');
INSERT INTO banners VALUES
(3, 6, 20),(1, 20, 14),(1, 6, 17),(1, 15, 6),(2, 16, 8),(2, 6, 7),(3, 6, 9),(1, 20, 16),
(3, 19, 14),(2, 9, 17),(2, 8, 12),(1, 12, 16),(3, 15, 14),(3, 11, 7),(3, 6, 14),
(2, 12, 7),(3, 7, 20),(1, 13, 6),(3, 10, 13),(2, 19, 15);

-- Solution for Question 52:
SELECT
    c.name AS city,
    COUNT(b.city_id) AS banners,
    MIN(b.width * b.height) AS min_area,
    CEIL(AVG(b.width * b.height))::INT AS avg_area,
    MAX(b.width * b.height) AS max_area,
    SUM(b.width * b.height) AS total_area
FROM
    cities c
JOIN
    banners b ON c.id = b.city_id
GROUP BY
    c.name
ORDER BY
    city ASC;

---
-- =====================================================
-- QUESTION 53: Auction Web Service Lot Statistics
-- =====================================================

DROP TABLE IF EXISTS offers;
DROP TABLE IF EXISTS lots;

CREATE TABLE lots ( id INT PRIMARY KEY, name VARCHAR(255) );
CREATE TABLE offers ( lot_id INT, amount DECIMAL(6,2), FOREIGN KEY (lot_id) REFERENCES lots(id) );

INSERT INTO lots VALUES
(1, 'Merremia quinquefolia (L.) Hallier f.'),(2, 'Plantago maritima L.'),
(3, 'Hohenbergia antillana Mez'),(4, 'Penstemon eriantherus Pursh var. argillosus M.E. Jones');
INSERT INTO offers VALUES
(1, 510.51),(2, 703.80),(2, 181.80),(1, 38.06),(2, 368.78),(3, 91.40),(2, 413.80),(3, 157.99),
(3, 885.82),(2, 863.99),(1, 307.61),(2, 120.39),(1, 771.96),(2, 801.42),(3, 871.59),(1, 541.61),
(3, 477.62),(2, 303.29),(2, 612.83),(3, 464.98);

-- Solution for Question 53:
SELECT
    l.name,
    COUNT(o.lot_id) AS offers,
    to_char(MIN(o.amount), 'FM9999.00') AS min_offer,
    to_char(AVG(o.amount), 'FM9999.00') AS avg_offer,
    to_char(MAX(o.amount), 'FM9999.00') AS max_offer
FROM
    lots l
LEFT JOIN
    offers o ON l.id = o.lot_id
GROUP BY
    l.name
ORDER BY
    offers DESC;

---
-- =====================================================
-- QUESTION 54: Tax Calculator Web Service Simple Report
-- =====================================================

DROP TABLE IF EXISTS declarations;
DROP TABLE IF EXISTS accounts;
DROP TYPE IF EXISTS quarter_enum;

CREATE TYPE quarter_enum AS ENUM('Q1','Q2','Q3','Q4');
CREATE TABLE accounts ( id INT PRIMARY KEY, first_name VARCHAR(255), last_name VARCHAR(255), iban VARCHAR(255) );
CREATE TABLE declarations ( account_id INT, quarter quarter_enum, income DECIMAL(7,2), FOREIGN KEY (account_id) REFERENCES accounts(id) );

INSERT INTO accounts VALUES
(1, 'Alex', 'Cantua', 'IL29 9590 1551 0560 0553 712'),(2, 'Chris', 'Lashmore', 'AZ54 CNUI 01DR XEXZ ASKY QM4W F8JI'),
(3, 'Taylor', 'Blum', 'HR20 2041 7741 5014 9873 9'),(4, 'Robin', 'Neachell', 'NL87 PPCD 0429 1849 92'),
(5, 'Drew', 'Barbier', 'FR72 7843 3990 42WM QC8P GVNV 78');
INSERT INTO declarations VALUES
(1, 'Q1', 49235.67),(1, 'Q2', 46653.11),(1, 'Q3', 63739.99),(1, 'Q4', 43222.54),(2, 'Q1', 69743.50),
(2, 'Q2', 29641.01),(2, 'Q3', 97725.49),(2, 'Q4', 91481.98),(3, 'Q1', 68402.43),(3, 'Q2', 12660.12),
(3, 'Q3', 59601.65),(3, 'Q4', 54701.74),(4, 'Q1', 55220.27),(4, 'Q2', 87752.41),(4, 'Q3', 44447.06),
(4, 'Q4', 45876.26),(5, 'Q1', 42511.74),(5, 'Q2', 22022.78),(5, 'Q3', 88396.81),(5, 'Q4', 67252.54);

-- Solution for Question 54:
SELECT
    a.first_name || ' ' || a.last_name AS full_name,
    a.iban,
    to_char(SUM(d.income), 'FM999999.00') AS income,
    '10%' AS rate,
    to_char(SUM(d.income) * 0.10, 'FM999999.00') AS tax
FROM
    accounts a
JOIN
    declarations d ON a.id = d.account_id
GROUP BY
    a.id, full_name, a.iban
ORDER BY
    full_name ASC;

---
-- =====================================================
-- QUESTION 55: Social Network Relationship Statistics
-- =====================================================

DROP TABLE IF EXISTS relations;
DROP TABLE IF EXISTS profiles;

CREATE TABLE profiles ( id INT PRIMARY KEY, first_name VARCHAR(255), last_name VARCHAR(255), email VARCHAR(255) );
CREATE TABLE relations ( profile_id INT, related_to VARCHAR(255), is_approved BOOLEAN, FOREIGN KEY (profile_id) REFERENCES profiles(id) );

INSERT INTO profiles VALUES
(1, 'Shayne', 'Shilito', 'sshilito0@ftc.gov'),
(2, 'Shell', 'Shade', 'sshade1@paginegialle.it'),
(3, 'Nobie', 'Splain', 'nsplain2@npr.org');
INSERT INTO relations VALUES
(1, 'cbasinigazzii', TRUE),(1, 'ldevered', TRUE),(1, 'edeniskeb', TRUE),(1, 'cstirland4', TRUE),(1, 'ngooddiea', TRUE),
(1, 'alockney7', TRUE),(1, 'jsorrillj', FALSE),(1, 'bnodin3', FALSE),(1, 'dwall2', FALSE),(1, 'folivas1', FALSE),
(2, 'ksharland6', FALSE),(2, 'pbarosch8', FALSE),(2, 'smacieja9', FALSE),(2, 'bbrasonf', FALSE),(2, 'dabrahartg', FALSE),
(3, 'gaymer5', TRUE),(3, 'rwoolcockse', TRUE),(3, 'egilyott0', TRUE),(3, 'agillionc', FALSE),(3, 'fgribbinh', FALSE);

-- Solution for Question 55:
SELECT
    p.first_name || ' ' || p.last_name AS full_name,
    p.email,
    COUNT(r.profile_id) AS total_relations,
    SUM(CASE WHEN r.is_approved = TRUE THEN 1 ELSE 0 END) AS approved_relations,
    SUM(CASE WHEN r.is_approved = FALSE THEN 1 ELSE 0 END) AS pending_relations
FROM
    profiles p
JOIN
    relations r ON p.id = r.profile_id
GROUP BY
    p.id, full_name, p.email
ORDER BY
    full_name ASC;

---
-- =====================================================
-- QUESTION 56: Online Banking Transactions
-- =====================================================

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts ( id INT PRIMARY KEY, iban VARCHAR(255) );
CREATE TABLE transactions ( account_id INT, dt TIMESTAMP, amount DECIMAL(5,2), FOREIGN KEY (account_id) REFERENCES accounts(id) );

INSERT INTO accounts VALUES
(1, 'SE48 2961 2087 8112 2835 6438'),(2, 'BE89 2286 5514 4847'),(3, 'MU84 HRGV 2047 2584 5774 3195 856J PZ');
INSERT INTO transactions VALUES
(2, '2022-09-25 19:24:50', 75.06),(2, '2022-09-24 03:09:17', 41.10),(1, '2022-09-19 04:13:17', 65.85),
(3, '2022-09-30 07:18:29', 44.57),(1, '2022-09-26 01:51:44', 98.93),(1, '2022-08-28 02:51:04', 60.42),
(2, '2022-09-09 11:00:48', 11.05),(3, '2022-08-25 19:37:02', 53.61),(2, '2022-09-23 09:44:05', 89.18),
(3, '2022-09-12 10:28:10', 96.40),(2, '2022-09-05 16:20:41', 46.78),(2, '2022-09-14 12:52:13', 20.36),
(1, '2022-09-28 11:05:21', 70.52),(3, '2022-09-30 09:21:12', 48.00);

-- Solution for Question 56:
SELECT
    a.iban,
    COUNT(t.account_id) AS transactions,
    SUM(t.amount) AS total
FROM
    accounts a
JOIN
    transactions t ON a.id = t.account_id
WHERE
    EXTRACT(YEAR FROM t.dt) = 2022 AND EXTRACT(MONTH FROM t.dt) = 9
GROUP BY
    a.iban
ORDER BY
    total DESC;

---
-- =====================================================
-- QUESTION 57: Internet Service Provider Monthly Report
-- =====================================================

DROP TABLE IF EXISTS traffic;
DROP TABLE IF EXISTS clients;
CREATE TABLE clients ( id SMALLINT PRIMARY KEY, mac VARCHAR(17), tariff DECIMAL(6,5) );
CREATE TABLE traffic ( client_id SMALLINT, dt VARCHAR(19), amount INT, FOREIGN KEY (client_id) REFERENCES clients(id) );

INSERT INTO clients VALUES
(1, 'A2-53-FC-0C-3E-B4', 0.00007),(2, 'DC-80-42-E9-AE-FC', 0.00003),(3, '3-9B-AF9-2A-B1-7B', 0.00007),
(4, 'D4-6F-E4-AF-47-D5', 0.00004),(5, 'B9-65-C-8E-FF0-15', 0.00007);
INSERT INTO traffic VALUES
(1, '2022-05-22', 9127),(2, '2022-05-31', 99874),(3, '2022-05-22', 8386),
(4, '2022-05-22', 93743),(5, '2022-05-16', 84660),(5, '2022-05-28', 63267);

-- Solution for Question 57:
SELECT
    c.mac,
    SUM(t.amount) AS traffic,
    SUM(t.amount * c.tariff) AS cost
FROM
    clients c
JOIN
    traffic t ON c.id = t.client_id
WHERE
    EXTRACT(YEAR FROM t.dt::date) = 2022 AND EXTRACT(MONTH FROM t.dt::date) = 5
GROUP BY
    c.mac
ORDER BY
    cost DESC;

---
-- =====================================================
-- QUESTION 58: The Yellow Pages Companies Report
-- =====================================================

DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS companies;
CREATE TABLE companies ( id SMALLINT PRIMARY KEY, name VARCHAR(255), address VARCHAR(255), phone VARCHAR(255) );
CREATE TABLE categories ( company_id SMALLINT, name VARCHAR(255), review_rating SMALLINT, FOREIGN KEY (company_id) REFERENCES companies(id) );

INSERT INTO companies VALUES
(1, 'Casper, Oberbrunner and Williamson', '53 Di Loreto Hill', '+420 (569) 566-3689'),
(2, 'Tromp, Kozey and Abbott', '84 Mcguire Plaza', '+62 (145) 722-2330'),
(3, 'Gerlach, Hayes and Stamm', '80 Service Point', '+86 (731) 234-4119'),
(4, 'Wolff-Fadel', '06 Fair Oaks Trail', '+7 (894) 233-0976'),
(5, 'Kihn-Cronin', '483 Nobel Road', '+1 (396) 693-1661');
INSERT INTO categories VALUES
(1, 'HVAC', 2),(2, 'HVAC', 2),(2, 'Retaining Wall and Brick Pavers', 1),(2, 'Rebar & Wire Mesh Install', 2),
(3, 'Prefabricated Aluminum Metal Canopies', 2),(3, 'Prefabricated Aluminum Metal Canopies', 0),
(3, 'RF Shielding', 2),(3, 'Overhead Doors', 0),(3, 'Rebar & Wire Mesh Install', 5),(3, 'Termite Control', 0),
(4, 'Sitework & Site Utilities', 0),(4, 'Electrical and Fire Alarm', 2),(4, 'Masonry', 2),
(4, 'Temp Fencing, Decorative Fencing and Gates', 0),(4, 'Elevator', 1),(4, 'Drywall & Acoustical (FED)', 5),
(5, 'Asphalt Paving', 0),(5, 'Glass & Glazing', 1),(5, 'Framing (Steel)', 3),(5, 'Structural & Misc Steel Erection', 1);

-- Solution for Question 58:
SELECT
    co.name,
    co.address,
    co.phone,
    to_char(AVG(cat.review_rating), 'FM9.0') || ' (' || COUNT(cat.name) || ' categories)' AS overall_review_rating
FROM
    companies co
JOIN
    categories cat ON co.id = cat.company_id
GROUP BY
    co.id, co.name, co.address, co.phone
ORDER BY
    AVG(cat.review_rating) DESC,
    co.name ASC;

---
-- =====================================================
-- QUESTION 59: Domain Name Registrar Accounts Report
-- =====================================================

DROP TABLE IF EXISTS domains;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts ( id SMALLINT PRIMARY KEY, username VARCHAR(255), is_active BOOLEAN );
CREATE TABLE domains ( account_id SMALLINT, name VARCHAR(255), expiration_date VARCHAR(19), FOREIGN KEY (account_id) REFERENCES accounts(id) );

INSERT INTO accounts VALUES
(1, 'obeedie0', FALSE),(2, 'stopham1', TRUE),(3, 'ndolder2', TRUE),
(4, 'jyanshinov3', TRUE),(5, 'ewilflinger4', FALSE);
INSERT INTO domains VALUES
(2, 'merriam-webster.com', '2022-02-20'), (2, 'tripod.com', '2022-08-08'),
(3, 'ca.gov', '2022-04-24'),(3, 'ehow.com', '2022-06-28'),(3, 'purevolume.com', '2022-07-01'),
(3, 'squidoo.com', '2022-10-27'), (3, 'eepurl.com', '2022-12-21'),(4, 'digg.com', '2022-05-14'),
(4, 'jugem.jp', '2022-08-05'), (4, 'artisteer.com', '2022-10-21');

-- Solution for Question 59:
SELECT
    a.username,
    COUNT(d.name) AS domains,
    MIN(d.expiration_date)::date AS nearest_expiration
FROM
    accounts a
JOIN
    domains d ON a.id = d.account_id
WHERE
    a.is_active = TRUE
    AND d.expiration_date::date > '2022-07-15'
GROUP BY
    a.username
ORDER BY
    a.username ASC;

---
-- =====================================================
-- QUESTION 60: Advertising Network Events Report
-- =====================================================

DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS campaigns;
CREATE TABLE campaigns ( id SMALLINT PRIMARY KEY, name VARCHAR(255) );
CREATE TABLE events ( campaign_id SMALLINT, dt VARCHAR(19), value DECIMAL(6,5), FOREIGN KEY (campaign_id) REFERENCES campaigns(id) );

INSERT INTO campaigns VALUES
(1, '11-080 - Registration Equipment'),(2, '12-700 - Systems Furniture'),(3, '9-900 - Paints and Coatings');
INSERT INTO events VALUES
(1, '2022-07-15 01:19:44', 0.97144),(1, '2022-07-15 22:52:02', 0.60728),
(2, '2022-07-15 06:43:08', 0.16662),(3, '2022-07-15 01:17:41', 0.37531),
(3, '2022-07-15 14:20:48', 0.24872);

-- Solution for Question 60:
SELECT
    c.name AS campaign,
    COUNT(e.campaign_id) AS events,
    AVG(e.value) AS average_value
FROM
    campaigns c
JOIN
    events e ON c.id = e.campaign_id
WHERE
    e.dt::date = '2022-07-15'
GROUP BY
    c.name
HAVING
    AVG(e.value) >= 0.7
ORDER BY
    average_value DESC;

---
-- =====================================================
-- QUESTION 61: Ecommerce Deal Report
-- =====================================================

DROP TABLE IF EXISTS deals;
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles ( id SMALLINT PRIMARY KEY, first_name VARCHAR(255), last_name VARCHAR(255), email VARCHAR(255) );
CREATE TABLE deals ( profile_id SMALLINT, dt VARCHAR(19), amount DECIMAL(5,2), FOREIGN KEY (profile_id) REFERENCES profiles(id) );

INSERT INTO profiles VALUES
(1, 'Wallis', 'Treadway', 'wtreadway0@senate.gov'), (2, 'Franklin', 'Blackston', 'fblackston1@parallels.com'),
(3, 'Honoria', 'Constant', 'hconstant2@umich.edu'), (4, 'Bertine', 'Hillaby', 'bhillaby3@artisteer.com'),
(5, 'Constance', 'Knutsen', 'cknutsen4@google.ca');
INSERT INTO deals VALUES
(4, '2022-06-04 07:16:27', 22.31), (4, '2022-06-04 14:15:03', 36.33), (5, '2022-06-04 15:03:10', 21.41),
(1, '2022-06-07 02:58:06', 92.84), (4, '2022-06-08 05:09:52', 24.41), (3, '2022-06-13 03:28:52', 61.55),
(4, '2022-06-16 15:09:39', 77.70), (5, '2022-06-18 16:51:32', 58.79), (4, '2022-06-20 02:55:20', 43.61),
(3, '2022-06-22 06:52:10', 10.41), (1, '2022-06-23 04:59:05', 6.59), (1, '2022-06-30 16:11:02', 43.07);

-- Solution for Question 61:
SELECT
    p.first_name,
    p.last_name,
    p.email,
    SUM(d.amount) AS total
FROM
    profiles p
JOIN
    deals d ON p.id = d.profile_id
WHERE
    EXTRACT(YEAR FROM d.dt::timestamp) = 2022 AND EXTRACT(MONTH FROM d.dt::timestamp) = 6
GROUP BY
    p.id, p.first_name, p.last_name, p.email
ORDER BY
    total DESC
LIMIT 3;

---
-- =====================================================
-- QUESTION 62: Freelance Platform Candidate Review
-- =====================================================

DROP TABLE IF EXISTS stats;
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles ( id SMALLINT PRIMARY KEY, first_name VARCHAR(255), last_name VARCHAR(255), email VARCHAR(255), is_verified BOOLEAN );
CREATE TABLE stats ( profile_id SMALLINT, job_success_score SMALLINT, FOREIGN KEY (profile_id) REFERENCES profiles(id) );

INSERT INTO profiles VALUES
(2, 'Dave', 'Halliburton', 'dhalliburton1@pbs.org', TRUE), (3, 'Agneta', 'Dutch', 'adutch2@thetimes.co.uk', TRUE),
(4, 'Kendell', 'Sylvester', 'ksylvester3@canalblog.com', TRUE), (5, 'Koralle', 'Ragsdale', 'kragsdale4@buzzfeed.com', TRUE),
(9, 'Garrik', 'Preddle', 'gpreddle8@topsy.com', TRUE), (10, 'Sophie', 'Messenger', 'smessenger9@myspace.com', TRUE),
(12, 'Kayle', 'Jesteco', 'kjestecob@ocn.ne.jp', TRUE), (13, 'Munroe', 'Chevolleau', 'mchevolleauc@yandex.ru', TRUE),
(14, 'Etheline', 'Choake', 'echoaked@hao123.com', TRUE), (18, 'Margo', 'Finnemore', 'mfinnemoreh@discovery.com', TRUE);
INSERT INTO stats VALUES
(4, 100),(18, 95),(5, 95),(10, 95),(12, 95),(13, 95),(14, 95);

-- Solution for Question 62:
SELECT
    p.first_name,
    p.last_name,
    p.email,
    s.job_success_score
FROM
    profiles p
JOIN
    stats s ON p.id = s.profile_id
WHERE
    p.is_verified = TRUE AND s.job_success_score > 90
ORDER BY
    s.job_success_score DESC,
    p.first_name ASC,
    p.last_name ASC
LIMIT 10;

---
-- =====================================================
-- QUESTION 63: Virtual Machine Deployment Report
-- =====================================================

DROP TABLE IF EXISTS deployments;
DROP TABLE IF EXISTS configurations;
CREATE TABLE configurations ( id VARCHAR(64) PRIMARY KEY, name VARCHAR(255) );
CREATE TABLE deployments ( configuration_id VARCHAR(64), dt VARCHAR(19), FOREIGN KEY (configuration_id) REFERENCES configurations(id) );

INSERT INTO configurations VALUES
('1vcpu_512mb_10gb_500gb', '1 CPU / 512 MB RAM / 10 GB SSD Disk / 500 GB transfer'),
('1vcpu_1gb_25gb_1tb', '1 CPU / 1 GB RAM / 25 GB SSD Disk / 1000 GB transfer'),
('1vcpu_2gb_50gb_2tb', '1 CPU / 2 GB RAM / 50 GB SSD Disk / 2 TB transfer'),
('2vcpu_2gb_60gb_3tb', '2 CPUs / 2 GB RAM / 60 GB SSD Disk / 3 TB transfer'),
('2vcpu_4gb_80gb_4tb', '2 CPUs / 4 GB RAM / 80 GB SSD Disk / 4 TB transfer'),
('4vcpu_8gb_160gb_5tb', '4 CPUs / 8 GB RAM / 160 GB SSD Disk / 5 TB transfer'),
('8vcpu_16gb_320gb_6tb', '8 CPUs / 16 GB RAM / 320 GB SSD Disk / 6 TB transfer');
INSERT INTO deployments VALUES
('1vcpu_1gb_25gb_1tb', '2021-12-27 07:07:23'), ('1vcpu_2gb_50gb_2tb', '2021-08-25 22:24:10'),
('1vcpu_2gb_50gb_2tb', '2021-11-01 19:00:30'), ('1vcpu_512mb_10gb_500gb', '2021-03-25 06:13:36'),
('1vcpu_512mb_10gb_500gb', '2021-05-31 05:03:28'), ('1vcpu_512mb_10gb_500gb', '2021-11-26 10:53:05'),
('2vcpu_2gb_60gb_3tb', '2021-01-24 15:41:42'), ('2vcpu_2gb_60gb_3tb', '2021-02-08 02:43:14'),
('2vcpu_2gb_60gb_3tb', '2021-05-24 09:48:16'), ('2vcpu_2gb_60gb_3tb', '2021-10-14 08:26:20'),
('2vcpu_4gb_80gb_4tb', '2021-09-05 22:12:17'), ('2vcpu_4gb_80gb_4tb', '2021-09-23 08:31:50'),
('2vcpu_4gb_80gb_4tb', '2021-09-28 05:15:24'), ('4vcpu_8gb_160gb_5tb', '2021-01-25 09:31:37'),
('8vcpu_16gb_320gb_6tb', '2021-03-26 22:23:42');

-- Solution for Question 63:
SELECT
    c.name AS configuration,
    COUNT(d.configuration_id) AS deployments
FROM
    configurations c
JOIN
    deployments d ON c.id = d.configuration_id
WHERE
    EXTRACT(YEAR FROM d.dt::timestamp) = 2021
GROUP BY
    c.name
ORDER BY
    deployments DESC;

---
-- =====================================================
-- QUESTION 64: Visitors Behavior Report
-- =====================================================

DROP TABLE IF EXISTS events;
CREATE TABLE events ( dt VARCHAR(19), type VARCHAR(64) );
INSERT INTO events VALUES
('2022-05-27 16:12:50', 'buy'), ('2022-05-20 09:09:07', 'buy'), ('2022-05-22 09:06:37', 'buy'),
('2022-05-31 07:49:36', 'buy'), ('2022-05-14 22:29:10', 'buy'), ('2022-05-13 15:00:54', 'sell'),
('2022-05-24 15:40:54', 'sell'), ('2022-05-13 01:20:05', 'sell'), ('2022-05-16 07:07:44', 'sell'),
('2022-05-01 16:57:00', 'sell');

-- Solution for Question 64:
SELECT
    COUNT(*) AS purchases
FROM
    events
WHERE
    type = 'buy'
    AND EXTRACT(YEAR FROM dt::timestamp) = 2022
    AND EXTRACT(MONTH FROM dt::timestamp) = 5;

---
-- =====================================================
-- QUESTION 65: Advertising Campaigns Report
-- =====================================================

DROP TABLE IF EXISTS campaigns;
DROP TABLE IF EXISTS companies;
CREATE TABLE companies ( id SMALLINT PRIMARY KEY, name VARCHAR(255) );
CREATE TABLE campaigns ( company_id SMALLINT, expenses DECIMAL(7,2), revenue DECIMAL(7,2), FOREIGN KEY (company_id) REFERENCES companies(id) );
INSERT INTO companies VALUES
(1, 'Lion Biotechnologies, Inc.'),(2, 'Boston Private Financial Holdings, Inc.'),(3, 'Universal Corporation'),(4, 'Arbutus Biopharma Corporation'),
(5, 'Royal Bank Of Canada'),(6, 'Penn West Petroleum Ltd'),(7, 'Public Storage'),(8, 'Halcon Resources Corporation'),
(9, 'TTM Technologies, Inc.'),(10, 'Atwood Oceanics, Inc.'),(11, 'ACADIA Pharmaceuticals Inc.'),(12, 'Central European Media Enterprises Ltd.'),
(13, 'Oxbridge Re Holdings Limited'),(14, 'Western Refining Logistics, LP'),(15, 'Vaalco Energy Inc'),(16, 'Xilinx, Inc.'),
(17, 'Liberty Global plc'),(18, 'Honda Motor Company, Ltd.'),(19, 'Great Plains Energy Inc'),(20, 'Assurant, Inc.');
INSERT INTO campaigns VALUES
(1, 7390.24, 8652.18),(2, 5774.65, 7955.47),(3, 2154.71, 5920.23),(4, 9366.49, 3397.85),
(5, 2765.18, 9158.63),(6, 7908.41, 5018.85),(7, 2251.44, 6654.52),(8, 3383.14, 9354.79),
(9, 8287.96, 9522.53),(10, 4356.62, 4658.52),(11, 9272.86, 9161.77),(12, 4996.18, 5903.57),
(13, 8354.75, 2259.26),(14, 6402.90, 8146.16),(15, 1692.05, 686.71),(16, 5988.48, 9089.41),
(17, 6192.33, 7580.19),(18, 3016.37, 7761.25),(19, 9838.05, 1293.09),(20, 4386.52, 9513.73);

-- Solution for Question 65:
SELECT
    co.name AS company_name,
    (ca.revenue - ca.expenses) AS profit
FROM
    companies co
JOIN
    campaigns ca ON co.id = ca.company_id
WHERE
    ca.revenue > ca.expenses
ORDER BY
    profit DESC
LIMIT 3;

---
-- =====================================================
-- QUESTION 66: Traffic Audit Report
-- =====================================================

DROP TABLE IF EXISTS clients;
CREATE TABLE clients ( mac VARCHAR(64), upstream_rate INT, downstream_rate INT, downtime_rate VARCHAR(64) );
INSERT INTO clients VALUES
('78-C1-E5-20-D5-61', 925526, 5195, 'never'),('78-E2-20-71-9C-30', 582152, 375829, 'never'),
('0D-09-F7-77-03-E5', 359529, 710743, 'never'),('56-18-67-55-58-EA', 78626, 562544, 'once');

-- Solution for Question 66:
SELECT
    mac,
    upstream_rate,
    downstream_rate,
    downtime_rate
FROM
    clients
WHERE
    downstream_rate > upstream_rate
    AND downtime_rate IN ('never', 'once')
ORDER BY
    mac ASC;

---
-- =====================================================
-- QUESTION 67: Calendar Application Events Report
-- =====================================================

DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS owners;
CREATE TABLE owners ( id SMALLINT PRIMARY KEY, full_name VARCHAR(255), email_address VARCHAR(255), on_vacation BOOLEAN );
CREATE TABLE events ( owner_id SMALLINT, dt VARCHAR(19), title VARCHAR(255), FOREIGN KEY (owner_id) REFERENCES owners(id) );

INSERT INTO owners VALUES
(1, 'Benjamin Sevier', 'bsevier0@discuz.net', TRUE),(2, 'Aleksandr Fellows', 'afellows1@instagram.com', FALSE),
(3, 'Collette Pack', 'cpack2@mit.edu', FALSE),(4, 'Lorelle Squibb', 'lsquibb3@huffingtonpost.com', FALSE),
(5, 'Cointon Welberry', 'cwelberry4@theguardian.com', TRUE);
INSERT INTO events VALUES
(1, '2021-08-13 09:17:41', 'ac consequat metus sapien ut'),(2, '2021-01-17 23:34:59', 'eu mi nulla ac'),
(2, '2021-01-26 15:59:04', 'nisl venenatis lacinia'),(2, '2021-04-25 05:04:29', 'arcu adipiscing molestie hendrerit'),
(3, '2021-03-11 08:25:21', 'felis sed interdum venenatis'),(4, '2021-02-28 16:10:55', 'cras mi pede malesuada in imperdiet et');

-- Solution for Question 67:
SELECT
    e.dt::timestamp,
    e.title,
    o.full_name,
    o.email_address
FROM
    events e
JOIN
    owners o ON e.owner_id = o.id
WHERE
    o.on_vacation = FALSE
ORDER BY
    dt ASC
LIMIT 5;

---
-- =====================================================
-- QUESTION 68: Firewall Active Clients Tracking
-- =====================================================

DROP TABLE IF EXISTS traffic;
DROP TABLE IF EXISTS clients;
CREATE TABLE clients ( id SMALLINT PRIMARY KEY, mac VARCHAR(64) );
CREATE TABLE traffic ( client_id SMALLINT, amount INT, FOREIGN KEY (client_id) REFERENCES clients(id) );

INSERT INTO clients VALUES
(3, '3A-4E-A6-43-1D-B1'),(8, 'E9-6-89-7FF-8D-34'),(14, '57-F7-E7-E7-45-36'),(16, '46-06-F1-B9-65-7C'),
(17, '0A-E0-26-9D-2A-27'),(18, '0-86-99-18-36-9BF'),(19, 'DD-81-B-53-BD-9BF'),(20, '50-53-64-8E-42-BE');
INSERT INTO traffic VALUES
(3, 6385047),(8, 6490817),(14, 9109219),(16, 5558512),(17, 1870152),(17, 8228920),
(18, 326127),(18, 5429741),(18, 4063477),(19, 7411789),(20, 5832337),(20, 1426585);

-- Solution for Question 68:
SELECT DISTINCT
    c.mac
FROM
    clients c
JOIN
    traffic t ON c.id = t.client_id
ORDER BY
    c.mac ASC;

---
-- =====================================================
-- QUESTION 69: Active Wallets
-- =====================================================

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS wallets;
CREATE TABLE wallets ( id SMALLINT PRIMARY KEY, address VARCHAR(64) );
CREATE TABLE transactions ( wallet_id SMALLINT, credit DECIMAL(4,2), FOREIGN KEY (wallet_id) REFERENCES wallets(id) );

INSERT INTO wallets VALUES
(3, '0x54c5c516b5c601a3e6fdea18db966186274879e6'),(6, '0xb38ca2076b2c3a0a1c0796ccab5dc3fcbb645336'),
(8, '0x76cfbf67e1765117a98fd2286bdbcb731b0d29ec'),(10, '0x010a4b23f985eda6b397864878cb70bf0b233aa6'),
(14, '0x6b021b12b779aec27009f18bd6ad227685df5474'),(15, '0x7073e9f48b7211d9940db4c8bad8e31d5d9d0577'),
(16, '0x4672e132b9627a7db76e5af431bb5febc93b1b2f'),(20, '0x1a31ac1b923fcc17a42a340091424ea18192a3e7');
INSERT INTO transactions VALUES
(3, 5.21),(6, 24.04),(8, 29.66),(10, 1.67),(10, 3.32),(10, 4.27),(14, 3.32),
(14, 3.35),(15, 14.34),(16, 11.94),(20, 13.86),(20, 16.54);

-- Solution for Question 69:
SELECT DISTINCT
    w.address
FROM
    wallets w
JOIN
    transactions t ON w.id = t.wallet_id
ORDER BY
    w.address ASC;

---
-- =====================================================
-- QUESTION 70: Animal Tracking
-- =====================================================

DROP TABLE IF EXISTS tracklog;
DROP TABLE IF EXISTS animals;
CREATE TABLE animals ( id SMALLINT PRIMARY KEY, name VARCHAR(64) );
CREATE TABLE tracklog ( animal_id SMALLINT, tracked_at VARCHAR(19), FOREIGN KEY (animal_id) REFERENCES animals(id) );

INSERT INTO animals VALUES
(2, 'Jungle kangaroo'),(5, 'Stork, woolly-necked'),(8, 'Capybara'),(9, 'Black-backed jackal'),
(11, 'Wombat, southern hairy-nosed'),(15, 'Indian star tortoise'),(19, 'Black-eyed bulbul');
INSERT INTO tracklog VALUES
(2, '2021-07-08 12:30:34'),(5, '2021-09-15 03:00:04'),(8, '2021-12-14 11:20:50'),(9, '2021-05-15 14:54:15'),
(11, '2021-07-03 17:04:14'),(11, '2021-02-23 09:02:11'),(15, '2021-11-02 22:49:37'),(15, '2021-07-31 04:51:25'),
(15, '2021-06-06 14:57:23'),(19, '2021-03-25 02:00:31'),(19, '2021-04-21 22:02:51'),(19, '2021-07-17 17:12:35');

-- Solution for Question 70:
SELECT
    a.name
FROM
    animals a
WHERE
    EXISTS (
        SELECT 1
        FROM tracklog t
        WHERE t.animal_id = a.id
    )
ORDER BY
    a.name ASC;
