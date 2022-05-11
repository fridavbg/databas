--
-- Create database structure
--

use exam;

-- DROP TABLES in right order
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS landskod;
DROP TABLE IF EXISTS speldag;
DROP TABLE IF EXISTS spelning;

CREATE TABLE artist 
(
    id CHAR(3),
    namn VARCHAR(20),
    ort CHAR(15),
    landskod CHAR(2)
);

CREATE TABLE landskod
(
    kod CHAR(2),
    namn CHAR(15),
    PRIMARY KEY (kod)
);

CREATE TABLE speldag
(
    id INT AUTO_INCREMENT NOT NULL,
    namn CHAR(15),
    datum DATE,
    PRIMARY KEY (id)
);

CREATE TABLE spelning
(
    artist_id CHAR(3),
    speldag_id INT,
    klockslag TIME
);

