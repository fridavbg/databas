--
-- ALTER table larare
--

-- Update columns

-- Albus kompetens är nu 7 och lönen har ökat till 85 000.
UPDATE larare
    SET 
        lon = 85000,
        kompetens = 7
    WHERE
        akronym = 'dum';

-- Minervas lön har ökat med 4 000.
UPDATE larare
    SET 
        lon = lon + 4000
    WHERE
        akronym = 'min';

-- Argus har fått ett risktillägg om 2 000 och kompetensen är satt till 3.
UPDATE larare
    SET 
        lon = lon + 2000,
        kompetens = 3
    WHERE
        akronym = 'fil';

-- Gyllenroy och Alastor har hög frånvaro och har fått ett löneavdrag med 3 000.
UPDATE larare
    SET 
        lon = lon - 3000
    WHERE
        akronym = 'gyl'
        OR akronym = 'ala';

-- Alla lärare på avdelningen DIDD fick en extra lönebonus om 2%.
UPDATE larare
    SET 
        lon = lon + ROUND(lon * 0.02)
    WHERE
        avdelning = 'DIDD';
        
-- Alla låglönade kvinnliga lärare, de som tjänar färre än 40 000, fick en lönejustering om extra 3%.
UPDATE larare
    SET 
        lon = lon + ROUND(lon * 0.03)
    WHERE
        lon < 40000
        OR kon = 'K';

-- Ge Snape, Minerva och Hagrid ett extra lönetillägg om 5 000 för extra arbete de utför åt Albus och öka deras kompetens med +1.
UPDATE larare
    SET 
        lon = lon + 5000,
        kompetens = kompetens + 1
    WHERE
        akronym = 'sna'
        OR akronym = 'min'
        OR akronym = 'hag';

-- Ge alla lärare en ökning om 2.2% men exkludera Albus, Snape, Minerva och Hagrid som redan fått tillräckligt.
UPDATE larare
    SET 
        lon = lon + ROUND(lon * 0.022)
    WHERE
        akronym = 'hoc'
        OR akronym = 'ala'
        OR akronym = 'gyl'
        OR akronym = 'fil';

-- Total salary sum and competence
SELECT
    SUM(lon) AS Lönesummaa,
    SUM(kompetens) AS Kompetens
FROM larare
;

-- Display updated table
SELECT akronym, avdelning, fornamn, kon, lon, kompetens
FROM larare
ORDER BY lon DESC
;