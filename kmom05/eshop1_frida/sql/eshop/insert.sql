--
-- Insert from CSV-files
--


-- OBS, många LOAD DATA... kan man kanske skapa en funktion för det?
-- Har provat procedur men LOAD DATA är inte tillåtet innanför en procedur

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

INSERT INTO
    kundorder(ordernummer, kund)
VALUES
    (11123, 3)
;

UPDATE kundorder
    SET
        kund = 2
    WHERE
        ordernummer = 11123
;

INSERT INTO
    kundorder_rad(kundorder, produkt)
VALUES
    (11123, 3)
;

UPDATE kundorder_rad
SET
    antal = 10
WHERE
    kundorder = 11123 AND
    produkt = 3
;

DELETE FROM
    kundorder_rad
WHERE
    kundorder = 11123 AND
    produkt = 3
;

INSERT INTO
    faktura(fakturanummer, kundorder)
VALUES
    (123, 11123)
;

UPDATE faktura
SET
    totalpris = 300
WHERE
    fakturanummer = 123
;


-- SELECT * FROM kund;
-- SELECT * FROM produkt;
-- SELECT * FROM kategori;
-- SELECT * FROM produkt_kategori;
-- SELECT * FROM lagerhylla;
-- SELECT * FROM stock;
-- SELECT * from kundorder;
-- SELECT * from kundorder_rad; -- obs tog bort den rad som fanns!
-- SELECT * from faktura;
-- SELECT * FROM logg;

-- CALL show_product();

-- CALL show_logg(3);

-- CALL show_product();
-- CALL show_stock();

-- CALL search_stock('kaffe');
-- CALL search_stock(3);
-- CALL search_stock(500);

-- CALL insert_stock(1, 4, 9999);
-- CALL insert_stock(1, 4, 11854);
-- CALL insert_stock(3, 2, 20);
-- CALL insert_stock(3, 2, 30);
-- SELECT * FROM stock;

-- CALL remove_from_stock(1, 1, 30);
-- SELECT * FROM stock;