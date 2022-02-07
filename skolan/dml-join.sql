--
-- JOIN
--

-- JOIN of larare & pre_larare
SELECT
    l.akronym,
    l.lon,
    l.kompetens,
    p.lon AS "pre-lon",
    p.kompetens AS "pre-kompetens",
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