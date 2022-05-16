--
-- Reset part 
--

source setup.sql;

use exam; 

source ddl.sql;
source insert.sql;

SHOW TABLES;
CALL show_concertinfo();