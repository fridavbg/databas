--
-- Check installation status
--

SHOW VARIABLES LIKE "%version%";

SELECT @@version;

select user,host from MySQL.user;