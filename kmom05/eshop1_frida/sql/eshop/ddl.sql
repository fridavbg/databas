-- UTAN FK sist, MED FK först
DROP TABLE IF EXISTS logg;
DROP TABLE IF EXISTS faktura_rad;
DROP TABLE IF EXISTS faktura;
DROP TABLE IF EXISTS produkt_kategori;
DROP TABLE IF EXISTS kundorder_produkt;
DROP TABLE IF EXISTS kundorder;

DROP TABLE IF EXISTS kund;
DROP TABLE IF EXISTS produkt;
DROP TABLE IF EXISTS kategori;


------------------------------------------
-- PRODUKT
-- En produkt kan ha många kategorier, kategorier kan finns i många produkter M:M
-- produkt, kategori, produkt_kategori

CREATE TABLE produkt
(
    produktkod INT AUTO_INCREMENT,
    produktnamn VARCHAR(20),
    produktbeskrivning VARCHAR(50),
    produktpris INT,

    PRIMARY KEY (produktkod)
);

CREATE TABLE kategori
(
    id INT AUTO_INCREMENT,
    firma VARCHAR(20),
    typ VARCHAR(20),

    PRIMARY KEY (id)
);

CREATE TABLE produkt_kategori
(
    produkt INT,
    kategori INT,

    PRIMARY KEY(produkt, kategori),
    FOREIGN KEY(produkt) REFERENCES produkt(produktkod),
    FOREIGN KEY(kategori) REFERENCES kategori(id)
);

-----------------------------------------------------------------
-- KUND
-- kund, kundorder, kundorder_rad

