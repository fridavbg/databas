--
-- Create the database structure
--

-- Create table larare in database skolan.
--
USE skolan;

-- DROP TABLES in right order to avoid FK constraint
DROP VIEW IF EXISTS v_planering;
DROP TABLE if EXISTS kurstillfalle;
DROP TABLE if EXISTS kurs;
DROP TABLE IF EXISTS larare_pre;
DROP VIEW IF EXISTS v_larare;

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
    kompetens INT NOT NULL DEFAULT 1,

    PRIMARY KEY (akronym)
);

-- SHOW larare TABLE
-- DESCRIBE larare;

--
-- Make copy of table
--
CREATE TABLE larare_pre LIKE larare;


-- Create a view of larare table with an age column
--

CREATE VIEW v_larare
AS
SELECT
    akronym,
    avdelning,
    fornamn,
    efternamn,
    kon,
    lon,
    fodd,
    kompetens,
    FLOOR((CURDATE() - fodd) / 10000) AS Alder
FROM larare;

-- Show view TABLE structure
-- DESCRIBE v_larare;

-- View to show old/new wage, wage increase in %, warning if wage increase does not reach 3% 

DROP VIEW IF EXISTS v_lonerevision;

CREATE VIEW v_lonerevision
AS
SELECT
    l.akronym,
    l.fornamn,
    l.efternamn,
    p.lon AS "pre",
    l.lon AS "nu",
    l.lon - p.lon AS "diff",
    CAST(ROUND(((l.lon / p.lon) -1) * 100, 2) AS DECIMAL(15, 2)) AS "proc",
    IF(CAST(ROUND(((l.lon / p.lon) -1) * 100, 2) AS DECIMAL(15, 2)) > 3,"ok","nok") AS mini,
    p.kompetens AS "prekomp",
    l.kompetens AS "nukomp",
    l.kompetens - p.kompetens AS "diffkomp"
FROM larare AS l
    JOIN larare_pre AS p
        ON l.akronym = p.akronym
;


-- Show view v_lonerevision;
-- DESCRIBE v_lonerevision;

--
-- Create table for courses
--

CREATE TABLE kurs
(
    kod CHAR(6) NOT NULL,
    namn VARCHAR(40),
    poang FLOAT,
    niva CHAR(3),

    PRIMARY KEY (kod)    
);

-- SHOW kurs table
-- DESCRIBE kurs;

--
-- Create table for course moments 
--

CREATE TABLE kurstillfalle
(
    id INT AUTO_INCREMENT NOT NULL,
    kurskod VARCHAR(6) NOT NULL,
    kursansvarig CHAR(3) NOT NULL,
    lasperiod INT NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (kurskod) REFERENCES kurs(kod),
    FOREIGN KEY (kursansvarig) REFERENCES larare(akronym)
);

-- SHOW kurstillfalle table
/* SHOW CREATE TABLE kurstillfalle \G; */

--
-- Create view of kurs, kurstillfalle, larare
--

DROP VIEW IF EXISTS v_planering;

CREATE VIEW v_planering
AS
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN larare AS l
        ON l.akronym = kt.kursansvarig;

DESCRIBE v_planering;