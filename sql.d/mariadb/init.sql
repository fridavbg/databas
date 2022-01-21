'''
Create User, database and table
'''

CREATE USER 'doe'@'%' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON doe.* TO 'doe'@'%';

CREATE DATABASE doe;
USE doe;

CREATE TABLE doe ( namn CHAR(10) );
INSERT INTO doe VALUES ("Jane Doe"), ("John Doe");