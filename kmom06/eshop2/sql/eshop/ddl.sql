
-- TABLE DROPS
-- UTAN FK sist, MED FK först
DROP TABLE IF EXISTS logg;
DROP TABLE IF EXISTS faktura_rad;
DROP TABLE IF EXISTS faktura;
DROP TABLE IF EXISTS produkt_kategori;
DROP TABLE IF EXISTS kundorder_produkt;
DROP TABLE IF EXISTS kundorder_rad;
DROP TABLE IF EXISTS kundorder;
DROP TABLE IF EXISTS kund;
DROP TABLE IF EXISTS produkt;
DROP TABLE IF EXISTS kategori;

-- TRIGGER DROPS
DROP TRIGGER IF EXISTS log_insert_kundorder;
DROP TRIGGER IF EXISTS log_update_kundorder;
DROP TRIGGER IF EXISTS log_insert_produkt;
DROP TRIGGER IF EXISTS log_update_produkt;
DROP TRIGGER IF EXISTS log_delete_produkt;
DROP TRIGGER IF EXISTS log_insert_faktura;
DROP TRIGGER IF EXISTS log_update_faktura;

-- PROCEDURE DROPS
DROP PROCEDURE IF EXISTS show_orders;
DROP PROCEDURE IF EXISTS show_customers;
DROP PROCEDURE IF EXISTS show_category;
DROP PROCEDURE IF EXISTS show_product;
DROP PROCEDURE IF EXISTS show_productkod;
DROP PROCEDURE IF EXISTS edit_produkt;
DROP PROCEDURE IF EXISTS insert_produkt;
DROP PROCEDURE IF EXISTS show_logg;
DROP PROCEDURE IF EXISTS show_lagerhylla;
DROP PROCEDURE IF EXISTS show_stock;
DROP PROCEDURE IF EXISTS search_stock;
DROP PROCEDURE IF EXISTS insert_stock;
DROP PROCEDURE IF EXISTS remove_from_stock;
DROP PROCEDURE IF EXISTS delete_produkt;

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

    PRIMARY KEY (produktkod),
    UNIQUE KEY index_produktnamn (produktnamn)
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
    CONSTRAINT FOREIGN KEY(produkt) REFERENCES produkt(produktkod) ON DELETE CASCADE,
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
    telefonnummer INT,
    mail VARCHAR(20),
    kreditkort INT NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE kundorder
