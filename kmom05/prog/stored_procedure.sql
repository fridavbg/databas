--
-- Example transactions
-- 
DROP TABLE IF EXISTS account;
CREATE TABLE account
(
    `id` CHAR(4) PRIMARY KEY,
    `name` VARCHAR(8),
    `balance` DECIMAL(4, 2)
);

INSERT INTO account
VALUES
    ('1111', 'Adam', 10.0),
    ('2222', 'Eva', 7.0)
;

-- SELECT * FROM account;

--
-- Move the money, within a transaction
--
-- START TRANSACTION;

-- UPDATE account 
-- SET
--     balance = balance + 1.5
-- WHERE
--     id = '2222';

-- UPDATE account 
-- SET
--     balance = balance - 1.5
-- WHERE
--     id = '1111';
    
-- COMMIT;

-- SELECT * FROM account;

--
-- Procedure move_money()
--
DROP PROCEDURE IF EXISTS move_money;

DELIMITER ;;

CREATE PROCEDURE move_money(
    from_account CHAR(4),
    to_account CHAR(4),
    amount NUMERIC(4, 2)
)
BEGIN
    DECLARE current_balance NUMERIC(4, 2);

    START TRANSACTION;

    SET current_balance = (SELECT balance FROM account WHERE id = from_account);
    SELECT current_balance;

    IF current_balance - amount < 0 THEN
        ROLLBACK;
        SELECT 'Amount on the account is not enough to make transaction.' AS message;
    ELSE
        UPDATE account 
        SET
            balance = balance + amount
        WHERE
            id = to_account;

        UPDATE account 
        SET
            balance = balance - amount
        WHERE
            id = from_account;
            
        COMMIT;
    END IF;

    SELECT * FROM account;
END
;;

DELIMITER ;

CALL move_money('1111', '2222', 1.5);


--
-- EXEMPEL med IN, OUT, INOUT
--

DROP PROCEDURE IF EXISTS get_money;

DELIMITER ;;

CREATE PROCEDURE get_money(
    IN account CHAR(4),
    OUT total NUMERIC(4, 2)
)
    BEGIN
        SELECT balance INTO total FROM account WHERE id = account;
    END
;;

DELIMITER ;

CALL get_money('1111', @sum);
SELECT @sum;

SHOW PROCEDURE STATUS LIKE '%money';
SHOW CREATE PROCEDURE move_money \G;
