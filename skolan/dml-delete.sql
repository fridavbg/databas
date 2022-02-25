--
-- Delete values from table larare.
--

--
-- Delete rows from table
--
DELETE FROM larare WHERE fornamn = 'Hagrid';
DELETE FROM larare WHERE avdelning = 'DIPT';
DELETE FROM larare WHERE lon IS NOT NULL LIMIT 2;
Delete FROM larare;


-- -- Show table content

-- SELECT akronym, avdelning, fornamn, efternamn, kon, lon, fodd
-- FROM larare;