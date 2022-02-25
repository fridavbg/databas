--
-- Insert from CSV-files
--


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

SELECT * FROM kund;


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

SELECT * FROM produkt;


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

SELECT * FROM kategori;


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

SELECT * FROM produkt_kategori;


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

SELECT * FROM lagerhylla;

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

SELECT * FROM stock;


INSERT INTO
    kundorder(ordernummer, kund)
VALUES
    (11123, 3)
;

SELECT * from kundorder;

INSERT INTO
    faktura(fakturanummer, kundorder)
VALUES
    (123, 11123)
;

SELECT * from faktura;


INSERT INTO
    logg (kundorder, faktura)
VALUES
    (11123, 123)
;

SELECT * FROM logg;