--
-- Join tables
--


SELECT *
FROM kurs;

SELECT *
FROM kurstillfalle;

-- -- A crossjoin (resulting in a loooooot of rows (110))
-- SELECT * FROM kurs, kurstillfalle;


-- Join using WHERE, use alias AS to shorten the statement
SELECT *
FROM kurs AS k, kurstillfalle AS kt
WHERE k.kod = kt.kurskod;

-- Same thing but using JOIN..ON
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod;


-- Join three tables
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN larare AS l
        ON l.akronym = kt.kursansvarig;


DROP VIEW IF EXISTS v_planering;

-- Make it a view
CREATE VIEW v_planering
AS
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN larare AS l
        ON l.akronym = kt.kursansvarig;


-- Make reports from v_planering

SELECT
    akronym AS Akronym,
    CONCAT(fornamn, ' ', efternamn) AS Namn,
    COUNT(akronym) AS Kurstillfallen
FROM
    v_planering
GROUP BY
    akronym
ORDER BY
    Kurstillfallen DESC,
    Fornamn
;

SELECT
    akronym AS Akronym,
    fornamn AS Fornamn,
    efternamn AS Efternamn,
    fodd AS Fodd,
    TIMESTAMPDIFF(year, fodd, CURRENT_DATE) AS Alder
FROM
    larare
ORDER BY
    Alder DESC
LIMIT 3
;

SELECT
    namn AS Kursnamn,
    CONCAT(fornamn, ' ', efternamn, ' (', akronym, ')') AS NamnOchAvdelning,
    TIMESTAMPDIFF(year, fodd, CURRENT_DATE) AS Alder
FROM
    v_planering
ORDER BY
    Alder DESC
LIMIT 6
;



