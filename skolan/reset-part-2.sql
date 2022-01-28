--
-- Reset part 2
--
source create-database.sql;

use skolan;

source ddl-larare.sql
source insert-larare.sql
source ddl-alter.sql
source dml-update.sql
source ddl-copy.sql
source dml-update-lonerevision.sql
source dml-view.sql
source dml-join.sql

SELECT
    SUM(lon) AS 'Lönesumma',
    SUM(kompetens) AS Kompetens
FROM larare;

SELECT 
    SUM(lon) AS 'Lönesumma', 
    SUM(kompetens) AS Kompetens
FROM larare_pre;
