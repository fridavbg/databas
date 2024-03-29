--
-- https://dbwebb.se/kunskap/index-och-prestanda-i-mysql
-- Example
--

DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;

DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`
(
    `code` CHAR(6),
    `nick` CHAR(12),
    `points` DECIMAL(3, 1),
<<<<<<< HEAD
    `name` VARCHAR(60)
=======
    `name` VARCHAR(60),
    PRIMARY KEY (`code`),
    UNIQUE KEY `nick_unique` (`nick`)
>>>>>>> Frida
);

DELETE FROM course;
INSERT INTO course
VALUES
    ('DV1531', 'python',     7.5, 'Programmering och Problemlösning med Python'),
    ('PA1439', 'htmlphp',    7.5, 'Webbteknologier'),
    ('DV1561', 'javascript', 7.5, 'Programmering med JavaScript'),
    ('PA1436', 'design',     7.5, 'Teknisk webbdesign och användbarhet'),
    ('DV1547', 'linux',      7.5, 'Programmera webbtjänster i Linux'),
    ('PA1437', 'oopython',   7.5, 'Objektorienterad design och programmering med Python'),
    ('DV1546', 'webapp',     7.5, 'Webbapplikationer för mobila enheter'),
    ('DV1506', 'webgl',      7.5, 'Spelteknik för webben'),
    ('PA1444', 'dbjs',      10.0, 'Webbprogrammering och databaser')
;

<<<<<<< HEAD
SELECT * FROM course;

EXPLAIN select * from course;
=======
-- SELECT * FROM course;

-- EXPLAIN select * from course;
-- SELECT * FROM course WHERE name LIKE 'Webb%';
DELIMITER ;;
CREATE PROCEDURE show()
BEGIN 
    EXPLAIN SELECT * FROM course WHERE name LIKE '%Python';
END
BEGIN
    SHOW WARNINGS;
END
;;
DELIMITER ;
>>>>>>> Frida
