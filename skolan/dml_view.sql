--
-- VIEWS
-- 

-- 
-- Create a view of larare table with an age column
--
CREATE VIEW v_larare
AS
SELECT
    akronym,
    avdelning,
    fornamn,
    efternamn,
    kon,
    lon,
    fodd,
    kompetens,
    FLOOR((CURDATE() - fodd) / 10000) AS Alder
FROM larare;

-- Show view
SELECT * FROM v_larare;

-- 
-- From v_larare show avg(age) per department, name of department, sorted by AVG(AGE)
--

SELECT
    avdelning,
    ROUND(SUM(Alder) / COUNT(Alder)) AS Snittalder
FROM v_larare
GROUP BY avdelning
ORDER BY Snittalder;