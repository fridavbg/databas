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
SELECT *
FROM kurs AS k
    JOIN kurstillfalle AS kt
        ON k.kod = kt.kurskod
    JOIN larare AS l
        ON l.akronym = kt.kursansvarig;
