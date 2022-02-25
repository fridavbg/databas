--
-- Create aggregated expressions
--

SELECT
    SUM(lon)
FROM
    larare;

SELECT
    MIN(lon) AS logstaLon
FROM
    larare;

SELECT
    MAX(lon) AS hogstaLon
FROM
    larare;

--- average
SELECT
    AVG(kompetens) AS medelkompetens
FROM
    larare;

-- average in all departments respectively
SELECT
    avdelning,
    AVG(kompetens) AS medelkompetens
FROM
    larare
GROUP BY
    avdelning
ORDER BY
    medelkompetens DESC
;

SELECT
    avdelning,
    kompetens,
    SUM(lon) as summa
FROM
    larare
GROUP BY
    avdelning, kompetens
ORDER BY
    summa DESC
;

SELECT
    COUNT(akronym) AS antalLarare
FROM
    larare
;

SELECT
    avdelning,
    lon
FROM
    larare
GROUP BY
    avdelning
;

SELECT
    avdelning,
    ROUND(AVG(lon), 0) AS medelinkomst
FROM
    larare
GROUP BY
    avdelning
;

SELECT
    avdelning,
    kon,
    ROUND(AVG(lon), 0) AS medelinkomst
FROM
    larare
GROUP BY
    kon
;

SELECT
    avdelning AS smartaAvdelningen,
    ROUND(AVG(kompetens), 0) AS medelkompetens
FROM
    larare
GROUP BY
    avdelning
ORDER BY
    medelkompetens DESC
LIMIT 1
;

SELECT
    avdelning,
    ROUND(AVG(kompetens), 0) AS medelkompetens,
    ROUND(AVG(lon), 0) AS medelinkomst,
    COUNT(akronym) AS antal
FROM
    larare
GROUP BY
    kompetens,
    lon
;


--- HAVING ---
-- It's like 'WHERE' BUT FOR AGGREGATED VALUES ONLY

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
ORDER BY
    Snittlon DESC
;

-- Only show where average income over 35000

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
HAVING
    Snittlon > 35000
ORDER BY
    Snittlon DESC
;

-- Only show where there are more three or more people at department
SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
HAVING
    Antal >= 3
ORDER BY
    Snittlon DESC
;

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
WHERE       -- we first specify here
    kompetens = 1
GROUP BY
    avdelning
HAVING      -- then we make further specification here
    Snittlon < 30000
ORDER BY
    avdelning
;

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(akronym) AS Antal
FROM
    larare
GROUP BY
    avdelning
ORDER BY
    avdelning,
    Snittlon
;

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    kompetens,
    COUNT(akronym) AS Antal
FROM
    larare
GROUP BY
    avdelning,
    kompetens
ORDER BY
    avdelning,
    kompetens DESC
;

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    kompetens,
    COUNT(akronym) AS Antal
FROM
    larare
WHERE
    kompetens <= 3
GROUP BY
    avdelning,
    kompetens
ORDER BY
    avdelning,
    kompetens DESC
;

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    kompetens,
    COUNT(akronym) AS Antal
FROM
    larare
WHERE
    kompetens <= 3
GROUP BY
    avdelning,
    kompetens
HAVING
    Antal <= 1 AND
    Snittlon >= 30000 AND
    Snittlon <= 45000
ORDER BY
    Snittlon DESC
;