CREATE TABLE kund
(
    id INT,
    fornamn VARCHAR(20),
    efternamn VARCHAR(20),
    adress VARCHAR(20),
    mail VARCHAR(20),
    kreditkort INT NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE kundorder
(
    ordernummer INT AUTO_INCREMENT,
    kund INT,
    orderdatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- uppdaterad funkar endast när vi kör sql men ej i sql-lite?
    -- föreläsning 2017 48:00
    -- borttagen markera som ej aktiv - soft delete
    uppdaterad DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    borttagen DATETIME,
    skickad DATETIME,

    PRIMARY KEY (ordernummer),
    FOREIGN KEY (kund) REFERENCES kund(id)
);

CREATE TABLE kundorder_rad
(
    kundorder INT,
    produkt INT,
    antal INT,
    PRIMARY KEY (kundorder, produkt),
    FOREIGN KEY (kundorder) REFERENCES kundorder(ordernummer),
    FOREIGN KEY (produkt) REFERENCES produkt(produktkod)
);

----------------------------------------------------------------
-- FAKTURA
-- faktura - faktura_rad

CREATE TABLE faktura
(
    fakturanummer INT,
    kundorder INT,
    kund INT,
    fakturadatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    totalpris INT,
    uppdaterad DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    borttagen DATETIME,
    skickad DATETIME,

    PRIMARY KEY(fakturanummer),
    FOREIGN KEY(kundorder) REFERENCES kundorder(ordernummer),
    FOREIGN KEY(kund) REFERENCES kund(id)
);

CREATE TABLE faktura_rad
(
    faktura INT,
    produkt INT,
    antal INT,

    -- Man kan väl tänka att det finns ett unikt fakturanummer och i fakturan finns
    -- rader där produkten är det som gör raden unik? Därmed kan man kombinera dem och
    -- ha dem som kombinerad primärnyckel? ZOOM 45:20
    PRIMARY KEY (faktura, produkt),
    FOREIGN KEY(produkt) REFERENCES produkt(produktkod),
    FOREIGN KEY(faktura) REFERENCES faktura(fakturanummer)
);

---------------------------------------------------------------------------
-- LAGER
-- lagerhylla - logg - stock

CREATE TABLE lagerhylla
(
    hylla INT,
    beskrivning VARCHAR(50),

    PRIMARY KEY(hylla)
);

CREATE TABLE stock
(
    produkt INT,
    lagerhylla INT,
    antal INT,

    PRIMARY KEY (produkt, lagerhylla),
    FOREIGN KEY (produkt) REFERENCES produkt(produktkod),
    FOREIGN KEY (lagerhylla) REFERENCES lagerhylla(hylla)
);


CREATE TABLE logg
(
    id INT AUTO_INCREMENT,
    kundorder INT,
    faktura INT,
    loggdatum DATETIME,
    kommentar VARCHAR(40),

    PRIMARY KEY(id),
    FOREIGN KEY(kundorder) REFERENCES kundorder(ordernummer),
    FOREIGN KEY(faktura) REFERENCES faktura(fakturanummer)
);

----------------------
-- VIEWS
--

DROP VIEW IF EXISTS plocklista;

CREATE VIEW plocklista
AS
SELECT
    ko.ordernummer,
    ko.kund,
    kor.kundorder,
    kor.produkt,
    kor.antal
FROM kundorder as ko
    INNER JOIN kundorder_rad AS kor
        on ko.ordernummer = kor.kundorder
;

SHOW TABLES;

DESCRIBE plocklista;


-- -----------------------
-- -- TRIGGER
-- --
-- -- Du skall ha en loggtabell som loggar intressanta händelser i systemet, via triggers. Du skall logga när någon gör INSERT, UPDATE och DELETE på tabellen produkt. Du loggar tiden då något hände och en textsträng som beskriver händelsen och det objekt som var inblandat i händelsen. Till exempel så här.
-- -- Få med loggers i webbklienten ???
-- --

-- Trigger kundorder
DROP TRIGGER IF EXISTS log_insert_kundorder;

CREATE TRIGGER log_insert_kundorder
AFTER INSERT
ON kundorder FOR EACH ROW
    INSERT INTO logg (kundorder, loggdatum, kommentar)
        VALUES (NEW.ordernummer, NEW.orderdatum, 'beställning skapad')
;

DROP TRIGGER IF EXISTS log_update_kundorder;

CREATE TRIGGER log_update_kundorder
AFTER UPDATE
ON kundorder FOR EACH ROW
    INSERT INTO logg (kundorder, loggdatum, kommentar)
        VALUES (NEW.ordernummer, NEW.uppdaterad, 'beställning ändrad')
;

-- -- Trigger kunorder_rad
DROP TRIGGER IF EXISTS log_insert_produkt;

CREATE TRIGGER log_insert_produkt
AFTER INSERT
ON produkt FOR EACH ROW
    INSERT INTO logg (loggdatum, kommentar)
        VALUES (NOW(), CONCAT('produkt med kod ', NEW.produktkod, ' tillagd'))
;

DROP TRIGGER IF EXISTS log_update_produkt;

CREATE TRIGGER log_update_produkt
AFTER UPDATE
ON produkt FOR EACH ROW
    INSERT INTO logg (loggdatum, kommentar)
        VALUES (NOW(), CONCAT('detaljer om produkt med kod ', NEW.produktkod, ' ändrade'))
;

DROP TRIGGER IF EXISTS log_delete_produkt;

CREATE TRIGGER log_delete_produkt
AFTER DELETE
ON produkt FOR EACH ROW
    INSERT INTO logg (loggdatum, kommentar)
        VALUES (NOW(), CONCAT('produkt med kod ', OLD.produktkod, ' raderad'))
;


-- Trigger faktura
DROP TRIGGER IF EXISTS log_insert_faktura;

CREATE TRIGGER log_insert_faktura
AFTER INSERT
ON faktura FOR EACH ROW
    INSERT INTO logg (kundorder, faktura, loggdatum, kommentar)
        VALUES (NEW.kundorder, NEW.fakturanummer, NEW.fakturadatum, 'faktura skapad')
;

DROP TRIGGER IF EXISTS log_update_faktura;

CREATE TRIGGER log_update_faktura
AFTER UPDATE
ON faktura FOR EACH ROW
    INSERT INTO logg (kundorder, faktura, loggdatum, kommentar)
        VALUES (NEW.kundorder, NEW.fakturanummer, NEW.fakturadatum, 'faktura ändrad')
;


-- -----------------------
-- -- PROCEDURES
-- --

--
-- Procedure to show category table
--
DROP PROCEDURE IF EXISTS show_category;
DELIMITER ;;
CREATE PROCEDURE show_category()
BEGIN
    SELECT * FROM produkt_kategori;
END
;;
DELIMITER ;

CALL show_category();

--
-- Procedure to show product table + stock antal
-- kod, namn, pris och antal
--
DROP PROCEDURE IF EXISTS show_product;
DELIMITER ;;
CREATE PROCEDURE show_product()
BEGIN
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
END
;;
DELIMITER ;

-- CALL show_product();

--
-- Procedure to show one product
-- . Visa även information om vilken kategori som produkten tillhör (TIPS GROUP_CONCAT).
-- BYTA KATEGORI IFRAN INT TILL STRANG ??
--
DROP PROCEDURE IF EXISTS show_productkod;
DELIMITER ;;
CREATE PROCEDURE show_productkod(
    a_id INT
)
BEGIN
    SELECT
    p.produktkod,
    p.produktnamn,
    p.produktbeskrivning,
    p.produktpris,
    s.antal
    FROM produkt as p
        INNER JOIN stock as s
            ON p.produktkod = s.produkt
    WHERE p.produktkod = a_id;
END
;;
DELIMITER ;

-- CALL show_productkod(1);

--
-- Procedure to edit product
--
DROP PROCEDURE IF EXISTS edit_produkt;

DELIMITER ;;
CREATE PROCEDURE edit_produkt(
    a_produktkod INT,
    a_produktnamn VARCHAR(20),
    a_produktbeskrivning VARCHAR(50),
    a_produktpris INT
)
BEGIN
    UPDATE produkt SET
        `produktnamn` = a_produktnamn,
        `produktbeskrivning` = a_produktbeskrivning,
        `produktpris` = a_produktpris
    WHERE
        `produktkod` = a_produktkod
    ;
END
;;
DELIMITER ;

-- SHOW PROCEDURE STATUS LIKE 'edit%';

--
-- Procedure to insert product
--
DROP PROCEDURE IF EXISTS insert_produkt;

DELIMITER ;;
CREATE PROCEDURE insert_produkt(
    a_produktnamn VARCHAR(20),
    a_produktbeskrivning VARCHAR(50),
    a_produktpris INT
)
BEGIN
    INSERT INTO
        produkt(produktnamn, produktbeskrivning, produktpris)
    VALUES
        (a_produktnamn, a_produktbeskrivning, a_produktpris)
    ;
END
;;
DELIMITER ;

-- SHOW PROCEDURE STATUS LIKE 'insert%';

-- Testar procedur:
-- CALL insert_produkt('kaffemugg', 'muggbeskrivning', 340);

--
-- Procedure to show logg
--
DROP PROCEDURE IF EXISTS show_logg;
DELIMITER ;;
CREATE PROCEDURE show_logg()
BEGIN
    SELECT * FROM logg;
END
;;
DELIMITER ;

-- Testar procedur: (fast inget är inlagt än)
-- CALL show_logg();