SELECT u.user_name,u.first_name,u.last_name,l.listing_id
FROM users u
JOIN listings l
ON u.user_id=l.user_id;

SELECT MIN(l.item_price) AS "minimum listing",MAX(l.item_price) AS "maximum listing",ROUND(AVG(l.item_price),2) AS "average listing item_price"
FROM listings l;

SELECT 
    u.user_name,
    (
        SELECT ROUND(AVG(r.rating), 2)
        FROM reviews r
        WHERE r.user_id = u.user_id
    ) AS average_rating
FROM users u;

SELECT l.category,COUNT(*) AS "number of listings"
FROM listings l
GROUP BY l.category;


SELECT l.listing_id,l.item_name,l.item_price
FROM listings l
ORDER BY l.item_price DESC;

SELECT CONCAT(l.item_name, ' (', l.category, ') - $', l.item_price)
FROM listings l
WHERE l.item_price > 100;

SELECT COUNT(DISTINCT o.user_id) AS "users with orders"
FROM orders o;