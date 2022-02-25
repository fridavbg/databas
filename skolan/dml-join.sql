--
-- Join tables
--

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

SELECT
    akronym, fornamn, efternamn, pre, nu, diff, proc, mini
FROM v_lonerevision
ORDER BY proc DESC
;

SELECT
    l.akronym,
    l.fornamn,
    l.efternamn,
    p.kompetens AS prekomp,
    l.kompetens AS nukomp,
    (l.kompetens - p.kompetens) AS diffkomp
FROM larare AS l
    JOIN larare_pre AS p
        ON l.akronym = p.akronym
ORDER BY diffkomp DESC
;