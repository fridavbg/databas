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
    JOIN kund2vaccin AS kv
        ON k.id = kv.kund_id
    JOIN vaccin AS v
        ON v.id = kv.vaccin_id
    JOIN vaccin2sjukdom AS vs
        ON v.id = vs.vaccin_id
    JOIN sjukdom AS s 
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
    *
    FROM 
    vaccineReport
    ;
END
;;
DELIMITER ;