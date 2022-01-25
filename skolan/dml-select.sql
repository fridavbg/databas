--
-- Display table larare
--

-- Display all rows from avdelning DIDD

SELECT * FROM larare WHERE avdelning = 'DIDD';

-- Display all rows where akronym starts with h 
SELECT * FROM larare WHERE akronym LIKE 'h%';

-- Display all rows where fornamns includes o
SELECT * FROM larare WHERE fornamn LIKE '%o%';

-- Display all rows where larare makes between 30 - 50 000
SELECT * FROM larare WHERE lon >= 30000 AND lon < 50000;

-- Visa de rader där lärarens kompetens är mindre än 7 och lönen är större än 40 000.
SELECT * FROM larare WHERE kompetens < 7 AND lon > 40000;
-- Visa rader som innehåller lärarna sna, dum, min (ledtråd IN).
SELECT * FROM larare WHERE akronym IN ('sna', 'dum', 'min');
-- Visa de lärare som har lön över 80 000, tillsammans med de lärare som har en kompetens om 2 och jobbar på avdelningen ADM.
SELECT * FROM larare WHERE lon > 80000 OR (avdelning = 'ADM' AND kompetens = 2);

-- ORDER BY

-- Skriv endast ut namnen på alla lärare och vad de tjänar.
SELECT fornamn, efternamn, lon from larare;
-- Sortera listan på efternamnet, både i stigande och sjunkande ordning.
SELECT * from larare ORDER BY efternamn DESC;
SELECT * from larare ORDER BY efternamn ASC;

-- Sortera listan på lönen, både i stigande och sjunkande ordning. Vem tjänar mest och vem tjänar minst?
SELECT * from larare ORDER BY lon ASC;
SELECT * from larare ORDER BY lon DESC;
--Välj ut de tre som tjänar mest och visa dem (ledtråd LIMIT).
SELECT * from larare ORDER BY lon DESC LIMIT 3;
-- ALIAS med AS 

--
-- Change namn of a column
--
SELECT
    fornamn AS 'Lärare',
    lon AS 'Lön',
    avdelning AS 'avdelning'
FROM larare;