## Krav
Uppgiften är indelad i tre huvudsakliga delar, en generell del inklusive databasdetaljer, en för webbklienten och en för terminalklienten.

## Generella krav

- Din katalog innehåller en package.json med samtliga externa moduler som används. [x]

- Inloggningsdetaljer till databasen skall sparas i config/db/eshop.json. [x]

- SQL-filer lägger du i sql/eshop. Skapa filen setup.sql för att skapa databasen. Låt din databas heta eshop. [x]

- Skapa filen sql/eshop/ddl.sql där du samlar all kod som skapar tabeller, vyer, procedurer, triggers och liknande. Använd den filen för att skapa databasens schema. [x]

- Skapa filen sql/eshop/insert.sql med SQL-kod för att lägga in minst 5 vardera, av följande: kunder, produkter, produktkategorier, lagerhyllor som du läser in från CSV-filer som du själv skapat. CSV-filerna sparar du i samma katalog som sql-filerna. Använd inte absoluta filvägar till CSV-filerna. [x]

- Försäkra dig om att samtliga produkter tillhör minst en produktkategori. Försäkra dig om att minst tre av produkterna tillhör två eller fler produktkategorier. Skriv kod i insert.sql, om det krävs. [x]

- Försäkra dig om att samtliga produkter finns på lagret, i någon omfattning. Skriv kod i insert.sql, om det krävs. [x]

- Skapa en SQL-fil som du kan använda för att återskapa hela databasen från början till slut, kalla den för sql/eshop/reset.sql. [x]

- Du skall ha en loggtabell som loggar intressanta händelser i systemet, via triggers. Du skall logga när någon gör 
- INSERT [x] 
- UPDATE [x] 
- DELETE [x]

på tabellen produkt. Du loggar tiden då något hände och en textsträng som beskriver händelsen och det objekt som var inblandat i händelsen.

Till exempel så här.

| Tidstämpel         | Händelse | # |
|--------------|:-----|-----------:|
| 2019-02-18 16:01:01 |  “Ny produkt lades till med produktid ‘produkt1’.” |         
| 2019-02-18 16:02:01 | “Detaljer om produktid ‘produkt1’ uppdaterades.”||
|2019-02-18 16:03:01|“Produkten med produktid ‘produkt1’ raderades.”|

## Webbklient
- Skapa en webbklient med Express. Servern startas via node index.js och skall snurra på porten 1337. [x]

- All access från klienten mot databasen skall gå via lagrade procedurer. [x]

- Alla sidor skall ha samma sidlayout med gemensam header, footer och det skall gå att klicka sig fram mellan sidorna, via navigeringen. [x]

- Skapa en om-sida på eshop/about som visar namnen på de som jobbat (i gruppen) för att lösa uppgiften. [x]

- I webbklienten, skapa routen /eshop/index som visar en välkomstssida till din eshop. Välj själv vad du visar på förstasidan. [x]

- I webbklienten, skapa en sida /eshop/category som visar en tabell över de produktkategorier som finns. [x]

- I webbklienten, skapa en sida /eshop/product som visar en översikt av de produkter som finns. Visa (minst) produktens id, namn, pris och antal som finns i lagret. Visa även information om vilken kategori som produkten tillhör (TIPS GROUP_CONCAT). [x]

- Skapa CRUD för att lägga till, redigera, visa och radera produkter. Du behöver enbart redigera de delar som finns i tabellen kopplad till produkten. Du behöver inte redigera antal produkter på lagret, eller kopplingen till kategori. [x]

- Se till att det är smidigt att navigera i din produkt CRUD, via länkar och/eller formulär, man skall kunna klicka sig fram till det man vill göra. [x]

## Terminalklient

- Bygg ett terminalprogram och spara main-funktionen i cli.js. Eventuell övrig kod lägger du i moduler under katalogen src/. Terminalprogrammet skall startas med node cli.js. [x]

- All access från klienten mot databasen skall gå via lagrade procedurer. [x]

- Ditt terminalprogram skall fungera som en oändlig kommandoloop där man kan skriva in kommandon som programmet utför. Det skall finnas ett kommando menu som visar menyn med samtliga kommandon. När man skriver kommandot exit skall programmet avslutas. [x]

- Skapa kommandot about som visar namnen på de som jobbat (i grupp) för att lösa uppgiften. [x]

- Skapa kommandot log <number> som visar de <number> senaste raderna i loggtabellen. [x]

- Skapa kommandot product som visar alla producter som finns, inklusive produkternas id. [x]

- Skapa kommandot shelf som visar vilka lagerhyllor som finns på lagret. [x]

- Skapa kommandot inv (inventory) som visar en tabell över vilka produkter som finns var i lagret. Visa produktid, produktnamn, lagerhylla och antal. [x]

- Skapa kommandot inv <str> där det optionella argumentet <str> används för att filtrera det som skrivs ut. Filtrering sker på produktid, produktnamn, lagerhylla. [x]

- Skapa kommandot invadd <productid> <shelf> <number> som lägger till ett visst antal av en produkt på en lagerhylla. Om det redan finns samma produkt på lagerhyllan så kan man öka på antalet. (Tips: det finns en konstruktion som heter INSERT ON DUPLICATE KEY UPDATE.) [x]

- Skapa kommandot invdel <productid> <shelf> <number> som plockar bort ett visst antal produkter från en viss lagerhylla. Det behöver inte finnas någon kontroll om antalet produkter fortfarande är positivt. [x]

### Lämna in

- När du är helt klar och har testkört ditt system mot din egen databas, så tar du en backup av databasen med mysqldump och sparar i sql/eshop/backup.sql. []

- Använd optionen --routines så att procedurerna följer med. Verifiera att backup-filen fungerar och tänk att rättaren kan ladda denna databas för att testköra mot ditt system. []

Testa och validera din kod.

###s Flytta till kurskatalogen

```
dbwebb test eshop1
dbwebb validate eshop1
```
Rätta eventuella fel som dyker upp och publisera igen. När det ser grönt ut så är du klar.