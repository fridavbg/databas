--
-- Insert data from csv files
--

DELETE FROM artist;
DELETE FROM landskod;
DELETE FROM spelning;
DELETE FROM speldag;

--
-- Insert into artist
--

LOAD DATA LOCAL INFILE 'artist.csv'
INTO TABLE artist
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES 
    TERMINATED BY '\n'
IGNORE 1 LINES
;

--
-- Insert into landskod
--

LOAD DATA LOCAL INFILE 'landskod.csv'
INTO TABLE landskod
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES 
    TERMINATED BY '\n'
IGNORE 1 LINES
;

--
-- Insert into spelning
--

LOAD DATA LOCAL INFILE 'spelning.csv'
INTO TABLE spelning
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES 
    TERMINATED BY '\n'
IGNORE 1 LINES
;

--
-- Insert into spelning
--

LOAD DATA LOCAL INFILE 'speldag.csv'
INTO TABLE speldag
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES 
    TERMINATED BY '\n'
IGNORE 1 LINES
;
