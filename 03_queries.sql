SELECT u.user_name,u.first_name,u.last_name,l.listing_id
FROM users u
JOIN listings l
ON u.user_id=l.user_id;

SELECT MIN(l.price) AS "minimum listing",MAX(l.price) AS "maximum listing",ROUND(AVG(l.price),2) AS "average listing price"
FROM listings l;

SELECT ROUND(AVG(r.rating))AS "average rating"
FROM reviews r;

SELECT l.catergory,COUNT(*) AS "number of unique listings"
FROM listings l
GROUP BY l.category;


SELECT l.listing_id,l.item_name,l.price
FROM listings l
ORDER BY l.price DESC;