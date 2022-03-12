--
-- Insert from CSV-files
--


-- OBS, många LOAD DATA... kan man kanske skapa en funktion för det?
-- Har provat procedur men LOAD DATA är inte tillåtet innanför en procedur

-- EXPLAIN stock;
-- EXPLAIN produkt;

LOAD DATA LOCAL INFILE 'kund.csv'
INTO TABLE kund
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;


LOAD DATA LOCAL INFILE 'produkt.csv'
INTO TABLE produkt
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'kategori.csv'
INTO TABLE kategori
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'produkt_kategori.csv'
INTO TABLE produkt_kategori
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'lagerhylla.csv'
INTO TABLE lagerhylla
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'stock.csv'
INTO TABLE stock
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

--
-- -- KRAV 5 att lägga in ordrar med olika status:
--

INSERT INTO
    kundorder(ordernummer, kund, orderdatum, uppdaterad, skickad, borttagen)
VALUES
    (1, 1, NULL, NULL, NULL, NULL),
    (2, 2, NOW(), NULL, NULL, NULL),
    (3, 3, NOW(), NOW(), NULL, NULL),
    (4, 4, NULL, NULL, NOW(), NULL),
    (5, 5, NULL, NULL, NULL, NOW())
;

LOAD DATA LOCAL INFILE 'kundorder_rad.csv'
INTO TABLE kundorder_rad
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;