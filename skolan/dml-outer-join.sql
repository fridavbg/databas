--
-- Join tables outer
--


SELECT DISTINCT
    akronym AS Akronym,
    CONCAT(fornamn, " ", efternamn) AS Namn
FROM v_planering
ORDER BY akronym
;



-- Outer join, inkludera lärare utan undervisning
-- "LEFT OUTER" gör att även de som inte matchar blir inkluderade
-- "LEFT" åsyfter larare och left kommer "kollas av" mot kurstillfalle
SELECT DISTINCT
    l.akronym AS Akronym,
    CONCAT(l.fornamn, " ", l.efternamn) AS Namn,
    l.avdelning AS Avdelning,
    kt.kurskod AS Kurskod
FROM larare AS l
    LEFT OUTER JOIN kurstillfalle AS kt
        ON l.akronym = kt.kursansvarig
;

-- Outer join, samma sak fast med kurser
-- Här använder vi RIGHT för vi jämför höger med vänster:
-- "Skriv ut alla kurskoder i KURSER (right) oavsett om de matchar
-- kurskoder i KURSTILLFÄLLEN (left)"
SELECT
    kt.kurskod AS Kurskod,
    k.namn AS Kursnamn,
    kt.lasperiod AS Lasperiod
FROM kurstillfalle AS kt
    RIGHT OUTER JOIN kurs AS k
        ON k.kod = kt.kurskod
WHERE
    Lasperiod IS NULL
;






