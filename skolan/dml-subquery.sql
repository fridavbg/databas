--
-- Trying out subquery
--


SELECT
    akronym
FROM larare
WHERE
    avdelning = 'DIDD'
;

SELECT
    *
FROM kurstillfalle
;


-- first subquery
SELECT
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
;

-- UNION using subquery
(
    SELECT akronym, avdelning FROM larare WHERE avdelning = 'DIDD'
)
UNION
(
    SELECT akronym, avdelning FROM larare WHERE avdelning = 'DIPT'
)
;


-- Är det meningen att man ska skriva såhär??
SELECT
    akronym,
    fornamn,
    efternamn,
    alder
FROM
    v_larare
WHERE
    alder = (
        SELECT
            alder
        FROM
            v_larare
        ORDER BY
            alder DESC
        LIMIT 1
    )
;
