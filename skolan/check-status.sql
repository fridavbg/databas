--
-- Check status version of MariaDB and
--

SHOW VARIABLES LIKE "%version%";

SELECT @@version;
SELECT @@version_compile_machine;

-- SELECT * FROM mysql.global_priv;

SELECT User, Host FROM mysql.global_priv;
