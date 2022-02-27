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
DROP TRIGGER IF EXISTS log_insert_kundorder_rad;

CREATE TRIGGER log_insert_kundorder_rad
AFTER INSERT
ON kundorder_rad FOR EACH ROW
    INSERT INTO logg (kundorder, loggdatum, kommentar)
        VALUES (NEW.kundorder, NOW(), CONCAT('produkt med id ', NEW.produkt, ' tillagd'))
;

DROP TRIGGER IF EXISTS log_update_kundorder_rad;

CREATE TRIGGER log_update_kundorder_rad
AFTER UPDATE
ON kundorder_rad FOR EACH ROW
    INSERT INTO logg (kundorder, loggdatum, kommentar)
        VALUES (NEW.kundorder, NOW(), CONCAT('detaljer om produkt med id ', NEW.produkt, ' ändrade'))
;

DROP TRIGGER IF EXISTS log_delete_kundorder_rad;

CREATE TRIGGER log_delete_kundorder_rad
AFTER DELETE
ON kundorder_rad FOR EACH ROW
    INSERT INTO logg (kundorder, loggdatum, kommentar)
        VALUES (OLD.kundorder, NOW(), CONCAT('produkt med id ', OLD.produkt, ' raderad'))
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



-- Hur göra för att visa produkter som lagts till eller tagits bort i kundorder (eftersom det är kopplat till kundorder-rad)? - IDÈ!!! : se om kundorder-rad INSERT eller DELETE
-- Lägga till compound för att se om det var "uppdaterad", "borttagen" eller "skickad" som ändrades och ändra kommentar i enlighet.


-- Trigger orderändring logg_kundorder (when delete kundorder)
-- Trigger fakturaändringsdatum logg_faktura (when update faktura)
-- Trigger fakturaändringsdatum logg_faktura (when delete faktura)



-- OBS NEDAN ÄR OM VI ISTÄLLET FÖR ATT LÄGGA IN NYA LOGGAR VARJE GÅNG VILL (BRA FÖR ATT SE HISTORIK)
-- ISTÄLLET VILL UPPDATERA EXISTERANDE (BRA FÖR ÖVERBLICK)

-- -- Trigger för logging vid update kundorder
-- DROP TRIGGER IF EXISTS log_update_kundorder;

-- CREATE TRIGGER log_update_kundorder
-- AFTER UPDATE
-- ON kundorder FOR EACH ROW
--     UPDATE logg
--         SET
--             orderändringsdatum = NEW.uppdaterad,
--             kommentar = 'beställning ändrad'
--         WHERE
--             kundorder = NEW.kundorder
-- ;

-- -- Trigger för logging vid insert faktura
-- DROP TRIGGER IF EXISTS log_faktura;

-- CREATE TRIGGER log_faktura
-- AFTER INSERT
-- ON faktura FOR EACH ROW
--     UPDATE logg
--         SET
--             faktura = NEW.fakturanummer,
--             fakturadatum = NEW.fakturadatum,
--             kommentar = 'faktura skickad'
--         WHERE
--             kundorder = NEW.kundorder
-- ;