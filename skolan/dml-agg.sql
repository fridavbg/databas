--
-- Aggregate functions 
--

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