(
    ordernummer INT AUTO_INCREMENT,
    kund INT,
    skapad DATETIME DEFAULT CURRENT_TIMESTAMP,
    orderdatum DATETIME DEFAULT NULL,
    uppdaterad DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    skickad DATETIME DEFAULT NULL,
    borttagen DATETIME DEFAULT NULL,

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
    CONSTRAINT FOREIGN KEY (produkt) REFERENCES produkt(produktkod) ON DELETE CASCADE,
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
-- VIEW DROPS
DROP VIEW IF EXISTS plocklista;

CREATE VIEW plocklista
AS
SELECT
    k.ordernummer,
    k.kund,
    kr.produkt,
    kr.antal AS antal_bestallt,
    s.lagerhylla,
    s.antal AS antal_i_lager
FROM kundorder as k
    JOIN kundorder_rad AS kr
        ON k.ordernummer = kr.kundorder
    JOIN stock AS s
        on kr.produkt = s.produkt
ORDER BY k.ordernummer
;
-- SHOW TABLES;

-- DESCRIBE plocklista;

-- -----------------------
-- -- TRIGGERS
-- --

-- Trigger kundorder

CREATE TRIGGER log_insert_kundorder
AFTER INSERT
ON kundorder FOR EACH ROW
    INSERT INTO logg (kundorder, loggdatum, kommentar)
        VALUES (NEW.ordernummer, NEW.orderdatum, 'beställning skapad')
;

CREATE TRIGGER log_update_kundorder
AFTER UPDATE
ON kundorder FOR EACH ROW
    INSERT INTO logg (kundorder, loggdatum, kommentar)
        VALUES (NEW.ordernummer, NEW.uppdaterad, 'beställning ändrad')
;

-- -- Trigger kunorder_rad

CREATE TRIGGER log_insert_produkt
AFTER INSERT
ON produkt FOR EACH ROW
    INSERT INTO logg (loggdatum, kommentar)
        VALUES (NOW(), CONCAT('produkt med kod ', NEW.produktkod, ' tillagd'))
;


CREATE TRIGGER log_update_produkt
AFTER UPDATE
ON produkt FOR EACH ROW
    INSERT INTO logg (loggdatum, kommentar)
        VALUES (NOW(), CONCAT('detaljer om produkt med kod ', NEW.produktkod, ' ändrade'))
;


CREATE TRIGGER log_delete_produkt
AFTER DELETE
ON produkt FOR EACH ROW
    INSERT INTO logg (loggdatum, kommentar)
        VALUES (NOW(), CONCAT('produkt med kod ', OLD.produktkod, ' raderad'))
;


-- Trigger faktura

CREATE TRIGGER log_insert_faktura
AFTER INSERT
ON faktura FOR EACH ROW
    INSERT INTO logg (kundorder, faktura, loggdatum, kommentar)
        VALUES (NEW.kundorder, NEW.fakturanummer, NEW.fakturadatum, 'faktura skapad')
;

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
DELIMITER ;;
CREATE PROCEDURE show_productkod(
    a_id INT
)
BEGIN
    SELECT
    *
    FROM produkt
    WHERE produktkod = a_id;
END
;;
DELIMITER ;

-- CALL show_productkod(1);

--
-- Procedure to edit product
--

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
DELIMITER ;;
CREATE PROCEDURE show_logg(
    a_limit INT
)
BEGIN
    SELECT * FROM logg
    LIMIT a_limit
    ;
END
;;
DELIMITER ;

--
-- Procedure to show lagerhylla
--
DELIMITER ;;
CREATE PROCEDURE show_lagerhylla()
BEGIN
    SELECT * FROM lagerhylla;
END
;;
DELIMITER ;

--
-- Procedure to show stock
--
DELIMITER ;;
CREATE PROCEDURE show_stock()
BEGIN
    SELECT
        s.produkt,
        p.produktnamn,
        s.lagerhylla,
        s.antal
    FROM stock as s
        JOIN produkt AS p
            on s.produkt = p.produktkod
    ;
END
;;
DELIMITER ;

--
-- Procedure to search stock
--
DELIMITER ;;
CREATE PROCEDURE search_stock(
    a_search VARCHAR(20)
)
BEGIN
    SELECT
        s.produkt,
        p.produktnamn,
        s.lagerhylla,
        s.antal
    FROM stock as s
        JOIN produkt AS p
            on s.produkt = p.produktkod
    WHERE
        s.produkt = a_search OR
        p.produktnamn LIKE CONCAT('%', a_search, '%') OR
        s.lagerhylla = a_search OR
        s.antal = a_search
    ;
END
;;
DELIMITER ;

-- Procedure to insert in stock

DELIMITER ;;
CREATE PROCEDURE insert_stock(
    a_produktkod INT,
    a_lagerhylla INT,
    a_antal INT
)
BEGIN
    INSERT INTO
        stock(produkt, lagerhylla, antal)
    VALUES
        (a_produktkod, a_lagerhylla, a_antal)
    ON DUPLICATE KEY UPDATE
        antal = antal + a_antal
    ;
END
;;
DELIMITER ;

-- Procedure to delete from stock

DELIMITER ;;
CREATE PROCEDURE remove_from_stock(
    a_produktkod INT,
    a_lagerhylla INT,
    a_antal INT
)
BEGIN
    UPDATE
        stock
    SET
        antal = antal - a_antal
    WHERE
        produkt = a_produktkod AND
        lagerhylla = a_lagerhylla
    ;
END
;;
DELIMITER ;

--
-- Procedure to show customers
--
DROP PROCEDURE IF EXISTS show_customers;

DELIMITER ;;
CREATE PROCEDURE show_customers()
BEGIN
    SELECT
        id,
        CONCAT(fornamn, ' ', efternamn) AS namn,
        adress,
        telefonnummer,
        mail
    FROM kund
    ;
END
;;
DELIMITER ;

--
-- Procedure to show customers
--
DROP PROCEDURE IF EXISTS show_individual_customer;

DELIMITER ;;
CREATE PROCEDURE show_individual_customer(
    a_id INT
)
BEGIN
    SELECT
        id,
        CONCAT(fornamn, ' ', efternamn) AS namn,
        adress,
        telefonnummer,
        mail
    FROM kund
    WHERE id = a_id
    ;
END
;;
DELIMITER ;

--
-- Procedure to insert order
--
DROP PROCEDURE IF EXISTS create_order;

DELIMITER ;;
CREATE PROCEDURE create_order(
    a_kund INT
)
BEGIN
INSERT INTO
    kundorder(kund)
VALUES
    (a_kund)
;
END
;;
DELIMITER ;


--
-- Procedure to insert order_rader
--
DROP PROCEDURE IF EXISTS insert_order_rad;

DELIMITER ;;
CREATE PROCEDURE insert_order_rad(
    a_kundorder INT,
    a_produkt INT,
    a_antal INT
)
BEGIN
INSERT INTO
    kundorder_rad(kundorder, produkt, antal)
VALUES
    (a_kundorder, a_produkt, a_antal)
ON DUPLICATE KEY UPDATE
    antal = antal + a_antal
;
END
;;
DELIMITER ;


--
-- Procedure to show orders
--
DROP PROCEDURE IF EXISTS show_orders;

DELIMITER ;;
CREATE PROCEDURE show_orders()
BEGIN
    SELECT
        k.ordernummer,
        k.kund,
        DATE_FORMAT(k.orderdatum, "%Y-%m-%d") AS orderdatum,
        COUNT(kr.kundorder) AS antal,
        orderstatus(skapad, orderdatum, uppdaterad, skickad, borttagen) AS orderstatus
    FROM kundorder AS k
    LEFT OUTER JOIN kundorder_rad AS kr
        ON k.ordernummer = kr.kundorder
    GROUP BY k.ordernummer;
END
;;
DELIMITER ;

--
-- Procedure to show specific orders
--
DROP PROCEDURE IF EXISTS show_specific_order;

DELIMITER ;;
CREATE PROCEDURE show_specific_order(
    a_ordernummer INT
)
BEGIN
    SELECT
        k.ordernummer AS ordernummer,
        k.kund AS kund,
        DATE_FORMAT(k.orderdatum, "%Y-%m-%d") AS orderdatum,
        -- COUNT(kr.kundorder) AS antal,
        orderstatus(skapad, orderdatum, uppdaterad, skickad, borttagen) AS orderstatus
    FROM kundorder AS k
    -- JOIN kundorder_rad AS kr
    -- ON k.ordernummer = kr.kundorder
    WHERE k.ordernummer = a_ordernummer;
END
;;
DELIMITER ;


--
-- Procedure to show specific orders
--
DROP PROCEDURE IF EXISTS show_specific_order_rows;

DELIMITER ;;
CREATE PROCEDURE show_specific_order_rows(
    a_ordernummer INT
)
BEGIN
    SELECT
        p.produktkod,
        p.produktnamn,
        p.produktbeskrivning,
        p.produktpris,
        k.antal
    FROM kundorder_rad AS k
    JOIN produkt AS p
    ON k.produkt = p.produktkod
    WHERE k.kundorder = a_ordernummer;
END
;;
DELIMITER ;


--
-- Procedure to show orders
--
DROP PROCEDURE IF EXISTS set_orderdatum;

DELIMITER ;;
CREATE PROCEDURE set_orderdatum(
    a_ordernummer INT
)
BEGIN
    UPDATE kundorder SET
        orderdatum = NOW(),
        uppdaterad = NULL -- vill att status är "beställd" inte "uppdaterad"
    WHERE
        ordernummer = a_ordernummer
    ;
END
;;
DELIMITER ;


-- DELIMITER ;;
-- CREATE PROCEDURE edit_produkt(
--     a_produktkod INT,
--     a_produktnamn VARCHAR(20),
--     a_produktbeskrivning VARCHAR(50),
--     a_produktpris INT
-- )
-- BEGIN
--     UPDATE produkt SET
--         `produktnamn` = a_produktnamn,
--         `produktbeskrivning` = a_produktbeskrivning,
--         `produktpris` = a_produktpris
--     WHERE
--         `produktkod` = a_produktkod
--     ;
-- END
-- ;;
-- DELIMITER ;


--
-- Procedure for delete produkt
--

DELIMITER ;;
CREATE PROCEDURE delete_produkt(
    a_id CHAR(4)
)
BEGIN
    DELETE FROM produkt
    WHERE
        `produktkod` = a_id;
END
;;
DELIMITER ;

-- CALL delete_produkt(6);


-- ------------------------
-- -- ORDER
-- --

--
-- Procedure to search order
--
DELIMITER ;;
CREATE PROCEDURE search_order(
    a_search VARCHAR(20)
)
BEGIN
    SELECT
        k.ordernummer,
        k.kund,
        DATE_FORMAT(k.orderdatum, "%Y-%m-%d") AS orderdatum,
        COUNT(kr.kundorder) AS antal,
        orderstatus(skapad, orderdatum, uppdaterad, skickad, borttagen) AS orderstatus
    FROM kundorder AS k
    LEFT OUTER JOIN kundorder_rad AS kr
    ON k.ordernummer = kr.kundorder
    WHERE
        k.ordernummer LIKE CONCAT('%', a_search, '%') OR
        kr.kundorder LIKE CONCAT('%', a_search, '%') OR
        k.kund = a_search
    GROUP BY ordernummer
    ;
END
;;
DELIMITER ;

--
-- Procedure to show ordernum picklist
--
DELIMITER ;;
CREATE PROCEDURE show_plocklista(
    a_order_number VARCHAR(20)
)
BEGIN
    SELECT
      *
    FROM plocklista as pl
    WHERE
        pl.ordernummer = a_order_number
    ;
END
;;
DELIMITER ;

--
-- Procdure to update orderstatus (IF NULL) by order number
--

DELIMITER ;;
CREATE PROCEDURE update_orderstatus(
        a_order_number INT
)
BEGIN
    UPDATE kundorder
    SET
    skickad = NOW()
    WHERE ordernummer = a_order_number
    -- only update IF skickad IS NULL
    AND CONCAT(skickad) IS NULL;
    SELECT *
    FROM kundorder
    WHERE ordernummer = a_order_number;
END
;;
DELIMITER ;

-- -----------------------
-- -- FUNCTIONS
-- --

--
-- Create orderstatus
--

DROP FUNCTION IF EXISTS orderstatus;
DELIMITER ;;

CREATE FUNCTION orderstatus(
    a_skapad TIMESTAMP,
    a_beställd TIMESTAMP,
    a_uppdaterad TIMESTAMP,
    a_skickad TIMESTAMP,
    a_raderad TIMESTAMP
)
RETURNS CHAR(10)
DETERMINISTIC
BEGIN
    IF a_raderad IS NOT NULL THEN
        RETURN 'Raderad';
    ELSEIF a_skickad IS NOT NULL THEN
        RETURN 'Skickad';
    ELSEIF a_uppdaterad IS NOT NULL THEN
        RETURN 'Uppdaterad';
    ELSEIF a_beställd IS NOT NULL THEN
        RETURN 'Beställd';
    ELSEIF a_skapad IS NOT NULL THEN
        RETURN 'Skapad';
    END IF;
    RETURN 'Okänd';
END
;;

DELIMITER ;

--
-- Date Formating
--

DROP FUNCTION IF EXISTS loggdatum;
DELIMITER ;;

CREATE FUNCTION loggdatum(
    a_skapad TIMESTAMP,
    a_beställd TIMESTAMP,
    a_uppdaterad TIMESTAMP,
    a_skickad TIMESTAMP,
    a_raderad TIMESTAMP
)
RETURNS DATE
DETERMINISTIC
BEGIN
    IF a_raderad IS NOT NULL THEN
        RETURN DATE_FORMAT(a_raderad, '%Y-%m-%d');
    ELSEIF a_skickad IS NOT NULL THEN
        RETURN DATE_FORMAT(a_skickad, '%Y-%m-%d');
    ELSEIF a_uppdaterad IS NOT NULL THEN
        RETURN DATE_FORMAT(a_uppdaterad, '%Y-%m-%d');
    ELSEIF a_beställd IS NOT NULL THEN
        RETURN DATE_FORMAT(a_beställd, '%Y-%m-%d');
    END IF;
    RETURN DATE_FORMAT(a_skapad, '%Y-%m-%d');
END
;;

DELIMITER ;
