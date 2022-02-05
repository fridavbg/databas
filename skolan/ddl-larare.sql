--
-- Create table larare in database skolan.
--

USE skolan;

DROP TABLE if exists larare;

CREATE TABLE larare
(
    akronym CHAR(3),
    avdelning CHAR(4),
    fornamn VARCHAR(20),
    efternamn VARCHAR(20),
    kon CHAR(1),
    lon INT,
    fodd DATE,

    PRIMARY KEY (akronym)
);

-- SHOW TABLES;

CREATE TABLE larare      
    akronym CHAR(3),     
    avdelning CHAR(4),     
    fornamn VARCHAR(20),     
    efternamn VARCHAR(20),     
    kon CHAR(1),     
    lon INT,     
    fodd DATE,     
    kompetens INT NOT NULL DEFAULT 1      
    
    PRIMARY KEY (akronym);    