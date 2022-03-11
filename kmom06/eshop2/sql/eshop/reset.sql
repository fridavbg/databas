--
-- Reset eshop
--

source setup.sql;

use eshop;

source ddl.sql;
source insert.sql;

-- Tabell koll
SELECT * FROM kundorder;