--
-- Create the database structure
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

-- Add kompetens to larare table
--
-- ALTER TABLE larare ADD COLUMN kompetens INT NOT NULL DEFAULT 1; 

-- ALTER TABLE larare DROP COLUMN kompetens;

ALTER TABLE larare ADD COLUMN kompetens INT NOT NULL DEFAULT 1;

-- Make copy of table
--
DROP TABLE IF EXISTS larare_pre;
CREATE TABLE larare_pre LIKE larare;
INSERT INTO larare_pre SELECT * FROM larare;

-- Check the content of the tables, for sanity checking
SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;
SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare_pre;


-- Create a view of larare table with an age column
--
DROP VIEW IF EXISTS v_larare;

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

-- From v_larare show avg(age) per department, name of department, sorted by AVG(AGE)
--

SELECT
    avdelning,
    ROUND(SUM(Alder) / COUNT(Alder)) AS Snittalder
FROM v_larare
GROUP BY avdelning
ORDER BY Snittalder DESC;

-- SHOW VIEW
-- SELECT * FROM v_larare;

-- JOIN of larare & pre_larare
SELECT
    l.akronym,
    l.lon,
    l.kompetens,
    p.lon AS "pre-lon",
    p.kompetens AS "pre-kompetens"
FROM larare AS l
    JOIN larare_pre AS p
        ON l.akronym = p.akronym
ORDER BY akronym
;

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

-- check wages in v_lonerevision
SELECT
    akronym, fornamn, efternamn, pre, nu, diff, proc, mini
FROM v_lonerevision
ORDER BY proc DESC
;

-- check kompetens in v_lonerevision
SELECT
    akronym, fornamn, efternamn, prekomp, nukomp, diffkomp
FROM v_lonerevision
ORDER BY nukomp DESC, diffkomp DESC
;