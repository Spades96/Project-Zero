-- This functions purpose is to calculate the total of the listings price. It does that
-- by taking the sum of the item.
DELIMITER //
CREATE FUNCTION get_total_item_value(p_listing_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE total INT;
    -- I had to do some research about the COALESCE and it helps not return null
    SELECT COALESCE(SUM(item_price), 0) INTO total
    FROM listings
    WHERE listing_id = p_listing_id;
    return total;
END //
DELIMITER ;

-- This trigger counts the amount of times a user has posted a review and takes place after the insert on review
DELIMITER //
CREATE TRIGGER tr_after_review_insert
	AFTER INSERT ON reviews
    FOR EACH ROW
    BEGIN
		UPDATE users
        SET review_count = review_count + 1
        WHERE user_id = NEW.user_id;
	END //
    DELIMITER ;

    -- This trigger logs the time an update on the price occurred and shows the new and old price of the item
    DELIMITER //
    CREATE TRIGGER tr_after_item_price_update
        AFTER UPDATE ON listings
        FOR EACH ROW
        BEGIN
            IF(OLD.item_price != NEW.item_price) THEN
                UPDATE listings
                SET item_price_history = OLD.item_price
                WHERE listing_id = OLD.listing_id;
            END IF;
        END //
    DELIMITER ;

        -- This trigger will check if the listing still has an item in it and will not allow for the listing to be deleted
        DELIMITER //
        CREATE TRIGGER tr_before_listing_delete
        BEFORE DELETE ON listings
        FOR EACH ROW
        BEGIN
			DECLARE item_count INT;
            SELECT COUNT(*) INTO item_count
            FROM listings
            WHERE listing_id = OLD.listing_id;

            IF item_count > 0 THEN
				-- This will give a message to the user letting them know the listing can't be deleted
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete listings';
			END IF;
		END//
        DELIMITER ;

        -- This procedure keeps track if an order is places for a user that exist
        DELIMITER //
        CREATE PROCEDURE place_order(IN p_user_id INT, IN p_order_id INT, IN p_listing_id INT)
        BEGIN
			DECLARE user_exists INT;
            -- Checks if the user exists
            SELECT COUNT(*) INTO user_exists
            FROM users
            WHERE user_id = p_user_id;
            IF user_exists = 0 THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'User Does Not Exist';
			ELSE
				INSERT INTO orders (order_id, user_id, listing_id)
                VALUES (p_order_id, p_user_id, p_listing_id);

                SELECT CONCAT('Order ', p_order_id, ' has been placed for user ', p_user_id) AS confirmation;
			END IF;
		END //
        DELIMITER ;