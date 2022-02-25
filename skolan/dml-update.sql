--
-- Update column values
--


UPDATE larare SET lon = 30000 WHERE akronym = 'gyl';


UPDATE larare
    SET
        lon = 30000
    WHERE
        akronym = 'gyl'
        OR akronym = 'ala'
;

-- WHERE IN returns values that match values in a list.
UPDATE larare
    SET
        lon = 30000
    WHERE
        akronym IN ('gyl', 'ala')
;

-- Set "default" salary for all teachers with no salary

UPDATE larare
    SET
        lon = 30000
    WHERE
        lon IS NULL
;

-- -- Check sum of salary

-- SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;

-- -- Check all teachers salary (from highest to lowest)

-- SELECT akronym, avdelning, fornamn, kon, lon, kompetens
-- FROM larare
-- ORDER BY lon DESC;