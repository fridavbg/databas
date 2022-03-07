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

--
-- -- KRAV 5 att lägga in ordrar med olika status:
--

INSERT INTO
    kundorder(ordernummer, kund, orderdatum, uppdaterad, skickad, borttagen)
VALUES
    (7774, 1, NULL, NULL, NULL, NULL),
    (54542, 2, NOW(), NULL, NULL, NULL),
    (11123, 3, NOW(), NOW(), NULL, NULL),
    (29304, 4, NULL, NULL, NOW(), NULL),
    (99874, 5, NULL, NULL, NULL, NOW())
;

-- INSERT INTO
--     kundorder(ordernummer, kund, orderdatum)
-- VALUES
--     (33433, 5, NOW())
-- ;

-- UPDATE kundorder
--     SET
--         kund = 2
--     WHERE
--         kund = 3
-- ;

-- UPDATE kundorder
--     SET
--     borttagen = NOW()
--     WHERE kund = 1
-- ;

-- UPDATE kundorder
--     SET
--     skickad = NOW()
--     WHERE ordernummer = 54542
-- ;

-- INSERT INTO
--     kundorder_rad(kundorder, produkt)
-- VALUES
--     (11123, 3)
-- ;

-- UPDATE kundorder_rad
-- SET
--     antal = 10
-- WHERE
--     kundorder = 11123 AND
--     produkt = 3
-- ;

-- DELETE FROM
--     kundorder_rad
-- WHERE
--     kundorder = 11123 AND
--     produkt = 3
-- ;

-- INSERT INTO
--     faktura(fakturanummer, kundorder)
-- VALUES
--     (123, 11123)
-- ;

-- UPDATE faktura
-- SET
--     totalpris = 300
-- WHERE
--     fakturanummer = 123
-- ;


SELECT * FROM kund;
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


-- -- TESTING ORDERSTATUS
--

SELECT * FROM kundorder
ORDER BY kund;

SELECT
    kund,
    orderstatus(skapad, orderdatum, uppdaterad, skickad, borttagen) AS orderstatus
FROM kundorder
ORDER BY kund;

--
-- -- TESTING INDEX!!!!!
--

-- EXPLAIN SELECT * from produkt;

-- EXPLAIN
-- SELECT
--     p.produktkod,
--     p.produktnamn,
--     p.produktbeskrivning,
--     p.produktpris,
--     s.antal,
--     GROUP_CONCAT(k.kategori) as "kategori"
-- FROM produkt as p
--     LEFT OUTER JOIN stock as s
--         ON p.produktkod = s.produkt
--     LEFT OUTER JOIN produkt_kategori as k
--         ON p.produktkod = k.produkt
-- GROUP BY p.produktkod
-- ;

-- EXPLAIN
-- SELECT
--     *
-- FROM produkt
-- WHERE produktkod = 3;

-- EXPLAIN
-- UPDATE produkt SET
--     produktnamn = "testprod",
--     produktbeskrivning = "testing testing",
--     produktpris = 300
-- WHERE
--     produktkod = 3
-- ;

-- EXPLAIN
-- INSERT INTO
--     produkt(produktnamn, produktbeskrivning, produktpris)
-- VALUES
--     ("testprod2", "ojojojoj", 600);



EXPLAIN stock;

EXPLAIN
SELECT
    s.produkt,
    p.produktnamn,
    s.lagerhylla,
    s.antal
FROM stock as s
    JOIN produkt AS p
        on s.produkt = p.produktkod
;


EXPLAIN
SELECT
    s.produkt,
    p.produktnamn,
    s.lagerhylla,
    s.antal
FROM stock as s
    JOIN produkt AS p
        on s.produkt = p.produktkod
WHERE
    s.produkt = "kaffe" OR
    p.produktnamn LIKE CONCAT('%', "kaffe", '%') OR
    s.lagerhylla = "kaffe" OR
    s.antal = "kaffe"
;

EXPLAIN
INSERT INTO
    stock(produkt, lagerhylla, antal)
VALUES
    ("a_produktkod", 5, 200)
ON DUPLICATE KEY UPDATE
    antal = antal + 200
;

-- EXPLAIN
-- UPDATE
--     stock
-- SET
--     antal = antal - 20
-- WHERE
--     produkt = 2 AND
--     lagerhylla = 2
-- ;

-- EXPLAIN
-- DELETE FROM produkt
-- WHERE
--     produktkod = 2;


EXPLAIN
SELECT
    kund,
    orderstatus(skapad, orderdatum, uppdaterad, skickad, borttagen) AS orderstatus
FROM kundorder
ORDER BY kund;

