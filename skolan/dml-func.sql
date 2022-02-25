--
-- Use built-in functions
--

SELECT
    CONCAT(fornamn, ' ', efternamn, ' (', avdelning, ')') AS NamnOchAvdelning
FROM
    larare
;

SELECT
    CONCAT(fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS NamnOchAvdelning
FROM
    larare
LIMIT
    3
;

SELECT
    CURRENT_DATE AS 'Dagens datum'
;

SELECT
    fornamn,
    fodd,
    CURRENT_DATE AS 'Dagens datum',
    CURRENT_TIME AS 'Klockslag'
FROM
    larare
;

-- Calculate age with TIMESTAMDIFF
SELECT
    fornamn,
    fodd,
    TIMESTAMPDIFF(YEAR, fodd, CURRENT_DATE) AS Alder
FROM
    larare
ORDER BY
    Alder DESC
;

-- Shows persons born on May
SELECT
    fornamn,
    fodd,
    MONTHNAME(fodd) AS 'Månad'
FROM
    larare
WHERE
    MONTH(fodd) = 5
;

-- Shows persons born during the 40's
SELECT
    fornamn,
    fodd,
    TIMESTAMPDIFF(year, fodd, CURRENT_DATE) AS Alder
FROM
    larare
WHERE
    YEAR(fodd) >= 1940 AND
    YEAR(fodd) < 1950
;
