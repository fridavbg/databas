--
-- Create database structure
--

use exam; 

-- DROP TABLES 
DROP TABLE IF EXISTS medlem;
DROP TABLE IF EXISTS hund;
DROP TABLE IF EXISTS ras;
DROP TABLE IF EXISTS medlem2hund;

-- ---------
-- -- Tables
-- -- 

CREATE TABLE medlem
(
    id INT AUTO_INCREMENT NOT NULL,
    fornamn VARCHAR(20),
    alias VARCHAR(20),
    efternamn VARCHAR(25),
    ort VARCHAR(25),

    PRIMARY KEY (id)
);

CREATE TABLE ras
(
    id VARCHAR(2),
    namn VARCHAR(20),
    godkänd VARCHAR(3),

    PRIMARY KEY(id)
);

CREATE TABLE hund
(
    id INT AUTO_INCREMENT NOT NULL,
    namn VARCHAR(20),
    url VARCHAR(1500),
    ras_id VARCHAR(2),

    PRIMARY KEY(id),
    CONSTRAINT FOREIGN KEY(ras_id) REFERENCES ras(id)
);

CREATE TABLE medlem2hund
(
    id INT AUTO_INCREMENT NOT NULL,
    medlem_id INT,
    hund_id INT,
    registrerad INT,

    PRIMARY KEY(id),
    FOREIGN KEY(medlem_id) REFERENCES medlem(id),
    FOREIGN KEY(hund_id) REFERENCES hund(id)
);

