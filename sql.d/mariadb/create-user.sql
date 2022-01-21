CREATE USER 'frida'@'localhost'
IDENTIFIED BY 'P@ssw0rd'
;

GRANT ALL PRIVILEGES
ON *.* TO 'frida'@'localhost'
WITH GRANT OPTION
;

FLUSH PRIVILEGES;


