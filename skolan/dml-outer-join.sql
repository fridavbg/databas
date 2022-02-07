--
-- Outer join, inkludera lärare utan undervisning
--
SELECT DISTINCT
    l.akronym AS Akronym,
    CONCAT(l.fornamn, " ", l.efternamn) AS Namn,
    l.avdelning AS Avdelning,
    kt.kurskod AS Kurskod
FROM larare AS l
    LEFT OUTER JOIN kurstillfalle AS kt
        ON l.akronym = kt.kursansvarig
;

--
-- Outer join, visa vilka kurser som inte har kurstillfällen
--
SELECT DISTINCT
    kurskod,
    namn,
    lasperiod
FROM kurs AS k
    LEFT OUTER JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
WHERE lasperiod IS NULL
;