--
-- Union
--

SELECT
    *,
    'after' AS origin FROM larare
UNION
SELECT
    *,
    'before' AS origin FROM larare_pre
ORDER BY
    akronym
;

DROP VIEW IF EXISTS v_before_after;

CREATE VIEW v_before_after
AS
SELECT
    *,
    'after' AS origin FROM larare
UNION
SELECT
    *,
    'before' AS origin FROM larare_pre
ORDER BY
    akronym
;

SELECT
    v_before_after.origin,
    akronym,
    fornamn,
    efternamn,
    kon,
    kompetens,
    lon
FROM
    v_before_after
WHERE
    akronym IN ('ala', 'dum')
ORDER BY
    akronym,
    origin
;
