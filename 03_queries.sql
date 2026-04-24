-- Retrieve user data (username, first name, last name) and their corresponding listing IDs
SELECT u.user_name,u.first_name,u.last_name,l.listing_id
FROM users u
JOIN listings l
ON u.user_id=l.user_id;

-- Calculate the minimum, maximum, and average item price across all listings
SELECT l.category,MIN(l.item_price) AS "minimum listing",MAX(l.item_price) AS "maximum listing",ROUND(AVG(l.item_price),2) AS "average listing"
FROM listings l
GROUP BY l.category;

-- Calculate the average rating for each user based on their reviews
SELECT 
    u.user_name,
    (
        SELECT ROUND(AVG(r.rating), 2)
        FROM reviews r
        WHERE r.user_id = u.user_id
    ) AS average_rating
FROM users u;

-- Count the number of listings in each category
SELECT l.category,COUNT(*) AS "number of listings"
FROM listings l
GROUP BY l.category;

-- List all listings(id, name, price) sorted by price in descending order
SELECT l.listing_id,l.item_name,l.item_price
FROM listings l
ORDER BY l.item_price DESC;

-- print the listings(name, category, price) that are above $100
SELECT CONCAT(l.item_name, ' (', l.category, ') - $', l.item_price) AS listings
FROM listings l
WHERE l.item_price > 100;

-- Count the number of users who have made at least one order
SELECT COUNT(DISTINCT o.user_id) AS "users with orders"
FROM orders o;

-- Show off  the review count trigger, which updates the review_count column when a new review is added --
SELECT user_id, user_name, review_count
FROM users;

INSERT INTO reviews (review_id, rating,review_text, user_id) 
VALUES (13, 5, 'Great product!', 1);

SELECT user_id, user_name, review_count
FROM users;

-- Show off the price history trigger, which logs price changes for listings --
SELECT listing_id, item_name, item_price
FROM listings;

UPDATE listings
SET item_price = 600
WHERE listing_id = 1;

SELECT old_price, new_price, change_date, listing_id
FROM price_history
WHERE listing_id = 1;

-- Tests the trigger for deleting a listing with an item in it , which should return an error --
DELETE FROM listings
WHERE listing_id = 1;

-- Tests the procedure for placing an order for a user that does not exist, which should return an error --
CALL place_order(999, 13, 1);