--
-- A crossjoin
--
/* SELECT * FROM kurs, kurstillfalle; */

--
-- Join using WHERE, use alias AS to shorten the statement
--
/* SELECT *
FROM kurs AS k, kurstillfalle AS kt
WHERE k.kod = kt.kurskod; */

--
-- Join using JOIN..ON
--
/* SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod; */

--
-- Join three tables
--
/* SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN larare AS l
        ON l.akronym = kt.kursansvarig; */

--
-- Teacher akronym, name and kurstillfallen
--

SELECT
    akronym,
    CONCAT(fornamn, " ", efternamn) AS Namn,
    COUNT(kurskod) AS Tillfallen
FROM v_planering
GROUP BY akronym
ORDER BY Tillfallen DESC, akronym;

--
-- Three oldest teacher in skolan
--

SELECT
    akronym,
    fornamn,
    efternamn,
    fodd,
    Alder
FROM v_larare
ORDER BY Alder DESC
LIMIT 3;

--
-- Courses with the three oldest teacher in skolan
--

SELECT
    Namn,
    CONCAT(l.fornamn, " ", l.efternamn, " ", "(", LOWER(l.akronym),")") AS Larare,
    Alder
FROM v_larare AS l
    JOIN v_planering AS p
        ON l.akronym = p.akronym
WHERE Alder >= 70
ORDER BY Alder DESC;
