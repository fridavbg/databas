--- SHOW TABLES WITH EMPTY SETS

SELECT table_schema AS 
        database_name,
        table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE'
    AND table_rows = 0
    AND table_schema NOT IN
    (
        'information_schema', 
        'sys',
        'performance_schema', 
        'mysql'
    )
ORDER BY table_schema, table_name;


CREATE TRIGGER log_update_kundorder
AFTER UPDATE
ON kundorder FOR EACH ROW
    INSERT INTO logg (kundorder, loggdatum, kommentar)
        VALUES (NEW.ordernummer, NEW.uppdaterad, 'beställning ändrad')
;