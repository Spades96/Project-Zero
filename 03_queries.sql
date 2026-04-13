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