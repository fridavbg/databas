--
-- Update values in table larare.
--


-- Add column to table
ALTER TABLE larare
ADD COLUMN kompetens INT;

-- -- Observe change
-- SELECT * FROM larare;


-- Delete column from table
ALTER TABLE larare
DROP COLUMN kompetens;

-- -- Observe change
-- SELECT * FROM larare;

ALTER TABLE larare
ADD COLUMN kompetens INT DEFAULT 1 NOT NULL
;

-- -- Table of column info
-- SHOW COLUMNS FROM larare;

-- -- Try insert row with kompetens = null (will create error)
-- INSERT INTO larare
-- VALUES ('dum', 'ADM', 'Albus', 'Dumbledore', 'M', 80000, '1941-04-01', NULL);