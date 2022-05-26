--
-- Create database structure
--

use exam; 

SET foreign_key_checks = 0;

-- DROP TABLES 
DROP TABLE IF EXISTS ras;
DROP TABLE IF EXISTS medlem2hund;
DROP TABLE IF EXISTS medlem;
DROP TABLE IF EXISTS hund;

SET foreign_key_checks = 1; 

-- DROP VIEWS
DROP VIEW IF EXISTS memberInfo;

-- DROP PROCEDURES
DROP PROCEDURE IF EXISTS show_memberinfo;
DROP PROCEDURE IF EXISTS search_memberinfo;

-- ---------
-- -- Tables
-- -- 

CREATE TABLE medlem
(
    id INT AUTO_INCREMENT NOT NULL,
    fornamn VARCHAR(20),
    alias VARCHAR(20),
    efternamn VARCHAR(25),
    ort VARCHAR(25),

    PRIMARY KEY (id)
);

CREATE TABLE ras
(
    id VARCHAR(2),
    namn VARCHAR(20),
    godkänd VARCHAR(3),

    PRIMARY KEY(id)
);

CREATE TABLE hund
(
    id INT AUTO_INCREMENT NOT NULL,
    namn VARCHAR(20),
    url VARCHAR(1500),
    ras_id VARCHAR(2),

    PRIMARY KEY(id),
    CONSTRAINT FOREIGN KEY(ras_id) REFERENCES ras(id)
);

CREATE TABLE medlem2hund
(
    id INT AUTO_INCREMENT NOT NULL,
    medlem_id INT,
    hund_id INT,
    registrerad INT,

    PRIMARY KEY(id),
    FOREIGN KEY(medlem_id) REFERENCES medlem(id),
    FOREIGN KEY(hund_id) REFERENCES hund(id)
);

CREATE VIEW memberInfo
AS
SELECT
    m.fornamn,
    m.efternamn,
    m.alias,
    m.ort,
    h.namn,
    h.url,
    r.namn AS ras,
    r.godkänd
FROM medlem AS m
    JOIN medlem2hund AS mh
        ON m.id = mh.medlem_id
    JOIN hund AS h
        ON h.id = mh.hund_id
    JOIN ras AS r
        ON r.id = h.ras_id
ORDER BY m.fornamn;

--
-- Proceudre to show member info
--

DELIMITER ;; 
CREATE PROCEDURE show_memberinfo()
BEGIN 
    SELECT * FROM memberInfo;
END
;;
DELIMITER ;

--
-- Procedure to search memberinfo table
--

DELIMITER ;;
CREATE PROCEDURE search_memberinfo(
    a_search VARCHAR(20)
)
BEGIN
    SELECT *
    FROM memberInfo AS mI
WHERE 
    mI.fornamn LIKE CONCAT('%', a_search, '%') OR
    mI.efternamn LIKE CONCAT('%', a_search, '%') OR
    mI.alias LIKE CONCAT('%', a_search, '%') OR
    mI.ort LIKE CONCAT('%', a_search, '%') OR
    mI.namn LIKE CONCAT('%', a_search, '%') OR
    mI.ras LIKE CONCAT('%', a_search, '%') OR
    mI.godkänd LIKE CONCAT('%', a_search, '%')
    ;
END
;;
DELIMITER ;
