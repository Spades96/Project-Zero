DROP SCHEMA IF EXISTS project_zero;
CREATE SCHEMA project_zero;
USE project_zero;

-- This table stores the Texas universities that users are required to be enrolled in
CREATE TABLE IF NOT EXISTS universities (
	university_id INT PRIMARY KEY,
	university_name VARCHAR(100) UNIQUE NOT NULL
);

-- Texan university students are the users of our marketplace database
-- This table defines user attributes and enforces the Texas university enrollment requirement
CREATE TABLE IF NOT EXISTS users (
	user_id INT PRIMARY KEY,
	user_name VARCHAR(100) UNIQUE NOT NULL,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	university_id INT NOT NULL,
    review_count INT DEFAULT 0,
	FOREIGN KEY (university_id) REFERENCES universities(university_id)
);

-- This table stores the listings for products/items that users put up
CREATE TABLE IF NOT EXISTS listings (
	listing_id INT PRIMARY KEY,
	category VARCHAR(100) NOT NULL,
    item_name VARCHAR(100) NOT NULL,
	item_price INT NOT NULL,
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- This table stores information on the price history of a listing,
-- how the price of the item in the listing has changed over time
CREATE TABLE IF NOT EXISTS price_history (
    old_price INT NOT NULL,
    new_price INT NOT NULL,
    change_date DATETIME NOT NULL,
    listing_id INT NOT NULL,
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id)
);

-- This table stores orders created when a user buys an item from a listing
CREATE TABLE IF NOT EXISTS orders (
	order_id INT PRIMARY KEY,
	user_id INT NOT NULL,
    listing_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id)
);

-- This table stores the data for reviews created by users
CREATE TABLE IF NOT EXISTS reviews (
	review_id INT PRIMARY KEY,
	rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
	review_text VARCHAR(500) NOT NULL,
	user_id INT NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(user_id)
);
