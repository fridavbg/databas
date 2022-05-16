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
-- Procedure to show concert_info view
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