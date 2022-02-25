--
-- Collection of code from dml-files
--

DELETE FROM larare;

-- Add teacher staff

INSERT INTO larare VALUES ('sna', 'DIPT', 'Severus', 'Snape', 'M', 40000, '1951-05-01', 1);
INSERT INTO larare VALUES ('dum', 'ADM', 'Albus', 'Dumbledore', 'M', 80000, '1941-04-01', 1);
INSERT INTO larare VALUES ('min', 'DIDD', 'Minerva', 'McGonagall', 'K', 40000, '1955-05-05', 1);

INSERT INTO larare VALUES
    ('hag', 'ADM', 'Hagrid', 'Rubeus', 'M', 25000, '1956-05-06', 1),
    ('fil', 'ADM', 'Argus', 'Filch', 'M', 25000, '1946-04-06', 1),
    ('hoc', 'DIDD', 'Madam', 'Hooch', 'K', 35000, '1948-04-08', 1)
;

-- Add teachers with data on specified columns (useful if some data from certain columns are missing)
-- Salary in this case will have value NULL
-- Could also have done is like above but with explicit value NULL

INSERT INTO larare
    (akronym, avdelning, fornamn, efternamn, kon, fodd)
VALUES
    ('gyl', 'DIPT', 'Gyllenroy', 'Lockman', 'M', '1952-05-02'),
    ('ala', 'DIPT', 'Alastor', 'Moody', 'M', '1943-04-03')
;

-- Set "default" salary for all teachers with no salary

UPDATE larare
    SET
        lon = 30000
    WHERE
        lon IS NULL
;


-- Make copy content of table

INSERT INTO
    larare_pre
SELECT
    *
FROM
larare
;



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

-- SELECT * FROM kurs;


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

-- SELECT * FROM kurstillfalle;
