--
-- STRING FUNCTIONS
--

--
-- 1
-- Print fornamn, efternamn, avdelning
--

SELECT 
    CONCAT(fornamn, " ", efternamn, " ", "(", avdelning,")") AS NamnAvdelning
FROM larare;

--
-- 2
-- Print fornamn, efternamn, avdelning in lowercase
-- 3 rows
--

SELECT 
    CONCAT(fornamn, " ", efternamn, " ", "(", LOWER(avdelning),")") AS NamnAvdelning
FROM larare
LIMIT 3;

--
-- DATE and TIME
--

--
-- 1
-- Display todays date
--

SELECT CURDATE() AS Today;

--
-- 2
-- Display teachers, birthdate, todays date, todays time
--

SELECT 
    fornamn,
    fodd,
    CURDATE() AS Dagensdatum,
    CURTIME() AS Klockslag
FROM larare;


    CURTIME() AS Klockslag

--
-- Calculate Age
--

--
-- 1
-- Calculate teachers age, sort by age
--

SELECT 
    fornamn,
    fodd,
    FLOOR((CURDATE() - fodd) / 10000) AS Alder
FROM larare
ORDER BY Alder DESC;

--
-- Filter by date
--

--
-- 1
-- Display teachers born in the 40s
--

SELECT
    fornamn,
    fodd
FROM larare
WHERE YEAR(fodd) BETWEEN 1940 AND 1950;