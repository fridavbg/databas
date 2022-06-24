--
-- Create database structure
--

use exam; 

SET foreign_key_checks = 0;

-- DROP TABLES 
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS aktier;
DROP TABLE IF EXISTS portfolj;
DROP TABLE IF EXISTS fastighet;

SET foreign_key_checks = 1; 

DROP VIEW IF EXISTS personReport;

DROP PROCEDURE IF EXISTS show_personReport;
DROP PROCEDURE IF EXISTS search_personReport;
DROP PROCEDURE IF EXISTS specialReport;


-- ---------
-- -- Tables
-- -- 

CREATE TABLE person
(
    id VARCHAR(4),
    fornamn VARCHAR(20),
    efternamn VARCHAR(25),
    foretag VARCHAR(25),
    formogenhet INT, 

    PRIMARY KEY (id)
);

CREATE TABLE aktier
(
    id VARCHAR(10),
    varde INT,

    PRIMARY KEY(id)
);

CREATE TABLE portfolj
(
    person_id VARCHAR(4),
    aktie_id VARCHAR(10),
    antal INT,
    inkop INT,

    CONSTRAINT FOREIGN KEY(person_id) REFERENCES person(id),
    CONSTRAINT FOREIGN KEY(aktie_id) REFERENCES aktier(id)
);

CREATE TABLE fastighet
(
    person_id VARCHAR(4),
    fastighet_id VARCHAR(15),
    vardering INT,

    PRIMARY KEY(fastighet_id),
    FOREIGN KEY(person_id) REFERENCES person(id)
);

CREATE VIEW personReport
AS
SELECT
    p.id,
    p.fornamn,
    p.efternamn,
    p.foretag,
    p.formogenhet,
    pf.aktie_id,
    pf.antal,
    pf.inkop,
    a.varde,
    f.fastighet_id,
    f.vardering
from person as p
    LEFT JOIN portfolj AS pf
        ON p.id = pf.person_id
    LEFT JOIN aktier as a
        ON pf.aktie_id = a.id
    LEFT JOIN fastighet as f
        ON p.id = f.person_id
;

--
-- Procedure to show person report
--

DELIMITER ;;
CREATE PROCEDURE show_personReport()
BEGIN 
    SELECT
    *
    FROM 
    personReport;
END
;;
DELIMITER ;

--
-- Procedure to search person report
--

DELIMITER ;;
CREATE PROCEDURE search_personReport(
    a_search VARCHAR(20)
)
BEGIN 
    SELECT
    *
    FROM 
    personReport
WHERE 
    id LIKE CONCAT('%', a_search, '%') OR
    fornamn LIKE CONCAT('%', a_search, '%') OR
    efternamn LIKE CONCAT('%', a_search, '%') OR
    foretag LIKE CONCAT('%', a_search, '%') OR
    formogenhet LIKE CONCAT('%', a_search, '%') OR
    aktie_id LIKE CONCAT('%', a_search, '%') OR
    antal LIKE CONCAT('%', a_search, '%') OR
    inkop LIKE CONCAT('%', a_search, '%') OR
    varde LIKE CONCAT('%', a_search, '%') OR
    fastighet_id LIKE CONCAT('%', a_search, '%') OR
    vardering LIKE CONCAT('%', a_search, '%')
    ;
END
;;
DELIMITER ;

--
-- Procedure to show special report
--

DELIMITER ;;
CREATE PROCEDURE specialReport()
BEGIN 
    SELECT
    CONCAT(p.fornamn, ' ' ,p.efternamn, ' (', p.foretag, ')') AS Person,
    p.formogenhet AS Förmögenhet,
    GROUP_CONCAT(DISTINCT pf.aktie_id) AS Aktie,
    pf.inkop AS Inköpspris,
    a.varde AS Nuvärde,
    f.fastighet_id As Fastighet,
    f.vardering AS Värdering
    FROM person as p
        LEFT OUTER JOIN portfolj as pf 
            ON p.id = pf.person_id
        LEFT JOIN aktier as a
            ON pf.aktie_id = a.id
        LEFT JOIN fastighet as f 
            ON p.id = f.person_id
    GROUP BY p.efternamn, p.foretag DESC
    ORDER BY Aktie;
END
;;
DELIMITER ;
