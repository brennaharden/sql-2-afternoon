-- PRACTICE JOINS
-- #1
SELECT * FROM invoice
WHERE invoice_id IN(
  SELECT invoice_id FROM invoice_line
  WHERE unit_price > .99);
-- #2
SELECT invoice.invoice_date, customer.first_name, customer.last_name, invoice.total FROM invoice
JOIN customer ON invoice.customer_id = customer.customer_id;
-- #3
SELECT customer.first_name, customer.last_name, employee.first_name, employee.last_name FROM customer
JOIN employee ON customer.support_rep_id = employee.employee_id;
-- #4
SELECT album.title, artist.name FROM album
JOIN artist ON album.artist_id = artist.artist_id;
-- #5
SELECT playlist_track_id FROM playlist_track
JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music';
-- #6
SELECT track.name FROM track
JOIN playlist_track ON track.track_id = playlist_track.track_id
WHERE playlist_track.playlist_id = 5;
-- #7
SELECT track.name, playlist.name FROM track
JOIN playlist_track ON track.track_id = playlist_track.track_id
JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id;
-- #8
SELECT track.name, album.title FROM track
JOIN album ON track.album_id = album.album_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Alternative & Punk';
-- Practice Nested Queries
-- #1
SELECT * FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > .99);
-- #2
SELECT * from playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music');
-- #3
SELECT name FROM track
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5);
-- #4
SELECT * FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Comedy');
-- #5
SELECT * FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball');
-- #6
SELECT * FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE artist_id IN (SELECT artist_id FROM artist WHERE name = 'Queen'));
-- Practice Updating Rows
-- #1
UPDATE customer
SET fax = null;
-- #2
UPDATE customer
SET company = 'Self'
WHERE company IS NULL;
-- #3
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';
-- #4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';
-- #5
UPDATE track
SET composer = 'The darkness around us'
WHERE composer IS NULL AND genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal');
-- #6
-- Refreshed
-- Group By
-- #1
SELECT COUNT(*), genre.name FROM track
JOIN genre ON track.genre_id = genre.genre_id
GROUP BY genre.name;
-- #2
SELECT COUNT(*), genre.name FROM track
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name IN ('Pop', 'Rock')
GROUP BY genre.name;
-- #3
SELECT artist.name, COUNT(*) FROM album
JOIN artist ON artist.artist_id = album.artist_id
GROUP BY artist.name;
-- Use Distinct
-- #1
SELECT DISTINCT composer FROM track;
-- #2
SELECT DISTINCT billing_postal_code FROM invoice;
-- #3
SELECT DISTINCT company FROM customer;
-- Delete Rows
-- #1
-- Executed
-- #2
DELETE FROM practice_delete
WHERE type = 'bronze';
-- #3
DELETE FROM practice_delete
WHERE type = 'silver';
-- #4
DELETE FROM practice_delete
WHERE value = 150;
-- eCommerce Simulation
-- -- -- -- -- -- -- -- --
CREATE TABLE users(
user_id SERIAL PRIMARY KEY,
name VARCHAR(25),
email VARCHAR(30)
);

CREATE TABLE products(
product_id SERIAL PRIMARY KEY,
name VARCHAR(30),
price INT
);

CREATE TABLE orders(
order_id SERIAL PRIMARY KEY,
product_id INT REFERENCES products(product_id)
);
 
 INSERT INTO users(name, email)
VALUES
('Bitsy', 'mindyisthebest@kaling.net'),
('Brenna', 'noshowbizplz@wme.com'),
('Chris', 'iloveny@bigapple.org');

INSERT INTO products(name, price)
VALUES
('cookie', 1),
('juice water', 1.50),
('lamb biryani', 14.99);

INSERT INTO orders(product_id)
VALUES
(3), (3), (2);

SELECT products.name FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE order_id = 1;

SELECT * FROM orders;

SELECT SUM(products.price) FROM orders
JOIN products ON orders.product_id = products.product_id
WHERE order_id = 2;

ALTER TABLE orders
ADD COLUMN user_id INT REFERENCES users(user_id);

SELECT * FROM orders
WHERE user_id = 2;

SELECT users.name, COUNT(*)  FROM orders
JOIN users ON orders.user_id = users.user_id
GROUP BY users.name;



