-- create database
CREATE DATABASE amazon_db;
USE amazon_db;

-- Loading data into database
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = TRUE;
GRANT FILE on *.* to user@'localhost';

create table item_category (
asin text,
cid text);

LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\item_category.csv' 
INTO TABLE item_category 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table item_external (
eid text,
asin text);

-- TODO: remove \r
LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\item_external.csv' 
INTO TABLE item_external 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table category (
cid int,
name text);

LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\category.csv' 
INTO TABLE category 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table author (
aid INT,
name text,
average_rating double ,
ratings_count int,
text_reviews_count int);
 
LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\author.csv' 
INTO TABLE author 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table item_author (
asin text,
aid INT);
 
LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\item_author.csv' 
INTO TABLE item_author 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table also_bought (
asin text,
also_buy text);
 
LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\also_bought.csv' 
INTO TABLE also_bought 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table also_viewed (
asin text,
also_view text);
 
LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\also_viewed.csv' 
INTO TABLE also_viewed 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table review_user (
rid text,
uid text);
 
LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\user_review.csv' 
INTO TABLE review_user
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table user (
uid text,
name text,
verified text);
 
LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\user.csv' 
INTO TABLE user
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

create table review (
rid text,
rating DECIMAL(10, 1),
review_time text,
summary text,
unix_time text,
vote int);
 
LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\review.csv' 
INTO TABLE review
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(rid,@rating,@review_time,@summary,@unix_time,@vote)
SET rating = NULLIF(@rating,''), 
	review_time = NULLIF(@review_time,''),
    summary = NULLIF(@summary,''),
	unix_time = NULLIF(@unix_time,''),
	vote = NULLIF(@vote,'');
    
create table item (
asin text,
title text,
description text,
price DECIMAL (10,2),
`rank` INT,
publisher text,
publication_year int);
 
LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\items.csv' 
INTO TABLE item
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(asin,@title,@description,@price,@`rank`,@publisher,@publication_year)
SET title = NULLIF(@title,''), 
	description = NULLIF(@description,''),
    price = NULLIF(@price,''),
	`rank` = NULLIF(@`rank`,''),
	publisher = NULLIF(@publisher,''),
    publication_year = NULLIF(@publication_year,0);
    
create table external (
eid text,
review_text text,
rating text,
n_votes int,
platform text);
 
LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\external.csv' 
INTO TABLE external
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(eid,@review_text,@rating,@n_votes,@platform)
SET review_text = NULLIF(@review_text,''), 
	rating = NULLIF(@rating,''),
	n_votes = NULLIF(@n_votes,''),
	platform = NULLIF(@platform,'');
    
create table item_review (
rid text,
asin text);
 
LOAD DATA LOCAL INFILE 'D:\\MSc\\DSA5104\\project\\data\\item_review.csv' 
INTO TABLE item_review
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- Set Indices
ALTER TABLE also_bought ADD INDEX idx1 (asin(15));
ALTER TABLE also_bought ADD INDEX idx2 (also_buy(15));
ALTER TABLE also_viewed ADD INDEX idx1 (asin(15));
ALTER TABLE also_viewed ADD INDEX idx2 (also_view(15));
ALTER TABLE author ADD INDEX idx1 (aid);
ALTER TABLE category ADD INDEX idx1 (cid);
ALTER TABLE external ADD INDEX idx1 (eid(12));
ALTER TABLE item ADD INDEX idx1 (asin(15), title(100),`rank`);
ALTER TABLE item_author ADD INDEX idx1 (asin(15));
ALTER TABLE item_author ADD INDEX idx2 (aid);
ALTER TABLE item_category ADD INDEX idx1 (asin(15));
ALTER TABLE item_category ADD INDEX idx2 (cid(15));
ALTER TABLE item_external ADD INDEX idx1 (eid(12));
ALTER TABLE item_external ADD INDEX idx2 (asin(15));
ALTER TABLE item_review ADD INDEX idx1 (asin(15));
ALTER TABLE item_review ADD INDEX idx2 (rid(15));
ALTER TABLE review ADD INDEX idx1 (rid(15),unix_time(15));
ALTER TABLE review_user ADD INDEX idx1 (rid(12));
ALTER TABLE review_user ADD INDEX idx2 (uid(15));
ALTER TABLE `user` ADD INDEX idx1 (uid(15));


-- Queries
-- 1a
SELECT u.name
FROM User u
JOIN Review_user ru ON u.uid = ru.uid
GROUP BY u.name
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 1b
SELECT COUNT(*) AS book_count
FROM Item_category AS ic
JOIN Category AS c ON ic.cid = c.cid
WHERE c.name = 'Piano';

-- 1c
SELECT AVG(r.rating) AS avg_rating
FROM Review r
JOIN Item_review ir ON r.rid = ir.rid
JOIN Item_category ic ON ir.asin = ic.asin
JOIN Category c ON ic.cid = c.cid
WHERE c.name = 'Music';
-- 2a
SELECT COUNT(*) AS book_count
FROM Author a
JOIN Item_author ia ON a.aid = ia.aid
WHERE a.name = 'William Shakespeare';

-- 3a
SELECT i.title AS book_title, AVG(r.rating) AS avg_rating
FROM Item_review AS ir
JOIN (
	SELECT asin, title
	FROM Item
	WHERE asin IN (
		SELECT asin
		FROM author AS a
		JOIN Item_author AS ia ON a.aid = ia.aid
        WHERE a.name = 'William Shakespeare'
	)
) AS i ON ir.asin = i.asin
JOIN Review AS r ON r.rid = ir.rid
GROUP BY book_title
HAVING avg_rating > 4
ORDER BY avg_rating DESC;

-- 4a
SELECT i.title, adb.amazon_rating, edb.external_rating
FROM Item AS i
JOIN (
	SELECT ir.asin, AVG(r.rating) AS amazon_rating
	FROM Item_review AS ir
	JOIN Review AS r ON ir.rid = r.rid
	GROUP BY ir.asin
	HAVING amazon_rating > 3
) AS adb ON adb.asin = i.asin

JOIN(
	SELECT ie.asin, AVG(e.rating) AS external_rating
	FROM Item_external AS ie
	JOIN External AS e ON ie.eid = e.eid
	GROUP BY ie.asin
	HAVING external_rating > 3
) AS edb ON edb.asin = i.asin
ORDER BY adb.amazon_rating DESC, edb.external_rating DESC;

-- 5a
SELECT verified, COUNT(*) AS customer_count
FROM User
GROUP BY verified;

-- 6a
SELECT name, average_rating, ratings_count
FROM Author
ORDER BY ratings_count DESC, average_rating DESC;


-- 6b
SELECT name, AVG(price) AS avg_price
FROM Item
JOIN Item_author ON Item.asin = Item_author.asin
JOIN Author ON Item_author.aid = Author.aid
WHERE publication_year > 2010
GROUP BY name
ORDER BY avg_price DESC
LIMIT 10;

-- 7a
SELECT c.name AS category_name, COUNT(ic.asin) AS book_count
FROM Category c
LEFT JOIN Item_category ic ON c.cid = ic.cid
GROUP BY c.name
ORDER BY book_count ASC;