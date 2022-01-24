--
-- Create a user with all privileges
--

-- If users already exists delete

DROP USER IF EXISTS 'frida'@'localhost';

-- create user with pw
CREATE USER 'frida'@'localhost' 
IDENTIFIED BY 'P@ssw0rd';

-- Grant all privileges to user
GRANT ALL PRIVILEGES
ON *.* TO 'frida'@'localhost'
WITH GRANT OPTION
;

-- flush privileges
FLUSH PRIVILEGES;
