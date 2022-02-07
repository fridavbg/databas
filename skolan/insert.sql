-- empty table before insert
SET FOREIGN_KEY_CHECKS = 0; 
TRUNCATE table kurstillfalle;
TRUNCATE table kurs;
TRUNCATE table larare;
TRUNCATE table larare_pre;
SET FOREIGN_KEY_CHECKS = 1;

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

--
-- Add kurs information
--

INSERT INTO kurs
    (kod, namn, poang, niva) 
VALUES
    ("AST101","Astronomi","5","G1N"),
    ("SVT101","Försvar mot svartkonster","8","G1N"),
    ("SVT201","Försvar mot svartkonster","6","G1F"),
    ("SVT202","Försvar mot svartkonster","6","G1F"),
    ("SVT401","Försvar mot svartkonster","6","G2F"),
    ("KVA101","Kvastflygning","4","G1N"),
    ("DJU101","Skötsel och vård av magiska djur","4","G1F"),
    ("DRY101","Trolldryckslära","6","G1N"),
    ("DRY102","Trolldryckslära","6","G1F"),
    ("VAN101","Förvandlingskonst","5","G1F"),
    ("MUG101","Mugglarstudier","6","G1F")
;

-- SELECT * FROM kurs;

--
-- Add kurstillfalle information
--

INSERT INTO kurstillfalle
    (kurskod, kursansvarig, lasperiod) 
VALUES
    ("SVT101","gyl","1"),
    ("SVT201","ala","1"),
    ("SVT202","ala","2"),
    ("SVT401","sna","1"),
    ("KVA101","hoc","1"),
    ("DJU101","hag","3"),
    ("DRY101","sna","2"),
    ("DRY102","sna","3"),
    ("MUG101","min","4")
;

-- SELECT * FROM kurstillfalle;
