--
-- Create database skolan
--

-- Radera en databas med allt innehåll
DROP DATABASE IF EXISTS skolan;

-- Skapa databas
CREATE DATABASE skolan;

-- -- Skapa databas om den inte redan finns
-- CREATE DATABASE IF NOT EXISTS skolan;

-- Välj vilken databas du vill använda
USE skolan;

-- -- Visa vilka databaser som finns
-- SHOW DATABASES;

-- -- Visa vilka databaser som finns
-- -- som heter något i stil med *skolan*
-- SHOW DATABASES LIKE "%skolan%";