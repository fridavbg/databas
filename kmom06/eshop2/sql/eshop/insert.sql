--
-- Insert from CSV-files
--


-- OBS, många LOAD DATA... kan man kanske skapa en funktion för det?
-- Har provat procedur men LOAD DATA är inte tillåtet innanför en procedur

EXPLAIN stock;
EXPLAIN produkt;

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
    kundorder(kund, orderdatum, uppdaterad, skickad, borttagen)
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


-- CALL show_customers();
-- CALL show_specific_order(1);
-- CALL show_specific_order_rows(1);
-- CALL show_orders();
-- CALL show_product();

-- CALL create_order(5);   -- skapar order
-- CALL insert_order_rad(5, 1, 10); --lägg in tio av en produkt
-- CALL set_orderdatum(5); -- lägg till beställningsdatum


-- -- TESTING ORDERSTATUS
--

-- SELECT * FROM kundorder
-- ORDER BY kund;


-- CALL show_orders();

-- CALL show_specific_order(2);

-- CALL show_individual_customer(2);


--
-- -- TESTING INDEX!!!!!
--

-- EXPLAIN SELECT * from produkt;

EXPLAIN
SELECT
    p.produktkod,
    p.produktnamn,
    p.produktbeskrivning,
    p.produktpris,
    s.antal,
    GROUP_CONCAT(k.kategori) as "kategori"
FROM produkt as p
    LEFT OUTER JOIN stock as s
        ON p.produktkod = s.produkt
    LEFT OUTER JOIN produkt_kategori as k
        ON p.produktkod = k.produkt
GROUP BY p.produktkod
;

EXPLAIN
SELECT
    *
FROM produkt
WHERE produktkod = 3;

EXPLAIN
UPDATE produkt SET
    produktnamn = "testprod",
    produktbeskrivning = "testing testing",
    produktpris = 300
WHERE
    produktkod = 3
;


EXPLAIN stock;

-- CREATE UNIQUE INDEX index_antal ON stock(antal);

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

SELECT
    s.produkt,
    p.produktnamn,
    s.lagerhylla,
    s.antal
FROM stock as s
    JOIN produkt AS p
        on s.produkt = p.produktkod
;

-- CREATE INDEX index_antal ON stock(antal);



EXPLAIN
UPDATE
    stock
SET
    antal = antal - 20
WHERE
    produkt = 2 AND
    lagerhylla = 2
;

EXPLAIN
DELETE FROM produkt
WHERE
    produktkod = 2;

-- CREATE INDEX index_orderdatum ON kundorder(orderdatum);

EXPLAIN
SELECT
    kund,
    orderstatus(skapad, orderdatum, uppdaterad, skickad, borttagen) AS orderstatus
FROM kundorder
ORDER BY kund;

EXPLAIN
    SELECT
        p.produktkod,
        p.produktnamn,
        p.produktbeskrivning,
        p.produktpris,
        k.antal
    FROM kundorder_rad AS k
    JOIN produkt AS p
    ON k.produkt = p.produktkod
    WHERE k.kundorder = 3;

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
    s.produkt = 54 OR
    p.produktnamn LIKE CONCAT('%', 54, '%') OR
    s.lagerhylla = 54 OR
    s.antal = 54
;