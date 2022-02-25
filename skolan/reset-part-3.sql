--
-- Reset part 3
--
source create-database.sql;

-- source ddl-larare.sql
-- source insert-larare.sql
-- source ddl-alter.sql
-- source dml-update.sql
-- source ddl-copy.sql

-- source dml-view.sql
-- source dml-join.sql

-- source insert-csv.sql
-- source dml-join2.sql
-- source dml-outer-join.sql
-- source dml-subquery.sql


source ddl.sql
source insert.sql
source dml-update-lonerevision.sql



SELECT
    SUM(lon) AS 'Lönesumma',
    SUM(kompetens) AS Kompetens
FROM larare_pre;

SELECT
    SUM(lon) AS 'Lönesumma',
    SUM(kompetens) AS Kompetens
FROM larare;

-- Three joined tables in a view
SELECT
    *
FROM
    v_planering
;

-- Visar alla tabeller (ungefär som en innehållsförteckning)
SHOW FULL TABLES
