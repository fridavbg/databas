--
-- Create exam database & user
--

DROP user IF EXISTS 'user'@'localhost';

CREATE USER 'user'@'localhost'
IDENTIFIED BY 'pass';

GRANT ALL PRIVILEGES
ON *.* TO 'user'@'localhost'
WITH GRANT OPTION;

FLUSH PRIVILEGES;

SELECT user FROM mysql.user;

DROP DATABASE IF EXISTS exam;
CREATE DATABASE exam;
USE exam;

-- klient koppling - db motor
-- undvika problem med svenska tecken
SET NAMES utf8;

SHOW DATABASES;

