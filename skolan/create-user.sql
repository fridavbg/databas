--
-- Create new user with all privileges
--

DROP USER IF EXISTS 'maria'@'localhost';

CREATE USER 'maria'@'localhost'
IDENTIFIED BY 'P@ssw0rd'
;

GRANT ALL PRIVILEGES
ON *.* TO 'maria'@'localhost'
WITH GRANT OPTION
;

FLUSH PRIVILEGES;   -- kind of like "refresh" so that changes takes place right away