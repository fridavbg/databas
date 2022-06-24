--
-- Create exam database & user
--

DROP user IF EXISTS 'dbadm'@'localhost';

CREATE USER 'dbadm'@'localhost'
IDENTIFIED BY 'P@ssw0rd';

GRANT ALL PRIVILEGES
ON *.* TO 'dbadm'@'localhost'
WITH GRANT OPTION;

FLUSH PRIVILEGES;

DROP DATABASE IF EXISTS exam;
CREATE DATABASE exam;
USE exam;

-- klient koppling - db motor
-- undvika problem med svenska tecken
SET NAMES utf8;

/* SHOW DATABASES;
SELECT CURRENT_USER; */

