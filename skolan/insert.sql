-- empty table before insert
TRUNCATE table larare;

--
-- Add teacher staff
--
INSERT INTO larare VALUES ('sna', 'DIPT', 'Severus', 'Snape', 'M', 40000, '1951-05-01', DEFAULT);
INSERT INTO larare VALUES ('dum', 'ADM', 'Albus', 'Dumbledore', 'M', 80000, '1941-04-01', DEFAULT);
INSERT INTO larare VALUES ('min', 'DIDD', 'Minerva', 'McGonagall', 'K', 40000, '1955-05-05', DEFAULT);

INSERT INTO larare VALUES
    ('hag', 'ADM', 'Hagrid', 'Rubeus', 'M', 25000, '1956-05-06', DEFAULT),
    ('fil', 'ADM', 'Argus', 'Filch', 'M', 25000, '1946-04-06', DEFAULT),
    ('hoc', 'DIDD', 'Madam', 'Hooch', 'K', 35000, '1948-04-08', DEFAULT)
;

INSERT INTO larare
    (akronym, avdelning, fornamn, efternamn, kon, fodd, kompetens)
VALUES
    ('gyl', 'DIPT', 'Gyllenroy', 'Lockman', 'M', '1952-05-02', DEFAULT),
    ('ala', 'DIPT', 'Alastor', 'Moody', 'M', '1943-04-03', DEFAULT)
;

--
-- Update a column value
--
UPDATE larare SET lon = 30000 WHERE akronym = 'gyl';

-- update lon to 30000 for akronyms gyl, ala
UPDATE larare
    SET
        lon = 30000
    WHERE
        akronym IN ('gyl', 'ala')
;

-- Remove NULL values, set default to 30000
UPDATE larare
    SET
        lon = 30000
    WHERE
        lon IS NULL
;

INSERT INTO larare_pre SELECT * FROM larare;

-- Check the content of the tables, for sanity checking
-- SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;
-- SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare_pre;

-- SELECT akronym, avdelning, fornamn, kon, lon, kompetens
    -- FROM larare
    -- ORDER BY lon DESC;

-- SHOW larare;
-- SELECT * FROM larare;
-- SELECT * FROM larare_pre;