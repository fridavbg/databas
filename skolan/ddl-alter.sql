--
-- ALTER table larare
--

-- Add column to table

ALTER TABLE larare DROP COLUMN IF EXISTS kompetens;

ALTER TABLE larare ADD COLUMN kompetens INT NOT NULL DEFAULT 1;

SHOW COLUMNS FROM larare;