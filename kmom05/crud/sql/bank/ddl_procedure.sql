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