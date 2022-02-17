--
-- Create database bank.
--

-- erasse db if it exits
DROP database if exists bank;

-- create db
CREATE DATABASE bank;

-- Chose db
USE bank;

-- show all dbs with bank in their name
SHOW DATABASES LIKE "%bank%";