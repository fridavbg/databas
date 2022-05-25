--
-- Create database structure
--

use exam; 

SET foreign_key_checks = 0;

-- DROP TABLES / VIEWS in right order
DROP TABLE IF EXISTS kund;
DROP TABLE IF EXISTS sjukdom;
DROP TABLE IF EXISTS vaccin;
DROP TABLE IF EXISTS kund2vaccin;
DROP TABLE IF EXISTS vaccin2sjukdom;

SET foreign_key_checks = 1; 

DROP VIEW IF EXISTS vaccineReport;

DROP PROCEDURE IF EXISTS show_vaccinereport;
DROP PROCEDURE IF EXISTS search_vaccineInfo;

CREATE TABLE kund
(
    id INT AUTO_INCREMENT,
    fornamn CHAR(15),
    efternamn CHAR(25),
    ort CHAR(20),
    medlem DATETIME,
    PRIMARY KEY (id)
);

CREATE TABLE sjukdom
(
    id INT AUTO_INCREMENT,
    namn CHAR(15),
    beskrivning CHAR(50),
    PRIMARY KEY (id)   
);

CREATE TABLE vaccin
(
    id CHAR(2),
    namn CHAR(25),
    typ CHAR(15),
    PRIMARY KEY (id)   
);

CREATE TABLE kund2vaccin
(
    id INT AUTO_INCREMENT,
    kund_id INT,
    vaccin_id CHAR(2),
    datum DATETIME,
    PRIMARY KEY (id),
    FOREIGN KEY(kund_id) REFERENCES kund(id),
    FOREIGN KEY(vaccin_id) REFERENCES vaccin(id)
);

CREATE TABLE vaccin2sjukdom
(
    id INT AUTO_INCREMENT,
    vaccin_id CHAR(2),
    sjukdom_id INT,
    sannolikhet INT,  
    PRIMARY KEY (id),
    FOREIGN KEY(vaccin_id) REFERENCES vaccin(id),
    FOREIGN KEY(sjukdom_id) REFERENCES sjukdom(id)  
);

CREATE VIEW vaccineReport
AS
SELECT
    k.id AS kund_id,
    k.fornamn,
    k.efternamn,
    k.ort,
    DATE_FORMAT(k.medlem, '%d-%m-%Y') AS registrerades,
    s.id AS sjukdom_id,
    s.namn AS sjukdom,
    s.beskrivning,
    v.id AS vaccin_id,
    v.namn AS vaccin,
    v.typ,
    DATE_FORMAT(kv.datum, '%d-%m-%Y') AS vaccinerades,
    vs.sannolikhet
FROM kund as k
    LEFT JOIN kund2vaccin AS kv
        ON k.id = kv.kund_id
    LEFT JOIN vaccin AS v
        ON v.id = kv.vaccin_id
    LEFT JOIN vaccin2sjukdom AS vs
        ON v.id = vs.vaccin_id
    LEFT JOIN sjukdom AS s 
        ON vs.sjukdom_id = s.id
ORDER BY kv.datum DESC
;

--
-- Procedure to show vaccine report
--
DELIMITER ;;
CREATE PROCEDURE show_vaccinereport()
BEGIN
    SELECT
    fornamn,
    efternamn,
    ort,
    registrerades,
    sjukdom,
    beskrivning,
    vaccin,
    typ,
    vaccinerades,
    sannolikhet
    FROM 
    vaccineReport;
END
;;
DELIMITER ;

--
-- Procedure to search vaccine information
-- Del sträng sjukdomsnamn, beskrivning, vaccinnamn & vaccin typ
--
DELIMITER ;;
CREATE PROCEDURE search_vaccineInfo(
    a_search VARCHAR(20)
)
BEGIN
    SELECT 
    s.namn AS sjukdom,
    s.beskrivning,
    v.namn AS vaccin,
    v.typ,
    v2s.sannolikhet
FROM sjukdom AS s
    LEFT JOIN vaccin2sjukdom AS v2s
        ON s.id = v2s.sjukdom_id
    LEFT JOIN vaccin AS v
        ON v.id = v2s.vaccin_id
WHERE 
    s.namn LIKE CONCAT('%', a_search, '%') OR
    v.typ LIKE CONCAT('%', a_search, '%') OR
    s.beskrivning LIKE CONCAT('%', a_search, '%') OR
    v.namn LIKE CONCAT('%', a_search, '%')
ORDER BY s.namn;
END
;;
DELIMITER ;