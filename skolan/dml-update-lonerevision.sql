--
-- Update column values that deals with salary
--

-- SELECT
--     SUM(lon) AS 'Lönesumma',
--     ROUND(SUM(lon) * 0.064, 0) AS 'Lönepott'
-- FROM larare
-- ;

UPDATE larare
    SET
        lon = 85000,
        kompetens = 7
    WHERE
        fornamn = 'Albus'
;

UPDATE larare
    SET
        lon = lon + 4000
    WHERE
        fornamn = 'Minerva'
;

UPDATE larare
    SET
        lon = lon + 2000,
        kompetens = 3
    WHERE
        fornamn = 'Argus'
;

UPDATE larare
    SET
        lon = lon - 3000
    WHERE
        fornamn IN ('Gyllenroy ', 'Alastor')
;

UPDATE larare
    SET
        lon = lon * 1.02
    WHERE
        avdelning = 'DIDD'
;

UPDATE larare
    SET
        lon = lon * 1.03
    WHERE
        kon = 'K'
    AND
        lon < 40000
;

UPDATE larare
    SET
        lon = lon + 5000,
        kompetens = kompetens + 1
    WHERE
        fornamn IN ('Severus ', 'Minerva ', 'Hagrid ')
;

UPDATE larare
    SET
        lon = lon * 1.022
    WHERE
        fornamn NOT IN ('Albus', 'Severus ', 'Minerva ', 'Hagrid ')
;



-- -- Check all teachers salary (from highest to lowest)

-- SELECT akronym, avdelning, fornamn, kon, lon, kompetens
-- FROM larare
-- ORDER BY lon DESC
-- ;

-- -- Check new sum of salary and make calculations

-- SELECT
--     SUM(lon) AS 'Lönesumma',
--     ROUND(SUM(lon) / 305000 * 100 - 100, 4) AS 'Lönesumma ökning %',
--     SUM(kompetens)
-- FROM larare
-- ;
