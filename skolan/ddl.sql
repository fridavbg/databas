--
-- Collection of code from ddl-files
--

DROP TABLE IF EXISTS larare;

CREATE TABLE larare
(
    akronym CHAR(3),
    avdelning CHAR(4),
    fornamn VARCHAR(20),
    efternamn VARCHAR(20),
    kon CHAR(1),
    lon INT,
    fodd DATE,
    kompetens INT DEFAULT 1 NOT NULL,

    PRIMARY KEY (akronym)
);


DROP VIEW IF EXISTS v_namn_alder;

-- Create view
CREATE VIEW v_namn_alder
AS
SELECT
    CONCAT(fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM larare;

DROP VIEW IF EXISTS v_larare;


CREATE VIEW v_larare
AS
SELECT
    *,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM
    larare
;



-- Make copy of table before lönerevision
DROP TABLE IF EXISTS larare_pre;

CREATE TABLE
larare_pre LIKE larare;


-- Create view lönerevision

DROP VIEW IF EXISTS v_lonerevision;

CREATE VIEW v_lonerevision
AS
SELECT
    l.akronym,
    l.fornamn,
    l.efternamn,
    p.lon AS pre,
    l.lon AS nu,
    (l.lon - p.lon) AS diff,
    ROUND((((l.lon / p.lon) - 1) * 100), 2) AS proc,
    IF(ROUND((((l.lon / p.lon) - 1) * 100), 2) >= 3, 'ok', 'nook') AS mini
FROM larare AS l
    JOIN larare_pre AS p
        ON l.akronym = p.akronym
ORDER BY proc DESC
;




-- Create table kurs

DROP TABLE IF EXISTS kurs;

CREATE TABLE kurs
(
    kod CHAR(6) NOT NULL,
    namn VARCHAR(40),
    poang FLOAT,
    niva CHAR(3),

    PRIMARY KEY (kod)
);


-- Create table kurstillfälle

DROP TABLE IF EXISTS kurstillfalle;

CREATE TABLE kurstillfalle
(
    id INT AUTO_INCREMENT NOT NULL,
    kurskod VARCHAR(6) NOT NULL,
    kursansvarig VARCHAR(3) NOT NULL,
    lasperiod INT NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (kurskod) REFERENCES kurs(kod),
    FOREIGN KEY (kursansvarig) REFERENCES larare(akronym)
);

-- Three tables join

DROP VIEW IF EXISTS v_planering;

CREATE VIEW v_planering
AS
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN larare AS l
        ON l.akronym = kt.kursansvarig;



-- -- Drop tables in order to avoid FK constraint
-- DROP TABLE IF EXISTS kurstillfalle;
-- DROP TABLE IF EXISTS kurs;

-- -- Check how a table was created
-- -- \G gör att det inte skrivs ut i en tabell utan i en rad
-- SHOW CREATE TABLE kurstillfalle \G;

-- -- Check that tables exist in database
-- SHOW TABLES;