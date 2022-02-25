-- Radera en databas med allt innehåll
DROP DATABASE IF EXISTS bank;

-- Skapa databas
CREATE DATABASE bank;

-- -- Skapa databas om den inte redan finns
-- CREATE DATABASE IF NOT EXISTS skolan;

-- Välj vilken databas du vill använda
USE bank;




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
    ("1111", "Adam", 10.0),
    ("2222", "Eva", 7.0)
;

-- SELECT * FROM account;


--
-- Move the money, within a transaction
--
START TRANSACTION;

UPDATE account
SET
    balance = balance + 1.5
WHERE
    id = "2222";

UPDATE account
SET
    balance = balance - 1.5
WHERE
    id = "1111";

COMMIT;

SELECT * FROM account;