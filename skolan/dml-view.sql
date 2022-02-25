--
-- Creates views
--

DROP VIEW IF EXISTS v_namn_alder;

-- Create view
CREATE VIEW v_namn_alder
AS
SELECT
    CONCAT(fornamn, ' ', efternamn, ' (', LOWER(avdelning), ')') AS namn,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM larare;

-- Use view
-- SELECT * FROM v_namn_alder;

-- SELECT
--     *
-- FROM
--     v_namn_alder
-- WHERE
--     Namn LIKE '%di%'
-- ORDER BY
--     alder DESC
-- LIMIT 3
-- ;

-- Alter view
-- ALTER VIEW v_namn_alder
-- ...

DROP VIEW IF EXISTS v_larare;

CREATE VIEW v_larare
AS
SELECT
    *,
    TIMESTAMPDIFF(YEAR, fodd, CURDATE()) AS alder
FROM
    larare
;

-- SELECT
--     avdelning,
--     ROUND(AVG(alder)) AS Snittalder
-- FROM
--     v_larare
-- GROUP BY
--     avdelning
-- ORDER BY
--     Snittalder DESC
-- ;
