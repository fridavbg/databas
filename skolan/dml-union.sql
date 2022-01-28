--
-- UNION
--

-- Join table larare & larare_pre to show new / old wages
SELECT
    *,
    'after' AS origin FROM larare
UNION
SELECT
    *,
    'before' AS origin FROM larare_pre
ORDER BY akronym
;

-- Show new / old wages for Moody & Dumbledore
SELECT
    lon.origin,
    akronym,
    fornamn,
    efternamn,
    kon,
    kompetens,
    lon
FROM
(
    SELECT
        *,
        'after' AS origin FROM larare
    UNION
    SELECT
        *,
        'before' AS origin FROM larare_pre
    ORDER BY akronym
) AS lon
WHERE
    akronym IN ('ala', 'dum')
ORDER BY akronym, origin
;