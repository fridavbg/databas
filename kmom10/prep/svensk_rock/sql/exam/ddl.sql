--
-- Create database structure
--

use exam;

-- DROP TABLES in right order
DROP TABLE IF EXISTS artist;
DROP TABLE IF EXISTS landskod;
DROP TABLE IF EXISTS speldag;
DROP TABLE IF EXISTS spelning;

-- VIEW DROPS
DROP VIEW IF EXISTS concertinfo;

--- PROCEDURE DROPS
DROP PROCEDURE IF EXISTS show_concertinfo;

-- ----------------
-- -- TABLES
-- --

CREATE TABLE artist 
(
    id CHAR(3),
    namn VARCHAR(20),
    ort CHAR(15),
    landskod CHAR(2)
);

CREATE TABLE landskod
(
    kod CHAR(2),
    namn CHAR(15),
    PRIMARY KEY (kod)
);

CREATE TABLE speldag
(
    id INT AUTO_INCREMENT NOT NULL,
    namn CHAR(15),
    datum DATETIME,
    PRIMARY KEY (id)
);

CREATE TABLE spelning
(
    artist_id CHAR(3),
    speldag_id INT,
    klockslag TIME
);

-- ---------------------
-- VIEW with concert information
--

CREATE VIEW concertinfo
AS 
SELECT
    a.id,
    a.namn,
    a.ort,
    a.landskod,
    lk.namn AS land, 
    s.klockslag,
    sd.datum,
    sd.namn AS dag
FROM artist AS a
    JOIN landskod AS lk
    ON a.landskod = lk.kod
    JOIN spelning AS s
    ON a.id = s.artist_id
    JOIN speldag AS sd
    ON sd.id = s.speldag_id
ORDER BY sd.datum ;

-- ----------------
-- -- PROCEDURES
-- --

--
-- Procedure to show concert_info
--

DELIMITER ;;
CREATE PROCEDURE show_concertinfo()
BEGIN
    SELECT
        a.id,
        a.namn,
        a.ort,
        a.landskod,
        lk.namn AS land, 
        s.klockslag,
        sd.datum,
        sd.namn AS dag
    FROM artist AS a
        JOIN landskod AS lk
        ON a.landskod = lk.kod
        JOIN spelning AS s
        ON a.id = s.artist_id
        JOIN speldag AS sd
        ON sd.id = s.speldag_id
    ORDER BY sd.datum
    ;
END
;;
DELIMITER ;

--
-- Procedure to search concert_info view
--

DELIMITER ;;
CREATE PROCEDURE search_concertinfo(
    a_search VARCHAR(20)
)
BEGIN
    SELECT
        a.id,
        a.namn,
        a.ort,
        a.landskod,
        lk.namn AS land, 
        s.klockslag,
        sd.datum,
        sd.namn AS dag
    FROM artist AS a
        JOIN landskod AS lk
        ON a.landskod = lk.kod
        JOIN spelning AS s
        ON a.id = s.artist_id
        JOIN speldag AS sd
        ON sd.id = s.speldag_id
    WHERE 
        a.id = a_search OR
        a.namn LIKE CONCAT('%', a_search, '%') OR
        a.ort LIKE CONCAT('%', a_search, '%') OR
        a.landskod = a_search OR
        lk.namn LIKE CONCAT('%', a_search, '%') OR
        s.klockslag LIKE CONCAT('%', a_search, '%') OR
        sd.datum LIKE CONCAT('%', a_search, '%') OR
        sd.namn LIKE CONCAT('%', a_search, '%')
    ;
END
;;
DELIMITER ;