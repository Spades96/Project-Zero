DROP SCHEMA IF EXISTS project_zero;
CREATE SCHEMA project_zero;
USE project_zero;

CREATE TABLE IF NOT EXISTS universities (
	university_id INT PRIMARY KEY,
	university_name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
	user_id INT PRIMARY KEY,
	user_name VARCHAR(100) UNIQUE NOT NULL,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	university_id INT NOT NULL,
    review_count INT DEFAULT 0,
	FOREIGN KEY (university_id) REFERENCES universities(university_id)
);

CREATE TABLE IF NOT EXISTS listings (
	listing_id INT PRIMARY KEY,
	category VARCHAR(100) NOT NULL,
    item_name VARCHAR(100) NOT NULL,
	item_price INT NOT NULL,
    item_price_history INT,
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS orders (
	order_id INT PRIMARY KEY,
	user_id INT NOT NULL,
    listing_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id)
);

CREATE TABLE IF NOT EXISTS reviews (
	review_id INT PRIMARY KEY,
	review_text VARCHAR(500) NOT NULL,
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);
