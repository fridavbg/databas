--
-- Create procedure for select * from account
--
DROP PROCEDURE IF EXISTS show_balance;
DELIMITER ;;
CREATE PROCEDURE show_balance()
BEGIN
    SELECT * FROM account;
END
;;
DELIMITER ;

CALL show_balance();

--
-- Create procedure for insert into account
--
DROP PROCEDURE IF EXISTS create_account;
DELIMITER ;;
CREATE PROCEDURE create_account(
    a_id CHAR(4),
    a_name VARCHAR(8),
    a_balance DECIMAL(4, 2)
)
BEGIN
    INSERT INTO account VALUES (a_id, a_name, a_balance);
END
;;
DELIMITER ;

--
-- Create procedure for individual account
--
DROP PROCEDURE IF EXISTS show_account;
DELIMITER ;;
CREATE PROCEDURE show_account(
    a_id CHAR(4)
)
BEGIN
    SELECT * FROM account WHERE id = a_id;
END
;;
DELIMITER ;

CALL show_account("1111");

--
-- Create procedure for edit account details
--
DROP PROCEDURE IF EXISTS edit_account;
DELIMITER ;;
CREATE PROCEDURE edit_account(
    a_id CHAR(4),
    a_name VARCHAR(8),
    a_balance DECIMAL(4, 2)
)
BEGIN
    UPDATE account SET
        `name` = a_name,
        `balance` = a_balance
    WHERE
        `id` = a_id;
END
;;
DELIMITER ;

--
-- Create procedure for delete account
--
DROP PROCEDURE IF EXISTS delete_account;
DELIMITER ;;
CREATE PROCEDURE delete_account(
    a_id CHAR(4)
)
BEGIN
    DELETE FROM account
    WHERE
        `id` = a_id;
END
;;
DELIMITER ;

-- SHOW WARNINGS;