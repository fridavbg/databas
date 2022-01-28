--
-- Aggregate functions 
--

USE skolan;

--
-- Highest salary of all the teachers
--
SELECT MAX(lon) FROM larare;

--
-- LOWEST salary of all the teachers
--
SELECT MIN(lon) FROM larare;

--
-- Total of teachers in each department
--

SELECT avdelning, COUNT(avdelning) AS employees FROM larare GROUP BY avdelning ORDER BY employees ASC;

--
-- Total salary amount paid out by each department monthly
--

SELECT
    avdelning,
    ROUND(SUM(lon) / 12) AS Sum
FROM larare
GROUP BY avdelning
ORDER BY Sum ASC;
;

--
-- Average salary amount by each department
--

SELECT
    avdelning,
    AVG(lon) AS Avg
FROM larare
GROUP BY avdelning
ORDER BY Avg ASC;
;

--
-- Average salary for women and men
--

SELECT
    kon,
    AVG(lon) AS Avg
FROM larare
GROUP BY kon
ORDER BY Avg ASC;
;

--
-- Department with highest average salary 
-- salaries sorted by kompetens in descending order
--

SELECT
    avdelning,
    AVG(kompetens) AS kompetens
FROM larare
GROUP BY avdelning
ORDER BY kompetens DESC
LIMIT 1;

--
-- Rounded avg salaries grouped by department, kompetens
-- sorted by department and avg salary
--

SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY avdelning, kompetens
ORDER BY avdelning, Snittlon
;

--
-- Average salary per department, total higher than 35 000
--

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

--
-- Average salary per department, total with 3 or more staff
--

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(lon) AS Antal
FROM larare
GROUP BY
    avdelning
HAVING
    COUNT(avdelning) >= 3
ORDER BY
    Snittlon DESC
;


-- HAVING


--
-- 1
-- Amount of staff, avg salary sorted by avdelning and avg salary
--

SELECT
    avdelning,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(avdelning) AS Antal
FROM larare
GROUP BY
    avdelning
HAVING
    COUNT(avdelning)
ORDER BY
    avdelning ASC,
    Snittlon ASC
;

--
-- 2
-- Amount of staff, avg salary, kompetens sorted by avdelning and kompetens
--

SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(avdelning) AS Antal
FROM larare
GROUP BY
    avdelning,
    kompetens
HAVING
    COUNT(avdelning)
ORDER BY
    avdelning, 
    kompetens DESC
;

--
-- 3
-- Amount of staff, avg salary, kompetens sorted by avdelning and kompetens less than 3
--

SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(avdelning) AS Antal
FROM larare
GROUP BY
    avdelning,
    kompetens
HAVING
    kompetens <= 3
ORDER BY
    avdelning, 
    kompetens DESC
;

--
-- 4
-- Amount of staff, avg salary, kompetens sorted by avdelning and kompetens
-- excluding groups > 1 
-- including 1 participant (staff ??)
-- avg(lon) between 30 000 - 45 000
-- sort by avg (lon)
--

SELECT
    avdelning,
    kompetens,
    ROUND(AVG(lon)) AS Snittlon,
    COUNT(avdelning) AS Antal
FROM larare
GROUP BY
    avdelning,
    kompetens
HAVING
    kompetens <= 3
    AND Snittlon BETWEEN 30000 AND 45000
ORDER BY
    Snittlon DESC
;