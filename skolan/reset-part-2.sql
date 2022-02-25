--
-- Reset part 2
--

source create-database.sql

source ddl-larare.sql
source insert-larare.sql
source ddl-alter.sql
source dml-update.sql


-- ddl-copy creates copy of table before we make changes in update-lonerevision
source ddl-copy.sql
source dml-update-lonerevision.sql

source dml-view.sql

-- dml-join connects the two tables and presents comparable data
source dml-join.sql

-- SELECT
--     akronym, fornamn, efternamn, pre, nu, diff, proc, mini
-- FROM
--     v_lonerevision
-- ORDER BY
--     proc DESC
-- ;

-- PURE REPORT FILES
-- source dml-select.sql
-- source dml-agg.sql
-- source dml-func.sql
-- source dml-union.sql
