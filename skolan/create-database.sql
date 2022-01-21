-- erasse db if it exits
DROP database if exists skolan;

-- create db
CREATE DATABASE skolan;

-- Chose db
USE skolan;

-- show all dbs with skolan in their name
SHOW DATABASES LIKE "%skolan%";
