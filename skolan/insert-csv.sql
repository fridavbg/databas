
--
-- Load data from csv-file (excel)
--




-- Delete tables, in order, depending on
-- foreign key constraints.
DELETE FROM kurstillfalle;
DELETE FROM kurs;


-- Insert into kurs
-- Ignore 1 Lines syftar på översta meningen i filen
-- som är meningslös!

LOAD DATA LOCAL INFILE 'kurs.csv'
INTO TABLE kurs
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM kurs;


-- Insert into kurstillfalle
-- Nederst specifierar vi kolumner där vi ska lägga in data
-- Detta är för att det fattas data till 'id'-kolumnen i csv-filen
-- När antal kolumner inte matchar händer ingenting,
-- om vi inte lägger till specifikation inom paranteser nederst

LOAD DATA LOCAL INFILE 'kurstillfalle.csv'
INTO TABLE kurstillfalle
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(kurskod, kursansvarig, lasperiod)
;

SELECT * FROM kurstillfalle;

SHOW WARNINGS