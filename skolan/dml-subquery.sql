--
-- All teachers in DIDD & All from kurstillfalle
-- DOUBLE SELECT
--

/* SELECT
    *
FROM kurstillfalle
WHERE
    kursansvarig IN (
        SELECT
            akronym
        FROM larare
        WHERE
            avdelning = 'DIDD'
    )
; */

--
-- All teachers in DIDD & DIPT
-- UNION
--

/* (
    SELECT akronym, avdelning FROM larare WHERE avdelning = 'DIDD'
)
UNION
(
    SELECT akronym, avdelning FROM larare WHERE avdelning = 'DIPT'
)
; */

--
-- Details about the oldest teacher in skolan
--

SELECT
    akronym,
    fornamn,
    efternamn,
    Alder
FROM v_larare
WHERE
    Alder = (
        SELECT
            MAX(Alder)
        FROM v_larare
    );