--
-- Reset eshop
--

source setup.sql;

use eshop;

source ddl.sql;
source insert.sql;

-- Tabell koll
-- SHOW FULL TABLES;

SELECT * FROM kundorder;
